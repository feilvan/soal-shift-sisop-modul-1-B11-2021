#! /bin/sh/

kitten () {
   echo "Download: Kucing"
   cd Koleksi
   mkdir $(date "+ Kucing_%d-%m-%Y")
   cd $(date "+ Kucing_%d-%m-%Y")
   printf "" > Foto.log
   wget https://loremflickr.com/320/240/kitten -a Foto.log
   cd
}

bunny () {
   echo "Download: Kelinci"
   cd Koleksi
   mkdir $(date "+ Kelinci_%d-%m-%Y")
   cd $(date "+ Kelinci_%d-%m-%Y")
   printf "" > Foto.log
   wget https://loremflickr.com/320/240/bunny -a Foto.log
   cd
}

d=$(date +"%a %d %b %Y")
day=$(($(date +"%w")+1))
week=$(($(date +"%U")+1))

echo "$d"
echo "Day: $day"
echo "Week: $week"

if [ $((week%2)) -eq 0 ] # minggu genap
then
   if [ $((day%2)) -eq 0 ] # hari genap
   then
      kitten
   else # hari ganjil
      bunny
   fi
else # minggu ganjil
   if [ $((day%2)) -eq 0 ] # hari genap
   then
      bunny
   else # hari ganjil
      kitten
   fi
fi
