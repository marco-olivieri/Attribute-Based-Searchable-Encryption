clc
clear all
close all

%% Dati

parallel_process = [1,5,10,100,200,300,400,500,600,700,800,900,1000];
parallel_process_plot = 100:100:1000;
total_time = 0:1:24;
%total_time_grid = 0:500:10500;

%%%%%
% stringa tempi per  label
total_time2 = (0:2:48)';
total_time_string = string(total_time2);
stringa_vuota = strings(length(total_time2),1);
unione = [total_time_string stringa_vuota]';
unione_alternata = unione(:);
total_time_label = unione_alternata';
%%%%%

excel_avgs = "data_timestamp/max_dict_ts.xlsx";
t_Wang2021 = readtable(excel_avgs, "Sheet", "Wang2021", VariableNamingRule="preserve");
t_H_Wang2020 = readtable(excel_avgs, "Sheet", "H.Wang2020_N5", VariableNamingRule="preserve");
t_Zheng2014 = readtable(excel_avgs, "Sheet", "Zheng2014_N5", VariableNamingRule="preserve");

% Schema Wang2021
time_1_Wang2021 = t_Wang2021.proc_1';
time_5_Wang2021 = t_Wang2021.proc_5';
time_10_Wang2021 = t_Wang2021.proc_10';
time_100_Wang2021 = t_Wang2021.proc_100';
time_200_Wang2021 = t_Wang2021.proc_200';
time_300_Wang2021 = t_Wang2021.proc_300';
time_400_Wang2021 = t_Wang2021.proc_400';
time_500_Wang2021 = t_Wang2021.proc_500';
time_600_Wang2021 = t_Wang2021.proc_600';
time_700_Wang2021 = t_Wang2021.proc_700';
time_800_Wang2021 = t_Wang2021.proc_800';
time_900_Wang2021 = t_Wang2021.proc_900';
time_1000_Wang2021 = t_Wang2021.proc_1000';

% Schema Wang2020
time_1_H_Wang2020 = t_H_Wang2020.proc_1';
time_5_H_Wang2020 = t_H_Wang2020.proc_5';
time_10_H_Wang2020 = t_H_Wang2020.proc_10';
time_100_H_Wang2020 = t_H_Wang2020.proc_100';
time_200_H_Wang2020 = t_H_Wang2020.proc_200';
time_300_H_Wang2020 = t_H_Wang2020.proc_300';
time_400_H_Wang2020 = t_H_Wang2020.proc_400';
time_500_H_Wang2020 = t_H_Wang2020.proc_500';
time_600_H_Wang2020 = t_H_Wang2020.proc_600';
time_700_H_Wang2020 = t_H_Wang2020.proc_700';
time_800_H_Wang2020 = t_H_Wang2020.proc_800';
time_900_H_Wang2020 = t_H_Wang2020.proc_900';
time_1000_H_Wang2020 = t_H_Wang2020.proc_1000';

% Schema Zheng2014
time_1_Zheng2014 = t_Zheng2014.proc_1';
time_5_Zheng2014 = t_Zheng2014.proc_5';
time_10_Zheng2014 = t_Zheng2014.proc_10';
time_100_Zheng2014 = t_Zheng2014.proc_100';
time_200_Zheng2014 = t_Zheng2014.proc_200';
time_300_Zheng2014 = t_Zheng2014.proc_300';
time_400_Zheng2014 = t_Zheng2014.proc_400';
time_500_Zheng2014 = t_Zheng2014.proc_500';
time_600_Zheng2014 = t_Zheng2014.proc_600';
time_700_Zheng2014 = t_Zheng2014.proc_700';
time_800_Zheng2014 = t_Zheng2014.proc_800';
time_900_Zheng2014 = t_Zheng2014.proc_900';
time_1000_Zheng2014 = t_Zheng2014.proc_1000';

%% Matrici

