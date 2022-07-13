import re
import os
import numpy as np
import pandas as pd

N_ATTR = 5

# lettura cartella contenente i file da analizzare, path relativo
directory = sorted(os.listdir("outfiles_lin_plot"))

averages = {}  # dizionario che conterrà i valori medi di ciascun file {"nome_file1": [0.2, 0.5, ...], "nome_file2": [0.9, 1.8, ...],}
master_times_dict = {}  # dizionario con {"nome file": {dizionazio times_dict}}
all_times_dict = {}  # dizionario con {"nome file": {tutti i tempi per n.ro di processi}}
avg_vects = {}  # {"filename": {"1": float, "5": float, "10": float, ...}}
max_dict = {}  # {"filename": {"1": [100 elements], "5": [100 elements], "10": [100 elements], ...}}

for filename in directory:
    print("processing ... ", filename)

    # di ciascun file di processi organizzo i dati da plottare
    stats = {"average": {}, "min": {}, "max_vect": {}, "avgs_vect": {}}
    records = {}
    x_axis = []

    # dizionario contenente i 100, 500, 1000... tempi più verosimili di timestamp dei singoli processi
    times_dict = {
        "1": [], "5": [], "10": [], "100": [], "200": [], "300": [], "400": [], "500": [], "600": [],
        "700": [], "800": [], "900": [], "1000": []
    }

    # apertura file
    with open(f"outfiles_lin_plot/{filename}", "r") as file:
        data = file.read()
        main_for_loop = list(data.split("\n\n"))

        # analisi singoli numeri di processi (1, 5, 10, 100, ...)
        for group in main_for_loop:
            try:

                n_process = int(re.findall(r"[0-9]+", group[0:20])[0])  # lettura tramite espressione regolare
                x_axis.append(n_process)
                process_subgroups = list(group.split("***\n"))[1:]  # separazione sottogruppi, separati da ***
                records[str(n_process)] = []  # aggiunta al dizionario records il campo {"n_process": []}
                stats["avgs_vect"][str(n_process)] = []
                stats["max_vect"][str(n_process)] = []
                avgs = []  # vettore medie parziali

                times_dict_temp = {i: [] for i in range(1, n_process+1)}

                time_min_ms = 1000000.0

                # analisi di ciascun sottogruppo
                for subgroup in process_subgroups:
                    time_max_s = 0.0
                    temp_idx = 1
                    ttime = 0.0
                    processes = list(subgroup.split("\n")) # separazione singole righe (processi)

                    for proc_time_s in processes:

                        try:
                            proc_time_s = float(proc_time_s)
                            proc_time_ms = proc_time_s * 1000
                            # aggiungo alla lista (vettore) inizializzata a riga 32 i vari tempi, per il boxplot
                            records[str(n_process)].append(proc_time_s)
                            if times_dict_temp:
                                times_dict_temp[temp_idx].append(proc_time_s)

                            ttime += proc_time_s
                            time_max_s = max(time_max_s, proc_time_s)
                            time_min_ms = min(time_min_ms, proc_time_ms)

                            temp_idx += 1

                        except Exception as e:
                            pass

                    avgs.append(ttime / n_process)
                    stats["avgs_vect"][str(n_process)].append((ttime / n_process))
                    stats["max_vect"][str(n_process)].append(time_max_s)

                # calcolo media, min e max ed aggiunta alle rispettive voci del dizionario stats
                avg_time_s = sum(avgs) / len(avgs)
                avg_time_ms = avg_time_s * 1000

                stats["average"][str(n_process)] = avg_time_s
                stats["min"].update({str(n_process): time_min_ms/1000})

                avg_vects.update({filename: {}})
                avg_vects[filename] = stats["avgs_vect"]

                # aggiornamento dizionario times_dict con i valori medi e all_times_dict con tutti i valori
                if times_dict_temp:
                    for key in times_dict_temp.keys():
                        avg4dict = sum(times_dict_temp[key])/len(times_dict_temp[key])
                        times_dict[str(n_process)].append(avg4dict)

                # print(f"average time with {n_process} parallel processes: {avg_time_ms:.5f} ms")

            except Exception as e:
                pass

    # print(times_dict)
    # print(len(times_dict["100"]), len(times_dict["500"]), len(times_dict["1000"]))

    # abbellimento nome file (tolgo l'estensione e sostituisco underscore con spazi) + caricamento nel dict averages
    better_filename = f"{filename.replace('.txt', '').replace('_', ' ')}"

    # definizione titolo boxplot
    better_title = "Wang2021"
    if "sch2" in better_filename:
        better_title = "H.Wang2020"
    elif "sch3" in better_filename:
        better_title = "Zheng2014"

    averages[better_title] = stats["average"].values()

    # ciascun file produce un boxplot (+ grafico medie):
    plt.figure()
    boxplot_items = stats["avgs_vect"].values() # creo lista (vettore) con i valori di records
    # print(boxplot_items)
    plt.boxplot(boxplot_items)
    plt.plot(range(1, len(x_axis)+1), averages[better_title], color="red", marker=".", ms=15, mec="#F10000", mfc="#F17C09", alpha=0.5)
    plt.xticks(list(range(1, len(x_axis)+1)), x_axis)
    plt.yticks(list(range(0, 20, 1)), fontsize=16)
    plt.xlabel("parallel processes [#]", fontsize=25)
    plt.ylabel("Search computing time [ms]", fontsize=25)
    plt.grid(True, which="major", alpha=0.3, linestyle='--')

    plt.title(better_title, fontsize=28)

    # ciascun file produce un istogramma singolo per ogni numero di processi:
    # draw_hist(n_p="100", t_dict=times_dict, title=better_title)
    # draw_hist(n_p="300", t_dict=times_dict, title=better_title)
    # draw_hist(n_p="500", t_dict=times_dict, title=better_title)
    # draw_hist(n_p="1000", t_dict=times_dict, title=better_title)

    master_times_dict[str(better_title)] = times_dict
    max_dict[str(better_title)] = stats["max_vect"]

    # grafici singoli tempi massimi medi
    t_max_vect = []
    for key in times_dict.keys():
        t_max_vect.append(times_dict[key][-1:])  # aggiunge l'ultimo elemento di ciascun vettore dei tempi
    for key in averages.keys():
        plt.figure()
        if "Wang2020" in key:
            plt.plot(x_axis, t_max_vect, color="red", marker=".", ms=15, mec="#F10000", mfc="#F17C09")
            plt.legend(["H.Wang2020"], fontsize=20, loc="upper left")
        elif "2014" in key:
            plt.plot(x_axis, t_max_vect, color="blue", marker=".", ms=15, mec="#0000C8", mfc="#249BC8")
            plt.legend(["Zheng2014"], fontsize=20, loc="upper left")
        else:
            plt.plot(x_axis, t_max_vect, color="#136F1C", marker=".", ms=15, mec="#136F1C", mfc="#00C700")
            plt.legend(["Wang2021"], fontsize=20, loc="upper left")

        plt.xticks([x for x in x_axis if x != 5], rotation=60, fontsize=16)
        plt.yticks(list(range(0, 26, 1)), fontsize=16)
        # plt.yticks([10**(-2), 10**(-1), 1, 10, 10**2], fontsize=16)
        plt.xlabel("Parallel processes [#]", fontsize=25)
        plt.ylabel("Search computing time [s]", fontsize=25)
        plt.title("Average Max Search Time", fontsize=28)
        plt.grid(True, which="major", alpha=0.7, linestyle='--')

