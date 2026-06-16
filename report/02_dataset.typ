= Datensatzbeschreibung <datensatzbeschreibung>

Für die Durchführung der Klassifikationsaufgaben wird der EuroSAT-Datensatz verwendet, der speziell für die Landnutzungs- und Landbedeckungsklassifikation (LULC) auf Basis von Satellitendaten entwickelt wurde @helber2019eurosat. Die Bilddaten stammen aus dem europäischen Erdbeobachtungsprogramm *Copernicus* und wurden von den Sentinel-2-Satelliten aufgezeichnet @helber2019eurosat.

Der Datensatz zeichnet sich durch folgende technische Spezifikationen aus:

- *Umfang und Struktur:* EuroSAT umfasst insgesamt 27.000 annotierte und georeferenzierte Einzelbilder @helber2019eurosat.
- *Klassen:* Die Bilder sind in zehn unterschiedliche Landnutzungskategorien unterteilt, darunter Klassen wie Wald, Gewässer, Autobahnen, landwirtschaftliche Nutzflächen und urbane Strukturen @helber2019eurosat, @howard2019mobilenetv3.
- *Auflösung:* Jedes Bild weist eine räumliche Auflösung von $64 times 64$ Pixeln auf @helber2019eurosat. Diese vergleichsweise geringe Auflösung stellt eine besondere Herausforderung für Deep-Learning-Modelle dar, da Merkmale auf engem Raum extrahiert werden müssen und die Gefahr von Overfitting besteht @howard2019mobilenetv3.
- *Datenformate:* Der Datensatz wird in zwei Varianten bereitgestellt: einer multispektralen Version (MS) mit 13 Spektralbändern und einer konvertierten RGB-Version @helber2019eurosat. Für die vorliegende Arbeit wird die RGB-Variante genutzt, um die Kompatibilität mit gängigen vortrainierten Modellen aus dem Bereich des Transfer Learnings zu gewährleisten. Die Bilder liegen im JPEG-Format vor.
- *Klassenverteilung:* Eine explorative Datenanalyse zeigt, dass der Datensatz nicht vollständig balanciert ist. Die Anzahl der Bilder pro Klasse variiert zwischen 2.000 und 3.000, wobei die Klasse _Pasture_ mit 2.000 Bildern am schwächsten vertreten ist, während die Klassen _AnnualCrop_, _Forest_, _HerbaceousVegetation_, _Residential_ und _SeaLake_ jeweils 3.000 Bilder umfassen. Die übrigen Klassen (_Highway_, _Industrial_, _PermanentCrop_, _River_) liegen mit je 2.500 Bildern im mittleren Bereich. Die genaue Verteilung ist in @tab-klassen dargestellt.

#figure(
  // [Abbildung: Balkendiagramm der Klassenverteilung einfügen]
  rect(width: 100%, height: 6cm, stroke: 0.5pt)[
    #align(center + horizon)[_Abbildung: Klassenverteilung im EuroSAT-Datensatz_]
  ],
  caption: [Klassenverteilung im EuroSAT-Datensatz (Balkendiagramm).],
) <fig-klassenverteilung>

#figure(
  table(
    columns: (auto, auto),
    align: (left, center),
    table.header([*Klasse*], [*Anzahl Bilder*]),
    [AnnualCrop],         [3.000],
    [Forest],             [3.000],
    [HerbaceousVegetation], [3.000],
    [Highway],            [2.500],
    [Industrial],         [2.500],
    [Pasture],            [2.000],
    [PermanentCrop],      [2.500],
    [Residential],        [3.000],
    [River],              [2.500],
    [SeaLake],            [3.000],
  ),
  caption: [Anzahl der Bilder pro Klasse im EuroSAT-Datensatz.],
) <tab-klassen>

- *Pixelstatistiken:* Die Analyse der mittleren RGB-Intensitätswerte offenbart deutliche Unterschiede zwischen den Klassen. Die Klasse _Forest_ weist die niedrigsten Intensitätswerte aller drei Kanäle auf und erscheint somit im Mittel am dunkelsten, was die homogene, dichte Vegetation widerspiegelt. Klassen wie _Industrial_ und _AnnualCrop_ zeigen hingegen deutlich höhere Mittelwerte. Hinsichtlich der Varianz der Pixelintensitäten fällt _Industrial_ durch die höchste Standardabweichung auf, was auf strukturreiche und heterogene Bildinhalte hinweist. Im Kontrast dazu zeigt _Forest_ auch hier die geringste Varianz, was auf homogene Flächen schließen lässt.

Der EuroSAT-Datensatz dient in der Wissenschaft als Benchmark für Deep-Learning-Verfahren. In der ursprünglichen Studie wurde mit modernsten Convolutional Neural Networks (CNNs) eine Klassifikationsgenauigkeit von bis zu 98,57 % erreicht @helber2019eurosat. Damit bietet er eine verlässliche Grundlage, um die Leistung des eigenständig entwickelten CNN-Modells gegenüber dem Transfer-Learning-Ansatz objektiv zu bewerten.

Die Wahl dieses Datensatzes ist zudem durch seine offene Verfügbarkeit unter der MIT-Lizenz begründet, was die Reproduzierbarkeit der Ergebnisse im akademischen Kontext unterstützt @helber2019eurosat. Für das Modelltraining ergibt sich aus der leichten Klassenungleichgewichtung die Empfehlung, stratifiziertes Sampling einzusetzen, um eine repräsentative Aufteilung in Trainings-, Validierungs- und Testmengen zu gewährleisten. Darüber hinaus erfordert die niedrige native Auflösung von $64 times 64$ Pixeln beim Einsatz von Transfer-Learning-Architekturen wie MobileNetV3, deren Eingangsformat auf $224 times 224$ Pixel ausgelegt ist, ein entsprechendes Upscaling der Eingabebilder.

