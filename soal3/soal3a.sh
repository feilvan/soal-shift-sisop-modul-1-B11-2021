#!/bin/bash
#3a. Script untuk download 23 gambar & simpan di Foto.log & hapus gambar yg sama

nokoleksi=1
printf "" > Foto.log #buat file kosong

for i in {1..23}
do
    #download & simpan di log
    wget "https://loremflickr.com/320/240/kitten" -O download -a Foto.log

    #jika file pertama maka langsung didownload & rename
    if [ $i -eq 1 ]
    then
        mv download `printf "Koleksi_%02d" "$nokoleksi"`
        nokoleksi=$(($nokoleksi+1))
    fi

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

        same=`cmp $filename download`
        if [ -z "$same" ]
        then
            fileissame=1
            break
        else
            fileissame=0
        fi
    done


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
done
