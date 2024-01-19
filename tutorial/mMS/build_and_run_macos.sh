#!/bin/bash

export PDAF_ARCH=macos_gfortran_openmpi
export makefilepath="/Users/arvynde/Documents/PDAF2/make.arch"
export PATH="/usr/local/bin:$PATH"

echo $makefilepath

######## GENERATE INIT FILES + NETCDF STATE FILE ########
if grep -q "\-DUSE_PDAF" $makefilepath; then
	sed -i '' 's/^CPP_DEFS = -DUSE_PDAF/CPP_DEFS = #-DUSE_PDAF/' $makefilepath
fi

# Compile mod_model.F90 with NetCDF flags
mpif90 -O3 -fdefault-real-8 -std=f2008 -DUSE_PDAF -I../../include -I/Users/arvynde/Documents/PDAF2/tutorial/mMS/netcdf/include -c mod_model.F90

# Link the object files to create the model executable
mpif90 -o model -L/Users/arvynde/Documents/PDAF2/tutorial/mMS/netcdf/lib -lnetcdff -lnetcdf mod_model.o


make clean
make model
./model -spinup 0
make clean
make model
./model -spinup 1


######## GENERATE ENSEMBLE AND OBSERVATIONS ########
cd tools
make clean
gfortran -c -o parser_no_mpi.o parser_no_mpi.F90
make all
./generate_ens -ens_size 4
./generate_obs -obs_choice 1 -obs_spacing 6


# ######## RUN ASSIMILATION ########
if grep -q "#-DUSE_PDAF" $makefilepath; then
	sed -i '' 's/^CPP_DEFS = #-DUSE_PDAF/CPP_DEFS = -DUSE_PDAF/' $makefilepath
fi
cd ..
make clean
make model_pdaf
mpirun -np 4 ./model_pdaf -dim_ens 4 -exp_type obs_spacing_exp -filt_type 7 -filter_type lestkf -obs_type uniform6 
# srun -n 10 ./model_pdaf -dim_ens 10 -exp_type obs_spacing_exp -filt_type 6 -filter_type estkf -obs_type uniform6
