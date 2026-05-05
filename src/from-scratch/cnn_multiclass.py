import tensorflow as tf
from tensorflow.keras import layers, models
from tensorflow.keras.callbacks import ModelCheckpoint, EarlyStopping
from pathlib import Path

# ==========================================
# 1. Pfade mit pathlib definieren
# ==========================================
# Wo befindet sich dieses Skript? (src/from-scratch/)
CURRENT_DIR = Path(__file__).resolve().parent
ROOT_DIR = CURRENT_DIR.parent.parent

# Exakte Pfade zu den Datenordnern
DATA_DIR = ROOT_DIR / "data"
TRAIN_DIR = DATA_DIR / "train_data"
VAL_DIR = DATA_DIR / "val_data"
TEST_DIR = DATA_DIR / "test_data"

# Speicherort für Modelle (ich wähle den models-Ordner in deinem from-scratch Verzeichnis)
MODEL_DIR = ROOT_DIR / "models"

# ==========================================
# 2. Konfiguration und Hyperparameter
# ==========================================
IMG_HEIGHT = 64
IMG_WIDTH = 64
BATCH_SIZE = 32
EPOCHS = 20

# ==========================================
# 3. Daten laden (Automatisch)
# ==========================================
print("Lade Trainingsdaten...")
# Wir wandeln die Path-Objekte mit str() in Strings um, um 100% kompatibel mit Keras zu sein
train_dataset = tf.keras.utils.image_dataset_from_directory(
    str(TRAIN_DIR),
    image_size=(IMG_HEIGHT, IMG_WIDTH),
    batch_size=BATCH_SIZE
)

print("Lade Validierungsdaten...")
val_dataset = tf.keras.utils.image_dataset_from_directory(
    str(VAL_DIR),
    image_size=(IMG_HEIGHT, IMG_WIDTH),
    batch_size=BATCH_SIZE
)

print("Lade Testdaten...")
test_dataset = tf.keras.utils.image_dataset_from_directory(
    str(TEST_DIR),
    image_size=(IMG_HEIGHT, IMG_WIDTH),
    batch_size=BATCH_SIZE
)

# Performance-Optimierung
AUTOTUNE = tf.data.AUTOTUNE
train_dataset = train_dataset.cache().prefetch(buffer_size=AUTOTUNE)
val_dataset = val_dataset.cache().prefetch(buffer_size=AUTOTUNE)
test_dataset = test_dataset.cache().prefetch(buffer_size=AUTOTUNE)


# ==========================================
# 4. Modellarchitektur definieren (From Scratch)
# ==========================================
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
        layers.Dense(10, activation='softmax')  # 10 Klassen für EuroSAT
    ])
    return model


model = create_model()
model.summary()

# ==========================================
# 5. Modell kompilieren
# ==========================================
model.compile(
    optimizer='adam',
    loss=tf.keras.losses.SparseCategoricalCrossentropy(),
    metrics=['accuracy']
)

# ==========================================
# 6. Callbacks konfigurieren
# ==========================================
# Checkpoint speichert in from-scratch/models/
checkpoint_path = MODEL_DIR / "best_eurosat_cnn.keras"
checkpoint_cb = ModelCheckpoint(
    filepath=str(checkpoint_path),
    save_best_only=True,
    monitor='val_accuracy'
)

early_stopping_cb = EarlyStopping(
    patience=5,
    restore_best_weights=True,
    monitor='val_loss'
)

# ==========================================
# 7. Training & Evaluierung
# ==========================================
print("Starte Training...")
history = model.fit(
    train_dataset,
    validation_data=val_dataset,
    epochs=EPOCHS,
    callbacks=[checkpoint_cb, early_stopping_cb]
)

print("Evaluiere Modell auf Testdaten...")
test_loss, test_acc = model.evaluate(test_dataset)
print(f"Test Accuracy: {test_acc:.4f}")

# Optional: Finale Version speichern
final_model_path = MODEL_DIR / "final_eurosat_cnn.keras"
model.save(str(final_model_path))
print(f"Modell gespeichert unter: {final_model_path}")