= Datensatzbeschreibung <datensatzbeschreibung>

Für die Durchführung der Klassifikationsaufgaben wird der EuroSAT-Datensatz verwendet, der speziell für die Landnutzungs- und Landbedeckungsklassifikation (LULC) auf Basis von Satellitendaten entwickelt wurde @helber2019eurosat. Die Bilddaten stammen aus dem europäischen Erdbeobachtungsprogramm *Copernicus* und wurden von den Sentinel-2-Satelliten aufgezeichnet @helber2019eurosat.

Der Datensatz zeichnet sich durch folgende technische Spezifikationen aus:

- *Umfang und Struktur:* EuroSAT umfasst insgesamt 27.000 annotierte und georeferenzierte Einzelbilder @helber2019eurosat.
- *Klassen:* Die Bilder sind in zehn unterschiedliche Landnutzungskategorien unterteilt, darunter Klassen wie Wald, Gewässer, Autobahnen, landwirtschaftliche Nutzflächen und urbane Strukturen @helber2019eurosat, @howard2019mobilenetv3.
- *Auflösung:* Jedes Bild weist eine räumliche Auflösung von $64 times 64$ Pixeln auf @helber2019eurosat. Diese vergleichsweise geringe Auflösung stellt eine besondere Herausforderung für Deep-Learning-Modelle dar, da Merkmale auf engem Raum extrahiert werden müssen und die Gefahr von Overfitting besteht @howard2019mobilenetv3.
- *Datenformate:* Der Datensatz wird in zwei Varianten bereitgestellt: einer multispektralen Version (MS) mit 13 Spektralbändern und einer konvertierten RGB-Version @helber2019eurosat. Für die vorliegende Arbeit wird die RGB-Variante genutzt, um die Kompatibilität mit gängigen vortrainierten Modellen aus dem Bereich des Transfer Learnings zu gewährleisten.

Der EuroSAT-Datensatz dient in der Wissenschaft als Benchmark für Deep-Learning-Verfahren. In der ursprünglichen Studie wurde mit modernsten Convolutional Neural Networks (CNNs) eine Klassifikationsgenauigkeit von bis zu 98,57 % erreicht @helber2019eurosat. Damit bietet er eine verlässliche Grundlage, um die Leistung des eigenständig entwickelten CNN-Modells gegenüber dem Transfer-Learning-Ansatz objektiv zu bewerten. 

Die Wahl dieses Datensatzes ist zudem durch seine offene Verfügbarkeit unter der MIT-Lizenz begründet, was die Reproduzierbarkeit der Ergebnisse im akademischen Kontext unterstützt @helber2019eurosat.

