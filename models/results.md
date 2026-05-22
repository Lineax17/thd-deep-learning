# Versuch 1

## Multilabel classification

acc: 0.8183 | kein Overfitting

```
Epoch 1/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 6s 13ms/step - accuracy: 0.3230 - loss: 1.7305 - val_accuracy: 0.4676 - val_loss: 1.3913
Epoch 2/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 5s 12ms/step - accuracy: 0.4865 - loss: 1.3543 - val_accuracy: 0.5722 - val_loss: 1.1771
Epoch 3/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 5s 12ms/step - accuracy: 0.5676 - loss: 1.1710 - val_accuracy: 0.6661 - val_loss: 0.9469
Epoch 4/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 5s 12ms/step - accuracy: 0.6197 - loss: 1.0669 - val_accuracy: 0.7024 - val_loss: 0.8459
Epoch 5/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 5s 12ms/step - accuracy: 0.6433 - loss: 0.9987 - val_accuracy: 0.7174 - val_loss: 0.8066
Epoch 6/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 5s 12ms/step - accuracy: 0.6722 - loss: 0.9125 - val_accuracy: 0.7413 - val_loss: 0.7642
Epoch 7/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 5s 12ms/step - accuracy: 0.6922 - loss: 0.8659 - val_accuracy: 0.7569 - val_loss: 0.6870
Epoch 8/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 5s 12ms/step - accuracy: 0.7084 - loss: 0.8189 - val_accuracy: 0.7722 - val_loss: 0.6435
Epoch 9/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 5s 13ms/step - accuracy: 0.7168 - loss: 0.7805 - val_accuracy: 0.7900 - val_loss: 0.5964
Epoch 10/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 5s 13ms/step - accuracy: 0.7310 - loss: 0.7463 - val_accuracy: 0.7883 - val_loss: 0.6025
Epoch 11/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 5s 13ms/step - accuracy: 0.7453 - loss: 0.7167 - val_accuracy: 0.8109 - val_loss: 0.5604
Epoch 12/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 6s 13ms/step - accuracy: 0.7593 - loss: 0.6768 - val_accuracy: 0.8052 - val_loss: 0.5598
Epoch 13/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 6s 13ms/step - accuracy: 0.7651 - loss: 0.6572 - val_accuracy: 0.8130 - val_loss: 0.5285
Epoch 14/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 6s 14ms/step - accuracy: 0.7776 - loss: 0.6119 - val_accuracy: 0.8220 - val_loss: 0.5339
Epoch 15/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 6s 14ms/step - accuracy: 0.7835 - loss: 0.6042 - val_accuracy: 0.8254 - val_loss: 0.5111
Epoch 16/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 6s 14ms/step - accuracy: 0.7944 - loss: 0.5674 - val_accuracy: 0.8217 - val_loss: 0.5123
Epoch 17/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 5s 12ms/step - accuracy: 0.8007 - loss: 0.5521 - val_accuracy: 0.8185 - val_loss: 0.5334
Epoch 18/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 5s 12ms/step - accuracy: 0.8136 - loss: 0.5182 - val_accuracy: 0.8070 - val_loss: 0.5382
Epoch 19/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 5s 12ms/step - accuracy: 0.8164 - loss: 0.5092 - val_accuracy: 0.8404 - val_loss: 0.4851
Epoch 20/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 5s 12ms/step - accuracy: 0.8274 - loss: 0.4897 - val_accuracy: 0.8289 - val_loss: 0.5010
[INFO] Evaluating on test data...
254/254 ━━━━━━━━━━━━━━━━━━━━ 1s 4ms/step - accuracy: 0.8477 - loss: 0.4556
[INFO] Test Accuracy: 0.8477
```

## Binary classification

acc: 0.9483 | kein Overfitting

