= Convolutional Neural Network von Scratch

Die Findung einer guten Architektur für unser CNN von Scratch involvierte diverse Versuche. Zuerst sahen wir uns den Datensatz an und analysierten seine Gegebenheiten. Wie schon in der Beschreibung erwähnt ist der EuroSAT Datensatz ein verhältnismäßig kleiner Datensatz mit verhältnismäßig kleinen Bildern. Dadurch war klar wie wir mit der Architektur-Findung anfangen. Wir würden ein kleines Netz nehmen und dieses dann bis zum Punkt des Overfittings vergrößern. Danach verkleinern wir es bis wir einen Punkt des optimalen Fits finden. Dadurch kam unser erster Versuch zu Stande.

== Versuch 1 - Ein kleines Netz

Unser erstes kleines Netz sah wie folgt aus:

```python
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
```

Die Architektur besteht aus drei aufeinanderfolgenden Convolutional-Blöcken sowie einem anschließenden voll verbundenen Klassifikator.

Jeder Convolutional-Block setzt sich aus einer Faltungsschicht (Conv2D) mit ReLU-Aktivierung und einer anschließenden Max-Pooling-Schicht zusammen. Die Faltungsschichten dienen der Extraktion lokaler Bildmerkmale, während das Max-Pooling eine Reduktion der räumlichen Auflösung bewirkt und somit die Rechenkomplexität verringert.

Die Anzahl der Filter steigt im Verlauf des Netzwerks von 32 auf 64, wodurch zunehmend komplexere Merkmale gelernt werden können.

Nach der Feature-Extraktion werden die Feature Maps mittels Flatten in einen Vektor überführt und durch zwei Dense-Schichten klassifiziert. Zur Regularisierung wird eine Dropout-Schicht eingesetzt, um Overfitting zu reduzieren.

Dieses Modell konnte in der Multilabelclassification schon über 80% Accuracy erzielen ohne zu Overfitten. Der nächste Schritt war nun dieses Modell zu vergrößern und damit bewusst Overfitting zu erreichen. Was wir später herausfinden sollten war, dass für das binäre Klassifikationsproblem dieses Netz sogar schon ausreichend war. 

== Versuch 2 - Gezieltes Overfitting

Deshalb haben wir das Modell deutlich verringert und zusätzlich architektonisch an modernere Conv-Nets angepasst. 

```python
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

        # Block 3: 128 filters
        layers.Conv2D(128, 3, padding='same', kernel_regularizer=regularizers.l2(weight_decay)),
        layers.BatchNormalization(),
        layers.Activation('relu'),
        layers.Conv2D(128, 3, padding='same', kernel_regularizer=regularizers.l2(weight_decay)),
        layers.BatchNormalization(),
        layers.Activation('relu'),
        layers.MaxPooling2D(2),

        # Block 4: 256 filters
        layers.Conv2D(256, 3, padding='same', kernel_regularizer=regularizers.l2(weight_decay)),
        layers.BatchNormalization(),
        layers.Activation('relu'),
        layers.MaxPooling2D(2),

        # Classifier
        layers.GlobalAveragePooling2D(),
        layers.Dropout(0.5),
        layers.Dense(128, activation='relu', kernel_regularizer=regularizers.l2(weight_decay)),
        layers.Dropout(0.5),
        layers.Dense(10, activation='softmax')
    ])
    return model
```

Damit besteht jeder Block aus zwei aufeinanderfolgenden Faltungsschichten mit „same“-Padding, gefolgt von Batch-Normalisierung und ReLU-Aktivierung. Diese Kombination ermöglicht eine stabilere und effizientere Trainingsdynamik, da interne Kovariatenverschiebungen reduziert werden.

Nach jeweils zwei Faltungsschichten erfolgt ein Max-Pooling zur Reduktion der räumlichen Dimensionen. Die Anzahl der Filter wird blockweise von 32 über 64 und 128 bis auf 256 erhöht, wodurch eine hierarchischere Merkmalsextraktion in Gegensatz zum ersten Netz ermöglicht wird.

Zusätzlich wird L2-Regularisierung (Weight Decay) in den Faltungsschichten eingesetzt, um Overfitting entgegenzuwirken.

Im Klassifikationskopf wird anstelle eines Flatten-Layers ein Global Average Pooling verwendet. Dies reduziert die Anzahl der Parameter signifikant und verbessert die Generalisierungsfähigkeit. Abschließend erfolgt die Klassifikation über zwei Dense-Schichten mit Dropout-Regularisierung.

Im Vergleich zum ersten Modell weist das zweite Modell eine deutlich tiefere und stärker regulärisierte Architektur auf. Durch den Einsatz mehrerer Faltungsschichten pro Block sowie Batch-Normalisierung kann eine robustere Feature-Repräsentation gelernt werden. Zudem reduziert Global Average Pooling die Modellkomplexität im Klassifikationskopf, was insbesondere bei begrenzten Trainingsdaten von Vorteil ist.

Aufgrund der Natur des Datensatzes führte dieses Modell wie erwartet zu großem Overfitting. Damit war das Ziel dieses Versuchs erreicht und wir konnten uns ab hier zurück arbeiten. 

