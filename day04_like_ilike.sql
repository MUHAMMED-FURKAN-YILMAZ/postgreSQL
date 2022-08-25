/*
SELECT - LIKE kosulu

LIKE : Sorgulama yaparken belirli kalip ifadeleri kullanabilmemizi saglar
ILIKE : Sorgulama yaparken buyuk/kucuk harfe duyarsiz olarak eslesir

LIKE : ~~
ILIKE : ~~*

NOT LIKE : !~~
NOT ILIKE : !~~*

% --> 0 veya daha fazla karakteri belirtir
_ --> tek bir karakteri belirtir
*/

create table personel(
	id char(4),
	isim varchar(50),
	maas int
);

insert into personel values('1001', 'Ali Can', 70000);
insert into personel values('1002', 'Veli Mert', 85000);
insert into personel values('1003', 'Ayşe Tan', 65000);
insert into personel values('1004', 'Derya Soylu', 95000);
insert into personel values('1005', 'Yavuz Bal', 80000);
insert into personel values('1006', 'Sena Beyaz', 100000);

select * from personel;

--SORU: ismi A harfi ile baslayan personeli listele
select * from personel where isim LIKE 'A%';

--SORU: ismi t harfi ile biten personeli listele
select * from personel where isim LIKE '%t';

--SORU: isminin ikinci harfi e olan personeli listele
select * from personel where isim LIKE '_e%';

-- 'a' ile başlayıp 'n' ile biten personel isimlerini listeleyiniz
select isim from personel Where isim ~~* 'a%n';

-- ikinci karakteri 'a' ve dördüncü karakteri 'u' olan personel isimlerini listeleyiniz
select isim from personel Where isim ~~ '_a_u%'; 

-- İçinde 'e' ve 'r' bulunan personel isimlerini listeleyiniz
select isim from personel Where isim ~~* '%e%' and isim ~~* '%r%';

-- 2. harfi e olup diğer harflerinde y olan personeli listeleyiniz
select isim from personel Where isim like '_e%y%';

-- a harfi olmayan personeli listeleyin
select isim from personel Where isim not like '%a%';

-- 1. harfi A ve 7. harfi a olan personeli listeleyin
select isim from personel Where isim like 'A_____a%';

--Sondan ikinci karakteri 'r' olan "isim" değerlerini listeleyiniz.
select isim from personel Where isim like '%r_';
