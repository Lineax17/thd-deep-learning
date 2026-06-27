= Vergleich

Nachdem wir die Ergebnisse der Scratch-Modelle (Versuch 1 bis 4) und des Transfer-Learnings ausgewertet haben, vergleichen wir nun die besten Ansätze miteinander.

Als stärkster Vertreter unserer Modelle "von Scratch" hat sich *Versuch 4* durchgesetzt. Durch eine limitierte Tiefe und moderate Kapazität konnte das Modell das gravierende Overfitting seiner Vorgänger stark einschränken und eine gute Balance zwischen Lernen und Generalisieren erreichen. Ihm gegenüber steht das vortrainierte *MobileNetV3Small*, das sich durch seine vortrainierten Feature-Maps und die effiziente Architektur auszeichnet.

== Multilabel Klassifikation

Bei der herausfordernden Aufgabe, alle 10 Klassen (u.a. Wald, Gewässer, Autobahn) korrekt zuzuweisen, schnitt das *MobileNetV3Small* erwartungsgemäß am besten ab. Mit einer finalen Test-Accuracy von *95,44 %* übertraf es das Modell aus *Versuch 4* (Test-Accuracy: *88,83 %*) recht deutlich. 

Die Lernkurven zeigten klar, dass das vortrainierte Modell viel früher konvergiert und stabiler im Validierungs-Loss bleibt. Unser selbstgewähltes Modell aus Versuch 4 erzielte zwar ebenfalls solide Werte, zeigte aber während des Trainings leichte Tendenzen eines fluktuierenden Loss, was auf Inkonsistenzen in der Generalisierung hindeutet. 

Der Grund für diese starke Performance des MobileNets liegt in der Natur der Satellitenbilder: Großflächige Strukturmuster und feine Kanten wurden bereits durch das Vortraining auf massiven Datensätzen effektiv gelernt. Die *Squeeze-and-Excitation*-Module lenken den Fokus adaptiv auf relevante Kanäle, was insbesondere bei Satellitendaten einen entscheidenden Boost gibt.

== Binäre Klassifikation

In der binären Kategorisierung ("Wasser" vs. "Nicht-Gewässer" o.ä.) erreichten beide Netzwerke exzellente Punktzahlen, was generell auf eine vergleichsweise einfachere Problemstellung hindeutet. 

Unser bestes Modell aus Scratch lieferte hierfür jedoch paradoxerweise in *Versuch 1* das stabilste Ergebnis mit *94,35 %* Test-Accuracy bei einer simplen Architektur. *Versuch 4* zeigte in der binären Form eher instabiles Validierungsverhalten (*86,86 %*). Unser starker Fokus auf die Optimierung der Multilabel-Variante könnte hier zu einer suboptimalen Anpassung an die binäre Aufgabe geführt haben.
Das *MobileNetV3Small* schlug aber auch hier alle eigens erstellten Modelle und erreichte eine fast perfekte Trefferquote von *98,16 %*. Der Trainingsverlauf wies extrem glatte Kurven ohne jegliches Overfitting auf.

== Fazit des Vergleichs

Das Transfer Learning mit *MobileNetV3Small* benötigte dank vortrainierter Gewichte weitaus weniger Epochen (oftmals stabil bei $<5$ Epochen), um sehr hohe Genauigkeiten zu erzielen, wodurch die Ressourceneffizienz und Trainingsdauer deutlich besser ausfallen als bei den eigens erstellten Modellen.
Die Herausforderung beim Aufbau eines Netzes "von Scratch" lag eindeutig im Overfitting. Die kleinen Bilder ($64 times 64$ Pixel) des EuroSAT-Datensatzes erfordern zwingend kleine Netzwerke. Das MobileNet umgeht dieses Problem elegant durch seine *Depthwise Separable Convolutions*.
Wenn hohe Genauigkeit bei geringen Rechenkosten wichtig ist, führt an Transfer Learning in diesem Fall kein Weg vorbei. Die von uns trainierten Modelle stellen dennoch einen sehr guten Lernfortschritt zur Analyse architektonischer Trade-Offs (Overfitting und Underfitting) dar.