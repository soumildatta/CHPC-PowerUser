#!/bin/bash

#SBATCH --time=1:00:00                # Adjust the requested wall time as necessary
#SBATCH --nodes=1                     # Use 1 node
#SBATCH --gres=gpu:h100nvl:1          # Request 1 GPU, adjust depending on availability
#SBATCH --mem=80G                     # Mem
#SBATCH --ntasks=1                    # Number of tasks, adjust if needed
#SBATCH -o slurm-%j.out-%N            # Output log
#SBATCH -e slurm-%j.err-%N            # Error log
#SBATCH --account=gtao-gpu-np         # Specify your account
#SBATCH --partition=partition-gpu-np  # Partition to use (PLEASE FILL IN YOURS)

export WORKDIR=$SLURM_SUBMIT_DIR

# scratch dir
export SCRDIR=/scratch/general/vast/$USER/PROJ_NAME
mkdir -p $SCRDIR

# Copy all the files in the current directory to the scratch directory
# You can also copy individual files. Treat the scratch directory as another filesystem that is temporary
# The scratch dir is where all your work will be done, and data stored (don't worry, we can copy it back to the home dir at the end)
cp -r $WORKDIR/* $SCRDIR
cd $SCRDIR

# Load any necessary modules
# Commonly used module example below to load python
module use $HOME/MyModules
module load miniforge3/latest

# Activate your virtual environment
source activate myenv


# Run your actual script/experiments
python experiment.py

# if you want to run a script multiple times
for i in {1..9}; do
  export OUTPUT_DIR="./results_${i}"

  python generate.py --save_path $OUTPUT_DIR

  # copy the results back to the home directory
  cp -r $OUTPUT_DIR $WORKDIR
  echo "Results for ${i} copied to $WORKDIR/$OUTPUT_DIR"
done

# Finally, cd back to the home directory and clean up the scratch directory
# NOTE: you can also not delete the scratch directory if your data is too large to copy every time
# In that case, comment line 52, 17, and 22 after the first run
cd $WORKDIR
rm -rf $SCRDIR

