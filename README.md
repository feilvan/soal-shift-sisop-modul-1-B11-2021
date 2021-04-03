# soal-shift-sisop-modul-1-B11-2021

Anggota kelompok :
* 05111940000181 - Cliffton Delias Perangin Angin
* 05111940000095 - Fuad Elhasan Irfani
* 05111940000107 - Sabrina Lydia Simanjuntak

## Soal 3
#### 3a. Membuat script untuk mengunduh 23 gambar dari "https://loremflickr.com/320/240/kitten" serta menyimpan log-nya ke file "Foto.log". Karena gambar yang diunduh acak, ada kemungkinan gambar yang sama terunduh lebih dari sekali, oleh karena itu kalian harus menghapus gambar yang sama (tidak perlu mengunduh gambar lagi untuk menggantinya). Kemudian menyimpan gambar-gambar tersebut dengan nama "Koleksi_XX" dengan nomor yang berurutan tanpa ada nomor yang hilang (contoh : Koleksi_01, Koleksi_02, ...)

Pertama membuat file log kosong

    printf "" > Foto.log

Buat loop 23 kali untuk mengunduh gambar dan menyimpan log

    for i in {1..23}
    do
        #download & simpan di log
        wget "https://loremflickr.com/320/240/kitten" -O download -a Foto.log
        
Cek jika ini file pertama maka langsung rename

    if [ $i -eq 1 ]
    then
        mv download `printf "Koleksi_%02d" "$nokoleksi"`
        nokoleksi=$(($nokoleksi+1))
    fi
    
Buat loop untuk file selanjutnya untuk cek apakah file sama atau tidak

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
    
Selanjutnya jika nama tidak sama maka akan direname

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


#### 3b. Karena Kuuhaku malas untuk menjalankan script tersebut secara manual, ia juga meminta kalian untuk menjalankan script tersebut sehari sekali pada jam 8 malam untuk tanggal-tanggal tertentu setiap bulan, yaitu dari tanggal 1 tujuh hari sekali (1,8,...), serta dari tanggal 2 empat hari sekali(2,6,...). Supaya lebih rapi, gambar yang telah diunduh beserta log-nya, dipindahkan ke folder dengan nama tanggal unduhnya dengan format "DD-MM-YYYY" (contoh : "13-03-2023").

Jalankan script 3a

    cd ~/modul1/soal3:
    bash ./soal3a.sh
    
Buat folder seperti format

    download_date=$(date +"%d-%m-%Y")
    mkdir "$download_date"
    
Lalu pindah gambar & log ke folder

    mv ./Koleksi_* "./$download_date/"
    mv ./foto.log "./$download_date/"
    
Gunakan cron untuk otomatisasi

    0 20 1-31/7,2-31/4 * * bash ./home/xa/modul1/soal3:/soal3b.sh
    # menit 0
    # jam 20 (8 malam)
    # untuk tgl 1-31 setiap 7 hari sekali
    # untuk tgl 2-31 setiap 4 hari sekali
    
#### 3b. Agar kuuhaku tidak bosan dengan gambar anak kucing, ia juga memintamu untuk mengunduh gambar kelinci dari "https://loremflickr.com/320/240/bunny". Kuuhaku memintamu mengunduh gambar kucing dan kelinci secara bergantian (yang pertama bebas. contoh : tanggal 30 kucing > tanggal 31 kelinci > tanggal 1 kucing > ... ). Untuk membedakan folder yang berisi gambar kucing dan gambar kelinci, nama folder diberi awalan "Kucing_" atau "Kelinci_" (contoh : "Kucing_13-03-2023").