```
Epoch 1/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 3s 13ms/step - accuracy: 0.8103 - loss: 0.3944 - val_accuracy: 0.8443 - val_loss: 0.3392
Epoch 2/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 2s 12ms/step - accuracy: 0.8592 - loss: 0.3064 - val_accuracy: 0.8752 - val_loss: 0.2763
Epoch 3/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 2s 12ms/step - accuracy: 0.8707 - loss: 0.2802 - val_accuracy: 0.8810 - val_loss: 0.2608
Epoch 4/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 2s 12ms/step - accuracy: 0.8785 - loss: 0.2678 - val_accuracy: 0.9010 - val_loss: 0.2274
Epoch 5/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 2s 12ms/step - accuracy: 0.8857 - loss: 0.2570 - val_accuracy: 0.9024 - val_loss: 0.2245
Epoch 6/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 2s 12ms/step - accuracy: 0.9013 - loss: 0.2295 - val_accuracy: 0.9062 - val_loss: 0.2244
Epoch 7/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 2s 12ms/step - accuracy: 0.8958 - loss: 0.2363 - val_accuracy: 0.8800 - val_loss: 0.2692
Epoch 8/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 2s 12ms/step - accuracy: 0.9023 - loss: 0.2220 - val_accuracy: 0.8948 - val_loss: 0.2544
Epoch 9/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 2s 12ms/step - accuracy: 0.9160 - loss: 0.1958 - val_accuracy: 0.9071 - val_loss: 0.2182
Epoch 10/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 2s 12ms/step - accuracy: 0.9299 - loss: 0.1739 - val_accuracy: 0.9267 - val_loss: 0.1748
Epoch 11/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 2s 12ms/step - accuracy: 0.9303 - loss: 0.1672 - val_accuracy: 0.9362 - val_loss: 0.1642
Epoch 12/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 2s 12ms/step - accuracy: 0.9330 - loss: 0.1542 - val_accuracy: 0.9086 - val_loss: 0.2162
Epoch 13/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 2s 12ms/step - accuracy: 0.9400 - loss: 0.1478 - val_accuracy: 0.9133 - val_loss: 0.2303
Epoch 14/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 2s 12ms/step - accuracy: 0.9461 - loss: 0.1342 - val_accuracy: 0.9186 - val_loss: 0.2173
Epoch 15/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 2s 12ms/step - accuracy: 0.9451 - loss: 0.1395 - val_accuracy: 0.9100 - val_loss: 0.2204
Epoch 16/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 2s 12ms/step - accuracy: 0.9453 - loss: 0.1331 - val_accuracy: 0.9457 - val_loss: 0.1431
Epoch 17/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 2s 12ms/step - accuracy: 0.9509 - loss: 0.1146 - val_accuracy: 0.9486 - val_loss: 0.1478
Epoch 18/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 2s 12ms/step - accuracy: 0.9552 - loss: 0.1118 - val_accuracy: 0.9481 - val_loss: 0.1475
Epoch 19/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 2s 12ms/step - accuracy: 0.9596 - loss: 0.0975 - val_accuracy: 0.9514 - val_loss: 0.1448
Epoch 20/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 2s 12ms/step - accuracy: 0.9630 - loss: 0.0914 - val_accuracy: 0.9490 - val_loss: 0.1558
[INFO] Evaluating on test data...
99/99 ━━━━━━━━━━━━━━━━━━━━ 0s 4ms/step - accuracy: 0.9435 - loss: 0.1456
[INFO] Test Accuracy: 0.9435
```

Kein Overfitting in Versuch 1, da val_loss stetig sinkt und val_accuracy stetig steigt -> Netz zu klein? -> Mehr Schichten, mehr Neuronen?

# Versuch 2

## Multilabel classification

acc: 0.8115 | starkes Overfitting

```
Epoch 1/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 36s 82ms/step - accuracy: 0.5249 - loss: 1.4700 - val_accuracy: 0.2933 - val_loss: 2.5255
Epoch 2/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 34s 81ms/step - accuracy: 0.6844 - loss: 1.0225 - val_accuracy: 0.5609 - val_loss: 1.4730
Epoch 3/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 34s 81ms/step - accuracy: 0.7385 - loss: 0.8744 - val_accuracy: 0.6869 - val_loss: 1.0017
Epoch 4/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 34s 81ms/step - accuracy: 0.7739 - loss: 0.7813 - val_accuracy: 0.6602 - val_loss: 1.1540
Epoch 5/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 35s 84ms/step - accuracy: 0.8100 - loss: 0.6814 - val_accuracy: 0.7763 - val_loss: 0.7338
Epoch 6/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 34s 81ms/step - accuracy: 0.8327 - loss: 0.6251 - val_accuracy: 0.7913 - val_loss: 0.7012
Epoch 7/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 34s 81ms/step - accuracy: 0.8500 - loss: 0.5737 - val_accuracy: 0.7115 - val_loss: 1.0566
Epoch 8/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 34s 81ms/step - accuracy: 0.8689 - loss: 0.5149 - val_accuracy: 0.6596 - val_loss: 1.3301
Epoch 9/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 36s 84ms/step - accuracy: 0.8756 - loss: 0.4992 - val_accuracy: 0.7048 - val_loss: 1.0969
Epoch 10/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 37s 87ms/step - accuracy: 0.8824 - loss: 0.4775 - val_accuracy: 0.5948 - val_loss: 1.5376
Epoch 11/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 36s 86ms/step - accuracy: 0.8929 - loss: 0.4477 - val_accuracy: 0.6959 - val_loss: 1.1257
[INFO] Evaluating on test data...
254/254 ━━━━━━━━━━━━━━━━━━━━ 5s 19ms/step - accuracy: 0.8115 - loss: 0.6826
[INFO] Test Accuracy: 0.8115
```

