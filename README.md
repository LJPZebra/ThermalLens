# 🔬 ThermalShift — Simulations & Analysis Toolkit

[![DOI](https://img.shields.io/badge/DOI-10.1364%2FBOE.17.001064-blue)](https://doi.org/10.1364/BOE.17.001064)

This repository contains the codebase for analyzing and simulating **thermal lensing effects** in two-photon light-sheet microscopy, as presented in our preprint:

> **Hubert, A.**, Trentesaux, H., Pujol, T., Debrégeas, G., & Bormuth, V. (2025).  
> [*Thermal Lensing Effects in Two-Photon Light-Sheet Microscopy*](https://doi.org/10.1364/BOE.564339).  
> **Biomedical Optics Express**, **17**, 1064–1073.

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
@article{hubert2026thermal,
  title   = {Thermal lensing effects in two-photon light-sheet microscopy},
  author  = {Hubert, Antoine and Trentesaux, Hugo and Pujol, Thomas and Debrégeas, Georges and Bormuth, Volker},
  journal = {Biomedical Optics Express},
  volume  = {17},
  pages   = {1064--1073},
  year    = {2026}
}
