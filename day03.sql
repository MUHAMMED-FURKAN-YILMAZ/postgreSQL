CREATE TABLE calisanlar(
	id CHAR(5) PRIMARY KEY, -- not null + unique
	isim VARCHAR(50) UNIQUE,
	maas int NOT NULL,
	ise_baslama DATE
);

select * from calisanlar;

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10010', Mehmet Yılmaz, 5000, '2018-04-14');-- unique
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12');-- not null
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14');-- unique
--INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14');-- not null
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
--INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14');-- primary key
--INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14');-- primary key
--INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14');-- primary key

-- FOREIGN KEY--
CREATE TABLE adresler
(
adres_id char(5) ,
sokak varchar(20),
cadde varchar(30),
sehir varchar(20),
CONSTRAINT fk FOREIGN KEY (adres_id) REFERENCES calisanlar(id)
);

INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

select * from adresler;

INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');
--Parent tabloda olmayan id ile child tabloya ekleme yapamayizz

INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');

--Calisanlar id ile adresler tablosundaki adres_id ile eslesenlere bakmak icin
select * from calisanlar,adresler WHERE calisanlar.id = adresler.adres_id;

DROP table calisanlar
--Parant tabloyu yani primary key olan tabloyu silmek istediğimizde tabloyu silmez
--Önce child tabloyu silmemiz gerekir


Delete from calisanlar where id='10002';-- parent

Delete from adresler where addres_id='10002';-- child

drop table calisanlar;

-- ON DELETE CASCADE --
-- Her defasinda once child tablodaki verileri silmek yerine ON DELETE CASCADE silme ozelligini aktif hale getirebiliriz.
-- Bunun icin FK olan satirin en sonuna ON DELETE CASCADE komutunu yazmamiz yeterli.

CREATE TABLE talebeler(
	id CHAR(3) primary key,
	isim VARCHAR(50),
	veli_isim VARCHAR(50),
	yazili_notu int
);

INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Nesibe YÄ±lmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);

CREATE TABLE notlar(
	talebe_id char(3),
	ders_adi varchar(30),
	yazili_notu int,
	CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id)
	on delete cascade
);

INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);

select * from talebeler;
select * from notlar;

delete from notlar where talebe_id='123';

delete from talebeler where id='126'; 
-- ON DELETE CASCADE kullandigimiz icin PARENT table'dan direkt silebildik. 
-- PARENT table'dan sildigimiz icin CHILD table'dan da silindi.


delete from talebeler;

Drop table talebeler CASCADE; -- Parent tabloyu kaldirmak istersek Drop table tablo_adi'ndan
--sonra CASCADE komutu kullaniriz


-- SORU:Talebeler tablosundaki isim sutununa NOT NULL kisitlamasi ekleyin ve veri tipini VARCHAR(30) olarak degistiriniz
alter table talebeler
alter column isim TYPE VARCHAR(30),
alter column isim SET NOT NULL;


--SORU: talebeler tablosundaki yazili_notu sutununa 60'dan buyuk rakam girilebilsin
alter table talebeler
add constraint sinir CHECK (yazili_notu>60);
INSERT INTO talebeler VALUES(128, 'Mustafa Can', 'Hasan',45);-- sinirlama oldugu icin ekleme yapmadi hata verdi

-- CHECK kisitlamasi ile tablodaki istedigimiz sutunu sinirlandirabiliriz
-- yukarida 60'i sinir olarak belirledigimiz icin bunu eklemedi


create table ogrenciler(
	id int,
	isim varchar(45),
	adres varchar(100),
	sinav_notu int
);

Create table ogrenci_adres
AS
SELECT id, adres from ogrenciler;

select * from ogrenciler;
select * from ogrenci_adres;


-- tablodaki bir sutuna PRIMARY KEY ekleme 1. yol
alter table ogrenciler
ADD PRIMARY KEY (id);

-- PRIMARY KEY olusturmada 2. yol
alter table ogrenciler
ADD CONSTRAINT pk_id1 PRIMARY KEY (id);


-- PK'den sonra FK atamasi
alter table ogrenci_adres 
ADD FOREIGN KEY (id) REFERENCES ogrenciler;
-- Child tabloyu parent tablodan olusturdugumuz icin kolon adi vermedim

-- PK'yi CONSTRAINT silme
alter table ogrenci_adres 
DROP CONSTRAINT ogrenci_adres_id_fkey;
-- FK'yi CONSTRAINT silme
alter table ogrenciler 
DROP CONSTRAINT pk_id1;


--SORU: Yazili notu 85'den buyuk olan talebe bilgilerini getirin
select * from talebeler where yazili_notu > 85;

--SORU: ismi Mustafa Bak olan talebenin tum bilgilerini getirin
select * from talebeler where isim='Mustafa Bak';


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

-- SELECT komutunda BETWEEN kosulu
-- BETWEEN belirttiginiz iki veri arasindaki bilgileri listeler
-- BETWEEN de belirttigimiz degerlerde listelemeye dahildir

/*
AND (VE): Belirtilen sartlarin her ikisi de gerceklesiyorsa o kayit listelenir. bir tanesi bile gerceklesmezse listelemez
			Select * from matematik sinav1 > 50 AND sinav2=>50;
			Hem sinav1 hem de sinav2 alani 50'den buyuk olan kayitlari listeler
			
OR(VEYA): Belirtilen sartlardan biri gerceklesirse kayit listelenir
			select * from matematik sinav1>50 OR sinav2>50
			sinav1 veya sinav2 alani 50 den buyuk olan kayitleri listeler
*/

--SORU id'si 1003 ile 1005 arasinda olan personel bilgisini listeleyiniz
select * from personel
where id BETWEEN '1003' AND '1005';

-- 2. yol
select * from personel
where id>= '1003' AND id<='1005';


--SORU: Derya Soylu ile Yavuz Bal arasindaki personel bilgisini listeleyiniz
select * from personel Where isim between 'Derya Soylu' AND 'Yavuz Bal';


--SORU: Maasi 70000 ve ismi Sena olan personeli listele
select * from personel where maas=70000 OR isim='Sena Beyaz';


-- IN: Birden fazla mantiksal ifade ile tanimlayabilecegimiz durumlari tek komutta yazabilme imkani verir
--	   Farkli sutunlar icin  IN kullanilamaz

--SORU: id'si 1001,1002 ve 1004 olan personelin bilgilerini listele
select * from personel where id='1001' or id='1002' or id='1004';
--2. yol
select * from personel where id IN ('1001','1002','1004');

--SORU: maasi sadece 70000, 100000 olan personeli listele
select * from personel where maas IN(70000,100000);