max_Wang2021 = [time_100_Wang2021;time_200_Wang2021;time_300_Wang2021;time_400_Wang2021;time_500_Wang2021;time_600_Wang2021;time_700_Wang2021;time_800_Wang2021;time_900_Wang2021;time_1000_Wang2021];
max_H_Wang2020 = [time_100_H_Wang2020;time_200_H_Wang2020;time_300_H_Wang2020;time_400_H_Wang2020;time_500_H_Wang2020;time_600_H_Wang2020;time_700_H_Wang2020;time_800_H_Wang2020;time_900_H_Wang2020;time_1000_H_Wang2020];
max_Zheng2014 = [time_100_Zheng2014;time_200_Zheng2014;time_300_Zheng2014;time_400_Zheng2014;time_500_Zheng2014;time_600_Zheng2014;time_700_Zheng2014;time_800_Zheng2014;time_900_Zheng2014;time_1000_Zheng2014];

%% Matrici Medie

avg_time_max_Wang2021 = [mean(time_100_Wang2021);mean(time_200_Wang2021);mean(time_300_Wang2021);mean(time_400_Wang2021);mean(time_500_Wang2021);mean(time_600_Wang2021);mean(time_700_Wang2021);mean(time_800_Wang2021);mean(time_900_Wang2021);mean(time_1000_Wang2021)];
%avg_time_max_Wang2021 = avg_time_max_Wang2021*1000;

avg_time_max_H_Wang2020 = [mean(time_100_H_Wang2020);mean(time_200_H_Wang2020);mean(time_300_H_Wang2020);mean(time_400_H_Wang2020);mean(time_500_H_Wang2020);mean(time_600_H_Wang2020);mean(time_700_H_Wang2020);mean(time_800_H_Wang2020);mean(time_900_H_Wang2020);mean(time_1000_H_Wang2020)];
%avg_time_max_H_Wang2020 = avg_time_max_H_Wang2020*1000;

avg_time_max_Zheng2014 = [mean(time_100_Zheng2014);mean(time_200_Zheng2014);mean(time_300_Zheng2014);mean(time_400_Zheng2014);mean(time_500_Zheng2014);mean(time_600_Zheng2014);mean(time_700_Zheng2014);mean(time_800_Zheng2014);mean(time_900_Zheng2014);mean(time_1000_Zheng2014)];
%avg_time_max_Zheng2014 = avg_time_max_Zheng2014*1000;

%% PLOT WANG2021

figure ('Name', strcat('Average Search Time Wang2021'))

plot(parallel_process_plot,avg_time_max_Wang2021,'-o','MarkerSize',14,'Color',[0.8500, 0.3250, 0.0980],'MarkerFaceColor',[0.9290,0.6940, 0.1250],'LineWidth',2)
grid on

set(gca,'FontSize',30)
xlim([0 1100])
xticks(parallel_process_plot)
xticklabels(parallel_process_plot)
ylim([0 24])
yticks(total_time)
yticklabels(total_time_label)
xlabel("Parallel processes [#]","FontSize",30,"FontWeight","bold")
ylabel("Search computing time [s]","FontSize",30,"FontWeight","bold")

title("Average Search Time Wang2021")


%% PLOT WANG2020

figure ('Name', strcat('Average Search Time Wang2020'))

plot(parallel_process_plot,avg_time_max_H_Wang2020,'-o','MarkerSize',14,'Color',[0, 0.5, 0],'MarkerFaceColor',[0.4660, 0.6740, 0.1880],'LineWidth',2)
grid on

set(gca,'FontSize',30)
xlim([0 1100])
xticks(parallel_process_plot)
xticklabels(parallel_process_plot)
ylim([0 24])
yticks(total_time)
yticklabels(total_time_label)
xlabel("Parallel processes [#]","FontSize",30,"FontWeight","bold")
ylabel("Search computing time [s]","FontSize",30,"FontWeight","bold")

title("Average Search Time H.Wang2020")


%% PLOT ZHENG2014

figure ('Name', strcat('Average Search Time Zheng2014'))

plot(parallel_process_plot,avg_time_max_Zheng2014,'-o','MarkerSize',14,'Color',[0, 0.4470, 0.7410],'MarkerFaceColor',[0.3010, 0.7450, 0.9330],'LineWidth',2)
grid on

