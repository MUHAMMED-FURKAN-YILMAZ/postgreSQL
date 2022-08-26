-- AGGREGATE METHOD KULLANIMI --

/*
-Aggregate methodlari (SUM, COUNT, MIN, MAX, AVG)
-- Sum(topla), Count(say), Min(en kucuk deger), Max(en buyuk deger, Avg(Ortalama))
-Subquery icinde de kullanilir
-Ancak, sorgu tek bir deger donduruyor olmalidir
SYNTAX: sum() seklinde olmali sum ile () arasinda bosluk olmamali
*/

-- ALIAS (AS) toplamda gecici isim vermek istersek kosuldan sonra AS sutun_isim olarak kullanilir


select * from calisanlar2;
select * from markalar;

-- calisanlar2 tablosundaki en yuksek maas degerini listeleyiniz
select Max(maas) from calisanlar2;



-- calisanlar2 tablosundaki maaslarin toplamini listeleyin
select sum(maas) from calisanlar2;



-- calisanlar2 tablosundaki maas ortalamalarii listeleyiniz
select avg(maas) from calisanlar2; -- 2714.2857142857142857
select round(avg(maas)) from calisanlar2; -- 2714
select round(avg(maas),2) from calisanlar2; -- 2714.29



-- calisanlar2 tablosundaki en dusuk maasi listeleyiniz
select min(maas) from calisanlar2;



-- calisanlar2 tablosundaki kac kisinin maas aldigini listeleyin
select count(maas) from calisanlar2;



-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maaşini listeleyiniz
select marka_isim, calisan_sayisi, (select sum(maas) from calisanlar2 where marka_isim=isyeri) AS toplam_maas from markalar;




-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz.
select marka_isim, calisan_sayisi, 
(select max(maas) from calisanlar2 where marka_isim=isyeri) as max_maas, 
(select min(maas) from calisanlar2 where marka_isim=isyeri) as min_maas from markalar



--Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz.
select marka_id, marka_isim, (select count(sehir) from calisanlar2 where marka_isim=isyeri) AS sehir_sayisi from markalar;



--Interview Question: En yüksek ikinci maas değerini çağırın.
select max(maas) AS en_yuksek_ikinci_maas from calisanlar2
where maas<(select max(maas) from calisanlar2);



----Interview Question: En düşük ikinci maas değerini çağırın.
select min(maas) AS en_dusuk_ikinci_maas from calisanlar2
where maas>(select min(maas) from calisanlar2);



--En yüksek üçüncü maas değerini bulun
select max(maas) AS en_yuksek_ucuncu_maas from calisanlar2
where maas<(select max(maas) from calisanlar2 
			where maas<(select max(maas) from calisanlar2));



--En dusuk üçüncü maas değerini bulun
select min(maas) AS en_dusuk_ucuncu_maas from calisanlar2
where maas>(select min(maas) from calisanlar2 
			where maas>(select min(maas) from calisanlar2));

select * from calisanlar2;
select * from markalar;
