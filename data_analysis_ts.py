import re
import os
import pandas as pd
import numpy as np
from io import StringIO

directory = sorted(os.listdir("raw_data"))

# {"nome_file1": {"1": [100*df], "5": [100*df],...}, ...}
raw_df_dict = {}

# creazione dataframe per ogni blocco di esecuzione, per ogni numero di
# processi, per ogni file e caricamento in raw_df_dict
for txtfile in directory:

    key_filename = str(txtfile).replace(".txt", "")
    raw_df_dict[key_filename] = {}

    with open(f"raw_data/{txtfile}", "r") as file:
        raw_data = file.read()
        processes_set = list(raw_data.split("\n\n"))

        for prc_set in processes_set:
            n_process = int(re.findall(r"[0-9]+", prc_set[0:20])[0])
            raw_df_dict[key_filename][str(n_process)] = []

            # divisione sottogruppi di file .csv da inserire in una lista
            # unica di 100 dataframe per numero di processi
            process_subgroups = list(prc_set.split("***\n"))[1:]
            for prc_sub in process_subgroups:
                csv_data = StringIO(prc_sub)
                raw_data_df = pd.read_csv(csv_data, names=["N", "t_start",
                                                           "t_end", "t_CPU"])
                raw_data_df.sort_values("t_start", axis=0,
                                        ascending=True, inplace=True)
                raw_df_dict[key_filename][str(n_process)].append(raw_data_df)

# {"data_file1": {"1": [[...],...], "5":[data_rows], ...}, ...}
raw_data_df_start = {}
raw_data_df_end = {}
raw_data_df_CPU = {}

# preparazione dati
for txtfile_d in raw_df_dict:
    raw_data_df_start[txtfile_d] = {}
    raw_data_df_end[txtfile_d] = {}
    raw_data_df_CPU[txtfile_d] = {}

    for n_process in raw_df_dict[txtfile_d]:
        raw_data_df_start[txtfile_d][n_process] = []
        raw_data_df_end[txtfile_d][n_process] = []
        raw_data_df_CPU[txtfile_d][n_process] = []

        for raw_df in raw_df_dict[txtfile_d][n_process]:
            raw_data_df_start[txtfile_d][n_process].append(raw_df["t_start"])
            raw_data_df_end[txtfile_d][n_process].append(raw_df["t_end"])
            raw_data_df_CPU[txtfile_d][n_process].append(raw_df["t_CPU"])

# {"datafile1": {"1": [], "5": [], ...}, ...}
data_df_start = {}
data_df_end = {}
data_df_CPU = {}

data_df_avgs = {}
data_df_max = {}

# creazione DataFrame start e media colonne
for txtfile in raw_data_df_start:

    data_df_start[txtfile] = {}
    for n_process in raw_data_df_start[txtfile]:
        df_data = np.array(raw_data_df_start[txtfile][n_process])
        df = pd.DataFrame(df_data)
        df_mean = df.mean(axis=0)

        data_df_start[txtfile][n_process] = df_mean



# creazione DataFrame end e media colonne
for txtfile in raw_data_df_end:

    data_df_end[txtfile] = {}
    data_df_avgs[txtfile] = {}
    data_df_max[txtfile] = {}
    for n_process in raw_data_df_end[txtfile]:

        df_data = np.array(raw_data_df_end[txtfile][n_process])
        df = pd.DataFrame(df_data)
        df_mean = df.mean(axis=0)

        data_df_avgs[txtfile][n_process] = []
        data_df_max[txtfile][n_process] = []
        for item in df_data:
            data_df_avgs[txtfile][n_process].append(item.mean())
            data_df_max[txtfile][n_process].append(max(item))

        data_df_end[txtfile][n_process] = df_mean

# creazione DataFrame CPU e media colonne
for txtfile in raw_data_df_CPU:

    data_df_CPU[txtfile] = {}
    for n_process in raw_data_df_CPU[txtfile]:
        df_data = np.array(raw_data_df_CPU[txtfile][n_process])
        df = pd.DataFrame(df_data)
        df_mean = df.mean(axis=0)

        data_df_CPU[txtfile][n_process] = df_mean

# {"data_file1": {"pag1": {"t_start": [], "t_end": [], "t_CPU": []}, ...}, ...}
excel_pages = {}
for txtfile in data_df_start:
    excel_pages[txtfile] = {}

    for n_process in data_df_start[txtfile]:
        excel_pages[txtfile][n_process] = pd.DataFrame(data={
            "t_start": data_df_start[txtfile][n_process].tolist(),
            "t_end": data_df_end[txtfile][n_process].tolist(),
            "t_CPU": data_df_CPU[txtfile][n_process].tolist()
        })
# creazione file excel: ad ogni file .txt si fa corrispondere
# un file .xlsx con una pagina per numero di processi
for txtfile in excel_pages:

    with pd.ExcelWriter(f'data_timestamp/{txtfile}.xlsx') as writer:
        for page in excel_pages[txtfile]:
            page_df = excel_pages[txtfile][page]
            page_df.to_excel(writer, sheet_name=page)

