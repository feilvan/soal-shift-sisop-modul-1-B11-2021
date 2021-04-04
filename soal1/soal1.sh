#!/bin/bash

#1a
# Menampilkan data syslog.log namun dari awal sampai ditemukan karakter :  pertama dipotong sehingga hanya menampilkan error/info jenis error/info dan username sesuai perintah soal
cat syslog.log | sed 's/^.*: //'

#1b
# Menampilkan data syslog.log namun hanya yang mengandung kata ERROR lalu memotong usernamenya dengan pattern ' (.*)' lalu di sort setelah itu data yang berulang hanya tampil sekali(sekaligus jumlahnya karena ada -c) dan terakhir di sort by number dan di reverse
grep 'ERROR' syslog.log | sed 's/^.*ERROR //' | sed 's/ (.*)//' | sort | uniq -c | sort -nr

#1d
# Sama dengan 1b namun dimasukan ke error_message.csv dan urutab data sesuai perintah soal
echo Error,Count >> error_message.csv
grep -oE '(ERROR) .* ' syslog.log | sed s/"ERROR "// | sort  | uniq -c | sort -nr | while read count text
do
    echo $text,$count >> error_message.csv
done

#1c&e
echo Username,INFO,ERROR >> user_statistic.csv
# memfilter data menjadi jumlah error/info dan usernamenya diurutkan berdasarkan nama ascending lalu di read per line
grep -oE '.* (\(.*\))' syslog.log | sed  's/.*(\(.*\))/\1/' | sort | uniq -c | while read count name
do 
    infoUser=`grep -oE ".* (INFO) .* (\($name\))" syslog.log | sed  's/.*(\(.*\))/\1/' | wc -l | sed 's/^[ \t]*//'`
    errUser=`grep -oE ".* (ERROR) .* (\($name\))" syslog.log | sed  's/.*(\(.*\))/\1/' | wc -l | sed 's/^[ \t]*//'`
    echo $name,$infoUser,$errUser >> user_statistic.csv
done
#Didalam while loop pada setiap iterasi disimpan data jumlah error dan jumlah info pada setiap username dan sebelum iterasi selanjutnya data berupa nama,jumlah info, jumlah error dikriim ke user_statistic.csv
