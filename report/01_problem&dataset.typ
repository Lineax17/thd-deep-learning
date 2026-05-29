= Problemstellung und Datensatzbeschreibung

== Einführung in EuroSAT

Der *EuroSAT-Datensatz* ist ein moderner, frei zugänglicher Benchmark-Datensatz für die Klassifizierung von *Landnutzung und Landbedeckung* (Land Use and Land Cover, kurz: *LULC*). Er basiert auf multispektralen Satellitendaten des *Sentinel-2*-Satellitenprogramms der Europäischen Weltraumorganisation (*ESA*).

Das Hauptziel der LULC-Klassifikation in der Erdbeobachtung besteht darin, die Erdoberfläche automatisch in verschiedene physikalische Bedeckungsarten (z. B. Wälder, Flüsse) und anthropogene Nutzungsarten (z. B. Industriegebiete, Wohngebiete) einzuteilen.

=== Warum ist LULC-Klassifikation wichtig?
- *Klimaschutz & Umweltmonitoring:* Überwachung von Entwaldung, Gletscherschmelze und Wüstenbildung.
- *Präzisionslandwirtschaft:* Vorhersage von Ernteerträgen und Überwachung der Bodengesundheit.
- *Stadtplanung:* Erfassung des urbanen Wachstums und Versiegelungsgrades von Böden.
- *Katastrophenmanagement:* Analyse von Überschwemmungen, Waldbränden und deren Ausbreitung.

**Hinweis:** EuroSAT wurde 2019 von Patrick Helber et al. im Paper *"EuroSAT: A Novel Dataset and Deep Learning Benchmark for Land Use and Land Cover Classification"* vorgestellt und hat sich seitdem zu einem Standard-Benchmark für Deep-Learning-Modelle in der Fernerkundung etabliert.

=== Grundlagen: Binäre vs. Multilabel-Klassifikation
Um die in diesem Dokument beschriebenen Aufgabenstellungen zu verstehen, ist es wichtig, die beiden grundlegenden Klassifikationsparadigmen im Machine Learning zu differenzieren:

- **Binäre Klassifikation (Binary Classification):**
  Hierbei existieren **exakt zwei sich gegenseitig ausschließende Klassen** (z. B. Klasse $0$ und Klasse $1$). Das Modell beantwortet im Prinzip eine einfache Ja/Nein-Frage. Das Ergebnis ist ein einzelner Wahrscheinlichkeitswert zwischen $0$ und $1$ (erzeugt durch die Sigmoid-Funktion).
  - *Alltagsbeispiel:* Ein Spam-Filter (E-Mail ist entweder *Spam* oder *kein Spam*).
  - *Erdbeobachtung:* Zeigt eine Kachel *Wasser* oder *Land*?
- **Multilabel-Klassifikation (Multi-label Classification):**
  Hierbei existieren **mehrere Klassen**, wobei ein einzelnes Objekt **mehrere Labels gleichzeitig** besitzen kann (sie schließen sich nicht aus). Das Modell beantwortet für jede der Klassen eine eigene, unabhängige Ja/Nein-Frage. Der Output besteht aus mehreren Wahrscheinlichkeitswerten (einer pro Klasse, jeweils durch eine separate Sigmoid-Funktion berechnet).
  - *Alltagsbeispiel:* Ein Film kann den Genres *Sci-Fi*, *Action* und *Abenteuer* gleichzeitig angehören.
  - *Erdbeobachtung:* Eine Kachel zeigt eine Landschaft mit einem Wald, einem Fluss und einer angrenzenden Autobahn. Die Kachel erhält somit alle drei Labels gleichzeitig.

**Abgrenzung zur Multiklassen-Klassifikation (Multi-class):**
Dies darf nicht mit der Multilabel-Klassifikation verwechselt werden. Bei *Multi-class* (wie dem originalen EuroSAT-Datensatz) gibt es zwar viele Klassen, aber ein Bild darf **exakt einer** dieser Kategorien angehören (z. B. ist ein Bild *entweder* nur Wald *oder* nur Wohngebiet). Dies wird mathematisch über die **Softmax-Funktion** gelöst, bei der sich alle Klassenwahrscheinlichkeiten zu genau $1.0$ aufsummieren.


== Der Datensatz im Detail