# creazione file excel times_dict_ts: ad ogni file .txt si fa corrispondere
# una pagina con una colonna per numero di processi

# {"filename1": {"proc_1": [], "proc_5": [], ...}, "filename2": {...}}
ts_dict_tot = {}
for txtfile in excel_pages:

    ts_dict_tot[txtfile] = {}
    for page in excel_pages[txtfile]:
        end_col = excel_pages[txtfile][page]["t_end"]
        ts_dict_tot[txtfile][f"proc_{page}"] = end_col

    for page in excel_pages[txtfile]:
        ts_df = pd.DataFrame(ts_dict_tot[txtfile])

with pd.ExcelWriter('data_timestamp/times_dict_ts.xlsx') as writer:
    for txtfile in excel_pages:
        page_df = pd.DataFrame(ts_dict_tot[txtfile])
        page_df.to_excel(writer, sheet_name=txtfile)

# Conteggio cumulativo processi:
prc_counter_dict = {}
for txtfile in excel_pages:
    t_dict = excel_pages[txtfile]
    prc_counter_dict[txtfile] = {}
    for n_proc in t_dict.keys():
        t_v = np.arange(start=0,
                        stop=max(t_dict[n_proc]["t_end"]) + 0.2,
                        step=0.01)
        t_v = sorted([round(x, ndigits=2) for x in t_v])
        p_times = sorted([
            round(x, ndigits=2) for x in t_dict[n_proc]["t_end"]
        ])

        v_count = []
        n = 0
        for time_step in t_v:
            c = [x for x in p_times if x == time_step]
            if c:
                n += len(c)
            v_count.append(n)
        prc_counter_dict[txtfile][n_proc] = v_count

df_counter_Wang2021 = pd.DataFrame(dict([
    (f"proc_{k}", pd.Series(v)) for k, v in prc_counter_dict["Wang2021"].items()
]))
df_counter_HWang2020_N5 = pd.DataFrame(dict([
    (f"proc_{k}", pd.Series(v)) for k, v in prc_counter_dict["H.Wang2020_N5"].items()
]))
df_counter_HWang2020_N10 = pd.DataFrame(dict([
    (f"proc_{k}", pd.Series(v)) for k, v in prc_counter_dict["H.Wang2020_N10"].items()
]))
df_counter_Zheng2014_N5 = pd.DataFrame(dict([
    (f"proc_{k}", pd.Series(v)) for k, v in prc_counter_dict["Zheng2014_N5"].items()
]))
df_counter_Zheng2014_N10 = pd.DataFrame(dict([
    (f"proc_{k}", pd.Series(v)) for k, v in prc_counter_dict["Zheng2014_N10"].items()
]))

max_max_N5 = round(max(ts_dict_tot["Zheng2014_N5"]["proc_1000"]), ndigits=2)
max_max_N10 = round(max(ts_dict_tot["Zheng2014_N10"]["proc_1000"]), ndigits=2)
print(max_max_N5)
df_max_max_N5 = pd.DataFrame({"general_time_max": [max_max_N5]})
df_max_max_N10 = pd.DataFrame({"general_time_max": [max_max_N10]})

with pd.ExcelWriter('data_timestamp/prc_counter_ts.xlsx') as writer:
    df_counter_Wang2021.to_excel(writer, sheet_name="Wang2021")
    df_counter_HWang2020_N5.to_excel(writer, sheet_name="H.Wang2020_N5")
    df_counter_Zheng2014_N5.to_excel(writer, sheet_name="Zheng2014_N5")
    df_counter_HWang2020_N10.to_excel(writer, sheet_name="H.Wang2020_N10")
    df_counter_Zheng2014_N10.to_excel(writer, sheet_name="Zheng2014_N10")
    df_max_max_N5.to_excel(writer, sheet_name="time_max_N5")
    df_max_max_N10.to_excel(writer, sheet_name="time_max_N10")


# plot e boxplot single search_time:
print("creating avgs_dict_ts.xlsx ...")

# {"filename1": {"proc_1": [], "proc_5": [], ...}, "filename2": {...}}
avg_vects = {}
for txtfile in excel_pages:
    t_dict = excel_pages[txtfile]
    avg_vects[txtfile] = {}
    for n_proc in t_dict.keys():
        avg = sum(t_dict[n_proc]["t_end"]) / len(t_dict[n_proc]["t_end"])
        avg_vects[txtfile][f"proc_{n_proc}"] = avg

df_avg_dict_Wang2021 = pd.DataFrame(dict([
    (f"proc_{k}", pd.Series(v)) for k, v in data_df_avgs["Wang2021"].items()
]))
df_avg_dict_HWang2020_N5 = pd.DataFrame(dict([
    (f"proc_{k}", pd.Series(v)) for k, v in data_df_avgs["H.Wang2020_N5"].items()
]))
df_avg_dict_HWang2020_N10 = pd.DataFrame(dict([
    (f"proc_{k}", pd.Series(v)) for k, v in data_df_avgs["H.Wang2020_N10"].items()
]))
df_avg_dict_Zheng2014_N5 = pd.DataFrame(dict([
    (f"proc_{k}", pd.Series(v)) for k, v in data_df_avgs["Zheng2014_N5"].items()
]))
df_avg_dict_Zheng2014_N10 = pd.DataFrame(dict([
    (f"proc_{k}", pd.Series(v)) for k, v in data_df_avgs["Zheng2014_N10"].items()
]))

