"""
Land/Water Classification via Existing EuroSAT Model Mapping
Loads pretrained 10-class model and maps predictions to Land/Water categories.
Automatically processes all images from the test dataset.
"""

import tensorflow as tf
from tensorflow.keras.models import load_model
from tensorflow.keras.applications.mobilenet_v3 import preprocess_input
from pathlib import Path
from PIL import Image
import numpy as np


# === Configuration ===
REPO_ROOT = Path(__file__).resolve().parents[3]
MODEL_PATH = REPO_ROOT / "models" / "eurosat_multilabel_mobilenetv3_freezed.keras"
TEST_DATA_DIR = REPO_ROOT / "data" / "test_data"
IMG_SIZE = (224, 224)

# === EuroSAT Class Names (10 classes from training) ===
EUROSAT_CLASSES = [
    "AnnualCrop",
    "Forest",
    "HerbaceousVegetation",
    "Highway",
    "Industrial",
    "Pasture",
    "PermanentCrop",
    "Residential",
    "River",
    "SeaLake"
]

# === Land/Water Mapping ===
LAND_WATER_MAPPING = {
    "AnnualCrop": "Land",
    "Forest": "Land",
    "HerbaceousVegetation": "Land",
    "Highway": "Land",
    "Industrial": "Land",
    "Pasture": "Land",
    "PermanentCrop": "Land",
    "Residential": "Land",
    "River": "Water",
    "SeaLake": "Water"
}


def load_pretrained_model(model_path):
    """Load the pretrained EuroSAT model."""
    if not model_path.exists():
        raise FileNotFoundError(f"Model not found at {model_path}")
    model = load_model(model_path)
    return model


def preprocess_image(image_path):
    """Load and preprocess image for MobileNetV3."""
    img = Image.open(image_path).convert('RGB')
    img = img.resize(IMG_SIZE)
    img_array = np.array(img)
    img_array = preprocess_input(img_array)
    return np.expand_dims(img_array, axis=0)


def classify_image(image_path, model):
    """
    Classify image using EuroSAT model and map to Land/Water category.
    
    Args:
        image_path: Path to image file
        model: Loaded TensorFlow model
    
    Returns:
        dict with: eurosat_class, confidence, land_water_class
    """
    img_array = preprocess_image(image_path)
    predictions = model.predict(img_array, verbose=0)
    
    # Get top prediction
    top_idx = np.argmax(predictions[0])
    confidence = float(predictions[0][top_idx])
    eurosat_class = EUROSAT_CLASSES[top_idx]
    land_water_class = LAND_WATER_MAPPING[eurosat_class]
    
    return {
        "eurosat_class": eurosat_class,
        "confidence": confidence,
        "land_water_class": land_water_class
    }


def main():
    if not TEST_DATA_DIR.exists():
        print(f"❌ Test data directory not found: {TEST_DATA_DIR}")
        return
    
    # Load model once
    print(f"Loading model from {MODEL_PATH}...")
    model = load_pretrained_model(MODEL_PATH)
    print("✓ Model loaded successfully\n")
    
    # Collect all images from test data directory
    image_files = list(TEST_DATA_DIR.glob("**/*.jpg")) + list(TEST_DATA_DIR.glob("**/*.jpeg")) + list(TEST_DATA_DIR.glob("**/*.png"))
    
    if not image_files:
        print(f"⚠️  No images found in {TEST_DATA_DIR}")
        return
    
    print(f"Processing {len(image_files)} images from test dataset...\n")
    print("-" * 80)
    
    # Statistics
    land_count = 0
    water_count = 0
    results = []
    eurosat_counts = {name: 0 for name in EUROSAT_CLASSES}
    multilabel_correct = 0
    multilabel_total = 0
    binary_correct = 0
    binary_total = 0
    
    # Classify each image
    for idx, image_path in enumerate(image_files, 1):
        try:
            result = classify_image(image_path, model)
            results.append(result)
            
            # Update counts
            if result['land_water_class'] == 'Land':
                land_count += 1
            else:
                water_count += 1
            eurosat_counts[result['eurosat_class']] += 1
            
            # Get class folder name
            class_folder = image_path.parent.name

            # Accuracy tracking
            if class_folder in EUROSAT_CLASSES:
                multilabel_total += 1
                if result['eurosat_class'] == class_folder:
                    multilabel_correct += 1

                binary_total += 1
                true_binary = LAND_WATER_MAPPING[class_folder]
                if result['land_water_class'] == true_binary:
                    binary_correct += 1
            
            print(f"{idx}. {image_path.name}")
            print(f"   Folder: {class_folder}")
            print(f"   EuroSAT: {result['eurosat_class']} ({result['confidence']:.1%})")
            print(f"   Category: {result['land_water_class']}")
            print()
        except Exception as e:
            print(f"❌ Error processing {image_path}: {e}\n")
    
    # Summary statistics
    print("-" * 80)
    print("\n📊 SUMMARY STATISTICS")
    print(f"Total images processed: {len(results)}")
    print(f"Land: {land_count} ({100*land_count/len(results):.1f}%)")
    print(f"Water: {water_count} ({100*water_count/len(results):.1f}%)")
    if multilabel_total > 0:
        multilabel_acc = 100 * multilabel_correct / multilabel_total
        print(f"Multilabel accuracy: {multilabel_acc:.1f}% ({multilabel_correct}/{multilabel_total})")
    else:
        print("Multilabel accuracy: n/a (no labeled folders)")
    if binary_total > 0:
        binary_acc = 100 * binary_correct / binary_total
        print(f"Binary (Land/Water) accuracy: {binary_acc:.1f}% ({binary_correct}/{binary_total})")
    else:
        print("Binary (Land/Water) accuracy: n/a (no labeled folders)")
    print("\nEuroSAT class breakdown:")
    for class_name in EUROSAT_CLASSES:
        count = eurosat_counts[class_name]
        percent = 100 * count / len(results)
        land_water = LAND_WATER_MAPPING[class_name]
        print(f"- {class_name}: {count} ({percent:.1f}%) -> {land_water}")


if __name__ == "__main__":
    main()
