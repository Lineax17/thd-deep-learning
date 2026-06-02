= Ergebnisse

== CNN von Scratch

=== Versuch 1
Unser Einstieg erfolgte über eine flache Netzwerkarchitektur, die bewusst einfach gehalten wurde. Bei der Multilabel-Klassifikation ergab sich eine Validierungsgenauigkeit, die stetig bis zur letzten Epoche (auf etwa 82,8 %) anstieg, ohne dass es zu Overfitting kam. Auch bei der binären Variante stieg die Accuracy kontinuierlich auf über 94 % auf den Validierungsdaten an. Der stetige Rückgang des *Loss* und die ausbleibende Divergenz zwischen Trainings- und Validierungsdaten weisen stark darauf hin, dass das Netzwerk noch deutliche Underfitting-Tendenzen aufweist und größer aufgebaut werden sollte.

#figure(
  image("figures/versuch_1_multilabel_classification.png", width: 90%),
  caption: [Lernverlauf Versuch 1 (Multilabel)]
)

#figure(
  image("figures/versuch_1_binary_classification.png", width: 90%),
  caption: [Lernverlauf Versuch 1 (Binär)]
)

=== Versuch 2
In Versuch 2 versuchten wir das andere Extrem und implementierten ein sehr tiefes Netzwerk mit vielen Filtern (bis zu 256), um gezielt Overfitting zu erzeugen. Wie erwartet, trennten sich Validierungs- und Trainings-Curves früh auf. Bei der Multilabel-Klassifikation wies der Validierungs-Loss bereits ab Epoche 5 starke Fluktuationen (Bouncing) und einen klaren Aufwärtstrend auf, während die Training-Accuracy über 89 % anstieg. Ähnlich zeigte sich das Bild bei Binär-Klassifikation, welche in der Testphase ebenfalls deutliche Generalisierungsfehler verzeichnete.

#figure(
  image("figures/versuch_2_multilabel_classification.png", width: 90%),
  caption: [Lernverlauf Versuch 2 (Multilabel) mit starkem Overfitting]
)

#figure(
  image("figures/versuch_2_binary_classification.png", width: 90%),
  caption: [Lernverlauf Versuch 2 (Binär) mit starkem Overfitting]
)

=== Versuch 3
Im dritten Versuch suchten wir die "goldene Mitte", reduzierten die Netzwerktiefe, behielten jedoch die Hierarchie der Filter bei. Dennoch zeigte sich weiterhin ein klares Overfitting, wie die Verlustkurven verdeutlichen. Bei Multilabel-Klassifikation verblieb die Testgenauigkeit unter 60 %, da das Netzwerk aufgrund der Modellgröße zu stark auf die Trainingsdaten abzielte. Für die binäre Variante erzielte das Netz zwar eine Test-Accuracy von 93,7 %, wies jedoch einen unruhigen Validierungs-Loss ab den letzten Epochen auf.

#figure(
  image("figures/versuch_3_multilabel_classification.png", width: 90%),
  caption: [Lernverlauf Versuch 3 (Multilabel)]
)

#figure(
  image("figures/versuch_3_binary_classification.png", width: 90%),
  caption: [Lernverlauf Versuch 3 (Binär)]
)

=== Versuch 4
Durch die Limitierung der Tiefe auf zwei Hauptblöcke sowie ein angepasstes Maß an Parametern konnten wir das Overfitting im Multilabel-Szenario eliminieren. Es resultierte eine gute Generalisierung mit einer Genauigkeit von 88,8 % auf dem ungesehenen Test-Set. Auch wenn der Validierungs-Loss etwas instabil war, zeigte das Netzwerk eine gute Fähigkeit zur Generalisierung. In der binären Klassifikation erreichte das Netz 86,8 %, zeigte jedoch in den Kurven noch stark instabiles Verhalten am Validierungssatz gegen Ende der Epochen. Das zeigt dass ein Modell mit der gleichen Größe auf den gleichen Datensatz in der Multilabel-Variante deutlich besser generalisiert als in der Binär-Variante, was auf die unterschiedlichen Anforderungen der beiden Aufgaben zurückzuführen sein könnte.

#figure(
  image("figures/versuch_4_multilabel_classification.png", width: 90%),
  caption: [Lernverlauf Versuch 4 (Multilabel)]
)

#figure(
  image("figures/versuch_4_binary_classification.png", width: 90%),
  caption: [Lernverlauf Versuch 4 (Binär)]
)

== CNN mit Transfer Learning

Für den Ansatz mittels Transfer Learning wurde die leichtgewichtige, vorab trainierte Architektur *MobileNetV3Small* eingesetzt. Die Ergebnisse spiegeln die theoretischen Vorzüge einer vortrainierten Architektur auf unserem EuroSAT-Datensatz exakt wider: 

Bei der *Multilabel-Klassifikation* lernte das Modell extrem zügig und stabil. Bereits ab der dritten Epoche überschritt die Genauigkeit 90 % und mündete schlussendlich in 95,44 % Test-Accuracy. Der Verlauf von Trainings- und Validierungs-Loss lief nahezu parallel zur Nulllinie zusammen, was ein starkes Indiz für exzellente Generalisierung ohne jegliches Overfitting darstellt.

#figure(
  image("figures/transferlearning_mit_mobilenetv3small_multilabel_classification.png", width: 90%),
  caption: [Lernverlauf Transfer Learning (Multilabel)]
)

Für die *Binäre Klassifikation* war der Anstieg etwas sprunghafter, aber ähnlich rasant. Das vortrainierte Netz generalisierte hervorragend und erreichte eine annähernd perfekte Test-Accuracy von 98,16 %. Das Konvergenzverhalten ist meist glatt und bestätigt die hohe Effizienz von MobileNetV3 für ressourcenbeschränkte Anwendungen.

#figure(
  image("figures/transferlearning_mit_mobilenetv3small_binary_classification.png", width: 90%),
  caption: [Lernverlauf Transfer Learning (Binär)]
)