Overfitting ab Epoche 7

## Binary classification

acc: 0.9483 | starkes Overfitting

```
Epoch 1/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 16s 85ms/step - accuracy: 0.8474 - loss: 0.4197 - val_accuracy: 0.6767 - val_loss: 1.3652
Epoch 2/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 14s 86ms/step - accuracy: 0.8861 - loss: 0.3466 - val_accuracy: 0.7643 - val_loss: 0.7249
Epoch 3/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 14s 83ms/step - accuracy: 0.9210 - loss: 0.2805 - val_accuracy: 0.7238 - val_loss: 0.8806
Epoch 4/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 13s 81ms/step - accuracy: 0.9429 - loss: 0.2216 - val_accuracy: 0.7667 - val_loss: 0.6928
Epoch 5/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 14s 82ms/step - accuracy: 0.9480 - loss: 0.2119 - val_accuracy: 0.7405 - val_loss: 0.9882
Epoch 6/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 15s 90ms/step - accuracy: 0.9594 - loss: 0.1795 - val_accuracy: 0.8976 - val_loss: 0.3415
Epoch 7/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 14s 88ms/step - accuracy: 0.9651 - loss: 0.1565 - val_accuracy: 0.7305 - val_loss: 1.0274
Epoch 8/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 14s 85ms/step - accuracy: 0.9680 - loss: 0.1420 - val_accuracy: 0.8676 - val_loss: 0.4900
Epoch 9/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 14s 84ms/step - accuracy: 0.9743 - loss: 0.1331 - val_accuracy: 0.7481 - val_loss: 1.1673
Epoch 10/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 14s 83ms/step - accuracy: 0.9737 - loss: 0.1330 - val_accuracy: 0.8438 - val_loss: 0.5648
Epoch 11/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 14s 84ms/step - accuracy: 0.9781 - loss: 0.1143 - val_accuracy: 0.8957 - val_loss: 0.3325
Epoch 12/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 15s 88ms/step - accuracy: 0.9714 - loss: 0.1319 - val_accuracy: 0.8148 - val_loss: 0.4487
Epoch 13/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 14s 88ms/step - accuracy: 0.9796 - loss: 0.1157 - val_accuracy: 0.9276 - val_loss: 0.2650
Epoch 14/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 14s 87ms/step - accuracy: 0.9806 - loss: 0.1050 - val_accuracy: 0.6133 - val_loss: 1.7907
Epoch 15/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 14s 86ms/step - accuracy: 0.9825 - loss: 0.1050 - val_accuracy: 0.7352 - val_loss: 1.3548
Epoch 16/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 14s 83ms/step - accuracy: 0.9842 - loss: 0.0926 - val_accuracy: 0.8333 - val_loss: 0.6370
Epoch 17/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 13s 81ms/step - accuracy: 0.9853 - loss: 0.0925 - val_accuracy: 0.8710 - val_loss: 0.6016
Epoch 18/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 14s 83ms/step - accuracy: 0.9886 - loss: 0.0827 - val_accuracy: 0.5762 - val_loss: 3.4965
[INFO] Evaluating on test data...
99/99 ━━━━━━━━━━━━━━━━━━━━ 2s 18ms/step - accuracy: 0.9232 - loss: 0.2761
[INFO] Test Accuracy: 0.9232
```

Overfitting ab Epoche 5
Bouncing von val_loss -> kleinere learning rate?

Netz viel zu groß in Versuch 2 -> In beiden Fällen massives Overfitting

# Versuch 3

## Multilabel classification