# istogrammi generali sovrapposti:
draw_hist_comp(n_p="100", t_dict=master_times_dict)
draw_hist_comp(n_p="300", t_dict=master_times_dict)
draw_hist_comp(n_p="500", t_dict=master_times_dict)
draw_hist_comp(n_p="1000", t_dict=master_times_dict)

# bar plot processi/sec per diverso numero di processi, confronto vari algoritmi
bar_1_avg, bar_2_avg, bar_3_avg, bar_4_avg, bar_5_avg = [], [], [], [], []
for key in averages:
    bar_item = []
    bar_1_avg.append(100 / (list(averages[key])[3]))  # 100
    bar_2_avg.append(300 / (list(averages[key])[5]))  # 300
    bar_3_avg.append(500 / (list(averages[key])[7]))  # 500
    bar_4_avg.append(800 / (list(averages[key])[10]))  # 800
    bar_5_avg.append(1000 / (list(averages[key])[12]))  # 1000

bar_data_avg = np.array([bar_1_avg, bar_2_avg, bar_3_avg, bar_4_avg, bar_5_avg])
bar_data_avg = bar_data_avg.T
# print(bar_data_avg)
# print(bar_data_avg.size)

plt.figure()
X = [0, 1.25, 2.5, 3.75, 5]
plt.bar(X, bar_data_avg[0], color='r', width=0.22)
plt.bar([a+0.25 for a in X], bar_data_avg[1], color='g', width=0.22)
plt.bar([a+0.5 for a in X], bar_data_avg[2], color='b', width=0.22)
plt.legend(["Wang2021", "H.Wang2020", "Zheng2014"])