EuroSAT zeichnet sich durch seine hohe Qualität und georeferenzierte Struktur aus. Jedes Bild stammt von realen Koordinaten aus **30 europäischen Ländern**.

=== Technische Spezifikationen

#table(
  columns: (1.8fr, 4fr),
  [*Parameter*], [*Spezifikation*],
  [*Gesamtbilderanzahl*], [27.000 Bilder],
  [*Bildauflösung (Pixel)*], [64 × 64 Pixel],
  [*Räumliche Auflösung*], [Bis zu 10 Meter pro Pixel (abhängig vom Spektralband)],
  [*Varianten*],
  [
    1. *RGB-Version:* Standard 3-Kanal-Bilder (JPEG, 8-Bit); 2. *Multispektrale Version:* 13-Kanal-Bilder (TIFF, 16-Bit)
  ],

  [*Klassen*], [10 disjunkte LULC-Klassen],
)

=== Die 13 Spektralkanäle von Sentinel-2
Im Gegensatz zu normalen Kameras erfassen Satelliten Wellenlängen weit außerhalb des menschlichen Sehvermögens. In der multispektralen Version von EuroSAT sind folgende 13 Kanäle enthalten:

#table(
  columns: (0.7fr, 1fr, 0.8fr, 1.6fr, 2.2fr),
  [*Band*], [*Wellenlänge (zentral)*], [*Auflösung*], [*Beschreibung*], [*Anwendung in LULC*],
  [*B1*], [443 nm], [60 m], [Aerosols (Küstenblau)], [Atmosphärenkorrektur, Aerosolerkennung],
  [*B2*], [490 nm], [10 m], [Blue (Blau)], [Sichtbarer Bereich, Gewässertiefe, Vegetation],
  [*B3*], [560 nm], [10 m], [Green (Grün)], [Sichtbarer Bereich, Peak-Vegetationsreflexion],
  [*B4*], [665 nm], [10 m], [Red (Rot)], [Sichtbarer Bereich, Chlorophyll-Absorption],
  [*B5*], [705 nm], [20 m], [Red Edge 1], [Vegetationszustand, Chlorophyll-Gehalt],
  [*B6*], [740 nm], [20 m], [Red Edge 2], [Vegetationszustand, Biomasse-Abschätzung],
  [*B7*], [783 nm], [20 m], [Red Edge 3], [Vegetationszustand, Blattflächenindex],
  [*B8*], [842 nm], [10 m], [NIR (Nahes Infrarot)], [Starke Reflexion durch gesunde Vegetation],
  [*B8a*], [865 nm], [20 m], [Narrow NIR], [Wasserdampf-Kompensation, Vegetation],
  [*B9*], [945 nm], [60 m], [Water vapour (Wasserdampf)], [Wolkenmaskierung und Wasserdampfbestimmung],
  [*B10*], [1375 nm], [60 m], [SWIR - Cirrus], [Erkennung von dünnen Cirruswolken],
  [*B11*], [1610 nm], [20 m], [SWIR 1 (Kurzwelliges Infrarot)], [Bodenfeuchte, Unterscheidung von Schnee/Eis],
  [*B12*], [2190 nm], [20 m], [SWIR 2 (Kurzwelliges Infrarot)], [Vegetationsfeuchte, Geologie],
)

=== Die 10 LULC-Klassen
Jede der 10 Klassen enthält 2.000 bis 3.000 Bilder, was EuroSAT zu einem weitgehend balancierten Datensatz macht.

+ **Industrial (Industriegebiete):** Fabriken, Lagerhallen, große versiegelte Parkplätze und Logistikzentren.
+ **Residential (Wohngebiete):** Wohnhäuser, städtische Infrastruktur, Vororte und Straßennetzwerke.
+ **Annual Crop (Einjährige Nutzpflanzen):** Ackerflächen mit jährlichem Fruchtwechsel (z. B. Weizen, Mais).
+ **Permanent Crop (Dauerhafte Nutzpflanzen):** Langfristige Agrarkulturen (z. B. Weinberge, Obstplantagen).
+ **River (Flüsse):** Fließgewässer, Kanäle und deren unmittelbare Uferbereiche.
+ **Sea & Lake (Meere & Seen):** Stehende Gewässer, Ozeanküsten, Stauseen.
+ **Herbaceous Vegetation (Krautige Vegetation):** Natürliches Grasland, Wildwiesen, nicht bewirtschaftetes Grünland.
+ **Highway (Autobahnen):** Große Fernverkehrsstraßen, Autobahntrassen, die sich durch die Landschaft ziehen.
+ **Pasture (Weideland):** Eingezäunte Wiesen zur Viehhaltung, oft mit sichtbaren Weidespuren.
+ **Forest (Wälder):** Dichte Baumbedeckung (Misch-, Nadel- oder Laubwälder).

