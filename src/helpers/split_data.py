import random
import shutil
from pathlib import Path
from typing import List, Dict

from project_constants import SEED, ORIGINAL_PICS_DIR
from project_constants import TRAIN_DIR, VAL_DIR, TEST_DIR
from project_constants import BINARY_TRAIN_DIR, BINARY_VAL_DIR, BINARY_TEST_DIR


SPLIT_RATIOS = {
    "train": 0.5,
    "val": 0.2,
    "test": 0.3
}

# ==========================================
# Binary classification mapping
# ==========================================
BINARY_CLASS_MAPPING = {
    "River": "Water",
    "SeaLake": "Water",
    "Highway": "Land",
    "Industrial": "Land"
}


def setup_directories(directories: Dict[str, Path]):
    """Removes existing directories and creates fresh ones."""
    for dir_path in directories.values():
        if dir_path.exists():
            shutil.rmtree(dir_path)
        dir_path.mkdir(parents=True)
        print(f"Prepared directory: {dir_path}")


def get_image_paths(class_dir: Path) -> List[Path]:
    """Retrieves all files from a class directory."""
    return [f for f in class_dir.glob("*") if f.is_file()]


def distribute_files(files: List[Path], class_name: str, output_dirs: Dict[str, Path]):
    """Splits a list of files and copies them to their respective destinations."""
    random.shuffle(files)

    total = len(files)
    train_end = int(total * SPLIT_RATIOS["train"])
    val_end = train_end + int(total * SPLIT_RATIOS["val"])

    splits = {
        "train": files[:train_end],
        "val": files[train_end:val_end],
        "test": files[val_end:]
    }

    for split_name, split_files in splits.items():
        target_dir = output_dirs[split_name] / class_name
        target_dir.mkdir(parents=True, exist_ok=True)

        for file_path in split_files:
            shutil.copy(file_path, target_dir / file_path.name)

    print(f"[OK] Processed '{class_name}': {len(splits['train'])} train, "
          f"{len(splits['val'])} val, {len(splits['test'])} test")


def split_multiclass():
    """Splits data for multiclass classification (all 10 classes)."""
    print("\n" + "="*50)
    print("MULTICLASS CLASSIFICATION (10 classes)")
    print("="*50)
    
    output_dirs = {
        "train": TRAIN_DIR,
        "val": VAL_DIR,
        "test": TEST_DIR
    }
    
    setup_directories(output_dirs)

    class_folders = sorted([d for d in ORIGINAL_PICS_DIR.iterdir() if d.is_dir() and d.name not in ["train_data", "val_data", "test_data"]])

    if not class_folders:
        print("No class directories found.")
        return False

    for class_dir in class_folders:
        images = get_image_paths(class_dir)
        if images:
            distribute_files(images, class_dir.name, output_dirs)

    print("\n[OK] Multiclass dataset splitting completed successfully!")
    return True


def split_binary():
    """Splits data for binary classification (Land vs Water)."""
    print("\n" + "="*50)
    print("BINARY CLASSIFICATION (Land vs Water)")
    print("="*50)
    
    output_dirs = {
        "train": BINARY_TRAIN_DIR,
        "val": BINARY_VAL_DIR,
        "test": BINARY_TEST_DIR
    }
    
    setup_directories(output_dirs)

    # Collect images from binary-relevant folders
    binary_images = {
        "Land": [],
        "Water": []
    }

    for source_class, target_class in BINARY_CLASS_MAPPING.items():
        class_dir = ORIGINAL_PICS_DIR / source_class
        if class_dir.exists():
            images = get_image_paths(class_dir)
            binary_images[target_class].extend(images)
            print(f"Found {len(images)} images from {source_class}")

    if not binary_images["Land"] and not binary_images["Water"]:
        print("No images found for binary classification.")
        return False

    # Distribute files for each binary class
    for binary_class, images in binary_images.items():
        if images:
            distribute_files(images, binary_class, output_dirs)

    print("\n[OK] Binary dataset splitting completed successfully!")
    return True


def main():
    """Main execution flow."""
    random.seed(SEED)

    if not ORIGINAL_PICS_DIR.exists():
        print(f"[ERROR] Error: Source directory {ORIGINAL_PICS_DIR} not found.")
        return

    print("\n[INFO] Starting Dataset Preparation...")

    # Split for multiclass
    split_multiclass()

    # Split for binary
    split_binary()

    print("\n" + "="*50)
    print("[OK] ALL DATASETS PREPARED SUCCESSFULLY!")
    print("="*50)


if __name__ == "__main__":
    main()