with pd.ExcelWriter(f'data_timestamp/avgs_dict_ts.xlsx') as writer:
    df_avg_dict_Wang2021.to_excel(writer, sheet_name="Wang2021")
    df_avg_dict_HWang2020_N5.to_excel(writer, sheet_name="H.Wang2020_N5")
    df_avg_dict_HWang2020_N10.to_excel(writer, sheet_name="H.Wang2020_N10")
    df_avg_dict_Zheng2014_N5.to_excel(writer, sheet_name="Zheng2014_N5")
    df_avg_dict_Zheng2014_N10.to_excel(writer, sheet_name="Zheng2014_N10")

# box plot average search time:
print("creating max_dict_ts.xlsx ...")

# {"filename1": {"proc_1": [], "proc_5": [], ...}, "filename2": {...}}
max_vects = {}
for txtfile in excel_pages:
    t_dict = excel_pages[txtfile]
    max_vects[txtfile] = {}
    for n_proc in t_dict.keys():
        max_vects[txtfile][f"proc_{n_proc}"] = max(t_dict[n_proc]["t_end"])

df_max_dict_Wang2021 = pd.DataFrame(dict([
    (f"proc_{k}", pd.Series(v)) for k, v in data_df_max["Wang2021"].items()
]))
df_max_dict_HWang2020_N5 = pd.DataFrame(dict([
    (f"proc_{k}", pd.Series(v)) for k, v in data_df_max["H.Wang2020_N5"].items()
]))
df_max_dict_HWang2020_N10 = pd.DataFrame(dict([
    (f"proc_{k}", pd.Series(v)) for k, v in data_df_max["H.Wang2020_N10"].items()
]))
df_max_dict_Zheng2014_N5 = pd.DataFrame(dict([
    (f"proc_{k}", pd.Series(v)) for k, v in data_df_max["Zheng2014_N5"].items()
]))
df_max_dict_Zheng2014_N10 = pd.DataFrame(dict([
    (f"proc_{k}", pd.Series(v)) for k, v in data_df_max["Zheng2014_N10"].items()
]))

with pd.ExcelWriter(f'data_timestamp/max_dict_ts.xlsx') as writer:
    df_max_dict_Wang2021.to_excel(writer, sheet_name="Wang2021")
    df_max_dict_HWang2020_N5.to_excel(writer, sheet_name="H.Wang2020_N5")
    df_max_dict_HWang2020_N10.to_excel(writer, sheet_name="H.Wang2020_N10")
    df_max_dict_Zheng2014_N5.to_excel(writer, sheet_name="Zheng2014_N5")
    df_max_dict_Zheng2014_N10.to_excel(writer, sheet_name="Zheng2014_N10")

# barplot:
print("creating bar_plot_ts.xlsx ...")

bar_1_avg, bar_2_avg, bar_3_avg, bar_4_avg, bar_5_avg = [], [], [], [], []
for txtfile in excel_pages:
    bar_item = []
    bar_1_avg.append(100 / avg_vects[txtfile]["proc_100"])  # 100
    bar_2_avg.append(300 / avg_vects[txtfile]["proc_300"])  # 300
    bar_3_avg.append(500 / avg_vects[txtfile]["proc_500"])  # 500
    bar_4_avg.append(800 / avg_vects[txtfile]["proc_800"])  # 800
    bar_5_avg.append(1000 / avg_vects[txtfile]["proc_1000"])  # 1000

bar_data_avg = np.array([bar_1_avg, bar_2_avg, bar_3_avg, bar_4_avg, bar_5_avg])
bar_data_avg = bar_data_avg

bar_1_max, bar_2_max, bar_3_max, bar_4_max, bar_5_max = [], [], [], [], []
bar_tags = []
for txtfile in excel_pages:
    bar_tags.append(txtfile)
    bar_1_max.append(100 / max_vects[txtfile]["proc_100"])  # 100
    bar_2_max.append(300 / max_vects[txtfile]["proc_300"])  # 300
    bar_3_max.append(500 / max_vects[txtfile]["proc_500"])  # 500
    bar_4_max.append(800 / max_vects[txtfile]["proc_800"])  # 800
    bar_5_max.append(1000 / max_vects[txtfile]["proc_1000"])  # 1000

bar_data_max = np.array(
    [bar_1_max, bar_2_max, bar_3_max, bar_4_max, bar_5_max]
)
bar_data_max = bar_data_max

df_barplot_avg = pd.DataFrame(data=dict(zip(bar_tags, bar_data_avg.T)))
df_barplot_max = pd.DataFrame(data=dict(zip(bar_tags, bar_data_max.T)))

with pd.ExcelWriter(f'data_timestamp/bar_plot_ts.xlsx') as writer:
    df_barplot_avg.to_excel(writer, sheet_name="bar_data_avg")
    df_barplot_max.to_excel(writer, sheet_name="bar_data_max")
