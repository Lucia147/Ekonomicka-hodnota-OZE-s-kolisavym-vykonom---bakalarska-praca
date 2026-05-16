This repository contains supplementary materials related to my bachelor's thesis. The analysis covers four EU countries: Austria (AT), Estonia (EE), Denmark (DE), and Lithuania (LT).
## Contents
- Datasets from [ENTSO-E Transparency Platform](https://transparency.entsoe.eu/)
    - Austria all data ENTSOE.xlsx
    - Estonia all data ENTSOE.xlsx
    - Germany all data ENTSOE.xlsx
    - Lithuania all data ENTSOE.xlsx

- R code
    - Code bakalarska praca OZE.R

- Figures of beta distribution fits over data histograms for solar and onshore wind capacity factor
    - betafit AT CF_s 15h.png
    - betafit EE CF_s 15h.png
    - betafit DE CF_s 15h.png
    - betafit LT CF_s 15h.png
    -
    - betafit AT CF_nv 24h.png
    - betafit EE CF_nv 24h.png
    - betafit DE CF_nv 24h.png
    - betafit DE upravena mierka.png
    - betafit LT CF_nv 24h.png

- Figures of hourly linear and quadratic regressions for electricity prices
    - Regresia AT 24h linearna+kvadraticka.png
    - Regresia EE 24h linearna+kvadraticka.png
    - Regresia DE 24h linearna+kvadraticka.png
    - Regresia LT 24h linearna+kvadraticka.png

- Figures of absolute errors in aggregate solar and onshore wind power sector expected revenue estimation as a function of installed capacity share
    - Cov_s.png
    - Cov_nv.png

- Figures of relative errors in aggregate solar and onshore wind power sector expected revenue estimation as a function of installed capacity share
    - R_cov solar.png
    - R_cov onshorewind.png
      
- Figures of aggregate solar power sector expected revenues
    - E(PQ)_s AT.png
    - E(PQ)_s EE.png
    - E(PQ)_s DE.png
    - E(PQ)_s LT.png

git checkout --orphan clean_branch
git add .
git commit -m "Initial upload"
git branch -D main
git branch -m main
git push -f origin main