== Die wissenschaftliche und technische Problemstellung der LULC-Klassifikation

Die automatische Klassifikation von Landnutzung und Landbedeckung (Land Use and Land Cover, LULC) mithilfe von Satellitenbildern stellt eine der zentralen Aufgabenstellungen in der modernen Fernerkundung und Geoinformatik dar. Obwohl Deep-Learning-Methoden bahnbrechende Erfolge erzielen konnten, ist die Aufgabe durch komplexe physikalische, sensorische und semantische Restriktionen geprägt.

=== Das Wesen der LULC-Klassifikation & "Semantic Gap"
In der Geowissenschaft muss strikt zwischen zwei Begriffen unterschieden werden, die oft fälschlicherweise synonym verwendet werden:

- **Landbedeckung (Land Cover):** Bezieht sich auf die physische, biophysikalische Beschaffenheit der Erdoberfläche (z. B. fließendes Wasser, Nadelwald, nackter Fels, Beton).
- **Landnutzung (Land Use):** Beschreibt die sozioökonomische Funktion oder den Zweck, zu dem eine Fläche von Menschen genutzt wird (z. B. Weideland zur Viehzucht, Wohngebiet, Industriegebiet).

**Die Problemstellung:** Satellitensensoren erfassen ausschließlich die physikalische Reflexion der Erdoberfläche (**Landbedeckung**). Ein Deep-Learning-Modell soll jedoch oft die funktionale Klassifizierung (**Landnutzung**) erlernen. Dies erzeugt eine semantische Lücke (*Semantic Gap*). Beispielsweise unterscheiden sich Weideland (*Pasture*) und natürliches Grasland (*Herbaceous Vegetation*) visuell und spektral kaum, besitzen jedoch eine völlig unterschiedliche anthropogene Zuordnung.

=== Fundamentale Herausforderungen in der Erdbeobachtung

Die praktische Umsetzung von LULC-Modellen wird durch folgende physikalische und technische Phänomene erschwert:

==== Das Mischpixel-Problem (Mixed Pixel Problem)
Die räumliche Auflösung von Sentinel-2 beträgt je nach Spektralband 10 bis 60 Meter pro Pixel. Eine EuroSAT-Kachel mit der Dimension 64 × 64 Pixeln deckt somit eine physische Fläche von ca. 640 m × 640 m (ca. 41 Hektar) ab.

- **Herausforderung:** Auf einer Fläche dieser Größe gibt es in Mitteleuropa fast nie eine vollkommen homogene Bodenbedeckung.
- **Auswirkung:** Pixel an den Grenzen verschiedener Regionen (z. B. Waldrand an einem Acker) enthalten eine physikalische Mischung der Spektralsignaturen beider Klassen. Das Modell muss lernen, diese verrauschten "Mischpixel" robust zu interpretieren, ohne falsche Klassenzuordnungen zu treffen.

==== Phänologische und saisonale Dynamik
Natürliche Oberflächen verändern ihre spektralen Eigenschaften im Jahresverlauf drastisch (Phänologie).

- **Vegetation:** Ein Laubwald wechselt von saftigem Grün im Frühling zu Rot-Braun im Herbst und verliert im Winter seine Blätter völlig, wodurch der darunterliegende Waldboden sichtbar wird.
- **Agrarwirtschaft:** Ein Weizenfeld (*Annual Crop*) durchläuft Phasen von kahlem, feuchtem Boden über grünes Wachstum bis hin zu trockenem Gelb vor der Ernte und gepflügter Erde danach.
- **Problemstellung:** Ein robustes Klassifikationsmodell darf sich nicht auf einfache Farbwerte verlassen. Es muss spektrale Signaturen erlernen, die gegenüber jahreszeitlichen, witterungsbedingten und landwirtschaftlichen Zyklen invariant sind.