acc: 0.5680 | starkes Overfitting

```
Epoch 1/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 14s 31ms/step - accuracy: 0.4659 - loss: 1.5316 - val_accuracy: 0.3567 - val_loss: 1.8139
Epoch 2/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 13s 30ms/step - accuracy: 0.6114 - loss: 1.1349 - val_accuracy: 0.5522 - val_loss: 1.2868
Epoch 3/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 13s 30ms/step - accuracy: 0.6670 - loss: 0.9819 - val_accuracy: 0.4711 - val_loss: 1.5434
Epoch 4/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 13s 30ms/step - accuracy: 0.6917 - loss: 0.9111 - val_accuracy: 0.5556 - val_loss: 1.3634
Epoch 5/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 13s 30ms/step - accuracy: 0.7100 - loss: 0.8522 - val_accuracy: 0.4241 - val_loss: 2.1963
Epoch 6/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 13s 31ms/step - accuracy: 0.7256 - loss: 0.8232 - val_accuracy: 0.5837 - val_loss: 1.2926
Epoch 7/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 13s 31ms/step - accuracy: 0.7300 - loss: 0.8009 - val_accuracy: 0.4365 - val_loss: 2.5004
[INFO] Evaluating on test data...
254/254 ━━━━━━━━━━━━━━━━━━━━ 2s 6ms/step - accuracy: 0.5680 - loss: 1.2453
[INFO] Test Accuracy: 0.5680
```

Immer noch Overfitting -> Mehr Schichten, weniger Neuronen?

## Binary classification

acc: 0.9378 | Overfitting

```
Epoch 1/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 6s 32ms/step - accuracy: 0.8406 - loss: 0.3898 - val_accuracy: 0.5238 - val_loss: 1.0957
Epoch 2/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 5s 30ms/step - accuracy: 0.8726 - loss: 0.3310 - val_accuracy: 0.5248 - val_loss: 0.9312
Epoch 3/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 5s 30ms/step - accuracy: 0.8829 - loss: 0.2994 - val_accuracy: 0.8395 - val_loss: 0.3877
Epoch 4/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 5s 30ms/step - accuracy: 0.8964 - loss: 0.2833 - val_accuracy: 0.8400 - val_loss: 0.3641
Epoch 5/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 5s 30ms/step - accuracy: 0.9093 - loss: 0.2628 - val_accuracy: 0.8657 - val_loss: 0.3253
Epoch 6/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 5s 30ms/step - accuracy: 0.9190 - loss: 0.2378 - val_accuracy: 0.9176 - val_loss: 0.2034
Epoch 7/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 5s 30ms/step - accuracy: 0.9230 - loss: 0.2277 - val_accuracy: 0.8814 - val_loss: 0.2696
Epoch 8/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 5s 30ms/step - accuracy: 0.9312 - loss: 0.2014 - val_accuracy: 0.9510 - val_loss: 0.1529
Epoch 9/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 5s 30ms/step - accuracy: 0.9394 - loss: 0.1934 - val_accuracy: 0.7443 - val_loss: 0.7177
Epoch 10/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 5s 30ms/step - accuracy: 0.9413 - loss: 0.1876 - val_accuracy: 0.7738 - val_loss: 0.6810
Epoch 11/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 5s 30ms/step - accuracy: 0.9432 - loss: 0.1755 - val_accuracy: 0.8357 - val_loss: 0.4499
Epoch 12/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 5s 30ms/step - accuracy: 0.9470 - loss: 0.1686 - val_accuracy: 0.7195 - val_loss: 0.7618
Epoch 13/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 5s 30ms/step - accuracy: 0.9411 - loss: 0.1876 - val_accuracy: 0.8905 - val_loss: 0.2658
[INFO] Evaluating on test data...
99/99 ━━━━━━━━━━━━━━━━━━━━ 1s 6ms/step - accuracy: 0.9378 - loss: 0.1770
[INFO] Test Accuracy: 0.9378
```

# Versuch 4

## Multilabel classification

acc: 0.8883 | kein klares Overfitting -> gute Generalisierung

