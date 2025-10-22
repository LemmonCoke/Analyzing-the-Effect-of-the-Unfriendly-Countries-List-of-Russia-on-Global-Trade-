## Overview

This archive contains the constructed dataset and code for the paper "Analyzing the Effect of the Unfriendly Countries List of Russia on Global Trade through the Staggered Difference-in-Differences Design in the Gravity Model"
All codes and data files are prepared for use in R (At least R version 4.3.3).

## Authors
Xiao Wang 
   
   Tohoku University, Graduate School of Economics and Management, PhD Candidate
   
   

Jun Nagayasu
   
   Tohoku University, Graduate School of Economics and Management,

   

## Data Files 

RUIM.csv:   Investigated countries' monthly imports data from Russia, along with control variables

RUEX.csv:   Investigated countries' monthly exports data from Russia, along with control variables

URIM.csv:    Investigated countries' imports data from Ukraine

RUEX.csv:    Investigated countries' exports data from Ukraine

DiversionFull.csv:    Investigated countries' imports from the 4 alternative oil suppliers

DiversionSub.csv:    Subset of DiversionFull.csv, only include importing countries that increased their oil imports after UCL issuance

For the detailed data description, refer to Section 4 of the paper


## R Scripts

TableCode2510.R:    R script for results reported the tables in Section 5 and 6, including the ATT estimates and robustness checks.

FigureCode2510.R:   R script for generating the figures in Section 5 and 6 (DiD plots, Common Trend Tests).

To run the R script, please follow the comments in the R scripts. 



## Data Source


The data used in this study are publicly available from sources including UN Comtrade, CEPII, and TheGlobalEconomy Website. 

Below are the formal data citations, following Wiley’s Data Citation Policy: \\

[UN Comtrade] UN Comtrade; 2024; UN Comtrade Database; United Nations; \url{https://comtradeplus.un.org/}\\

[CEPII] CEPII; 2023; Actualités du CEPII – Gravity Dataset; CEPII; \url{http://www.cepii.fr/CEPII/en/bdd_modele/bdd_modele_item.asp?id=6}\\

[TheGlobalEconomy] Valev, Neven; Bieri, Franziska; Bizuneh, Menna; 2024; Global Economy, World Economy; TheGlobalEconomy.com; \url{https://www.theglobaleconomy.com/}\\
\vspace{1em}