==== Atmosphärische Störungen und atmosphärische Korrektur
Obwohl EuroSAT auf Level-2A-Daten basiert (die bereits durch die ESA einer atmosphärischen Korrektur unterzogen wurden, um Reflektanzen am Boden – *Bottom-Of-Atmosphere, BOA* – zu schätzen), verbleiben inhärente Störfaktoren:

- **Störungen:** Dünne Cirruswolken, Dunst, Aerosole und Wolkenschatten verändern das spektrale Signal signifikant.
- **Auswirkung:** Die spektrale Signatur einer Klasse kann durch diese Einflüsse so stark verschoben werden, dass sie einer anderen Klasse ähnelt. Modelle müssen gegenüber diesen atmosphärischen Artefakten eine hohe Fehlertoleranz aufweisen.

==== Die Dimensionalität multispektraler Daten
Im Gegensatz zu dreikanaligen RGB-Standardbildern liefert Sentinel-2 Daten in 13 Spektralkanälen. Diese Bänder decken spezifische Wellenlängen ab, darunter die *Red Edge*-Bänder (optimiert für die Vegetationsanalyse) sowie kurzwelliges Infrarot (SWIR, optimiert zur Erkennung von Boden- und Vegetationsfeuchtigkeit).

- **Herausforderung:** Die zusätzlichen Kanäle enthalten wertvolle physikalische Informationen, erhöhen jedoch auch drastisch die Dimensionalität des Feature-Raums.
- **Auswirkung:** Das neuronale Netz muss lernen, diese spektralen Signaturen und Band-Verhältnisse (wie den normierten Differenzvegetationsindex, *NDVI*) effektiv zu extrahieren, ohne in einen Zustand von Overfitting zu geraten.

== Problemstellung: Binäre Klassifikation (Binary Classification)

In vielen praktischen Szenarien ist die vollständige Unterscheidung von 10 Klassen überflüssig. Stattdessen wird die Aufgabe auf eine binäre Fragestellung reduziert, bei der das Netzwerk zwischen genau zwei disjunkten Zuständen (z. B. *Präsenz* vs. *Abszenz* eines Merkmals) entscheiden soll.

=== Gängige binäre Formulierungen auf EuroSAT
+ **Urban vs. Natur (Built-up vs. Non-built-up):**
  - **Klasse 0 (Natur):** *Forest, River, Sea & Lake, Pasture, Herbaceous Vegetation, Annual Crop, Permanent Crop*.
  - **Klasse 1 (Bebaut):** *Industrial, Residential, Highway*.
  - *Socio-ökonomischer Nutzen:* Überwachung von Urbanisierungsprozessen und Analyse der Bodenversiegelung.
+ **Wasser vs. Land (Water vs. Land):**
  - **Klasse 0 (Land):** Alle terrestrischen Klassen.
  - **Klasse 1 (Wasser):** *River, Sea & Lake*.
  - *Socio-ökonomischer Nutzen:* Echtzeit-Kartierung von Überschwemmungsgebieten bei Naturkatastrophen oder Küstenschutz.
+ **Wald vs. Nicht-Wald (Forest vs. Non-Forest):**
  - **Klasse 0 (Nicht-Wald):** Alle übrigen 9 Klassen.
  - **Klasse 1 (Wald):** *Forest*.
  - *Socio-ökonomischer Nutzen:* Früherkennung illegaler Abholzung (Deforestation) sowie Monitoring von Waldbrand-Ausbreitungen.

=== Methodische und mathematische Herausforderungen

==== Extrem komplexer Feature-Raum durch Klassen-Aggregation
Wenn man sieben biologisch und physikalisch grundverschiedene Klassen (wie tiefblaues Meereswasser, hellen Ackerboden und saftige Weiden) zu einer einzigen Klasse "Natur" aggregiert, zwingt man das neuronale Netz dazu, extrem disparate Spektralverteilungen unter einem einzigen Label zu vereinen.

- **Konsequenz:** Die Entscheidungsgrenze im hochdimensionalen Feature-Raum wird hochgradig nicht-linear und komplex. Das Modell muss lernen, dass trotz minimaler spektraler Ähnlichkeit zwischen einer Ackerfläche und einem See beide der "Natur"-Klasse angehören.

