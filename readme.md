# How to get started
1. Clone the repository
2. Install the required dependencies using ``pip install -r requirements.txt``
3. Download the dataset and unzip it to ``data`` folder (see readme in data folder)
4. Rename the folder from *2510* to *original*
5. Run the ``split_data.py``
6. At the end, you should have in ``data``-folder 4 folders: ```original```, ```train_data```, ```val_data``` and ```test_data```

# ``project_constants.py``
This file contains all the project-wide constants, such as paths to data folders, model parameters, functions used across scripts, etc. Change values here if needed.

# How to run from-scratch implementation
```cnn_multiclass.py``` - a from-scratch implementation of a Convolutional Neural Network for multi-class classification. Run this script to train the model. Trained model is saved to ```models```- folder <br><br>
``test_multiclass.py`` - a script to manually test the trained multiclass CNN model.







