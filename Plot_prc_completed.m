clc
clear all
close all

%% Dati
parallel_process = [1,5,10,100,200,300,400,500,600,700,800,900,1000];
parallel_process_plot = 100:100:1000;
total_time = 0:500:15000;
%total_time_grid = 0:500:10500;

%%%%%
%stringa tempi per  label
total_time2 = (0:2:50)';
total_time_string = string(total_time2);
stringa_vuota = strings(length(total_time2),1);
unione = [total_time_string stringa_vuota]';
unione_alternata = unione(:);
total_time_label = unione_alternata';
%%%%%

excel_times = "data_timestamp/times_dict_ts.xlsx";
t_Wang2021 = readtable(excel_times, "Sheet", "Wang2021", VariableNamingRule="preserve");
t_H_Wang2020 = readtable(excel_times, "Sheet", "H.Wang2020_N5", VariableNamingRule="preserve");
t_Zheng2014 = readtable(excel_times, "Sheet", "Zheng2014_N5", VariableNamingRule="preserve");

%Wang2021
%times_dict_100_Wang2021 = t_Wang2021.proc_100';
times_dict_300_Wang2021 = t_Wang2021.proc_300';
times_dict_500_Wang2021 = t_Wang2021.proc_500';
%times_dict_800_Wang2021 = t_Wang2021.proc_800';
times_dict_1000_Wang2021 = t_Wang2021.proc_1000';

%Wang2020
%times_dict_100_H_Wang2020 = t_H_Wang2020.proc_100';
times_dict_300_H_Wang2020 = t_H_Wang2020.proc_300';
times_dict_500_H_Wang2020 = t_H_Wang2020.proc_500';
%times_dict_800_H_Wang2020 = t_H_Wang2020.proc_800';
times_dict_1000_H_Wang2020 = t_H_Wang2020.proc_1000';

%Zheng2014
%times_dict_100_Zheng2014 = t_Zheng2014.proc_100';
times_dict_300_Zheng2014 = t_Zheng2014.proc_300';
times_dict_500_Zheng2014 = t_Zheng2014.proc_500';
%times_dict_800_Zheng2014 = t_Zheng2014.proc_800';
times_dict_1000_Zheng2014 = t_Zheng2014.proc_1000';

%% Plot Unici
%% Plot Wang2021
figure ('Name', strcat('Completed processes during the time Wang2021'))

subplot(1, 3, 1)
histogram(times_dict_300_Wang2021,200,"DisplayStyle","stairs","EdgeColor",[0.8500, 0.3250, 0.0980],"LineWidth",1)
grid on
set(gca,'FontSize',20)
ax = gca;
ax.GridAlpha = 0.1;
ax.GridLineStyle = "--";

xlim([0 25])
xticks(0:1:25)
xticklabels(total_time_label)
%xticklabels(0:1:25)
ylim([0 55])
yticks(0:5:55)
yticklabels(0:5:55)

xlabel("Time [s]","FontSize",20,"FontWeight","bold")
ylabel("Completed processes [#]","FontSize",20,"FontWeight","bold")
%title("Completed processes(100) during the time Wang2021","FontSize",25,"FontWeight","bold")

subplot(1, 3, 2)
histogram(times_dict_500_Wang2021,200,"DisplayStyle","stairs","EdgeColor",[0.8500, 0.3250, 0.0980],"LineWidth",1)
grid on
set(gca,'FontSize',20)
ax = gca;
ax.GridAlpha = 0.1;
ax.GridLineStyle = "--";

xlim([0 25])
xticks(0:1:25)
xticklabels(total_time_label)
%xticklabels(0:1:25)
ylim([0 55])
yticks(0:5:55)
yticklabels(0:5:55)

xlabel("Time [s]","FontSize",20,"FontWeight","bold")
ylabel("Completed processes [#]","FontSize",20,"FontWeight","bold")
%title("Completed processes(500) during the time Wang2021","FontSize",25,"FontWeight","bold")

subplot(1, 3, 3)
histogram(times_dict_1000_Wang2021,200,"DisplayStyle","stairs","EdgeColor",[0.8500, 0.3250, 0.0980],"LineWidth",1)
grid on
set(gca,'FontSize',20)
ax = gca;
ax.GridAlpha = 0.1;
ax.GridLineStyle = "--";

xlim([0 25])
xticks(0:1:25)
xticklabels(total_time_label)
%xticklabels(0:1:25)
ylim([0 55])
yticks(0:5:55)
yticklabels(0:5:55)

xlabel("Time [s]","FontSize",20,"FontWeight","bold")
ylabel("Completed processes [#]","FontSize",20,"FontWeight","bold")
%title("Completed processes(1000) during the time Wang2021","FontSize",25,"FontWeight","bold")
sgtitle("Completed processes during the time Wang2021","FontSize",25,"FontWeight","bold")

%% Plot H_Wang2020
figure ('Name', strcat('Completed processes during the time H_Wang2020'))

