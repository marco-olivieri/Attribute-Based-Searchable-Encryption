clc
clear all
close all

%% import data from excel file

excel_times = "data_timestamp/prc_counter_ts.xlsx";
count_Wang2021 = readtable(excel_times, "Sheet", "Wang2021", VariableNamingRule="preserve");
count_H_Wang2020 = readtable(excel_times, "Sheet", "H.Wang2020_N5", VariableNamingRule="preserve");
count_Zheng2014 = readtable(excel_times, "Sheet", "Zheng2014_N5", VariableNamingRule="preserve");
max_max_time = readtable(excel_times, "Sheet", "time_max_N5", VariableNamingRule="preserve").general_time_max;

% Wang2021
count_100_Wang2021 = count_Wang2021.proc_100';
count_300_Wang2021 = count_Wang2021.proc_300';
count_500_Wang2021 = count_Wang2021.proc_500';
count_800_Wang2021 = count_Wang2021.proc_800';
count_1000_Wang2021 = count_Wang2021.proc_1000';

% H.Wang2020
count_100_H_Wang2020 = count_H_Wang2020.proc_100';
count_300_H_Wang2020 = count_H_Wang2020.proc_300';
count_500_H_Wang2020 = count_H_Wang2020.proc_500';
count_800_H_Wang2020 = count_H_Wang2020.proc_800';
count_1000_H_Wang2020 = count_H_Wang2020.proc_1000';

% Zheng2014
count_100_Zheng2014 = count_Zheng2014.proc_100';
count_300_Zheng2014 = count_Zheng2014.proc_300';
count_500_Zheng2014 = count_Zheng2014.proc_500';
count_800_Zheng2014 = count_Zheng2014.proc_800';
count_1000_Zheng2014 = count_Zheng2014.proc_1000';

time_axis = round(0:0.01:max_max_time+1, 2);

%% plot 100 

% Wang2021
figure ('Name', strcat('Process completed Wang2021 (100)'))
len_diff = ceil(abs(length(time_axis) - length(count_100_Wang2021)));
plot(time_axis, [count_100_Wang2021 NaN(1, len_diff)],'Color',[0.8500, 0.3250, 0.0980], "LineWidth",2)
grid on
set(gca,'FontSize',30)
xlim([0 ceil(time_axis(end))])
xticks([round(time_axis(1:100:end))])
ylim([0 1100])
yticks(0:100:1000)
yticklabels(0:100:1000)
xlabel("Time [s]","FontSize",30,"FontWeight","bold")
ylabel("Completed Process [#]","FontSize",30,"FontWeight","bold")
title("Process completed Wang2021 (100)")

% H.Wang2020
figure ('Name', strcat('Process completed H.Wang2020 (100)'))
len_diff = ceil(abs(length(time_axis) - length(count_100_H_Wang2020)));
plot(time_axis, [count_100_H_Wang2020 NaN(1, len_diff)],'Color',[0, 0.5, 0], "LineWidth",2)
grid on
set(gca,'FontSize',30)
xlim([0 ceil(time_axis(end))])
xticks([round(time_axis(1:100:end))])
ylim([0 1100])
yticks(0:100:1000)
yticklabels(0:100:1000)
xlabel("Time [s]","FontSize",30,"FontWeight","bold")
ylabel("Completed Process [#]","FontSize",30,"FontWeight","bold")
title("Process completed H.Wang2020 (100)")

% Zheng2014
figure ('Name', strcat('Process completed Zheng2014 (100)'))
len_diff = ceil(abs(length(time_axis) - length(count_100_Zheng2014)));
plot(time_axis, [count_100_Zheng2014 NaN(1, len_diff)],'Color',[0, 0.4470, 0.7410], "LineWidth",2)
grid on
set(gca,'FontSize',30)
xlim([0 ceil(time_axis(end))])
xticks([round(time_axis(1:100:end))])
ylim([0 1100])
yticks(0:100:1000)
yticklabels(0:100:1000)
xlabel("Time [s]","FontSize",30,"FontWeight","bold")
ylabel("Completed Process [#]","FontSize",30,"FontWeight","bold")
title("Process completed Zheng2014 (100)")

