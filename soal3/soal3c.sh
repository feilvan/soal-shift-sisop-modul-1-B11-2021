#! /bin/sh/
# sebelumnya buat folder koleksi untuk mengumpulkan semuanya

function kitten() {
   cd Koleksi
   # buat folder
   mkdir $(date "+ Kucing_%d-%m-%Y")
   cd $(date "+ Kucing_%d-%m-%Y")
   # download gambar
   wget https://loremflickr.com/320/240/kitten
   cd
}

function bunny() {
   cd Koleksi
   mkdir $(date "+ Kelinci_%d-%m-%Y")
   cd $(date "+ Kelinci_%d-%m-%Y")
   wget https://loremflickr.com/320/240/bunny
   cd
}

# misal untuk mengunduh gambar kucing, bisa menggunakan
# $ source soal3c.sh; kitten

# otomatisasi ada di cron3e.tab