```
Epoch 1/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 26s 58ms/step - accuracy: 0.4027 - loss: 1.7315 - val_accuracy: 0.2226 - val_loss: 2.0773
Epoch 2/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 24s 57ms/step - accuracy: 0.5700 - loss: 1.2576 - val_accuracy: 0.6537 - val_loss: 0.9946
Epoch 3/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 24s 58ms/step - accuracy: 0.6361 - loss: 1.0925 - val_accuracy: 0.6300 - val_loss: 1.0722
Epoch 4/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 27s 63ms/step - accuracy: 0.6730 - loss: 0.9887 - val_accuracy: 0.5778 - val_loss: 1.1103
Epoch 5/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 25s 60ms/step - accuracy: 0.6970 - loss: 0.9144 - val_accuracy: 0.6494 - val_loss: 0.9545
Epoch 6/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 26s 61ms/step - accuracy: 0.7184 - loss: 0.8652 - val_accuracy: 0.7402 - val_loss: 0.7774
Epoch 7/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 25s 60ms/step - accuracy: 0.7252 - loss: 0.8457 - val_accuracy: 0.5993 - val_loss: 1.1748
Epoch 8/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 26s 62ms/step - accuracy: 0.7433 - loss: 0.7975 - val_accuracy: 0.5915 - val_loss: 1.1633
Epoch 9/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 25s 59ms/step - accuracy: 0.7475 - loss: 0.7822 - val_accuracy: 0.7594 - val_loss: 0.7454
Epoch 10/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 25s 60ms/step - accuracy: 0.7513 - loss: 0.7644 - val_accuracy: 0.6457 - val_loss: 1.0307
Epoch 11/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 25s 58ms/step - accuracy: 0.7639 - loss: 0.7376 - val_accuracy: 0.6674 - val_loss: 0.9760
Epoch 12/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 25s 60ms/step - accuracy: 0.7720 - loss: 0.7133 - val_accuracy: 0.6093 - val_loss: 1.3957
Epoch 13/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 25s 60ms/step - accuracy: 0.7831 - loss: 0.6926 - val_accuracy: 0.7869 - val_loss: 0.6736
Epoch 14/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 25s 60ms/step - accuracy: 0.7919 - loss: 0.6728 - val_accuracy: 0.7609 - val_loss: 0.7253
Epoch 15/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 25s 60ms/step - accuracy: 0.7944 - loss: 0.6634 - val_accuracy: 0.7831 - val_loss: 0.6650
Epoch 16/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 25s 59ms/step - accuracy: 0.8096 - loss: 0.6282 - val_accuracy: 0.7741 - val_loss: 0.7237
Epoch 17/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 24s 58ms/step - accuracy: 0.8113 - loss: 0.6112 - val_accuracy: 0.6852 - val_loss: 0.9465
Epoch 18/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 24s 58ms/step - accuracy: 0.8225 - loss: 0.6018 - val_accuracy: 0.6887 - val_loss: 1.3360
Epoch 19/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 24s 58ms/step - accuracy: 0.8288 - loss: 0.5763 - val_accuracy: 0.7831 - val_loss: 0.7953
Epoch 20/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 24s 58ms/step - accuracy: 0.8279 - loss: 0.5775 - val_accuracy: 0.8737 - val_loss: 0.4232
[INFO] Evaluating on test data...
254/254 ━━━━━━━━━━━━━━━━━━━━ 3s 12ms/step - accuracy: 0.8883 - loss: 0.4003
[INFO] Test Accuracy: 0.8883
```

Deutlich besser als in Versuch 1 -> Annäherung an ein gutes Modell

## Binary classification

acc: 0.8686 | Overfitting