%% plot 300 

% Wang2021
figure ('Name', strcat('Process completed Wang2021 (300)'))
len_diff = ceil(abs(length(time_axis) - length(count_300_Wang2021)));
plot(time_axis, [count_300_Wang2021 NaN(1, len_diff)],'Color',[0.8500, 0.3250, 0.0980], "LineWidth",2)
grid on
set(gca,'FontSize',30)
xlim([0 ceil(time_axis(end))])
xticks([round(time_axis(1:100:end))])
ylim([0 1100])
yticks(0:100:1000)
yticklabels(0:100:1000)
xlabel("Time [s]","FontSize",30,"FontWeight","bold")
ylabel("Completed Process [#]","FontSize",30,"FontWeight","bold")
title("Process completed Wang2021 (300)")

% H.Wang2020
figure ('Name', strcat('Process completed H.Wang2020 (300)'))
len_diff = ceil(abs(length(time_axis) - length(count_300_H_Wang2020)));
plot(time_axis, [count_300_H_Wang2020 NaN(1, len_diff)],'Color',[0, 0.5, 0], "LineWidth",2)
grid on
set(gca,'FontSize',30)
xlim([0 ceil(time_axis(end))])
xticks([round(time_axis(1:100:end))])
ylim([0 1100])
yticks(0:100:1000)
yticklabels(0:100:1000)
xlabel("Time [s]","FontSize",30,"FontWeight","bold")
ylabel("Completed Process [#]","FontSize",30,"FontWeight","bold")
title("Process completed H.Wang2020 (300)")

% Zheng2014
figure ('Name', strcat('Process completed Zheng2014 (300)'))
len_diff = ceil(abs(length(time_axis) - length(count_300_Zheng2014)));
plot(time_axis, [count_300_Zheng2014 NaN(1, len_diff)],'Color',[0, 0.4470, 0.7410], "LineWidth",2)
grid on
set(gca,'FontSize',30)
xlim([0 ceil(time_axis(end))])
xticks([round(time_axis(1:100:end))])
ylim([0 1100])
yticks(0:100:1000)
yticklabels(0:100:1000)
xlabel("Time [s]","FontSize",30,"FontWeight","bold")
ylabel("Completed Process [#]","FontSize",30,"FontWeight","bold")
title("Process completed Zheng2014 (300)")

%% plot 500 
 
% Wang2021
figure ('Name', strcat('Process completed Wang2021 (500)'))
len_diff = ceil(abs(length(time_axis) - length(count_500_Wang2021)));
plot(time_axis, [count_500_Wang2021 NaN(1, len_diff)],'Color',[0.8500, 0.3250, 0.0980], "LineWidth",2)
grid on
set(gca,'FontSize',30)
xlim([0 ceil(time_axis(end))])
xticks([round(time_axis(1:100:end))])
ylim([0 1100])
yticks(0:100:1000)
yticklabels(0:100:1000)
xlabel("Time [s]","FontSize",30,"FontWeight","bold")
ylabel("Completed Process [#]","FontSize",30,"FontWeight","bold")
title("Process completed Wang2021 (500)")

% H.Wang2020
figure ('Name', strcat('Process completed H.Wang2020 (500)'))
len_diff = ceil(abs(length(time_axis) - length(count_500_H_Wang2020)));
plot(time_axis, [count_500_H_Wang2020 NaN(1, len_diff)],'Color',[0, 0.5, 0], "LineWidth",2)
grid on
set(gca,'FontSize',30)
xlim([0 ceil(time_axis(end))])
xticks([round(time_axis(1:100:end))])
ylim([0 1100])
yticks(0:100:1000)
yticklabels(0:100:1000)
xlabel("Time [s]","FontSize",30,"FontWeight","bold")
ylabel("Completed Process [#]","FontSize",30,"FontWeight","bold")
title("Process completed H.Wang2020 (500)")

