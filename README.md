# About this project
Implementation of "Low-complexity detection of atrial fibrillation in continuous long-term monitoring", made by: A. Petrėnas, V. Marozas, L. Sörnmo, published in Computers in Biology and Medicine, 65, pages: 184-191, year 2015.

## Installation
To install the algorithm, make a git clone of the repository (or simply download it).
To make it works, WFDB library and LTAF Database from PhysioNet are required.

WFDB library: https://archive.physionet.org/physiotools/matlab/wfdb-app-matlab/

LTAF Database: https://physionet.org/content/ltafdb/1.0.0/

For LTAF Database:
- make sure to change the path_to_record variable in main.m, according to where you save in computer (original value on main.m: database\mcode\dataSet01\files\);

For WFDB library:
- use the command to salve WFDB's path. Original path in main.m "WFDB".

## Variables
- execute_all : execute the algorithm on the entire dataset (only LTAF) if value = 1. If value = 0, only execute the signal saved in 'record_name' variable. Results are saved in 'results.xlsx' file;
- alpha, gamma, N, delta, threshold : values used in the algorithm. In main.m, values written by the paper are reported;
- record_name : variable for the name of the file, used for a single execution. *Make sure that the file actually exists*;
- plot_final_merge, plot_comp_irr_bigeminy, plot_groundtruth = variables used to plot or not some figures where there is a single execution on a specific file.
