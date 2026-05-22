import tensorflow as tf
from tensorflow.keras import regularizers
from tensorflow.keras import layers, models
from tensorflow.keras.callbacks import ModelCheckpoint, EarlyStopping
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from src.helpers.project_constants import (
    TRAIN_DIR, VAL_DIR, TEST_DIR,
    IMG_HEIGHT, IMG_WIDTH, BATCH_SIZE, EPOCHS, MODEL_DIR
)

BEST_MULTICLASS_SCRATCH_MODEL = MODEL_DIR / "best_multiclass_cnn_v4.keras"
FINAL_MULTICLASS_SCRATCH_MODEL = MODEL_DIR / "final_multiclass_cnn_v4.keras"

print("[INFO] Loading training data...")
train_dataset = tf.keras.utils.image_dataset_from_directory(
    str(TRAIN_DIR),
    image_size=(IMG_HEIGHT, IMG_WIDTH),
    batch_size=BATCH_SIZE
)

print("[INFO] Loading validation data...")
val_dataset = tf.keras.utils.image_dataset_from_directory(
    str(VAL_DIR),
    image_size=(IMG_HEIGHT, IMG_WIDTH),
    batch_size=BATCH_SIZE
)

print("[INFO] Loading test data...")
test_dataset = tf.keras.utils.image_dataset_from_directory(
    str(TEST_DIR),
    image_size=(IMG_HEIGHT, IMG_WIDTH),
    batch_size=BATCH_SIZE
)

# performance optimizations
AUTOTUNE = tf.data.AUTOTUNE
train_dataset = train_dataset.cache().prefetch(buffer_size=AUTOTUNE)
val_dataset = val_dataset.cache().prefetch(buffer_size=AUTOTUNE)
test_dataset = test_dataset.cache().prefetch(buffer_size=AUTOTUNE)


def create_model():
    weight_decay = 1e-4

    model = models.Sequential([
        layers.Input(shape=(IMG_HEIGHT, IMG_WIDTH, 3)),
        layers.Rescaling(1.0/255),

        # Block 1: 32 filters
        layers.Conv2D(32, 3, padding='same', kernel_regularizer=regularizers.l2(weight_decay)),
        layers.BatchNormalization(),
        layers.Activation('relu'),
        layers.Conv2D(32, 3, padding='same', kernel_regularizer=regularizers.l2(weight_decay)),
        layers.BatchNormalization(),
        layers.Activation('relu'),
        layers.MaxPooling2D(2),

        # Block 2: 64 filters
        layers.Conv2D(64, 3, padding='same', kernel_regularizer=regularizers.l2(weight_decay)),
        layers.BatchNormalization(),
        layers.Activation('relu'),
        layers.Conv2D(64, 3, padding='same', kernel_regularizer=regularizers.l2(weight_decay)),
        layers.BatchNormalization(),
        layers.Activation('relu'),
        layers.MaxPooling2D(2),

        # Classifier
        layers.GlobalAveragePooling2D(),
        layers.Dropout(0.5),
        layers.Dense(64, activation='relu', kernel_regularizer=regularizers.l2(weight_decay)),
        layers.Dropout(0.5),
        layers.Dense(10, activation='softmax')
    ])
    return model


model = create_model()
model.summary()

model.compile(
    optimizer='adam',
    loss=tf.keras.losses.SparseCategoricalCrossentropy(),
    metrics=['accuracy']
)

checkpoint_cb = ModelCheckpoint(
    filepath=str(BEST_MULTICLASS_SCRATCH_MODEL),
    save_best_only=True,
    monitor='val_accuracy'
)

early_stopping_cb = EarlyStopping(
    patience=5,
    restore_best_weights=True,
    monitor='val_loss'
)

print("[INFO] Starting training...")
history = model.fit(
    train_dataset,
    validation_data=val_dataset,
    epochs=EPOCHS,
    callbacks=[checkpoint_cb, early_stopping_cb]
)

print("[INFO] Evaluating on test data...")
test_loss, test_acc = model.evaluate(test_dataset)
print(f"[INFO] Test Accuracy: {test_acc:.4f}")

model.save(str(FINAL_MULTICLASS_SCRATCH_MODEL))
print(f"[INFO] Model saved to: {FINAL_MULTICLASS_SCRATCH_MODEL}")