subplot(1, 3, 1)
histogram(times_dict_300_H_Wang2020,200,"DisplayStyle","stairs","EdgeColor",[0, 0.5, 0],"LineWidth",1)
grid on
set(gca,'FontSize',20)
ax = gca;
ax.GridAlpha = 0.1;
ax.GridLineStyle = "--";

xlim([0 25])
xticks(0:1:25)
xticklabels(total_time_label)
%xticklabels(0:1:25)
ylim([0 55])
yticks(0:5:55)
yticklabels(0:5:55)

xlabel("Time [s]","FontSize",20,"FontWeight","bold")
ylabel("Completed processes [#]","FontSize",20,"FontWeight","bold")
%title("Completed processes(100) during the time H_Wang2020","FontSize",25,"FontWeight","bold")

subplot(1, 3, 2)
histogram(times_dict_500_H_Wang2020,200,"DisplayStyle","stairs","EdgeColor",[0, 0.5, 0],"LineWidth",1)
grid on
set(gca,'FontSize',20)
ax = gca;
ax.GridAlpha = 0.1;
ax.GridLineStyle = "--";

xlim([0 25])
xticks(0:1:25)
xticklabels(total_time_label)
%xticklabels(0:1:25)
ylim([0 55])
yticks(0:5:55)
yticklabels(0:5:55)

xlabel("Time [s]","FontSize",20,"FontWeight","bold")
ylabel("Completed processes [#]","FontSize",20,"FontWeight","bold")
%title("Completed processes(500) during the time H_Wang2020","FontSize",25,"FontWeight","bold")

subplot(1, 3, 3)
histogram(times_dict_1000_H_Wang2020,200,"DisplayStyle","stairs","EdgeColor",[0, 0.5, 0],"LineWidth",1)
grid on
set(gca,'FontSize',20)
ax = gca;
ax.GridAlpha = 0.1;
ax.GridLineStyle = "--";

xlim([0 25])
xticks(0:1:25)
xticklabels(total_time_label)
%xticklabels(0:1:25)
ylim([0 55])
yticks(0:5:55)
yticklabels(0:5:55)

xlabel("Time [s]","FontSize",20,"FontWeight","bold")
ylabel("Completed processes [#]","FontSize",20,"FontWeight","bold")
%title("Completed processes(1000) during the time H.Wang2020","FontSize",25,"FontWeight","bold")
sgtitle("Completed processes during the time H.Wang2020","FontSize",25,"FontWeight","bold")

%% Plot Zheng2014
figure ('Name', strcat('Completed processes during the time Zheng2014'))

subplot(1, 3, 1)
histogram(times_dict_300_Zheng2014,200,"DisplayStyle","stairs","EdgeColor",[0, 0.4470, 0.7410],"LineWidth",1)
grid on
set(gca,'FontSize',20)
ax = gca;
ax.GridAlpha = 0.1;
ax.GridLineStyle = "--";

xlim([0 25])
xticks(0:2:25)
xticklabels(total_time_label)
ylim([0 55])
yticks(0:5:55)
yticklabels(0:5:55)

xlabel("Time [s]","FontSize",20,"FontWeight","bold")
ylabel("Completed processes [#]","FontSize",20,"FontWeight","bold")
%title("Completed processes(100) during the time Zheng2014","FontSize",25,"FontWeight","bold")

subplot(1, 3, 2)
histogram(times_dict_500_Zheng2014,200,"DisplayStyle","stairs","EdgeColor",[0, 0.4470, 0.7410],"LineWidth",1)
grid on
set(gca,'FontSize',20)
ax = gca;
ax.GridAlpha = 0.1;
ax.GridLineStyle = "--";

xlim([0 25])
xticks(0:1:25)
xticklabels(total_time_label)
ylim([0 55])
yticks(0:5:55)
yticklabels(0:5:55)

xlabel("Time [s]","FontSize",20,"FontWeight","bold")
ylabel("Completed processes [#]","FontSize",20,"FontWeight","bold")
%title("Completed processes(500) during the time Zheng2014","FontSize",25,"FontWeight","bold")

subplot(1, 3, 3)
histogram(times_dict_1000_Zheng2014,200,"DisplayStyle","stairs","EdgeColor",[0, 0.4470, 0.7410],"LineWidth",1)
grid on
set(gca,'FontSize',20)
ax = gca;
ax.GridAlpha = 0.1;
ax.GridLineStyle = "--";

xlim([0 25])
xticks(0:1:25)
xticklabels(total_time_label)
ylim([0 55])
yticks(0:5:55)
yticklabels(0:5:55)

xlabel("Time [s]","FontSize",20,"FontWeight","bold")
ylabel("Completed processes [#]","FontSize",20,"FontWeight","bold")
%title("Completed processes(1000) during the time Zheng2014","FontSize",25,"FontWeight","bold")
sgtitle("Completed processes during the time Zheng2014","FontSize",25,"FontWeight","bold")

