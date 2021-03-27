export LC_ALL=C

#awk untuk membaca input dari file per tab
awk=-F"\t"

#melakukan iterasi pada file
BEGIN
{
#inisialisasi profit dan costprice
#profit ada di tab 21 (u)
profit=$21
#costprice pengurangan sales - profit
costprice=($18-$21)
profitpercentage=(profit/costprice)*100

#untuk mencari profit percentage dan Row ID terbesar
if (maks<=profitpercentage){
	maks=profitpercentage;
	RowID=$1;}
}

END{
echo "Transaksi terakhir dengan profit percentager terbesar yaitu "$RowID"dengan persentase "$profitpercentage"%.")
/home/Downloads/Laporan-TokoShiSop.tsv >> hasil.txt

#2b
awk=-F"\t"
BEGIN{}
{
orderID=$2
City=$10
customername=$7

if(orderID~"2017" && city == "Albuquerque"){
	 arrname[customername]+=1}
}

END{
echo "Daftar nama customer di Albuquerque pada tahun 2017 antara lain:\n"
{
for(customername in arrname){
	{print arrname}
}/home/sabrina/Downloads/Laporan-TokoShiSop.tsv >> hasil.txt


#2c
awk=-F"\t"
BEGIN{}
{
#mengecualikan row paling atas

if(NR!=1){
	arrsegment[$8]+=1}
}

END{
minsales=10000
for ( segment in arrsegment){
	if(minsales>arrsegment[segment]){
		minsales=arrsegment[segment]
		minsales=segment}
	}
}
echo "Tipe segment customer yang penjualannya paling sedikit adalah "$segment"dengan "$arrsegment"transaksi."
}/home/sabrina/Downloads/Laporam-TokoShiShop.tsv >> hasil.txt

#2d
awk=-F"\t"
BEGIN{}
{
if(NR!=1){
	arrregion[$13]=+$21}
}
END{
minprofit=5000
for(region in arrregion){
	if(minprofit>arrregion[region]){
		minprofit=arrregion[region]
		minprofit=region
	}
}
echo "Wilayah bagian "$region"yang memiliki total keuntungan (profit) yang paling sedikit adalah "$arrregion"dengan total keuntungan"
}/home/sabrina/Downloads/TokoShiSop.tsv >> hasil.txt
