from pathlib import Path

SRC_DIR = Path(__file__).resolve().parent.parent
ROOT_DIR = SRC_DIR.parent

DATA_DIR = ROOT_DIR / "data"
ORIGINAL_PICS_DIR = DATA_DIR / "original"
MODEL_DIR = ROOT_DIR / "models"

TRAIN_DIR = DATA_DIR / "train_data"
VAL_DIR = DATA_DIR / "val_data"
TEST_DIR = DATA_DIR / "test_data"

# Binary classification directories
BINARY_TRAIN_DIR = DATA_DIR / "binary_train_data"
BINARY_VAL_DIR = DATA_DIR / "binary_val_data"
BINARY_TEST_DIR = DATA_DIR / "binary_test_data"


# Picture dimensions
IMG_HEIGHT = 64
IMG_WIDTH = 64

# Hyperparameters
BATCH_SIZE = 32
EPOCHS = 20
SEED = 467


def get_class_names() -> list:
    if not TEST_DIR.exists():
        raise FileNotFoundError(f"Test-Verzeichnis nicht gefunden: {TEST_DIR}")
    
    class_names = sorted([d.name for d in TEST_DIR.iterdir() if d.is_dir()])
    return class_names


