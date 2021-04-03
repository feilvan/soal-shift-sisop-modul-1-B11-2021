#!/bin/bash
# 3b. Script untuk mengerjakan 3a sehari sekali pada jam 8 malam.
# Dari tgl 1 tujuh hari sekali (1,8,..), dari tgl 2 empat hari sekali (2,6,..)
# Gambar & log dipindah ke folder dgn nama tgl download (DD-MM-YYYY)

#Jalankan 3a
cd ~/modul1/soal3
bash ./soal3a.sh

#buat folder
download_date=$(date +"%d-%m-%Y")
mkdir "$download_date"

#pindah gambar & log
mv ./Koleksi_* "./$download_date/"
mv ./Foto.log "./$download_date/"