% Zheng2014
figure ('Name', strcat('Process completed Zheng2014 (500)'))
len_diff = ceil(abs(length(time_axis) - length(count_500_Zheng2014)));
plot(time_axis, [count_500_Zheng2014 NaN(1, len_diff)],'Color',[0, 0.4470, 0.7410], "LineWidth",2)
grid on
set(gca,'FontSize',30)
xlim([0 ceil(time_axis(end))])
xticks([round(time_axis(1:100:end))])
ylim([0 1100])
yticks(0:100:1000)
yticklabels(0:100:1000)
xlabel("Time [s]","FontSize",30,"FontWeight","bold")
ylabel("Completed Process [#]","FontSize",30,"FontWeight","bold")
title("Process completed Zheng2014 (500)")

%% plot 800 

% Wang2021
figure ('Name', strcat('Process completed Wang2021 (800)'))
len_diff = ceil(abs(length(time_axis) - length(count_800_Wang2021)));
plot(time_axis, [count_800_Wang2021 NaN(1, len_diff)],'Color',[0.8500, 0.3250, 0.0980], "LineWidth",2)
grid on
set(gca,'FontSize',30)
xlim([0 ceil(time_axis(end))])
xticks([round(time_axis(1:100:end))])
ylim([0 1100])
yticks(0:100:1000)
yticklabels(0:100:1000)
xlabel("Time [s]","FontSize",30,"FontWeight","bold")
ylabel("Completed Process [#]","FontSize",30,"FontWeight","bold")
title("Process completed Wang2021 (800)")

% H.Wang2020
figure ('Name', strcat('Process completed H.Wang2020 (800)'))
len_diff = ceil(abs(length(time_axis) - length(count_800_H_Wang2020)));
plot(time_axis, [count_800_H_Wang2020 NaN(1, len_diff)],'Color',[0, 0.5, 0], "LineWidth",2)
grid on
set(gca,'FontSize',30)
xlim([0 ceil(time_axis(end))])
xticks([round(time_axis(1:100:end))])
ylim([0 1100])
yticks(0:100:1000)
yticklabels(0:100:1000)
xlabel("Time [s]","FontSize",30,"FontWeight","bold")
ylabel("Completed Process [#]","FontSize",30,"FontWeight","bold")
title("Process completed H.Wang2020 (800)")

% Zheng2014
figure ('Name', strcat('Process completed Zheng2014 (800)'))
len_diff = ceil(abs(length(time_axis) - length(count_800_Zheng2014)));
plot(time_axis, [count_800_Zheng2014 NaN(1, len_diff)],'Color',[0, 0.4470, 0.7410], "LineWidth",2)
grid on
set(gca,'FontSize',30)
xlim([0 ceil(time_axis(end))])
xticks([round(time_axis(1:100:end))])
ylim([0 1100])
yticks(0:100:1000)
yticklabels(0:100:1000)
xlabel("Time [s]","FontSize",30,"FontWeight","bold")
ylabel("Completed Process [#]","FontSize",30,"FontWeight","bold")
title("Process completed Zheng2014 (800)")

%% plot 1000 

% Wang2021
figure ('Name', strcat('Process completed Wang2021 (1000)'))
len_diff = ceil(abs(length(time_axis) - length(count_1000_Wang2021)));
plot(time_axis, [count_1000_Wang2021 NaN(1, len_diff)],'Color',[0.8500, 0.3250, 0.0980], "LineWidth",2)
grid on
set(gca,'FontSize',30)
xlim([0 ceil(time_axis(end))])
xticks([round(time_axis(1:100:end))])
ylim([0 1100])
yticks(0:100:1000)
yticklabels(0:100:1000)
xlabel("Time [s]","FontSize",30,"FontWeight","bold")
ylabel("Completed Process [#]","FontSize",30,"FontWeight","bold")
title("Process completed Wang2021 (1000)")