```
Epoch 1/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 11s 59ms/step - accuracy: 0.8253 - loss: 0.4201 - val_accuracy: 0.5238 - val_loss: 1.2600
Epoch 2/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 9s 57ms/step - accuracy: 0.8594 - loss: 0.3530 - val_accuracy: 0.5238 - val_loss: 0.8168
Epoch 3/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 9s 57ms/step - accuracy: 0.8735 - loss: 0.3215 - val_accuracy: 0.6724 - val_loss: 0.6077
Epoch 4/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 9s 57ms/step - accuracy: 0.8943 - loss: 0.2848 - val_accuracy: 0.8310 - val_loss: 0.4177
Epoch 5/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 9s 57ms/step - accuracy: 0.8971 - loss: 0.2662 - val_accuracy: 0.8100 - val_loss: 0.4058
Epoch 6/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 9s 57ms/step - accuracy: 0.9080 - loss: 0.2467 - val_accuracy: 0.6619 - val_loss: 1.1004
Epoch 7/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 9s 57ms/step - accuracy: 0.9225 - loss: 0.2176 - val_accuracy: 0.6338 - val_loss: 0.9123
Epoch 8/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 9s 57ms/step - accuracy: 0.9263 - loss: 0.2052 - val_accuracy: 0.7762 - val_loss: 0.6548
Epoch 9/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 10s 60ms/step - accuracy: 0.9373 - loss: 0.1942 - val_accuracy: 0.8881 - val_loss: 0.2780
Epoch 10/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 9s 57ms/step - accuracy: 0.9215 - loss: 0.2160 - val_accuracy: 0.5305 - val_loss: 1.8737
Epoch 11/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 9s 57ms/step - accuracy: 0.9347 - loss: 0.1833 - val_accuracy: 0.7171 - val_loss: 0.8868
Epoch 12/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 9s 57ms/step - accuracy: 0.9377 - loss: 0.1811 - val_accuracy: 0.6586 - val_loss: 1.0629
Epoch 13/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 9s 57ms/step - accuracy: 0.9406 - loss: 0.1730 - val_accuracy: 0.6657 - val_loss: 0.8900
Epoch 14/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 9s 57ms/step - accuracy: 0.9430 - loss: 0.1612 - val_accuracy: 0.5286 - val_loss: 4.0237
[INFO] Evaluating on test data...
99/99 ━━━━━━━━━━━━━━━━━━━━ 1s 12ms/step - accuracy: 0.8686 - loss: 0.3313
[INFO] Test Accuracy: 0.8686
```

# Transferlearning mit MobileNetV3Small

## Multilabel classification

Final Test Accuracy: 95.44% | kein Overfitting -> gute Generalisierung

```
Epoch 1/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 61s 137ms/step - accuracy: 0.7211 - loss: 0.9418 - val_accuracy: 0.8859 - val_loss: 0.4024
Epoch 2/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 52s 123ms/step - accuracy: 0.8741 - loss: 0.4129 - val_accuracy: 0.9128 - val_loss: 0.2831
Epoch 3/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 53s 126ms/step - accuracy: 0.8977 - loss: 0.3254 - val_accuracy: 0.9217 - val_loss: 0.2442
Epoch 4/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 51s 121ms/step - accuracy: 0.9099 - loss: 0.2781 - val_accuracy: 0.9296 - val_loss: 0.2227
Epoch 5/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 50s 119ms/step - accuracy: 0.9164 - loss: 0.2530 - val_accuracy: 0.9344 - val_loss: 0.2064
Epoch 6/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 50s 119ms/step - accuracy: 0.9239 - loss: 0.2307 - val_accuracy: 0.9378 - val_loss: 0.1963
Epoch 7/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 49s 117ms/step - accuracy: 0.9295 - loss: 0.2193 - val_accuracy: 0.9407 - val_loss: 0.1884
Epoch 8/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 33s 78ms/step - accuracy: 0.9335 - loss: 0.2027 - val_accuracy: 0.9415 - val_loss: 0.1810
Epoch 9/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 28s 67ms/step - accuracy: 0.9348 - loss: 0.1927 - val_accuracy: 0.9443 - val_loss: 0.1752
Epoch 10/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 28s 67ms/step - accuracy: 0.9368 - loss: 0.1883 - val_accuracy: 0.9444 - val_loss: 0.1707
Epoch 11/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 27s 63ms/step - accuracy: 0.9414 - loss: 0.1755 - val_accuracy: 0.9439 - val_loss: 0.1662
Epoch 12/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 27s 63ms/step - accuracy: 0.9400 - loss: 0.1766 - val_accuracy: 0.9474 - val_loss: 0.1612
Epoch 13/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 28s 66ms/step - accuracy: 0.9448 - loss: 0.1669 - val_accuracy: 0.9465 - val_loss: 0.1569
Epoch 14/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 28s 67ms/step - accuracy: 0.9485 - loss: 0.1583 - val_accuracy: 0.9476 - val_loss: 0.1552
Epoch 15/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 28s 66ms/step - accuracy: 0.9476 - loss: 0.1568 - val_accuracy: 0.9489 - val_loss: 0.1534
Epoch 16/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 27s 63ms/step - accuracy: 0.9484 - loss: 0.1507 - val_accuracy: 0.9483 - val_loss: 0.1513
Epoch 17/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 27s 63ms/step - accuracy: 0.9530 - loss: 0.1462 - val_accuracy: 0.9498 - val_loss: 0.1482
Epoch 18/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 27s 63ms/step - accuracy: 0.9532 - loss: 0.1421 - val_accuracy: 0.9520 - val_loss: 0.1466
Epoch 19/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 27s 65ms/step - accuracy: 0.9514 - loss: 0.1422 - val_accuracy: 0.9515 - val_loss: 0.1437
Epoch 20/20
422/422 ━━━━━━━━━━━━━━━━━━━━ 27s 64ms/step - accuracy: 0.9524 - loss: 0.1377 - val_accuracy: 0.9522 - val_loss: 0.1428
254/254 ━━━━━━━━━━━━━━━━━━━━ 21s 79ms/step - accuracy: 0.9544 - loss: 0.1337
```

