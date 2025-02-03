# About this Project

Implementation of *"Low-complexity detection of atrial fibrillation in continuous long-term monitoring"* by A. Petrėnas, V. Marozas, and L. Sörnmo, published in *Computers in Biology and Medicine*, Vol. 65, pp. 184-191, 2015.

## Installation

To install the algorithm, clone the repository using Git or download it manually.  
The following dependencies are required:

- **WFDB library**: [WFDB for MATLAB](https://archive.physionet.org/physiotools/matlab/wfdb-app-matlab/)
- **LTAF Database**: [LTAF Database on PhysioNet](https://physionet.org/content/ltafdb/1.0.0/)

### Setup Instructions

#### LTAF Database:
- Update the `path_to_record` variable in *main.m* to match the location where the database is saved on your computer.  
  - Default path in *main.m*: `database\mcode\dataSet01\files\`

#### WFDB Library:
- Update the path for the WFDB library in *main.m*.
  - Default path in *main.m*: `WFDB`

#### Folders
- Folders for both LTAF database and WFDB Library have to be created.

## Variables

- **`execute_all`**:
  - If set to `1`, the algorithm runs on the entire LTAF dataset.
  - If set to `0`, it runs only on the signal specified in `record_name`.
  - Results are saved in *results.xlsx*.

- **Algorithm Parameters**:
  - `alpha`, `gamma`, `N`, `delta`, `threshold`: These control the algorithm’s behavior. The default values in *main.m* are those reported in the original paper.

- **`record_name`**:
  - Specifies the file name for single execution mode.
  - *Ensure the file exists before running the algorithm.*

- **Plotting Variables** (for single execution mode):
  - `plot_final_merge`, `plot_comp_irr_bigeminy`, `plot_groundtruth`: Control whether certain figures are plotted.
