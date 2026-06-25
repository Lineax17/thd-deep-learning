= Convolutional Neural Network von Scratch

Die Suche nach einer geeigneten Architektur für unser CNN von Scratch umfasste mehrere Versuche. Zunächst analysierten wir den Datensatz und seine Eigenschaften. Wie bereits in der Beschreibung erwähnt, ist der EuroSAT-Datensatz vergleichsweise klein und enthält entsprechend kleine Bilder. Daher war schnell klar, wie wir bei der Architektursuche vorgehen würden: Wir begannen mit einem kleinen Netz, vergrößerten es gezielt bis zum Overfitting und verkleinerten es anschließend wieder, bis wir einen möglichst guten Kompromiss gefunden hatten. Daraus entstand unser erster Versuch.

== Versuch 1 - Ein kleines Netz

Unser erstes kleines Netz sah wie folgt aus:

Die Architektur besteht aus drei aufeinanderfolgenden Convolutional-Blöcken sowie einem anschließenden vollständig verbundenen Klassifikator.

Jeder Convolutional-Block setzt sich aus einer Faltungsschicht (Conv2D) mit ReLU-Aktivierung und einer anschließenden Max-Pooling-Schicht zusammen. Die Faltungsschichten dienen der Extraktion lokaler Bildmerkmale, während das Max-Pooling die räumliche Auflösung reduziert und damit die Rechenkomplexität verringert.

Die Anzahl der Filter steigt im Verlauf des Netzwerks von 32 auf 64, wodurch zunehmend komplexere Merkmale gelernt werden können.

Nach der Feature-Extraktion werden die Feature Maps mittels Flatten in einen Vektor überführt und durch zwei Dense-Schichten klassifiziert. Zur Regularisierung wird eine Dropout-Schicht eingesetzt, um Overfitting zu reduzieren.