set(gca,'FontSize',30)
xlim([0 1100])
xticks(parallel_process_plot)
xticklabels(parallel_process_plot)
ylim([0 24])
yticks(total_time)
yticklabels(total_time_label)
xlabel("Parallel processes [#]","FontSize",30,"FontWeight","bold")
ylabel("Search computing time [s]","FontSize",30,"FontWeight","bold")

title("Average Search Time Zheng2014")

%% PLOT COMPARISON

figure ('Name', strcat('Average Search Time'))

plot(parallel_process_plot,avg_time_max_Wang2021,'-o','MarkerSize',14,'Color',[0.8500, 0.3250, 0.0980],'MarkerFaceColor',[0.9290,0.6940, 0.1250],'LineWidth',2)
hold on
plot(parallel_process_plot,avg_time_max_H_Wang2020,'-o','MarkerSize',14,'Color',[0, 0.5, 0],'MarkerFaceColor',[0.4660, 0.6740, 0.1880],'LineWidth',2)
plot(parallel_process_plot,avg_time_max_Zheng2014,'-o','MarkerSize',14,'Color',[0, 0.4470, 0.7410],'MarkerFaceColor',[0.3010, 0.7450, 0.9330],'LineWidth',2)
grid on

set(gca,'FontSize',30)
xlim([0 1100])
xticks(parallel_process_plot)
xticklabels(parallel_process_plot)
ylim([0 24])
yticks(total_time)
yticklabels(total_time_label)
xlabel("Parallel processes [#]","FontSize",30,"FontWeight","bold")
ylabel("Search computing time [s]","FontSize",30,"FontWeight","bold")

title("Average Search Time")
lgnStr_search_time = (["Wang2021","H.Wang2020","Zheng2014"]);
legend(lgnStr_search_time,'FontSize',30,'Location','northwest');

%% Boxplot WANG2021

figure ('Name', strcat('Average Search Time Wang2021'))