% H.Wang2020
figure ('Name', strcat('Process completed H.Wang2020 (1000)'))
len_diff = ceil(abs(length(time_axis) - length(count_1000_H_Wang2020)));
plot(time_axis, [count_1000_H_Wang2020 NaN(1, len_diff)],'Color',[0, 0.5, 0], "LineWidth",2)
grid on
set(gca,'FontSize',30)
xlim([0 ceil(time_axis(end))])
xticks([round(time_axis(1:100:end))])
ylim([0 1100])
yticks(0:100:1000)
yticklabels(0:100:1000)
xlabel("Time [s]","FontSize",30,"FontWeight","bold")
ylabel("Completed Process [#]","FontSize",30,"FontWeight","bold")
title("Process completed H.Wang2020 (1000)")

% Zheng2014
figure ('Name', strcat('Process completed Zheng2014 (1000)'))
len_diff = ceil(abs(length(time_axis) - length(count_1000_Zheng2014)));
plot(time_axis, [count_1000_Zheng2014 NaN(1, len_diff)],'Color',[0, 0.4470, 0.7410], "LineWidth",2)
grid on
set(gca,'FontSize',30)
xlim([0 ceil(time_axis(end))])
xticks([round(time_axis(1:100:end))])
ylim([0 1100])
yticks(0:100:1000)
yticklabels(0:100:1000)
xlabel("Time [s]","FontSize",30,"FontWeight","bold")
ylabel("Completed Process [#]","FontSize",30,"FontWeight","bold")
title("Process completed Zheng2014 (1000)")

%% MERGED PLOTS

% 100
figure ('Name', strcat('Process completed (100)'))

len_diff = ceil(abs(length(time_axis) - length(count_100_Wang2021)));
plot(time_axis, [count_100_Wang2021 NaN(1, len_diff)],'Color',[0.8500, 0.3250, 0.0980], "LineWidth",2)
hold on

len_diff = ceil(abs(length(time_axis) - length(count_100_H_Wang2020)));
plot(time_axis, [count_100_H_Wang2020 NaN(1, len_diff)],'Color',[0, 0.5, 0], "LineWidth",2)

len_diff = ceil(abs(length(time_axis) - length(count_100_Zheng2014)));
plot(time_axis, [count_100_Zheng2014 NaN(1, len_diff)],'Color',[0, 0.4470, 0.7410], "LineWidth",2)

grid on
set(gca,'FontSize',30)
xlim([0 ceil(time_axis(end))])
xticks([round(time_axis(1:100:end))])
ylim([0 1100])
yticks(0:100:1000)
yticklabels(0:100:1000)
xlabel("Time [s]","FontSize",30,"FontWeight","bold")
ylabel("Completed Process [#]","FontSize",30,"FontWeight","bold")
title("Process completed (100)")
legend([" Wang2021", " H.Wang2020", " Zheng2014"],'FontSize',30,'Location','southeast');

% 300
figure ('Name', strcat('Process completed (300)'))

len_diff = ceil(abs(length(time_axis) - length(count_300_Wang2021)));
plot(time_axis, [count_300_Wang2021 NaN(1, len_diff)],'Color',[0.8500, 0.3250, 0.0980], "LineWidth",2)
hold on

len_diff = ceil(abs(length(time_axis) - length(count_300_H_Wang2020)));
plot(time_axis, [count_300_H_Wang2020 NaN(1, len_diff)],'Color',[0, 0.5, 0], "LineWidth",2)

len_diff = ceil(abs(length(time_axis) - length(count_300_Zheng2014)));
plot(time_axis, [count_300_Zheng2014 NaN(1, len_diff)],'Color',[0, 0.4470, 0.7410], "LineWidth",2)

grid on
set(gca,'FontSize',30)
xlim([0 ceil(time_axis(end))])
xticks([round(time_axis(1:100:end))])
ylim([0 1100])
yticks(0:100:1000)
yticklabels(0:100:1000)
xlabel("Time [s]","FontSize",30,"FontWeight","bold")
ylabel("Completed Process [#]","FontSize",30,"FontWeight","bold")
title("Process completed (300)")
legend([" Wang2021", " H.Wang2020", " Zheng2014"],'FontSize',30,'Location','southeast');