```python
def create_model():
    model = models.Sequential([
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
#v(-2pt)
#text(size: 8pt)[Listing 1. Model architecture used in experiment 1]
#v(8pt)

Dieses Modell konnte in der Multiclass-Klassifikation bereits eine Accuracy von über 80% erzielen, ohne zu overfitten. Der nächste Schritt bestand daher darin, das Modell zu vergrößern und bewusst Overfitting zu erzeugen. Später stellte sich jedoch heraus, dass dieses Netz für das binäre Klassifikationsproblem bereits ausreichte.

== Versuch 2 - Gezieltes Overfitting

Um dieses Überfitten gezielt zu produzieren, wurde die Netzwerkarchitektur im zweiten Versuch erheblich vergrößert und strukturell an modernere Conv-Nets angepasst.

Damit besteht jeder Block aus zwei aufeinanderfolgenden Faltungsschichten mit „same“-Padding, gefolgt von Batch-Normalisierung und ReLU-Aktivierung. Diese Kombination ermöglicht eine stabilere und effizientere Trainingsdynamik, da interne Kovariatenverschiebungen reduziert werden.

Nach jeweils zwei Faltungsschichten erfolgt ein Max-Pooling zur Reduktion der räumlichen Dimensionen. Die Anzahl der Filter wird blockweise von 32 über 64 und 128 bis auf 256 erhöht, wodurch im Gegensatz zum ersten Netz eine hierarchischere Merkmalsextraktion ermöglicht wird.

Zusätzlich wird L2-Regularisierung (Weight Decay) in den Faltungsschichten eingesetzt, um Overfitting entgegenzuwirken.

Im Klassifikationskopf wird anstelle eines Flatten-Layers ein Global Average Pooling verwendet. Dies reduziert die Anzahl der Parameter signifikant und verbessert die Generalisierungsfähigkeit. Abschließend erfolgt die Klassifikation über zwei Dense-Schichten mit Dropout-Regularisierung.

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
#v(-2pt)
#text(size: 8pt)[Listing 2. Model architecture used in experiment 2]
#v(8pt)

Im Vergleich zum ersten Modell weist das zweite Modell eine deutlich tiefere und stärker regularisierte Architektur auf. Durch den Einsatz mehrerer Faltungsschichten pro Block sowie Batch-Normalisierung kann eine robustere Feature-Repräsentation gelernt werden. Zudem reduziert Global Average Pooling die Modellkomplexität im Klassifikationskopf, was insbesondere bei begrenzten Trainingsdaten von Vorteil ist.

Die Architektur orientiert sich an Designprinzipien moderner CNNs wie VGGNet, reduziert jedoch gezielt die Tiefe, um sich besser an die begrenzte Datensatzgröße anzupassen. @simonyan2014vgg @he2015resnet

Aufgrund der Eigenschaften des Datensatzes führte dieses Modell erwartungsgemäß zu starkem Overfitting. Damit hatten wir unser Ziel für diesen Versuch erreicht (bewusstes Overfitting) und konnten das Modell danach schrittweise wieder verkleinern.

== Versuch 3 - Die Suche nach der goldenen Mitte

Für den dritten Versuch haben wir die Architektur aus Versuch 2 genommen, aber die Anzahl der Layer reduziert.

#place(top, float: true, clearance: 15.5pt)[
  #block(width: 100%)[
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
    #v(-2pt)
    #text(size: 8pt)[Listing 3. Model architecture used in experiment 3]
  ]
]

Im Gegensatz zum zweiten Modell besteht jeder Convolutional-Block nur noch aus einer einzelnen Faltungsschicht, gefolgt von Batch-Normalisierung, ReLU-Aktivierung und Max-Pooling. Dadurch wird die Tiefe des Netzwerks deutlich reduziert, was zu einer geringeren Anzahl trainierbarer Parameter führt.

Die Anzahl der Filter steigt weiterhin blockweise von 32 über 64 auf 128 an, sodass die grundlegende hierarchische Feature-Extraktion erhalten bleibt. Allerdings entfällt die zweite Faltungsschicht pro Block, wodurch die Fähigkeit zur Modellierung komplexer Merkmale eingeschränkt ist.

Wie im zweiten Modell werden Batch-Normalisierung sowie L2-Regularisierung eingesetzt, um das Training zu stabilisieren und Overfitting zu reduzieren.

Der Klassifikationskopf bleibt weitgehend unverändert und verwendet Global Average Pooling sowie Dropout-Regularisierung. Im Unterschied zu den vorherigen Modellen wird die finale Dense-Schicht jedoch auf zwei Ausgabeneuronen angepasst, um das binäre Klassifikationsproblem zu lösen.

Damit konnten wir das Overfitting reduzieren, aber noch nicht vollständig beheben. Daraufhin war die nächste Idee, die Breite des Modells zu verringern (maximal 64 Neuronen), dafür aber die Tiefe leicht zu vergrößern.


== Versuch 4 - Die erfolgreiche finale Architektur

Anschließend führten wir unseren letzten und erfolgreichsten Versuch durch.

Das vierte Modell stellt damit eine ausgewogene Weiterentwicklung der vorherigen Ansätze dar. Die Architektur besteht aus zwei Convolutional-Blöcken, die jeweils zwei aufeinanderfolgende Faltungsschichten mit Batch-Normalisierung und ReLU-Aktivierung enthalten. Durch die Verwendung mehrerer Faltungsschichten pro Block wird eine hierarchische Merkmalsextraktion innerhalb eines Blocks ermöglicht, wodurch komplexere Feature-Repräsentationen gelernt werden können.

Im Vergleich zu tieferen Architekturen wird die Anzahl der Blöcke jedoch bewusst auf zwei beschränkt. Dies reduziert die Modellkomplexität und verhindert eine zu starke räumliche Reduktion der Feature Maps durch wiederholtes Pooling.

Die Anzahl der Filter steigt von 32 auf 64 an, wodurch eine schrittweise Erweiterung des Merkmalsraums erfolgt. Zur Stabilisierung des Trainings und zur Reduktion von Overfitting werden sowohl Batch-Normalisierung als auch L2-Regularisierung eingesetzt.

Der Klassifikationskopf verwendet Global Average Pooling zur Reduktion der Parameteranzahl, gefolgt von Dense-Schichten mit Dropout-Regularisierung. Die finale Softmax-Schicht ermöglicht die Klassifikation in zehn Klassen.

```python

def create_model():
    weight_decay = 1e-4
```
#pagebreak()
```python
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
#v(-2pt)
#text(size: 8pt)[Listing 4. Model architecture used in experiment 4]
#v(8pt)

Mit diesem Modell konnten wir kein Overfitting mehr feststellen. Mit diesem Ansatz stieg die Accuracy von etwa 80 % auf beachtliche 88 % an. Für eine von Grund auf selbst entwickelte CNN-Architektur stellt dies ein äußerst solides Resultat dar, welches eine gute Generalisierungsfähigkeit bei einer ausgewogenen Modellkomplexität für diese Multilabel-Aufgabe belegt.

Wie schon bei Versuch 1 erwähnt, war dieser erste Versuch für das binäre Klassifikationsproblem am erfolgreichsten. Dazu jedoch mehr bei der Auswertung der Ergebnisse.