# bar plot processi/sec per diverso numero di processi, confronto vari algoritmi
bar_1_max, bar_2_max, bar_3_max, bar_4_max, bar_5_max = [], [], [], [], []
for key in max_dict:
    bar_item = []
    bar_1_max.append(100 / (np.array(max_dict[key]["100"]).mean()))  # 100
    bar_2_max.append(300 / (np.array(max_dict[key]["300"]).mean()))  # 300
    bar_3_max.append(500 / (np.array(max_dict[key]["500"]).mean()))  # 500
    bar_4_max.append(800 / (np.array(max_dict[key]["800"]).mean()))  # 800
    bar_5_max.append(1000 / (np.array(max_dict[key]["1000"]).mean()))  # 1000

bar_data_max = np.array([bar_1_max, bar_2_max, bar_3_max, bar_4_max, bar_5_max])
bar_data_max = bar_data_max.T
# print(bar_data_max)
# print(bar_data_max.size)

plt.figure()
X = [0, 1.25, 2.5, 3.75, 5]
plt.bar(X, bar_data_max[0], color='r', width=0.22)
plt.bar([a+0.25 for a in X], bar_data_max[1], color='g', width=0.22)
plt.bar([a+0.5 for a in X], bar_data_max[2], color='b', width=0.22)
plt.legend(["Wang2021", "H.Wang2020", "Zheng2014"])

# plot con sovrapposizione dei tempi massimi medi
plt.figure()

plot_legend = []
t_max_dict = {}  # dizionario {"filename": [t_max_vect]}

for key in master_times_dict.keys():
    t_max_vect = []
    for key_2 in master_times_dict[key].keys():
        t_max_vect.append(((master_times_dict[key])[key_2][-1:])[0])  # aggiunge l'ultimo elemento di ciascun vettore dei tempi
    t_max_dict[key] = t_max_vect

for key in master_times_dict.keys():
    if "Wang2020" in key:
        plt.plot(x_axis, t_max_dict[key], color="#F10000", marker=".", ms=15, mec="#F10000", mfc="#F17C09")
        plot_legend.append("H.Wang2020")
    elif "Zheng" in key:
        plt.plot(x_axis, t_max_dict[key], color="#0000C8", marker=".", ms=15, mec="#0000C8", mfc="#249BC8")
        plot_legend.append("Zheng2014")
    else:
        plt.plot(x_axis, t_max_dict[key], color="#136F1C", marker=".", ms=15, mec="#136F1C", mfc="#00C700")
        plot_legend.append("Wang2021")

plt.xticks([x for x in x_axis if x != 5], rotation=60, fontsize=16)
plt.yticks(list(range(0, 26, 1)), fontsize=16)
# plt.yticks([10**(-2), 10**(-1), 1, 10, 10**2], fontsize=16)
plt.xlabel("Parallel processes [#]", fontsize=25)
plt.ylabel("Search computing time [s]", fontsize=25)
plt.title("Average Max Search Time", fontsize=28)

plt.grid(True, which="major", alpha=0.7, linestyle='--')
plt.legend(plot_legend, fontsize=20, loc="upper left")

# grafici singoli
for key in averages.keys():
    plt.figure()
    if "Wang2020" in key:
        plt.plot(x_axis, averages[key], color="red", marker=".", ms=15, mec="#F10000", mfc="#F17C09")
        plt.legend(["H.Wang2020"], fontsize=20, loc="upper left")
    elif "Zheng2014" in key:
        plt.plot(x_axis, averages[key], color="blue", marker=".", ms=15, mec="#0000C8", mfc="#249BC8")
        plt.legend(["Zheng2014"], fontsize=20, loc="upper left")
    else:
        plt.plot(x_axis, averages[key], color="#136F1C", marker=".", ms=15, mec="#136F1C", mfc="#00C700")
        plt.legend(["Wang2021"], fontsize=20, loc="upper left")

    plt.xticks([x for x in x_axis if x != 5], rotation=60, fontsize=16)
    # plt.yticks([10**(-2), 10**(-1), 1, 10, 10**2], fontsize=16)
    plt.yticks(list(range(0, 26, 1)), fontsize=16)
    plt.xlabel("Parallel processes [#]", fontsize=25)
    plt.ylabel("Search computing time [s]", fontsize=25)
    plt.title("Average Search Time", fontsize=28)
    plt.grid(True, which="major", alpha=0.7, linestyle='--')

