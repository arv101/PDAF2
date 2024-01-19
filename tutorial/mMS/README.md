Welcome to Shoale Badr's modified version of PDAF (used for synthetic cardiac data assimilation).

Now, PDAF can be run with just a few tweaks to this code here. 

To download and run:
1. Make sure your machine has the dependencies installed listed on the PDAF website (`cmake`, `gfortran`, etc).
2. Clone the PDAF 2.0 repo: https://github.com/PDAF/PDAF/tree/PDAF_V2.0 (this is a slightly older version of PDAF now- I think they updated it within the last few months).
3. Navigate to the `/tutorial` folder.
4. Clone this repo into that folder and rename it whatever you'd like (mMS for example, for Modified Mitchell-Schaeffer).
5. Create an `/outputs` folder and a `/results` folder within it.
6. Open `prepoststep_ens_pdaf.F90` and find lines 332 and 351 (variable name `filename`). Change `'results/for_elizabeth/jan_2024/rmserror_'` to just `'results/rmserror_'`
   and `'results/for_elizabeth/jan_2024/spread_'` to just `'results/spread_'`.
7. Open the `build_and_run_macos.sh` file.
8. In lines 6 & 7 and lines 27 & 28, change the filepath to where your header file is located (should be something similar to what I have there).
9. Now, the code is ready to run. To modify values for experimentation (more options will be added soon, such as changing parameter sets for the model),
   you can edit:
   - line 22: change the ensemble size (`-ens_size`) `\n`
   - line 23: change the observation type (`-obs_type`, see `tools/generate_ens.F90` for more info)
              change the observation spacing (`-obs_spacing`, if observation type is uniform)
   - line 33: set the number of processors (`-np`, should be equal to ensemble size)  
              set the ensemble size (`-dim_ens`),
              set stgrings for output file: 
                - `-exp_type`: experiment type, should be something like "obs_spacing"
                - `-filter_type`: filter type (e.g. "estkf", "etkf", etc.)
                - `-obs_type`: observation type (e.g. uniformly distributed observations every 8th grid point - "uniform8")
              set the filter (`-filt_type`, see `init_pdaf.F90` for more info).
13. In your terminal, run `chmod +x build_and_run_macos.sh` and then `./build_and_run_macos.sh`.
14. Congrats, you've run PDAF!



