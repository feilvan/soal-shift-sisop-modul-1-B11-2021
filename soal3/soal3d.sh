#! /bin/sh/
# 3d. Membuat script untuk memindahkan ke Koleksi.zip
# dan beri password sesuai dgn tgl saat ini (MMDDYYYY)

function zipping() {
   current=$(date "+%m%d%Y")
   # buat zip
   # -p: password. -r: recursive (subfolder masuk zip)
   zip -P $current -r Koleksi.zip Koleksi/
   # 3e. hapus folder setelah masuk zip
   rm -rf Koleksi/
}

function unzipping() {
   current=$(date "+%m%d%Y")
   unzip -P $current Koleksi.zip
   # 3e. hapus zip setelah unzip
   rm -f Koleksi.zip
}
