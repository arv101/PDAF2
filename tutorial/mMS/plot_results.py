#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Mar 13 23:09:53 2023

@author: shoale
"""


import matplotlib.pyplot as plt
import numpy as np

total_steps = 16000

def constantobs_changingdeltobs():

    # 100 uniformly distributed observations
    file1 = 'results/true_rmse_ens_size_05no_model_error.txt'
    file2 = 'results/true_rmse_ens_size_10no_model_error.txt'
    file3 = 'results/true_rmse_ens_size_20no_model_error.txt'
    # file2 = 'spread_rmse_delt_obs_0010_ens_size_20.txt'
    # file2 = 'spread_rmse_delt_obs_0005_ens_size_04.txt'
    # file3 = 'spread_rmse_delt_obs_00010_ens_size_05.txt'
    # file4 = 'true_rmse_delt_obs_0005_ens_size_04.txt'
    # file5 = 'rmse_results_0250.txt'
    # file6 = 'rmse_results_0005.txt'
    # file3 = '../../outputs/spiral_wave/rmse_results_12_250.txt'
    
    # # 500 uniformly distributed observations
    # file4 = '../../outputs/spiral_wave/rmse_results_ 2_500.txt'
    # file5 = '../../outputs/spiral_wave/rmse_results_ 8_500.txt'
    # file6 = '../../outputs/spiral_wave/rmse_results_12_500.txt'
    # file7 = '../../outputs/spiral_wave/rmse_results_20_500.txt'
    # file8 = '../../outputs/spiral_wave/rmse_results_25_500.txt'
    
    # assimilation intervals
    deltobs1 = 10
    deltobs2 = 10
    deltobs3 = 10
    # deltobs4 = 5
    # deltobs5 = 250
    # deltobs6 = 5
    
    # result output files
    results1 = np.loadtxt(file1)
    results2 = np.loadtxt(file2)
    results3 = np.loadtxt(file3)
    # results4 = np.loadtxt(file4)
    # results5 = np.loadtxt(file5)
    # results6 = np.loadtxt(file6)
    
    # results4 = np.loadtxt(file4)
    # results5 = np.loadtxt(file5)
    # results6 = np.loadtxt(file6)
    # results7 = np.loadtxt(file7)
    # results8 = np.loadtxt(file8)
    
    # x-axes
    x1 = range(0, total_steps, deltobs1)
    x2 = range(0, total_steps, deltobs2)
    x3 = range(0, total_steps, deltobs3)
    # x4 = range(0, total_steps, deltobs4)
    # x5 = range(0, total_steps, deltobs5)
    # x6 = range(0, total_steps, deltobs6)
    
    # dot size
    dotsize = 10
    
    # 250 observations plot
    plt.plot(x1, results1)
    plt.plot(x2, results2)
    plt.plot(x3, results3)
    # plt.yscale('log')
    # plt.plot(x4, results4)
    # plt.plot(x5, results5)
    # plt.plot(x6, results6)
    # plt.scatter(x2, results2, s=dotsize)
    # plt.scatter(x3, results3, s=dotsize)
    # leg = ['25', '50', '500', '100', '250', '5']
    leg = ['20', '10', '5']
    # leg = ['Analysis RMSE', 'Spread']
    plt.legend(leg)
    plt.yscale('log')
    # plt.legend(['$\delta$ obs = 2', '$\delta$ obs = 8', '$\delta$ obs = 12'])
    # plt.title('RMSE over time for PDAF Run on FHN Model w/250 observations')
    plt.show()
    
    # 500 observations plot
    # plt.plot(x1, results4, color='blue')
    # plt.plot(x2, results5, color='red')
    # # plt.scatter(x3, results6, marker = '*', s=dotsize)
    # plt.plot(x4, results7, color='black')
    # plt.plot(x5, results8, color='green')
    # # plt.legend(['$\delta$ obs = 2', '$\delta$ obs = 8', '$\delta$ obs = 12', '$\delta$ obs = 20', '$\delta$ obs = 25'])
    # plt.legend(['$\delta$ obs = 2', '$\delta$ obs = 8', '$\delta$ obs = 20', '$\delta$ obs = 25'])
    # plt.title('RMSE over time for PDAF Run on FHN Model w/500 observations')
    # plt.show()
    
# def changing

if __name__ == '__main__':
    constantobs_changingdeltobs()











