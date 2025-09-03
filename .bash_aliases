# Helpful aliases for CHPC
# Please edit as necessary for your own use
# Add to the end of your ~/.bashrc file

# Add a path for huggingface so it does not waste space in your home dir
export HF_HOME=/scratch/general/vast/$USER/hf_cache

# NOTE: If you want to keep the alias file separate, add the following line to your ~/.bashrc file
# if [ -f ~/.bash_aliases ]; then . ~/.bash_aliases; fi

# Initialize miniconda and git on your current session
alias hello='module use $HOME/MyModules && module load miniforge3/latest && module use git && echo "Hello!!! Initialized Python and Git f$alias gtaospace='cd /uufs/chpc.utah.edu/common/home/gtao-group1/u1529523'

# Alias for your group directory. Change as needed
alias grouppath='/uufs/chpc.utah.edu/common/home/lab-group1/u1234567'

# Scratch directory
alias scratchpath='/scratch/general/vast/$USER'

# Check the files in your scratch directory
alias checkscratch='ls -lh /scratch/general/vast/$USER'

# Check the error file for a specific job
slurmerr() {
    tail -f slurm-"$1".err-notch501
}

# Check the output file for a specific job
slurmout() {
    tail -f slurm-"$1".out-notch501
}

# Display all jobs running on the node. Replace notch501 with your node name that contains the GPUs
alias fullqueue='squeue -w notch501'

source ~/.createslurm