## Binary classification

Final Test Accuracy: 98.16% | kein Overfitting, gute Generalisierung

```
Epoch 1/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 13s 67ms/step - accuracy: 0.8657 - loss: 0.3077 - val_accuracy: 0.9386 - val_loss: 0.1654
Epoch 2/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 12s 75ms/step - accuracy: 0.9370 - loss: 0.1625 - val_accuracy: 0.9519 - val_loss: 0.1264
Epoch 3/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 20s 123ms/step - accuracy: 0.9528 - loss: 0.1301 - val_accuracy: 0.9614 - val_loss: 0.1079
Epoch 4/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 17s 103ms/step - accuracy: 0.9558 - loss: 0.1195 - val_accuracy: 0.9667 - val_loss: 0.0946
Epoch 5/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 17s 106ms/step - accuracy: 0.9608 - loss: 0.1071 - val_accuracy: 0.9700 - val_loss: 0.0856
Epoch 6/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 20s 124ms/step - accuracy: 0.9617 - loss: 0.1005 - val_accuracy: 0.9752 - val_loss: 0.0773
Epoch 7/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 21s 127ms/step - accuracy: 0.9630 - loss: 0.0948 - val_accuracy: 0.9752 - val_loss: 0.0723
Epoch 8/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 20s 122ms/step - accuracy: 0.9712 - loss: 0.0794 - val_accuracy: 0.9738 - val_loss: 0.0693
Epoch 9/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 22s 135ms/step - accuracy: 0.9686 - loss: 0.0800 - val_accuracy: 0.9752 - val_loss: 0.0670
Epoch 10/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 21s 127ms/step - accuracy: 0.9720 - loss: 0.0746 - val_accuracy: 0.9767 - val_loss: 0.0638
Epoch 11/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 21s 127ms/step - accuracy: 0.9718 - loss: 0.0754 - val_accuracy: 0.9771 - val_loss: 0.0637
Epoch 12/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 20s 124ms/step - accuracy: 0.9726 - loss: 0.0716 - val_accuracy: 0.9786 - val_loss: 0.0621
Epoch 13/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 19s 115ms/step - accuracy: 0.9758 - loss: 0.0652 - val_accuracy: 0.9781 - val_loss: 0.0611
Epoch 14/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 21s 125ms/step - accuracy: 0.9741 - loss: 0.0676 - val_accuracy: 0.9767 - val_loss: 0.0610
Epoch 15/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 20s 120ms/step - accuracy: 0.9766 - loss: 0.0636 - val_accuracy: 0.9805 - val_loss: 0.0572
Epoch 16/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 20s 123ms/step - accuracy: 0.9754 - loss: 0.0619 - val_accuracy: 0.9814 - val_loss: 0.0566
Epoch 17/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 20s 123ms/step - accuracy: 0.9789 - loss: 0.0603 - val_accuracy: 0.9824 - val_loss: 0.0553
Epoch 18/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 18s 112ms/step - accuracy: 0.9768 - loss: 0.0581 - val_accuracy: 0.9795 - val_loss: 0.0565
Epoch 19/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 21s 126ms/step - accuracy: 0.9741 - loss: 0.0633 - val_accuracy: 0.9810 - val_loss: 0.0548
Epoch 20/20
165/165 ━━━━━━━━━━━━━━━━━━━━ 20s 121ms/step - accuracy: 0.9781 - loss: 0.0561 - val_accuracy: 0.9795 - val_loss: 0.0544
99/99 ━━━━━━━━━━━━━━━━━━━━ 12s 80ms/step - accuracy: 0.9816 - loss: 0.0588
```