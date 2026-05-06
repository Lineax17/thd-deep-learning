import tensorflow as tf
import matplotlib.pyplot as plt
from pathlib import Path
import numpy as np
import random
import sys

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from src.helpers.project_constants import (
    ROOT_DIR, TEST_DIR, MODEL_DIR, IMG_HEIGHT, IMG_WIDTH,
    get_class_names, BEST_MULTICLASS_SCRATCH_MODEL, FINAL_MULTICLASS_SCRATCH_MODEL,
)

# Config
CLASS_NAMES = get_class_names()
print(f"[INFO] Class names: {CLASS_NAMES}")

MODEL_PATH = BEST_MULTICLASS_SCRATCH_MODEL

print(f"\nLoading model from: {MODEL_PATH}")
if not MODEL_PATH.exists():
    print(f"[ERR] Model not found, trying other model...")
    MODEL_PATH = FINAL_MULTICLASS_SCRATCH_MODEL

if not MODEL_PATH.exists():
    print(f"[ERR] Model not found in {MODEL_DIR}")
    exit(1)

model = tf.keras.models.load_model(str(MODEL_PATH))
print("[INFO] Model loaded")


def get_random_images(test_dir, num_images=15):
    images_data = []

    for class_dir in test_dir.iterdir():
        if class_dir.is_dir():
            class_name = class_dir.name
            image_files = list(class_dir.glob("*.jpg")) + list(class_dir.glob("*.png"))

            if image_files:
                selected = random.sample(image_files, min(2, len(image_files)))
                for img_path in selected:
                    images_data.append((img_path, class_name))

    return random.sample(images_data, min(num_images, len(images_data)))


def load_and_preprocess_image(image_path):
    img = tf.keras.preprocessing.image.load_img(
        image_path,
        target_size=(IMG_HEIGHT, IMG_WIDTH)
    )
    img_array = tf.keras.preprocessing.image.img_to_array(img)
    img_array = tf.expand_dims(img_array, 0)  # Batch dimension
    return img, img_array


test_images = get_random_images(TEST_DIR, num_images=15)

if not test_images:
    print("[ERR] No pictures found!")
    exit(1)

print(f"\n[INFO] Testing the model for {len(test_images)} pictures...\n")

num_cols = 3
num_rows = (len(test_images) + num_cols - 1) // num_cols
fig, axes = plt.subplots(num_rows, num_cols, figsize=(15, num_rows * 4))

if num_rows == 1:
    axes = axes.reshape(1, -1)
if num_cols == 1:
    axes = axes.reshape(-1, 1)

axes = axes.flatten()

for idx, (img_path, true_label) in enumerate(test_images):
    img, img_array = load_and_preprocess_image(img_path)

    predictions = model.predict(img_array, verbose=0)
    predicted_class_idx = np.argmax(predictions[0])
    predicted_label = CLASS_NAMES[predicted_class_idx]
    confidence = predictions[0][predicted_class_idx] * 100

    title_color = "green" if predicted_label == true_label else "red"

    ax = axes[idx]
    ax.imshow(img)

    title = f"True: {true_label}\nPred: {predicted_label}\nConf: {confidence:.1f}%"
    ax.set_title(title, color=title_color, fontweight='bold', fontsize=10)
    ax.axis('off')

    status = "[INFO] Correct prediction" if predicted_label == true_label else "[INFO] Wrong prediction"
    print(f"{status} Bild {idx + 1}: True={true_label:20} | Pred={predicted_label:20} | Conf={confidence:5.1f}%")

for idx in range(len(test_images), len(axes)):
    axes[idx].axis('off')

plt.tight_layout()

plt.show()

print("\n[INFO] Done!")