%% Plot Merged
%% Plot 300 Processi
figure ('Name', strcat('Completed processes (300) during the time'))

histogram(times_dict_300_Wang2021,200,"DisplayStyle","stairs","EdgeColor",[0.8500, 0.3250, 0.0980],"LineWidth",1)
hold on
histogram(times_dict_300_H_Wang2020,200,"DisplayStyle","stairs","EdgeColor",[0, 0.5, 0],"LineWidth",1)
histogram(times_dict_300_Zheng2014,200,"DisplayStyle","stairs","EdgeColor",[0, 0.4470, 0.7410],"LineWidth",1)
grid on
%bar for legend
b = bar(nan(3,3));
b(1).FaceColor = [0.8500, 0.3250, 0.0980];
b(2).FaceColor = [0, 0.5, 0];
b(3).FaceColor = [0, 0.4470, 0.7410];
%%%%
hold off

set(gca,'FontSize',25)
ax = gca;
ax.GridAlpha = 0.1;
ax.GridLineStyle = "--";

xlim([0 25])
xticks(0:1:25)
xticklabels(total_time_label)
xticklabels(0:1:25)
ylim([0 55])
yticks(0:5:55)
yticklabels(0:5:55)

xlabel("Time [s]","FontSize",30,"FontWeight","bold")
ylabel("Completed processes [#]","FontSize",30,"FontWeight","bold")


title("Completed processes (300) during the time")
lgnStr_search_time = ([" Wang2021"," H.Wang2020"," Zheng2014"]);
legend(b,lgnStr_search_time,'FontSize',30,'Location','northwest');


%% Plot 500 Processi
figure ('Name', strcat('Completed processes (500) during the time'))

histogram(times_dict_500_Wang2021,200,"DisplayStyle","stairs","EdgeColor",[0.8500, 0.3250, 0.0980],"LineWidth",1)
hold on
histogram(times_dict_500_H_Wang2020,200,"DisplayStyle","stairs","EdgeColor",[0, 0.5, 0],"LineWidth",1)
histogram(times_dict_500_Zheng2014,200,"DisplayStyle","stairs","EdgeColor",[0, 0.4470, 0.7410],"LineWidth",1)
grid on

%bar for legend
b = bar(nan(3,3));
b(1).FaceColor = [0.8500, 0.3250, 0.0980];
b(2).FaceColor = [0, 0.5, 0];
b(3).FaceColor = [0, 0.4470, 0.7410];
%%%%
hold off

set(gca,'FontSize',25)
ax = gca;
ax.GridAlpha = 0.1;
ax.GridLineStyle = "--";

xlim([0 25])
xticks(0:1:25)
xticklabels(total_time_label)
xticklabels(0:1:25)
ylim([0 55])
yticks(0:5:55)
yticklabels(0:5:55)

xlabel("Time [s]","FontSize",30,"FontWeight","bold")
ylabel("Completed processes [#]","FontSize",30,"FontWeight","bold")


title("Completed processes (500) during the time")
lgnStr_search_time = ([" Wang2021"," H.Wang2020"," Zheng2014"]);
legend(b,lgnStr_search_time,'FontSize',30,'Location','northwest');

%% Plot 1000 Processi
figure ('Name', strcat('Completed processes (1000) during the time'))

hb1 = histogram(times_dict_1000_Wang2021,201,"DisplayStyle","stairs","EdgeColor",[0.8500, 0.3250, 0.0980],"LineWidth",1);
hold on
hb2 = histogram(times_dict_1000_H_Wang2020,201,"DisplayStyle","stairs","EdgeColor",[0, 0.5, 0],"LineWidth",1);
hb3 = histogram(times_dict_1000_Zheng2014,201,"DisplayStyle","stairs","EdgeColor",[0, 0.4470, 0.7410],"LineWidth",1);
grid on
%bar for legend
b = bar(nan(3,3));
b(1).FaceColor = [0.8500, 0.3250, 0.0980];
b(2).FaceColor = [0, 0.5, 0];
b(3).FaceColor = [0, 0.4470, 0.7410];
%%%%%
hold off 

set(gca,'FontSize',25)
ax = gca;
ax.GridAlpha = 0.1;
ax.GridLineStyle = "--";

xlim([0 25])
xticks(0:1:25)
xticklabels(total_time_label)
xticklabels(0:1:25)
ylim([0 55])
yticks(0:5:55)
yticklabels(0:5:55)

xlabel("Time [s]","FontSize",30,"FontWeight","bold")
ylabel("Completed processes [#]","FontSize",30,"FontWeight","bold")

title("Completed processes (1000) during the time")
lgnStr_search_time = ([" Wang2021"," H.Wang2020"," Zheng2014"]);
legend(b,lgnStr_search_time,'FontSize',30,'Location','northwest');


% hold on
% plot(data2,value2)
% plot(data3,value3)