== Versuch 3 - Die Suche nach der goldenen Mitte 

Im dritten Versuch haben wir das Netz aus dem zweiten Versuch genommen und die Anzahl der Layer ein wenig reduziert.

```python
def create_model():
    weight_decay = 1e-4

    model = models.Sequential([
        layers.Input(shape=(IMG_HEIGHT, IMG_WIDTH, 3)),
        layers.Rescaling(1.0/255),

        # Block 1: 32 filters
        layers.Conv2D(32, 3, padding='same', kernel_regularizer=regularizers.l2(weight_decay)),
        layers.BatchNormalization(),
        layers.Activation('relu'),
        layers.MaxPooling2D(2),

        # Block 2: 64 filters
        layers.Conv2D(64, 3, padding='same', kernel_regularizer=regularizers.l2(weight_decay)),
        layers.BatchNormalization(),
        layers.Activation('relu'),
        layers.MaxPooling2D(2),

        # Block 3: 128 filters
        layers.Conv2D(128, 3, padding='same', kernel_regularizer=regularizers.l2(weight_decay)),
        layers.BatchNormalization(),
        layers.Activation('relu'),
        layers.MaxPooling2D(2),

        # Classifier
        layers.GlobalAveragePooling2D(),
        layers.Dropout(0.5),
        layers.Dense(128, activation='relu', kernel_regularizer=regularizers.l2(weight_decay)),
        layers.Dropout(0.5),
        layers.Dense(10, activation='softmax')
    ])
    return model
```

Im Gegensatz zum zweiten Modell besteht jeder Convolutional-Block nur noch aus einer einzelnen Faltungsschicht, gefolgt von Batch-Normalisierung, ReLU-Aktivierung und Max-Pooling. Dadurch wird die Tiefe des Netzwerks deutlich reduziert, was zu einer geringeren Anzahl trainierbarer Parameter führt.

Die Anzahl der Filter steigt weiterhin blockweise von 32 über 64 auf 128 an, sodass grundlegende hierarchische Feature-Extraktion erhalten bleibt. Allerdings entfällt die zweite Faltungsschicht pro Block, wodurch die Fähigkeit zur Modellierung komplexer Merkmale eingeschränkt ist.

Wie im zweiten Modell werden Batch-Normalisierung sowie L2-Regularisierung eingesetzt, um das Training zu stabilisieren und Overfitting zu reduzieren.

Der Klassifikationskopf bleibt weitgehend unverändert und verwendet Global Average Pooling sowie Dropout-Regularisierung. Im Unterschied zu den vorherigen Modellen wird die finale Dense-Schicht jedoch auf zwei Ausgabeneuronen angepasst, um ein binäres Klassifikationsproblem zu lösen.

Damit konnten wir das Overfitting reduzieren aber noch nicht ganz beheben. Daraufhin war die nächste Idee die Breite des Modells zu verringern (max 64 Neuronen), aber dafür die Tiefe ein wenig zu vergrößern.


== Versuch 4 - Auf dem Weg zu einem guten Modell 

Hierauf führten wir unseren letzten und erfolgreichsten Versuch durch.

```python
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
```

Das vierte Modell stellt damit eine ausgewogene Weiterentwicklung der vorherigen Ansätze dar, bei der eine moderate Netzwerktiefe mit effektiver Regularisierung kombiniert wird.

Die Architektur besteht aus zwei Convolutional-Blöcken, die jeweils zwei aufeinanderfolgende Faltungsschichten mit Batch-Normalisierung und ReLU-Aktivierung enthalten. Durch die Verwendung mehrerer Faltungsschichten pro Block wird eine hierarchische Merkmalsextraktion innerhalb eines Blocks ermöglicht, wodurch komplexere Feature-Repräsentationen gelernt werden können.

Im Vergleich zu tieferen Architekturen wird die Anzahl der Blöcke jedoch bewusst auf zwei beschränkt. Dies reduziert die Modellkomplexität und verhindert eine zu starke räumliche Reduktion der Feature Maps durch wiederholtes Pooling.

Die Anzahl der Filter steigt von 32 auf 64 an, wodurch eine schrittweise Erweiterung des Merkmalsraums erfolgt. Zur Stabilisierung des Trainings und zur Reduktion von Overfitting werden sowohl Batch-Normalisierung als auch L2-Regularisierung eingesetzt.

Der Klassifikationskopf verwendet Global Average Pooling zur Reduktion der Parameteranzahl, gefolgt von Dense-Schichten mit Dropout-Regularisierung. Die finale Softmax-Schicht ermöglicht die Klassifikation in zehn Klassen.

Mit diesem Modell konnten wir keinerlei Overfitting bei der Multilabelclassification mehr feststellen. Die Accuracy stieg damit von ca 80% auf 88% an, was uns zu dem Schluss führt dass wir hiermit auf dem Weg zu einem guten Modell sind, das eine gute Generalisierungsfähigkeit und eine für das Vorliegende Problem geeignete Komplexität bietet.