% 500
figure ('Name', strcat('Process completed (500)'))

len_diff = ceil(abs(length(time_axis) - length(count_500_Wang2021)));
plot(time_axis, [count_500_Wang2021 NaN(1, len_diff)],'Color',[0.8500, 0.3250, 0.0980], "LineWidth",2)
hold on

len_diff = ceil(abs(length(time_axis) - length(count_500_H_Wang2020)));
plot(time_axis, [count_500_H_Wang2020 NaN(1, len_diff)],'Color',[0, 0.5, 0], "LineWidth",2)

len_diff = ceil(abs(length(time_axis) - length(count_500_Zheng2014)));
plot(time_axis, [count_500_Zheng2014 NaN(1, len_diff)],'Color',[0, 0.4470, 0.7410], "LineWidth",2)

grid on
set(gca,'FontSize',30)
xlim([0 ceil(time_axis(end))])
xticks([round(time_axis(1:100:end))])
ylim([0 1100])
yticks(0:100:1000)
yticklabels(0:100:1000)
xlabel("Time [s]","FontSize",30,"FontWeight","bold")
ylabel("Completed Process [#]","FontSize",30,"FontWeight","bold")
title("Process completed (500)")
legend([" Wang2021", " H.Wang2020", " Zheng2014"],'FontSize',30,'Location','southeast');

% 800
figure ('Name', strcat('Process completed (800)'))

len_diff = ceil(abs(length(time_axis) - length(count_800_Wang2021)));
plot(time_axis, [count_800_Wang2021 NaN(1, len_diff)],'Color',[0.8500, 0.3250, 0.0980], "LineWidth",2)
hold on

len_diff = ceil(abs(length(time_axis) - length(count_800_H_Wang2020)));
plot(time_axis, [count_800_H_Wang2020 NaN(1, len_diff)],'Color',[0, 0.5, 0], "LineWidth",2)

len_diff = ceil(abs(length(time_axis) - length(count_800_Zheng2014)));
plot(time_axis, [count_800_Zheng2014 NaN(1, len_diff)],'Color',[0, 0.4470, 0.7410], "LineWidth",2)

grid on
set(gca,'FontSize',30)
xlim([0 ceil(time_axis(end))])
xticks([round(time_axis(1:100:end))])
ylim([0 1100])
yticks(0:100:1000)
yticklabels(0:100:1000)
xlabel("Time [s]","FontSize",30,"FontWeight","bold")
ylabel("Completed Process [#]","FontSize",30,"FontWeight","bold")
title("Process completed (800)")
legend([" Wang2021", " H.Wang2020", " Zheng2014"],'FontSize',30,'Location','southeast');

% 1000
figure ('Name', strcat('Process completed (1000)'))

len_diff = ceil(abs(length(time_axis) - length(count_1000_Wang2021)));
plot(time_axis, [count_1000_Wang2021 NaN(1, len_diff)],'Color',[0.8500, 0.3250, 0.0980], "LineWidth",2)
hold on

len_diff = ceil(abs(length(time_axis) - length(count_1000_H_Wang2020)));
plot(time_axis, [count_1000_H_Wang2020 NaN(1, len_diff)],'Color',[0, 0.5, 0], "LineWidth",2)

len_diff = ceil(abs(length(time_axis) - length(count_1000_Zheng2014)));
plot(time_axis, [count_1000_Zheng2014 NaN(1, len_diff)],'Color',[0, 0.4470, 0.7410], "LineWidth",2)

grid on
set(gca,'FontSize',30)
xlim([0 ceil(time_axis(end))])
xticks([round(time_axis(1:100:end))])
ylim([0 1100])
yticks(0:100:1000)
yticklabels(0:100:1000)
xlabel("Time [s]","FontSize",30,"FontWeight","bold")
ylabel("Completed Process [#]","FontSize",30,"FontWeight","bold")
title("Process completed (1000)")
legend([" Wang2021", " H.Wang2020", " Zheng2014"],'FontSize',30,'Location','southeast');




