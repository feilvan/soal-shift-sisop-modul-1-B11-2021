#!/bin/bash
export LC_ALL=C
awk'
BEGIN{FS="\t"}
{
profit=$21;
costprice=($18-$21);
profitpercentage=(profit/costprice)*100
#untuk mencari profit percentage dan Row ID terbesar
if(maks<=profitpercentage){
maks=profitpercentage;
RowID=$1s}
}
END{
printf("Transaksi terakhir dengan profit percentage terbesar yaitu %d dengan persentase %d%.",RowID,profitpercentage)
}'/home/Downloads/Laporan-TokoShiSop.tsv >> hasil.txt

#2b
awk'
BEGIN{FS="\t"}
{
orderID=$2
City=$10
customername=$7

if(orderID~"2017" && city=="Albuquerque"){
arrname[customername]++}
}
END{
print "\nDaftar nama customer di Albuquerque pada tahun 2017 antara lain:\n"
{
for(customername in arrname){
{print customername}
}/home/sabrina/Downloads/Laporan-TokoShiSop.tsv >> hasil.txt


#2c
export LC_ALL=C
awk'
BEGIN{FS="\t"}
{
#mengecualikan row paling atas
if(NR!=1){
arrsegment[$8]}
}
END{
minsales=10000
for(segment in arrsegment){
if(minsales>arrsegment[segment]){
minsales=arrsegment[segment]
sum=segment;
}
}
printf("\nTipe segment customer yang penjualannya paling sedikit adalah %s dengan %.1f transaksi.\n",sum,minsales)
}/home/sabrina/Downloads/Laporam-TokoShiShop.tsv >> hasil.txt

#2d
export LC_ALL=C
awk'
BEGIN{FS="\t"}
{
if(NR!=1){
arrregion[$13]=+$21}
}
END{
minprofit=100000
for(region in arrregion){
if(minprofit>arrregion[region]){
minprofit=arrregion[region]
wilayah=region
}
}
printf("\nWilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah %s dengan total keuntungan %.1f",wilayah,minprofit)
}/home/sabrina/Downloads/TokoShiSop.tsv >> hasil.txt
