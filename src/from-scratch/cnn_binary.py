import tensorflow as tf
from tensorflow.keras import layers, models
from tensorflow.keras.callbacks import ModelCheckpoint, EarlyStopping
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from src.helpers.project_constants import (
    BINARY_TRAIN_DIR, BINARY_VAL_DIR, BINARY_TEST_DIR,
    IMG_HEIGHT, IMG_WIDTH, BATCH_SIZE, EPOCHS,
    BEST_BINARY_SCRATCH_MODEL, FINAL_BINARY_SCRATCH_MODEL
)

print("[INFO] Loading training data...")
train_dataset = tf.keras.utils.image_dataset_from_directory(
    str(BINARY_TRAIN_DIR),
    image_size=(IMG_HEIGHT, IMG_WIDTH),
    batch_size=BATCH_SIZE
)

print("[INFO] Loading validation data...")
val_dataset = tf.keras.utils.image_dataset_from_directory(
    str(BINARY_VAL_DIR),
    image_size=(IMG_HEIGHT, IMG_WIDTH),
    batch_size=BATCH_SIZE
)

print("[INFO] Loading test data...")
test_dataset = tf.keras.utils.image_dataset_from_directory(
    str(BINARY_TEST_DIR),
    image_size=(IMG_HEIGHT, IMG_WIDTH),
    batch_size=BATCH_SIZE
)

# performance optimizations
AUTOTUNE = tf.data.AUTOTUNE
train_dataset = train_dataset.cache().prefetch(buffer_size=AUTOTUNE)
val_dataset = val_dataset.cache().prefetch(buffer_size=AUTOTUNE)
test_dataset = test_dataset.cache().prefetch(buffer_size=AUTOTUNE)


def create_model():
    model = models.Sequential([
        # Rescaling: Pixelwerte von [0, 255] auf [0, 1] normalisieren
        layers.Rescaling(1. / 255, input_shape=(IMG_HEIGHT, IMG_WIDTH, 3)),

        # Block 1
        layers.Conv2D(32, (3, 3), activation='relu'),
        layers.MaxPooling2D((2, 2)),

        # Block 2
        layers.Conv2D(64, (3, 3), activation='relu'),
        layers.MaxPooling2D((2, 2)),

        # Block 3
        layers.Conv2D(64, (3, 3), activation='relu'),
        layers.MaxPooling2D((2, 2)),

        # Flatten und Klassifikator
        layers.Flatten(),
        layers.Dense(64, activation='relu'),
        layers.Dropout(0.5),
        layers.Dense(2, activation='softmax')  # 2 Klassen für binäre Klassifikation (Land vs Water)
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
    filepath=str(BEST_BINARY_SCRATCH_MODEL),
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

model.save(str(FINAL_BINARY_SCRATCH_MODEL))
print(f"[INFO] Model saved to: {FINAL_BINARY_SCRATCH_MODEL}")