# plot con sovrapposizione dei tempi medi medi
plt.figure()

plot_legend = []

for key in averages.keys():
    if "Wang2020" in key:
        plt.plot(x_axis, averages[key], color="#F10000", marker=".", ms=15, mec="#F10000", mfc="#F17C09")
        plot_legend.append("H.Wang2020")
    elif "2014" in key:
        plt.plot(x_axis, averages[key], color="#0000C8", marker=".", ms=15, mec="#0000C8", mfc="#249BC8")
        plot_legend.append("Zheng2014")
    else:
        plt.plot(x_axis, averages[key], color="#136F1C", marker=".", ms=15, mec="#136F1C", mfc="#00C700")
        plot_legend.append("Wang2021")

plt.xticks([x for x in x_axis if x != 5], rotation=60, fontsize=16)
# plt.yticks([10**(-2), 10**(-1), 1, 10, 10**2], fontsize=16)
plt.yticks(list(range(0, 26, 1)), fontsize=16)
plt.xlabel("Parallel processes [#]", fontsize=25)
plt.ylabel("Search computing time [s]", fontsize=25)
plt.title("Average Search Time", fontsize=28)

plt.grid(True, which="major", alpha=0.7, linestyle='--')
plt.legend(plot_legend, fontsize=20, loc="upper left")

"""
# grafico per distacco medie fra 2 algoritmi
plt.figure()
y_axis = []
for i in range(len(list(averages.values())[0])):
    print(list(averages[list(averages.keys())[0]])[i])
    y = list(averages[list(averages.keys())[0]])[i] - list(averages[list(averages.keys())[1]])[i]
    y_axis.append(y)

plt.plot(x_axis, y_axis, marker=".", ms=8, mec="#cc4400ff", mfc="#cc4400ff")
plt.xticks([x for x in x_axis if x != 5], rotation=60)
plt.xlabel("parallel processes [#]")
plt.ylabel("difference time [ms]")
plt.title("With minus without Multiplication in G")

plt.grid(True, which="major", alpha=0.7, linestyle='--')
"""

# CREAZIONE DATAFRAME -> EXCEL PER ESPORTAZIONE DATI SU MATLAB
print()

# istogrammi:
print("creating times_dict.xlsx ...")
df_times_dict_Wang2021 = pd.DataFrame(dict([(f"proc_{k}", pd.Series(v)) for k, v in master_times_dict["Wang2021"].items()]))
df_times_dict_HWang2020 = pd.DataFrame(dict([(f"proc_{k}", pd.Series(v)) for k, v in master_times_dict["H.Wang2020"].items()]))
df_times_dict_Zheng2014 = pd.DataFrame(dict([(f"proc_{k}", pd.Series(v)) for k, v in master_times_dict["Zheng2014"].items()]))

with pd.ExcelWriter(f'matlab/data_N{N_ATTR}/times_dict.xlsx') as writer:
    df_times_dict_Wang2021.to_excel(writer, sheet_name="Wang2021")
    df_times_dict_HWang2020.to_excel(writer, sheet_name="H.Wang2020")
    df_times_dict_Zheng2014.to_excel(writer, sheet_name="Zheng2014")

# plot e boxplot single search_time:
print("creating avgs_dict.xlsx ...")
key_1 = f"{list(filter(lambda x: 'sch' not in x, avg_vects.keys()))[0]}"
key_2 = f"{list(filter(lambda x: 'sch2' in x, avg_vects.keys()))[0]}"
key_3 = f"{list(filter(lambda x: 'sch3' in x, avg_vects.keys()))[0]}"
df_avg_dict_Wang2021 = pd.DataFrame(dict([(f"proc_{k}", pd.Series(v)) for k, v in avg_vects[key_1].items()]))
df_avg_dict_HWang2020 = pd.DataFrame(dict([(f"proc_{k}", pd.Series(v)) for k, v in avg_vects[key_2].items()]))
df_avg_dict_Zheng2014 = pd.DataFrame(dict([(f"proc_{k}", pd.Series(v)) for k, v in avg_vects[key_3].items()]))

