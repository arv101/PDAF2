#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Mar  7 17:34:10 2023

@author: shoale
"""

import numpy as np
import matplotlib.pyplot as plt
import random

###################### PLOTTING THINGS #############################

## STATE STEP FORECAST
def forecast_state(start, stop, interval):
    for i in range(start, stop, interval):
        if i < 10:
            file = f'state_00{i}_for.txt'
        elif i < 100:
            file = f'state_00{i}_for.txt'
        elif i < 1000:
            file = f'state_0{i}_for.txt'
        elif i < 10000:
            file = f'state_{i}_for.txt'
        else:
            file = f'state_{i}_for.txt'
        field = np.loadtxt(file)
        plt.pcolor(field)
        plt.title(f'Forecasted Step {i}')
        plt.show()

## STATE STEP ANALYSIS
def analysis_state(start, stop, interval):
    for i in range(start, stop, interval):
        if i < 10:
            file = f'state_{i}_ana.txt'
        elif i < 100:
            file = f'state_{i}_ana.txt'
        elif i < 1000:
            file = f'state_{i}_ana.txt'
        elif i < 10000:
            file = f'state_{i}_ana.txt'
        else:
            file = f'state_{i}_ana.txt'
        field = np.loadtxt(file)
        plt.pcolor(field)
        plt.title(f'Analysis Step {i}')
        plt.show()
        
## ENSEMBLE ANALYSIS STATE
def ens_analysis_state(start, stop, interval, ens_num):
    for i in range(start, stop, interval):
        if i < 10:
            file = f'0{ens_num}_step{i}_ana.txt'
        elif i < 100:
            file = f'0{ens_num}_step{i}_ana.txt'
        elif i < 1000:
            file = f'0{ens_num}_step{i}_ana.txt'
        elif i < 10000:
            file = f'0{ens_num}_step{i}_ana.txt'
        else:
            file = f'0{ens_num}_step{i}_ana.txt'
        field = np.loadtxt(file)
        plt.pcolor(field)
        plt.title(f'Analysis Step {i}')
        plt.show()
    
## TRUE STEPS
def true_state(start, stop, interval):
    for i in range(start, stop, interval):
        if i < 10:
            file = f'true_v_  {i}.txt'
        elif i < 100:
            file = f'true_v_ {i}.txt'
        elif i < 1000:
            file = f'true_v_{i}.txt'
        elif i < 10000:
            file = f'true_v_{i}.txt'
        else:
            file = f'true_v_{i}.txt'
        field = np.loadtxt(file)
        plt.pcolor(field)
        plt.title(f'True Step {i}')
        plt.show()

## ENSEMBLE MEMBERS
def ens_member(start, stop):
    for i in range(start, stop):
        file = f'../inputs/ens_{i}.txt'
        field = np.loadtxt(file)
        plt.pcolor(field)
        plt.title(f'Ensemble Member {i}')
        plt.show()

## OBSERVATIONS
def observations(start, stop, interval):
    for i in range(start, stop, interval):
        file = f'obs_{i}.txt'
        field = np.loadtxt(file)
        plt.pcolor(field)
        plt.title(f'Observation Field Step {i}')
        plt.show()

        
##### ORIGINAL MODEL FROM TEST FORTRAN CODE #####
def og_model(start, stop, interval):
    for i in range(start, stop, interval):
        if i < 10:
            file = f'../inputs/corr_    {i}.txt'
        elif i < 100:
            file = f'../inputs/corr_   {i}.txt'
        elif i < 1000:
            file = f'../inputs/corr_  {i}.txt'
        elif i < 10000:
            file = f'../inputs/corr_ {i}.txt'
        else:
            file = f'../inputs/corr_{i}.txt'
        field = np.loadtxt(file)
        plt.pcolor(field)
        plt.title(f'Original Field Step {i}')
        plt.show()


### ENSEMBLE MEAN STATES
def ens_mean(start, stop, interval):
    # for i in range(start, stop, interval):
    #     if i < 10:
    #         file = f'outputs/ens_mean_step_0000{i}.txt'
    #     elif i < 100:
    #         file = f'outputs/state_{i}_ana.txt'
    #     elif i < 1000:
    #         file = f'outputs/ens_mean_step_0{i}.txt'
    #     elif i < 10000:
    #         file = f'outputs/ens_mean_step_{i}.txt'
    #     else:
    #         file = f'outputs/ens_mean_step_{i}.txt'
    #     field = np.loadtxt(file)
    #     plt.pcolor(field)
    #     plt.title(f'Ensemble Mean State Step {i}')
    #     plt.show()
    for i in range(start, stop, interval):
        if i < 10:
            filename = f'outputs/for_elizabeth/ens_mean_size_10_Obs_100_step_0000{i}.txt'
        elif i < 1000:
            filename = f'outputs/for_elizabeth/ens_mean_size_10_Obs_100_step_00{i}.txt'
        elif i < 10000:
            filename = f'outputs/for_elizabeth/ens_mean_size_10_Obs_100_step_0{i}.txt'
        else:
            filename = f'outputs/for_elizabeth/ens_mean_size_10_Obs_100_step_{i}.txt'
        with open(filename) as file:
            lines = file.readlines()
        pls = []
        for x in lines:
            for y in x.split():
                pls.append(float(y))
        pls2 = np.array(pls).reshape(200,200)
        plt.pcolor(pls2)
        plt.show()





# ## RESULTS ##

# # 250 uniformly distributed observations
# file1 = 'rmse_results_**.txt'

# # assimilation intervals
# total_steps = 16000
# deltobs1 = 100

# # result output files
# results1 = np.loadtxt(file1)

# # x-axes
# x1 = range(0, total_steps, deltobs1)

# # dot size
# dotsize = 10

# # 250 observations plot
# plt.plot(x1, results1)
# plt.show()



##### CALLING FUNCTIONS TO PLOT THINGS #####
stop_time = 16000
# forecast_state(20, stop_time, 100)
# analysis_state(100, stop_time, 200)
ens_mean(800, stop_time, 800)
# ens_analysis_state(100, stop_time, 100, 3)
# ens_member(1, 5)
# true_state(1, 160, 1)
# observations(0, 15, 15)
# og_model(10, stop_time,  100)







    
    
    
    