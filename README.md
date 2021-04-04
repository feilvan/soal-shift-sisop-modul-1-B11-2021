# soal-shift-sisop-modul-1-B11-2021

Anggota kelompok :
* 05111940000181 - Cliffton Delias Perangin Angin
* 05111940000095 - Fuad Elhasan Irfani
* 05111940000107 - Sabrina Lydia Simanjuntak

## Soal 1
#### 1a. Membuat script untuk memotong data setiap barisnya sampai ditemukan karakter : pertama sehingga hanya menampilkan error/info, jenisnya dan username

```shell
cat syslog.log | sed 's/^.*: //'
```

#### 1b. Menampilkan data syslog.log namun hanya yang mengandung kata ERROR lalu memotong usernamenya dengan pattern ' (.*)' lalu di sort setelah itu data yang berulang hanya tampil sekali dengan uniq(sekaligus jumlahnya karena ada -c) dan terakhir di sort by number dan di reverse

```shell
grep 'ERROR' syslog.log | sed 's/^.*ERROR //' | sed 's/ (.*)//' | sort | uniq -c | sort -nr
```

![1](https://i.imgur.com/PHfmh5m.png)
![1](https://i.imgur.com/83VRZhx.png)

#### 1d.Sama dengan 1b namun dimasukan ke error_message.csv dan dengan urutan data sesuai perintah soal

```shell
echo Error,Count >> error_message.csv
grep -oE '(ERROR) .* ' syslog.log | sed s/"ERROR "// | sort  | uniq -c | sort -nr | while read count text
do
     echo $text,$count >> error_message.csv
done
```

![1](https://i.imgur.com/6DZEKCb.png)

#### 1c&e. Menampilkan data username, jumlah info dan jumlah error dengan urutan berdasarkan username

```shell
echo Username,INFO,ERROR >> user_statistic.csv
# memfilter data menjadi jumlah error/info dan usernamenya diurutkan berdasarkan nama ascending lalu di read per line
grep -oE '.* (\(.*\))' syslog.log | sed  's/.*(\(.*\))/\1/' | sort | uniq -c | while read count name
do 
    infoUser=`grep -oE ".* (INFO) .* (\($name\))" syslog.log | sed  's/.*(\(.*\))/\1/' | wc -l | sed 's/^[ \t]*//'`
    errUser=`grep -oE ".* (ERROR) .* (\($name\))" syslog.log | sed  's/.*(\(.*\))/\1/' | wc -l | sed 's/^[ \t]*//'`
    echo $name,$infoUser,$errUser >> user_statistic.csv
done

#Didalam while loop pada setiap iterasi disimpan data jumlah error dan jumlah info pada setiap username dan sebelum iterasi selanjutnya data berupa nama,jumlah info, jumlah error dikriim ke user_statistic.csv
```

![1](https://i.imgur.com/FDnCpdH.png)

Kendala pengerjaan no. 1 secara keseluruhan:
* Pengerjaan lama karena belum terlalu paham shell sehingga tidak sempat selesai sampai praktikum berakhir.

## Soal 2
#### 2a. Untuk mengerjakan soal nomor 2, kita terlebih dahulu harus mendownload file Laporan-TokoShiSop.tsv , dan untuk menyelesaikan soal ini digunakan awk.

Pada soal nomor 2a, kita diminta untuk menampilkan transaksi dengan profit persentase terbesar dari file Laporan-TokoShiSop.tsv

```shell
export LC_ALL=C
awk '
BEGIN{FS="\t"}
```

LC_ALL=C berfungsi untuk membaca data yang mengandung titik di file sebagai koma, agar terbaca sebagai desimal. awk berfungsi untuk memproses file Laporan-TokoShiSop.tsv. BEGIN merupakan special rule yang terdapat pada awk untuk membaca algoritma. FS=”\t” untuk memisahkan atau memproses file per tab, karena file Laporan-TokoShiSop memiliki data yang dipisahkan per tab.

```shell
profit=$21
sales=$18
profitpercentage=profit/(sales-profit)*100
```

Pada bagian ini, diinisialisasikan profit dan sales. DImana untuk profit=$21 artinya nilai dari profit akan diambil atau terletak di tab ke-21, begitu juga untuk sales yang terletas di tab ke-18. Lalu dilakukan perhitungan untuk mencari profit persentase dengan rumus sesuai dengan soal yaitu profitpercentage=profit/(sales-profit)*100. Dimana profit dan sales akan menuju ke $21 dan $18 sesuai dengan inisialisasinya.

```shell
if(max<=profitpercentage){
    max=profitpercentage
    RowID=$1
}
```

Disini diinisialisasi variable max, dimana variable max berfungsi sebagai pembanding untuk profitpercentage untuk memperoleh nilai terbesar. Dimana, jika nilai profitpercentage lebih besar dari max, maka nilai max akan terupdate sebagai nilai profitpercentage tersebut, hingga setiap nilai yang lebih besar akan tersimpan di max.

```shell
END{
    printf("Transaksi terakhir dengan profit persentase terbesar yaitu %d dengan persentase %d%.",RowID,max)
} ' /home/sabrina/Documents/sisop/Laporan-TokoShiSop.tsv >> hasil.txt
```

END merupakan special rule dalam awk. Pada, section ini, hasil profit persentase terbesar, beserta RowIDnya akan di print. Lalu, dibagian setelah END, /home/sabrina/Document/sisop/Laporan-TokoShiShop.tsv merupakan direktori file Laporan-TokoShiSop.tsv dan hasil outputnya akan dimasukkan ke file hasil.txt.</br>

Berikut merupakan output profit persentase terbesar dari Laporan-TokoShiSop.tsv yaitu 9952 dengan persentase 100%
![2a](https://i.imgur.com/lhIfKnA.png)

#### 2b. Pada soal nomor 2b, kita diminta untuk menampilkan daftar nama customer di Albuquerque pada tahun 2017 dari file Laporan-TokoShiSop.tsv 
```shell
export LC_ALL=C
awk '
BEGIN{FS="\t"}
```
LC_ALL=C berfungsi untuk membaca data yang mengandung titik di file sebagai koma, agar terbaca sebagai desimal. awk berfungsi untuk memproses file Laporan-TokoShiSop.tsv. BEGIN merupakan special rule yang terdapat pada awk untuk membaca algoritma. FS=”\t” untuk memisahkan atau memproses file per tab, karena file Laporan-TokoShiSop memiliki data yang dipisahkan per tab.
```shell
  orderID=$2
  city=$10
  customername=$7
  if(orderID~"2017" && city=="Albuquerque"){
    arrname[customername]++
  }
```
Pada bagian ini, diinisialisasikan orderID, city, dan customername. Dimana untuk orderID=$2 artinya nilai dari profit akan diambil atau terletak di tab ke-2, begitu juga untuk city yang terletas di tab ke-10 dan customername di tab ke-7. Lalu dilakukan pengkondisian, dimana jika orderID mengandung 2017 (pada tahun 2017) dan citynya adalah Albuquerque, maka nama customer yagn memenuhi kedua kondisi tersebut akan dimasukan ke arrname.
```shell
END{
  print "Daftar nama customer di Albuquerque pada tahun 2017 antara lain:"
  for(customername in arrname)
  {print customername}
}' /home/sabrina/Documents/sisop/Laporan-TokoShiSop.tsv >> hasil.txt
```
END merupakan special rule dalam awk. Pada, section ini, Daftar nama customer yang memenuhi kedua kondisi sebelumnya akan diprint. Lalu, dibagian setelah END, /home/sabrina/Document/sisop/Laporan-TokoShiShop.tsv merupakan direktori file Laporan-TokoShiSop.tsv dan hasil outputnya akan dimasukkan ke file hasil.txt.</br>

Berikut merupakan output daftar nama customer di Albuquerque pada tahun 2017 dari Laporan-TokoShiSop.tsv yaitu Benjamin Farhat, David Wiener, Michelle Lonsdale, dan Susan Vittorini.
![2b](https://i.imgur.com/wS7oZkO.png)

#### 2c. Pada soal nomor 2c, kita diminta tipe segmen yang penjualannya paling sedikit dari file Laporan-TokoShiSop.tsv
```shell
export LC_ALL=C
awk '
BEGIN{FS="\t"}
```
LC_ALL=C berfungsi untuk membaca data yang mengandung titik di file sebagai koma, agar terbaca sebagai desimal. awk berfungsi untuk memproses file Laporan-TokoShiSop.tsv. BEGIN merupakan special rule yang terdapat pada awk untuk membaca algoritma. FS=”\t” untuk memisahkan atau memproses file per tab, karena file Laporan-TokoShiSop memiliki data yang dipisahkan per tab.

```shell
  segment=$8
  if(NR>1){
    arrsegment[segment]++
  }
```
Pada bagian ini, diinisialisasikan segment. Dimana untuk segment=$8 artinya nilai dari profit akan diambil atau terletak di tab ke-8. Lalu dilakukan pengkondisian, dimana jika NR>1 (yang artinya dilakukan pengecualian untuk baris paling atas, yaitu judul dari tabel), maka segmen tersebut akan dimasukan ke arrsegment, dan untuk segment tersebut akan dijumlahkan dan dicatat.

```shell
END{
  minsales=5000
  for(segment in arrsegment){
    if(minsales > arrsegment[segment]){
      minsales=arrsegment[segment]
      namasegment=segment;
    }
```
END merupakan special rule dalam awk. Pada, section ini, dilakukan inisialisasi untuk minsales yaitu 5000. Lalu untuk segment yang namanya berada di arrsegment, nilai dari arrsegment[segment] akan dibandingkan dengan nilai minsales, dimana jika nilai arrsegment[segment] lebih kecil dari nilai minsales, maka nilai tersebut akan disimpan di minsales dan segment akan tersimpan di namasegment. Minsales dan namasegment akan terupdate jika ditemukan nilai yang lebih kecil, hingga ditemukan nilai yang paling kecil.

```shell
  printf("\nTipe segmen customer yang penjualannya paling sedikit adalah %s dengan %.1f transaksi.\n",namasegment,minsales)
}' /home/sabrina/Documents/sisop/Laporam-TokoShiSop.tsv >> hasil.txt
```
Disini tipe segmen yang penjualannya paling sedikit akan diprint. Lalu, dibagian setelah END, /home/sabrina/Document/sisop/Laporan-TokoShiShop.tsv merupakan direktori file Laporan-TokoShiSop.tsv dan hasil outputnya akan dimasukkan ke file hasil.txt.</br>

Berikut merupakan output tipe customer pyang penjualannya paling sedikit dari Laporan-TokoShiSop.tsv yaitu Home Office dengan 1783 total transaksi.
![2c](https://i.imgur.com/C7EXVw2.png)

#### 2d. Pada soal nomor 2a, kita diminta untuk menampilkan wilayah bagian (region) yang total profitnya paling sedikit  dari file Laporan-TokoShiSop.tsv

```shell
export LC_ALL=C
awk '
BEGIN{FS="\t"}
```
LC_ALL=C berfungsi untuk membaca data yang mengandung titik di file sebagai koma, agar terbaca sebagai desimal. awk berfungsi untuk memproses file Laporan-TokoShiSop.tsv. BEGIN merupakan special rule yang terdapat pada awk untuk membaca algoritma. FS=”\t” untuk memisahkan atau memproses file per tab, karena file Laporan-TokoShiSop memiliki data yang dipisahkan per tab.

```shell
  region=$13
  profit=$21
  if(NR>1){
    arrregion[region]=arrregion[region]+profit;
  }
```
Pada bagian ini, diinisialisasikan profit dan region. Dimana untuk profit=$21 artinya nilai dari profit akan diambil atau terletak di tab ke-21, begitu juga untuk region yang terletas di tab ke-13. Lalu dilakukan pengkondisian, dimana jika NR>1 (yang artinya dilakukan pengecualian untuk baris paling atas, yaitu judul dari tabel), maka jumlah profit dari region tersebut akan dimasukkan ke arrregion[region] dan akan terus dijumlahkan profitnya kedalam arrregion[region].

```shell
END{
  totalprofit=100000
  for(region in arrregion){
    if (totalprofit > arrregion[region]){
      totalprofit = arrregion[region]
      namaregion = region
    }
  }
```
END merupakan special rule dalam awk. Pada, section ini, dilakukan inisialisasi untuk totalprofit yaitu 100000. Lalu untuk region yang namanya berada di arrregion, nilai dari arrregion[region] akan dibandingkan dengan nilai totalprofit, dimana jika nilai arrregion[region]  lebih kecil dari nilai totalprofit, maka nilai tersebut akan disimpan di totalprofit dan region akan tersimpan di namaregion. totalprofit dan namaregion akan terupdate jika ditemukan nilai yang lebih kecil, hingga ditemukan nilai yang paling kecil.

```shell
  printf("Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah %s dengan total keuntungan %.1f",namaregion,totalprofit)
}' /home/sabrina/Documents/sisop/TokoShiSop.tsv >> hasil.txt
```
Disini wilayah bagian (region) yang total profitnya paling sedikit akan diprint. Lalu, dibagian setelah END, /home/sabrina/Document/sisop/Laporan-TokoShiShop.tsv merupakan direktori file Laporan-TokoShiSop.tsv dan hasil outputnya akan dimasukkan ke file hasil.txt.</br>

Berikut merupakan wilayah bagian (region) yang total keuntungannya paling sedikit dari Laporan-TokoShiSop.tsv yaitu Central dengan total keuntungan 39706.3625
![2d](https://i.imgur.com/NJ8Dybs.png)

Kesulitan:</br>
Untuk kesulitan yang dihadapi dalam mengerjakan soal nomor 2 ialah kesulitan mengeluarkan output. Setelah melakukan revisi, ternyata hal tersebut terjadi karena ketidaktelitian, dimana  error terjadi karena tidak ada spasi, lupa memberi petik penutup awk, dan kesalahan pada penamaan direktori.

## Soal 3
#### 3a. Membuat script untuk mengunduh 23 gambar dari "https://loremflickr.com/320/240/kitten" serta menyimpan log-nya ke file "Foto.log". Karena gambar yang diunduh acak, ada kemungkinan gambar yang sama terunduh lebih dari sekali, oleh karena itu kalian harus menghapus gambar yang sama (tidak perlu mengunduh gambar lagi untuk menggantinya). Kemudian menyimpan gambar-gambar tersebut dengan nama "Koleksi_XX" dengan nomor yang berurutan tanpa ada nomor yang hilang (contoh : Koleksi_01, Koleksi_02, ...)

Pertama membuat file log kosong

```shell
printf "" > Foto.log
```

Buat loop 23 kali untuk mengunduh gambar dan menyimpan log

```shell
for i in {1..23}
do
    #download & simpan di log
    wget "https://loremflickr.com/320/240/kitten" -O download -a Foto.log
```

Cek jika ini file pertama maka langsung rename

```shell
if [ $i -eq 1 ]
then
    mv download `printf "Koleksi_%02d" "$nokoleksi"`
    nokoleksi=$(($nokoleksi+1))
fi
```
    
Buat loop untuk file selanjutnya untuk cek apakah file sama atau tidak

```shell
fileissame=0

#untuk file selanjutnya
for((j=1;j<nokoleksi;j=j+1))
do
    if [ $i -eq 1 ]
    then
        break
    fi

    #cek apakah nama file sama
    filename=`printf "Koleksi_%02d" "$j"`

    same=`cmp $filename download -b`
    if [ -z "$same" ]
    then
        fileissame=1
        break
    else
        fileissame=0
    fi
done
```
    
Selanjutnya jika nama tidak sama maka akan direname

```shell
if [ $i -gt 1 ]
then
    if [ $fileissame -eq 1 ]
    then
        #jika nama sama maka hapus
        rm download
    else
        #jika nama tidak sama maka direname
        mv download `printf "Koleksi_%02d" "$nokoleksi"`
        nokoleksi=$(($nokoleksi+1))
    fi
fi
```

Berikut hasil dari script diatas
![3a](https://i.imgur.com/EH9ULrk.png)

Kendala 3a:
* Pengerjaan lama karena belum terlalu paham shell

#### 3b. Karena Kuuhaku malas untuk menjalankan script tersebut secara manual, ia juga meminta kalian untuk menjalankan script tersebut sehari sekali pada jam 8 malam untuk tanggal-tanggal tertentu setiap bulan, yaitu dari tanggal 1 tujuh hari sekali (1,8,...), serta dari tanggal 2 empat hari sekali(2,6,...). Supaya lebih rapi, gambar yang telah diunduh beserta log-nya, dipindahkan ke folder dengan nama tanggal unduhnya dengan format "DD-MM-YYYY" (contoh : "13-03-2023").

Jalankan script 3a

```shell
cd ~/modul1/soal3
bash ./soal3a.sh
```

Buat folder seperti format

```shell
download_date=$(date +"%d-%m-%Y")
mkdir "$download_date"
```

Lalu pindah gambar & log ke folder

```shell
mv ./Koleksi_* "./$download_date/"
mv ./Foto.log "./$download_date/"
```

Gunakan cron untuk otomatisasi

```shell
0 20 1-31/7,2-31/4 * * bash ./home/xa/modul1/soal3:/soal3b.sh
# menit 0
# jam 20 (8 malam)
# untuk tgl 1-31 setiap 7 hari sekali
# untuk tgl 2-31 setiap 4 hari sekali
```

Berikut hasil dari script diatas
![3b](https://i.imgur.com/wqnAOhV.png)

Kendala 3b:
* Tidak ada

#### 3c. Agar kuuhaku tidak bosan dengan gambar anak kucing, ia juga memintamu untuk mengunduh gambar kelinci dari "https://loremflickr.com/320/240/bunny". Kuuhaku memintamu mengunduh gambar kucing dan kelinci secara bergantian (yang pertama bebas. contoh : tanggal 30 kucing > tanggal 31 kelinci > tanggal 1 kucing > ... ). Untuk membedakan folder yang berisi gambar kucing dan gambar kelinci, nama folder diberi awalan "Kucing_" atau "Kelinci_" (contoh : "Kucing_13-03-2023").

Pertama buat satu folder bernama "Koleksi" untuk mengumpulkan semua folder agar di soal selanjutnya lebih mudah. Lalu buat fungsi untuk mengunduh gambar kucing dan kelinci secara terpisah

```shell
kitten () {
```

Pindah ke direktori koleksi

```shell
   cd Koleksi
```

Buat folder sesuai format lalu masuk ke direktori tersebut

```shell
   mkdir $(date "+ Kucing_%d-%m-%Y")
   cd $(date "+ Kucing_%d-%m-%Y")
```

Buat file untuk menyimpan log agar terminal terlihat rapi (opsional). Lalu download gambar

```shell
   printf "" > Foto.log
   wget https://loremflickr.com/320/240/kitten -a Foto.log
   cd
}
```

Buat script yang sama untuk fungsi mengunduh gambar kelinci

```shell
bunny () {
   echo "Download: Kelinci"
   cd Koleksi
   mkdir $(date "+ Kelinci_%d-%m-%Y")
   cd $(date "+ Kelinci_%d-%m-%Y")
   printf "" > Foto.log
   wget https://loremflickr.com/320/240/bunny -a Foto.log
   cd
}
```

Buat inisialisasi week of year & day of week. Dan tampilkan date, day, dan week (opsional)

```shell
d=$(date +"%a %d %b %Y")
day=$(($(date +"%w")+1))
week=$(($(date +"%U")+1))

echo "$d"
echo "Day: $day"
echo "Week: $week"
```

Untuk minggu genap dan hari genap maka jalankan fungsi kitten, untuk minggu genap dan hari ganjil maka jalankan fungsi bunny.

```shell
if [ $((week%2)) -eq 0 ] # minggu genap
then
   if [ $((day%2)) -eq 0 ] # hari genap
   then
      kitten
   else # hari ganjil
      bunny
   fi
```
       
Untuk minggu ganjil jalankan kebalikan dari minggu genap.

```shell
else # minggu ganjil
   if [ $((day%2)) -eq 0 ] # hari genap
   then
      bunny
   else # hari ganjil
      kitten
   fi
fi
```

Berikut hasil dari script diatas
![3c](https://i.imgur.com/TTIuAP6.png)

Kendala 3c:
* Salah memahami soal. Saya kira menggunakan cron dan dimasukkan ke cron3e.tab

#### 3d. Untuk mengamankan koleksi Foto dari Steven, Kuuhaku memintamu untuk membuat script yang akan memindahkan seluruh folder ke zip yang diberi nama “Koleksi.zip” dan mengunci zip tersebut dengan password berupa tanggal saat ini dengan format "MMDDYYYY" (contoh : “03032003”).

Buat fungsi zipping (agar bisa dipisah dengan unzip yang ada pada soal 3e)

```shell
function zipping() {
```

Buat "current" yang nanti digunakan untuk password (MMDDYYYY)

```shell
   current=$(date "+%m%d%Y")
```

Buat zip. Set password (-p) dengan "current". Masukkan semua subfolder (-r) ke dalam zip juga

```shell
   zip -P $current -r Koleksi.zip Koleksi/
```

Hapus direktori setelah masuk zip

```shell
   rm -rf Koleksi/
}
```

Berikut hasil fungsi zipping
![3d zip](https://i.imgur.com/jdCfYKG.png)

Unzip Koleksi.zip
![3d unzip](https://i.imgur.com/mA6BQIm.png)

Kendala 3d:
* Tidak ada

#### 3e. Karena kuuhaku hanya bertemu Steven pada saat kuliah saja, yaitu setiap hari kecuali sabtu dan minggu, dari jam 7 pagi sampai 6 sore, ia memintamu untuk membuat koleksinya ter-zip saat kuliah saja, selain dari waktu yang disebutkan, ia ingin koleksinya ter-unzip dan tidak ada file zip sama sekali.

Tambahkan fungsi unzip ke script 3d. Script unzip hampir sama dengan zip

```shell
function unzipping() {
   current=$(date "+%m%d%Y")
   unzip -P $current Koleksi.zip
   rm -f Koleksi.zip
}
```

Buat cron job untuk menjalankan script secara otomatis

```shell
0 7 * * 1-5 source soal3d.sh; zipping
0 18 * * 1-5 source soal3d.sh; unzipping
```

7: jalankan (zip) tiap jam 7 pagi </br>
18: jalankan (unzip) tiap jam 6 sore </br>
1-5: setiap hari senin sampai Jum'at

Kendala 3e:
* Tidak ada

Kendala pengerjaan no. 3 secara keseluruhan:
* Pengerjaan lama karena belum terlalu paham shell sehingga tidak sempat selesai sampai praktikum berakhir.