boxplot(max_Wang2021',parallel_process_plot)
grid on

set(gca,'FontSize',30)
% xlim([0 1100])
% xticks(parallel_process_plot)
% xticklabels(parallel_process_plot)
ylim([0 24])
yticks(total_time)
yticklabels(total_time_label)
xlabel("Parallel processes [#]","FontSize",30,"FontWeight","bold")
ylabel("Search computing time [s]","FontSize",30,"FontWeight","bold")

title("Average Search Time Wang2021")


%% Boxplot WANG2020

figure ('Name', strcat('Average Search Time Wang2020'))

boxplot(max_H_Wang2020',parallel_process_plot)
grid on

set(gca,'FontSize',30)
% xlim([0 1100])
% xticks(parallel_process_plot)
% xticklabels(parallel_process_plot)
ylim([0 24])
yticks(total_time)
yticklabels(total_time_label)
xlabel("Parallel processes [#]","FontSize",30,"FontWeight","bold")
ylabel("Search computing time [s]","FontSize",30,"FontWeight","bold")

title("Average Search Time H.Wang2020")


%% Boxplot ZHENG2014

figure ('Name', strcat('Average Search Time Zheng2014'))

boxplot(max_Zheng2014',parallel_process_plot)
grid on

set(gca,'FontSize',30)
% xlim([0 1100])
% xticks(parallel_process_plot)
% xticklabels(parallel_process_plot)
ylim([0 24])
yticks(total_time)
yticklabels(total_time_label)
xlabel("Parallel processes [#]","FontSize",30,"FontWeight","bold")
ylabel("Search computing time [s]","FontSize",30,"FontWeight","bold")

title("Average Search Time Zheng2014")


%% PLOT+BOX WANG2021

figure ('Name', strcat('Average Search Time Wang2021'))

hb_wang21 = boxplot(max_Wang2021',parallel_process_plot);
set(hb_wang21,'LineWidth',1.5);
hold on
plot(avg_time_max_Wang2021,'-o','MarkerSize',8,'Color',[0.8500, 0.3250, 0.0980],'MarkerFaceColor',[0.9290,0.6940, 0.1250],'LineWidth',0.8)
grid on

set(gca,'FontSize',30)
% xlim([0 1100])
% xticks(parallel_process_plot)
% xticklabels(parallel_process_plot)
ylim([0 24])
yticks(total_time)
yticklabels(total_time_label)
xlabel("Parallel processes [#]","FontSize",30,"FontWeight","bold")
ylabel("Search computing time [s]","FontSize",30,"FontWeight","bold")

title("Average Search Time Wang2021")


%% PLOT+BOX WANG2020
figure ('Name', strcat('Average Search Time H.Wang2020'))

hb_wang20 = boxplot(max_H_Wang2020',parallel_process_plot);
set(hb_wang20,'LineWidth',1.5);
hold on
plot(avg_time_max_H_Wang2020,'-o','MarkerSize',8,'Color',[0, 0.5, 0],'MarkerFaceColor',[0.4660, 0.6740, 0.1880],'LineWidth',0.8)
grid on

set(gca,'FontSize',30)
% xlim([0 1100])
% xticks(parallel_process_plot)
% xticklabels(parallel_process_plot)
ylim([0 24])
yticks(total_time)
yticklabels(total_time_label)
xlabel("Parallel processes [#]","FontSize",30,"FontWeight","bold")
ylabel("Search computing time [s]","FontSize",30,"FontWeight","bold")

title("Average Search Time H.Wang2020")


%% PLOT+BOX ZHENG2014

figure ('Name', strcat('Average Search Time Zheng2014'))

hb_zheng = boxplot(max_Zheng2014',parallel_process_plot);
set(hb_zheng,'LineWidth',1.5);
hold on
plot(avg_time_max_Zheng2014,'-o','MarkerSize',8,'Color',[0, 0.4470, 0.7410],'MarkerFaceColor',[0.3010, 0.7450, 0.9330],'LineWidth',0.8)
grid on

set(gca,'FontSize',30)
% xlim([0 1100])
% xticks(parallel_process_plot)
% xticklabels(parallel_process_plot)
ylim([0 24])
yticks(total_time)
yticklabels(total_time_label)
xlabel("Parallel processes [#]","FontSize",30,"FontWeight","bold")
ylabel("Search computing time [s]","FontSize",30,"FontWeight","bold")

title("Average Search Time Zheng2014")

%% PLOT+BOX COMPARISON

pl_wang21 = plot(avg_time_max_Wang2021,'-o','MarkerSize',8,'Color',[0.8500, 0.3250, 0.0980],'MarkerFaceColor',[0.9290,0.6940, 0.1250],'LineWidth',1);
hold on
pl_wang20 = plot(avg_time_max_H_Wang2020,'-o','MarkerSize',8,'Color',[0, 0.5, 0],'MarkerFaceColor',[0.4660, 0.6740, 0.1880],'LineWidth',1);
pl_zheng = plot(avg_time_max_Zheng2014,'-o','MarkerSize',8,'Color',[0, 0.4470, 0.7410],'MarkerFaceColor',[0.3010, 0.7450, 0.9330],'LineWidth',1);

hb_wang21 = boxplot(max_Wang2021',parallel_process_plot);
set(hb_wang21,'LineWidth',1.5);

hb_wang20 = boxplot(max_H_Wang2020',parallel_process_plot);
set(hb_wang20,'LineWidth',1.5);

hb_zheng = boxplot(max_Zheng2014',parallel_process_plot);
set(hb_zheng,'LineWidth',1.5);

grid on

set(gca,'FontSize',30)
% xlim([0 1100])
% xticks(parallel_process_plot)
% xticklabels(parallel_process_plot)
ylim([0 24])
yticks(total_time)
yticklabels(total_time_label)
xlabel("Parallel processes [#]","FontSize",30,"FontWeight","bold")
ylabel("Search computing time [s]","FontSize",30,"FontWeight","bold")

title("Average Search Time")
lgnStr_search_time = (["Wang2021","H.Wang2020","Zheng2014"]);
legend([pl_wang21,pl_wang20,pl_zheng],lgnStr_search_time,'FontSize',30,'Location','northwest');






