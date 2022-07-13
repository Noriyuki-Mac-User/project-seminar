import csv

#ヘッダーの作成
for yn in ["有", "無"]:
    csv_name = "プロゼミ_変更後_ODAの空欄" + yn + ".csv"
    with open(csv_name, "w", encoding = "utf-8-sig") as f:
        header_list = ["国名"]
        for i in ["2019", "2020"]:
            for j in ["名目DGP", "実質GDP", "一人当たりGDP", "GDP成長率", "一人当たりDGP成長率", "消費者物価上昇率", "総貯蓄", "GDPデフレーター", "純受取ODA", "一人当たり純受取ODA"]:
                header_name = i + j
                header_list.append(header_name)
        csv.writer(f).writerow(header_list)

#データがそろっていないものを取り除く
with open("プロゼミ.csv", "r", encoding = "utf-8-sig") as f:
    readers = csv.reader(f)
    header = next(readers)
    for row in readers:
        first_half_of_row  = row[0:9]
        second_half_of_row = row[11:19]
        excluded_first_list  = [a for a in first_half_of_row  if a != ""]
        excluded_second_list = [a for a in second_half_of_row if a != ""]
        len_of_row = len(excluded_first_list) + len(excluded_second_list)
        if len_of_row == 17:
            with open("プロゼミ_変更後_ODAの空欄有.csv", "a", newline="", encoding = "utf-8-sig") as g:
                csv.writer(g).writerow(row)
        
        excluded_list = [a for a in row if a != ""]
        if len(excluded_list) == 21:
            with open("プロゼミ_変更後_ODAの空欄無.csv", "a", newline="", encoding = "utf-8-sig") as g:
                csv.writer(g).writerow(excluded_list)

#ODAを取り除く
with open("プロゼミ_変更後_ODAの空欄有.csv", "r", encoding = "utf-8-sig") as f:
    readers = csv.reader(f)
    for row in readers:
        first_half_of_row  = row[0:9]
        second_half_of_row = row[11:19]
        write_list = []
        write_list.extend(first_half_of_row)
        write_list.extend(second_half_of_row)
        print(write_list)
        with open("プロゼミ_変更後_ODA無.csv", "a", newline="", encoding = "utf-8-sig") as g:
            csv.writer(g).writerow(write_list)