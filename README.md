# THD Deep Learning

## GPU-Training im ROCm-TensorFlow-Container

Das Training schreibt das Modell direkt in dein lokales `models/`-Verzeichnis. Nutze dafür den Wrapper unter `scripts/train_freezed_gpu.sh`.

### Build

```bash
bash scripts/train_freezed_gpu.sh
```

### Hinweise

- `pyproject.toml` ist die Single Source of Truth für die zusätzlichen Python-Abhängigkeiten.
- Das Docker-Image installiert daraus alle Pakete außer `tensorflow`, weil TensorFlow bereits im ROCm-Base-Image enthalten ist.
- `data/` wird nur lesend gemountet, `models/` wird beschreibbar gemountet.
- Das Modell landet auf dem Host unter `models/eurosat_multilabel_mobilenetv3_freezed.keras`.

