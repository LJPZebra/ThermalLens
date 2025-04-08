# 🔬 ThermalShift — Simulations & Analysis Toolkit

[![arXiv](https://img.shields.io/badge/arXiv-2504.02969-b31b1b.svg)](https://doi.org/10.48550/arXiv.2504.02969)

This repository contains the codebase for analyzing and simulating **thermal lensing effects** in two-photon light-sheet microscopy, as presented in our preprint:

> **Hubert, A.**, Trentesaux, H., Pujol, T., Debrégeas, G., & Bormuth, V. (2025).  
> [*Thermal Lensing Effects in Two-Photon Light-Sheet Microscopy*](https://doi.org/10.48550/arXiv.2504.02969).  
> _arXiv e-prints_, arXiv:2504.02969.

---

## 📂 Project Overview

### 🧪 Notebooks
- `ThermalShift_main_code.ipynb`: main notebook for processing **experimental beam propagation data** (Python)
- `ThermalShift_simulations.ipynb`: notebook for simulating **thermal lensing and beam dynamics** (Julia)

### ⚙️ Code Modules
- `simulations_codes/`: contains all **Julia functions and parameters** for simulating Gaussian beam propagation under thermal lensing
- `wvlengths.csv`: absorption coefficients vs wavelength (interpolated from Hale & Querry, 1973)

### 🗃️ Dataset
- Raw data available on request
- Pre-processed data is included under the `dataset/` folder.


---

## 📝 Citation

If you use this repository, please cite our preprint:

```bibtex
@misc{hubert2025thermal,
title = {Thermal Lensing Effects in Two-Photon Light-Sheet Microscopy},
author = {Hubert, Antoine and Trentesaux, Hugo and Pujol, Thomas and Debrégeas, Georges and Bormuth, Volker},
year = {2025},
eprint = {2504.02969},
archivePrefix = {arXiv},
primaryClass = {physics.bio-ph}
}