with pd.ExcelWriter(f'matlab/data_N{N_ATTR}/avgs_dict.xlsx') as writer:
    df_avg_dict_Wang2021.to_excel(writer, sheet_name="Wang2021")
    df_avg_dict_HWang2020.to_excel(writer, sheet_name="H.Wang2020")
    df_avg_dict_Zheng2014.to_excel(writer, sheet_name="Zheng2014")

# box plot average search time:
print("creating max_dict.xlsx ...")
df_max_dict_Wang2021 = pd.DataFrame(dict([(f"proc_{k}", pd.Series(v)) for k, v in max_dict["Wang2021"].items()]))
df_max_dict_HWang2020 = pd.DataFrame(dict([(f"proc_{k}", pd.Series(v)) for k, v in max_dict["H.Wang2020"].items()]))
df_max_dict_Zheng2014 = pd.DataFrame(dict([(f"proc_{k}", pd.Series(v)) for k, v in max_dict["Zheng2014"].items()]))

with pd.ExcelWriter(f'matlab/data_N{N_ATTR}/max_dict.xlsx') as writer:
    df_max_dict_Wang2021.to_excel(writer, sheet_name="Wang2021")
    df_max_dict_HWang2020.to_excel(writer, sheet_name="H.Wang2020")
    df_max_dict_Zheng2014.to_excel(writer, sheet_name="Zheng2014")

# barplot:
print("creating bar_plot.xlsx ...")
df_barplot_avg = pd.DataFrame(data=bar_data_avg.T)
df_barplot_max = pd.DataFrame(data=bar_data_max.T)

with pd.ExcelWriter(f'matlab/data_N{N_ATTR}/bar_plot.xlsx') as writer:
    df_barplot_avg.to_excel(writer, sheet_name="bar_data_avg")
    df_barplot_max.to_excel(writer, sheet_name="bar_data_max")

# plot conteggio cumulativo processi:
print("creating prc_counter.xlsx ...")

prc_counter_dict = {}
for txtfile in master_times_dict.keys():
    t_dict = master_times_dict[txtfile]
    prc_counter_dict[txtfile] = {}
    for n_proc in t_dict.keys():
        t_v = np.arange(start=0, stop=max(t_dict[n_proc])+0.2, step=0.01)
        t_v = sorted([round(x, ndigits=2) for x in t_v])
        p_times = sorted([round(x, ndigits=2) for x in t_dict[n_proc]])

        v_count = []
        n = 0
        for time_step in t_v:
            c = [x for x in p_times if x == time_step]
            if c:
                n += len(c)
            v_count.append(n)

        prc_counter_dict[txtfile][n_proc] = v_count

df_counter_Wang2021 = pd.DataFrame(dict([(f"proc_{k}", pd.Series(v)) for k, v in prc_counter_dict["Wang2021"].items()]))
df_counter_HWang2020 = pd.DataFrame(dict([(f"proc_{k}", pd.Series(v)) for k, v in prc_counter_dict["H.Wang2020"].items()]))
df_counter_Zheng2014 = pd.DataFrame(dict([(f"proc_{k}", pd.Series(v)) for k, v in prc_counter_dict["Zheng2014"].items()]))

max_max = round(max(master_times_dict["Zheng2014"]["1000"]), ndigits=2)
df_max_max = pd.DataFrame({"general_time_max": [max_max]})
with pd.ExcelWriter(f'matlab/data_N{N_ATTR}/prc_counter.xlsx') as writer:
    df_counter_Wang2021.to_excel(writer, sheet_name="Wang2021")
    df_counter_HWang2020.to_excel(writer, sheet_name="H.Wang2020")
    df_counter_Zheng2014.to_excel(writer, sheet_name="Zheng2014")
    df_max_max.to_excel(writer, sheet_name="time_max")

print("DONE")

# plt.show()


""" 
Per installare matplotlib, pandas, numpy, openpyxl (serve per esportare in excel):

Windows (una di queste funziona in base a come è stato settato python 3.x durante l'installazione):
py -m pip install matplotlib pandas numpy openpyxl
py -m pip3 install matplotlib pandas numpy openpyxl
python -m pip install matplotlib pandas numpy openpyxl
python -m pip3 install matplotlib pandas numpy openpyxl

Linux:
python3 -m pip install matplotlib pandas numpy openpyxl
python3 -m pip3 install matplotlib pandas numpy openpyxl

A fine installazione controllare che effettivamente le librerie vengano viste:

Windows:
py -m pip freeze
python -m pip freeze

Linux:
python3 -m pip freeze

"""
