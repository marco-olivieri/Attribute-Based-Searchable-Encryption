clc
clear all
close all

%% Dati

parallel_process = [100,300,500,800,1000];
parallel_process_label = 1:length(parallel_process);
% bar_data = [2.25321912865855, 2.241564391854963, 0.7007169589883857; 0.9521415078405467, 0.9456128207700718, 0.25151986849361085; 0.6503786353630272, 0.6431552996328381, 0.16900868408080824; 0.43994485740783773, 0.4388612961949624, 0.11990366548539913; 0.3602204167649087, 0.3609944831419354, 0.10109477902868971];

excel_bar = "data_timestamp/bar_plot_ts.xlsx";
bar_data_sgl_xls = readtable(excel_bar, "Sheet", "bar_data_avg", VariableNamingRule="preserve");
bar_data_sgl_xls = [bar_data_sgl_xls.Wang2021 bar_data_sgl_xls.("H.Wang2020_N5") bar_data_sgl_xls.Zheng2014_N5];
    
bar_data_sgl_xls;
%bar_data_sgl_mat = table2array(bar_data_sgl_xls);

bar_data_tot_xls = readtable(excel_bar, "Sheet", "bar_data_max", VariableNamingRule="preserve");
bar_data_tot_xls = [bar_data_tot_xls.Wang2021 bar_data_tot_xls.("H.Wang2020_N5") bar_data_tot_xls.Zheng2014_N5];
%bar_data_tot_mat = table2array(bar_data_tot_xls);

%% Plot basato sul singolo processo

% figure ('Name', strcat('Average completed processes per second'))
% 
% pl_bar = bar(parallel_process_label, bar_data_sgl_mat);
% grid on
% pl_bar(1).FaceColor = [0.8500, 0.3250, 0.0980];
% pl_bar(2).FaceColor = [0, 0.5, 0];
% pl_bar(3).FaceColor = [0, 0.4470, 0.7410];
% 
% set(gca,'FontSize',25)
% xticklabels(parallel_process)
% ylim([0 3])
% yticks(0:0.5:3)
% yticklabels({'0','','1','','2','','3'})
% 
% xlabel("Parallel processes [#]","FontSize",30,"FontWeight","bold")
% ylabel("Completed processes [#/s]","FontSize",30,"FontWeight","bold")
% lgnStr_search_time = ([" Wang2021"," H.Wang2020"," Zheng2014"]);
% legend(lgnStr_search_time,'FontSize',30,'Location','northeast');
% title("Average completed processes per second")

%% Plot basato sul tempo di search totale 

figure ('Name', strcat('Average completed processes per second'))

pl_bar = bar(parallel_process_label, bar_data_tot_xls);
grid on
pl_bar(1).FaceColor = [0.8500, 0.3250, 0.0980];
pl_bar(2).FaceColor = [0, 0.5, 0];
pl_bar(3).FaceColor = [0, 0.4470, 0.7410];

set(gca,'FontSize',25)
xticklabels(parallel_process)
ylim([0 300])
yticks(0:20:300)
%yticklabels({'0','','1','','2','','3'})

xlabel("Parallel processes [#]","FontSize",30,"FontWeight","bold")
ylabel("Completed processes [#/s]","FontSize",30,"FontWeight","bold")
lgnStr_search_time = ([" Wang2021"," H.Wang2020"," Zheng2014"]);
legend(lgnStr_search_time,'FontSize',30,'Location','northeast');
title("Average completed processes per second")