==== Massives Klassen-Ungleichgewicht (Class Imbalance)
Durch die Zusammenlegung von Klassen entsteht fast immer ein starkes Ungleichgewicht.

- *Beispiel:* Im "Wald vs. Nicht-Wald"-Szenario stehen 3.000 Wald-Bilder ca. 24.000 Nicht-Wald-Bildern gegenüber (Verhältnis 1:8).
- **Das Problem:** Wird ein solches Modell mit einer Standard-BCE-Verlustfunktion trainiert, neigt das Modell dazu, die Majoritätsklasse ("Nicht-Wald") massiv zu bevorzugen. Es erzielt eine scheinbar hervorragende Genauigkeit (Accuracy) von über 88 %, selbst wenn es keinen einzigen Wald-Pixel korrekt erkennt.
- **Lösungsansatz:** Verwendung gewichteter Verlustfunktionen (z. B. `pos_weight` in PyTorch's `BCEWithLogitsLoss`) oder alternativer Losses wie Focal Loss sowie die Bewertung anhand des *F1-Scores* und der *Precision-Recall-AUC* anstelle der reinen Accuracy.

==== Grenzfälle an Infrastrukturlinien
Ein typischer Grenzfall im binären Szenario ist ein Bild der Klasse *Highway*, das sich als schmale Betonlinie durch einen dichten Wald zieht. Für eine binäre "Urban vs. Natur"-Klassifikation muss das Modell entscheiden, ob die Natur oder die Infrastruktur überwiegt. Dies führt zu inhärentem Rauschen in den Trainingsdaten, da solche Kacheln oft subjektiv gelabelt sind.

=== Technische Implementierung (Binär)
- **Letzte Ebene des Modells:** 1 Ausgangsneuron.
- *Aktivierungsfunktion:* *Sigmoid* sigma(x) = 1 / (1 + e^-x), um einen Wahrscheinlichkeitswert zwischen 0 und 1 zu erhalten.
- **Loss-Funktion:** **Binary Cross-Entropy Loss (BCE Loss)**.

  *Formel:* `L_BCE = -(1 / N) sum_{i=1}^{N} [y_i log(p_i) + (1 - y_i) log(1 - p_i)]`

- **Metriken:** F1-Score (primär bei Klassen-Imbalance), Precision, Recall, ROC-AUC, Balanced Accuracy.

== Problemstellung: Multilabel-Klassifikation (Multi-label Classification)

**Konzeptioneller Unterschied:**
Der originale EuroSAT-Datensatz wurde als *Single-label (Multi-class)* Datensatz konzipiert. Jedem Bild ist exakt *eine* dominante Klasse zugeordnet. In der echten Fernerkundungspraxis ist dies jedoch ein künstlicher und oft fehlerhafter Ansatz, da auf einer Fläche von 640 m × 640 m fast immer *mehrere Bedeckungsarten koexistieren*.

=== Das Single-Label-Dilemma in der Erdbeobachtung
Wenn ein Fluss (*River*) durch ein Wohngebiet (*Residential*) fließt oder eine Eisenbahntrasse eine Weide kreuzt, muss beim Single-Label-Ansatz eine Klasse willkürlich als dominant deklariert werden.

- **Das Problem:** Das neuronale Netz sieht die Spektralsignatur von Wasser und Asphalt, wird aber dafür bestraft, wenn es diese Klassen vorhersagt, weil das offizielle Label "Residential" lautet.
- **Auswirkung:** Dies erzeugt ein systematisches Label-Rauschen im Trainingsdatensatz, behindert die Generalisierung des Modells auf große, zusammenhängende Satellitenszenen und schränkt den praktischen Nutzen ein.

Die Formulierung als **Multilabel-Problem** löst dieses Dilemma auf, indem sie dem Modell erlaubt, das gleichzeitige Vorhandensein mehrerer Klassen unabhängig voneinander vorherzusagen.

=== Methodische und mathematische Herausforderungen

==== Die mathematische Unabhängigkeitsannahme und ihre Grenzen
In der Multilabel-Klassifikation wird die Wahrscheinlichkeit jeder Klasse unabhängig über eine eigene Sigmoid-Aktivierung berechnet:

`p_c = sigma(z_c)` für `c in {1, ..., C}`

Die Verlustfunktion summiert die binären Kreuzentropien über alle Klassen hinweg.

- **Das methodische Problem:** Dieser Ansatz geht mathematisch davon aus, dass die Klassen statistisch unabhängig voneinander sind. In der Realität der Erdbeobachtung weisen LULC-Klassen jedoch starke Korrelationen (Kookkurrenzen) auf.
- *Beispiel:* Das Auftreten von *Industrial* korreliert stark positiv mit *Highway* und extrem negativ mit *Forest*. Ein einfaches Multilabel-Modell ignoriert diese semantischen Abhängigkeiten im Loss-Raum. Moderne Architekturen versuchen daher, diese Kovarianzen über Graph Neural Networks (GNNs) oder hierarchische Loss-Funktionen explizit zu modellieren.

==== Generierung valider Multilabel-Annotationen (Weak Supervision)
Da EuroSAT standardmäßig keine Multilabel-Annotationen besitzt, müssen Forscher auf Hilfskonstruktionen zurückgreifen:

===== Ansatz A: Pseudo-Multilabeling (Soft-Labels)
Hierbei wird das Problem technisch als Multilabel-Problem formuliert, obwohl die Trainingsdaten als One-Hot-Vektoren vorliegen. Das Modell lernt für jede Klasse unabhängig die Entscheidung "vorhanden/nicht vorhanden". Dies trainiert das Netz darauf, flexibler auf Mischklassen in realen Testdaten zu reagieren.

===== Ansatz B: Regelbasierte Attribut-Aggregation
Bilder werden in übergeordnete, sich nicht ausschließende physische Dimensionen umsortiert:

- $y_1$ = *Vegetation vorhanden?* (Positiv bei: Forest, Pasture, Herbaceous Vegetation, Crops)
- $y_2$ = *Wasser vorhanden?* (Positiv bei: River, Sea & Lake)
- $y_3$ = *Anthropogene Struktur vorhanden?* (Positiv bei: Industrial, Residential, Highway)

Ein Bild, das ein Wohngebiet mit Gärten und einem angrenzenden Fluss zeigt, erhält somit den Zielvektor $[1, 1, 1]$ (Vegetation, Wasser, Struktur).

=== Technische Implementierung (Multilabel)
- **Letzte Ebene des Modells:** $C$ Ausgangsneuronen (eines pro Klasse, z. B. $C=10$).
- **Aktivierungsfunktion:** **Sigmoid** auf jedem der $C$ Ausgänge unabhängig angewendet (NICHT Softmax!).
- **Loss-Funktion:** Summierter Binary Cross-Entropy Loss mit Logits (**BCEWithLogitsLoss**):

  *Formel:* `L_Multilabel = sum_{c=1}^{C} L_BCE(y_c, p_c)`

- **Metriken:** Mean Average Precision (mAP), Macro-F1-Score, Hamming-Loss (Anteil falsch klassifizierter Label-Bits).

== Vergleich der Klassifikationsaufgaben auf EuroSAT

#table(
  columns: (1.7fr, 1.8fr, 1.7fr, 1.9fr),
  [*Kriterium*], [*Binäre Klassifikation*], [*Multi-Class (Standard)*], [*Multilabel-Klassifikation*],
  [*Anzahl Klassen*],
  [2 (z. B. Wasser vs. Land)],
  [10 disjunkte Klassen],
  [10 (oder mehr) nicht-ausschließende Attribute],

  [*Output-Dimension*], [1], [10], [10],
  [*Aktivierungsfunktion*], [Sigmoid], [Softmax], [Sigmoid (auf jedem Kanal unabhängig)],
  [*Verlustfunktion*], [BCE Loss], [Cross-Entropy Loss], [BCE Loss (summiert/gemittelt)],
  [*Label-Format*],
  [Binärer Skalar ($0$ oder $1$)],
  [Integer ($0$ bis $9$) oder One-Hot],
  [Binärer Vektor (z. B. $[1, 0, 1, 0, 0, 0, 0, 1, 0, 0]$)],

  [*Interpretation*],
  ["Ist auf dem Bild Wasser?"],
  ["Welches ist das *eine* dominierende Landbedeckungsmerkmal?"],
  ["Welche der 10 Merkmale sind *alle* auf dem Bild zu sehen?"],
)
