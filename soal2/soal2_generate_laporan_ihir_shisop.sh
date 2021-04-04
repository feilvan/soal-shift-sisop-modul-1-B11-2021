#!/bin/bash

#2a
export LC_ALL=C
awk '
BEGIN{FS="\t"}
{
  profit=$21
  sales=$18
  profitpercentage=profit/(sales-profit)*100

if(max<=profitpercentage){
     max=profitpercentage
     RowID=$1}
}

END {
 printf("Transaksi terakhir dengan profit persentase terbesar yaitu %d dengan persentase %d%%.\n\n", RowID, max)
} ' /home/sabrina/Documents/sisop/Laporan-TokoShiSop.tsv >> hasil.txt

#2b
export LC_ALL=C
awk '
BEGIN{FS="\t"}
{
  orderID=$2
  city=$10
  customername=$7
  if(orderID~"2017" && city=="Albuquerque"){
    arrname[customername]++
  }
}
END{
  print "Daftar nama customer di Alburquerque pada tahun 2017 antara lain:"
  for(customername in arrname)
  {print customername}
}' /home/sabrina/Documents/sisop/Laporan-TokoShiSop.tsv >> hasil.txt

#2c
export LC_ALL=C
awk '
BEGIN{FS="\t"}
{
   segment=$8
   if(NR>1){
    arrsegment[segment]++
  }
}
END {
  minsales=5000
  for(segment in arrsegment){
    if(minsales > arrsegment[segment]){
      minsales=arrsegment[segment]
      namasegment=segment;
    }
  }
  printf("\nTipe segmen customer yang penjualannya paling sedikit adalah %s dengan %d total transaksi.\n\n", namasegment, minsales)
}' /home/sabrina/Documents/sisop/Laporan-TokoShiSop.tsv >> hasil.txt

#2d
export LC_ALL=C
awk '
BEGIN{FS="\t"}
{  
   region=$13
   profit=$21
   if(NR>1){
    arrregion[region]=arrregion[region]+profit;
  }
}
END {
  totalprofit=100000
  for(region in arrregion){
    if (totalprofit > arrregion[region]){
      totalprofit = arrregion[region]
      namaregion = region
    }
  }
  printf("Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah %s dengan total keuntungan %.4f\n", namaregion, totalprofit);
}' /home/sabrina/Documents/sisop/Laporan-TokoShiSop.tsv >> hasil.txt

