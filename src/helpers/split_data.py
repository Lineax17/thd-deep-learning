import random
import shutil
from pathlib import Path
from typing import List, Dict

from project_constants import SEED, TRAIN_DIR, VAL_DIR, TEST_DIR, ORIGINAL_PICS_DIR


SPLIT_RATIOS = {
    "train": 0.5,
    "val": 0.2,
    "test": 0.3
}

OUTPUT_DIRS = {
    "train": TRAIN_DIR,
    "val": VAL_DIR,
    "test": TEST_DIR
}


def setup_directories(directories: Dict[str, Path]):
    for dir_path in directories.values():
        if dir_path.exists():
            shutil.rmtree(dir_path)
        dir_path.mkdir(parents=True)
        print(f"Prepared directory: {dir_path}")


def get_image_paths(class_dir: Path) -> List[Path]:
    return [f for f in class_dir.glob("*") if f.is_file()]


def distribute_files(files: List[Path], class_name: str, output_root: Dict[str, Path]):
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
        target_dir = output_root[split_name] / class_name
        target_dir.mkdir(parents=True, exist_ok=True)

        for file_path in split_files:
            shutil.copy(file_path, target_dir / file_path.name)

    print(f"Processed '{class_name}': {len(splits['train'])} train, "
          f"{len(splits['val'])} val, {len(splits['test'])} test")


def main():
    random.seed(SEED)

    if not ORIGINAL_PICS_DIR.exists():
        print(f"Error: Source directory {ORIGINAL_PICS_DIR} not found.")
        return

    setup_directories(OUTPUT_DIRS)

    class_folders = [d for d in ORIGINAL_PICS_DIR.iterdir() if d.is_dir()]

    if not class_folders:
        print("No class directories found.")
        return

    for class_dir in class_folders:
        images = get_image_paths(class_dir)
        if images:
            distribute_files(images, class_dir.name, OUTPUT_DIRS)

    print("\nDataset splitting completed successfully.")

if __name__ == "__main__":
    main()