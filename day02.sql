-- Personel isminde bir tablo olusturalim
create table personel(
	pers_id int,
	isim varchar(30),
	sehir varchar(30),
	maas int,
	sirket varchar(20),
	adres varchar(50)
);

-- Var olan personel tablosundan personel_id, sehir, adres fieldlarina sahip 
--personel_adres adinda yeni tablo olusturalim

CREATE table personel_adres
as
select pers_id, sehir, adres from personel;


-- DML --> Data Manipulation Lang
-- INSERT - UPDATE - DELETE
-- Tabloya veri ekleme, tablodan veri guncelleme ve silme islemlerinde kullanilan komutlar

-- INSERT

create table student(
id varchar(4),
st_name varchar(30),
age int
);

INSERT into student VALUES ('1001','Ali Can',25);
INSERT into student VALUES ('1002','Veli Can',35);
INSERT into student VALUES ('1003','Ayse Can',45);
INSERT into student VALUES ('1004','Derya Can',55);

-- tabloya parcali veri ekleme
insert into student(st_name,age) values('Murat Can',65);

-- DQL --> Data Query Lang
-- SELECT
select * from personel;
select * from personel_Adres;
select * from student;

select st_name from student;

--SELECT KOMUTU WHERE KOSULU
SELECT * from student WHERE age>35;

--TCL - Transaction Control Lang.
--Begin - Savepoint - rollback - commit
--Transaction veritabanı sistemlerinde bir işlem başladığında başlar ve işlem bitince sona erer
--Bu işlemler veri tabanı oluşturma, veri silme, veri güncelleme, veriyi geri getirme gibi işlemler olabilir
CREATE table ogrenciler2(
	id serial,
	isim VARCHAR(50),
	veli_isim varchar(50),
	yazili_notu  real
);

BEGIN;
insert into ogrenciler2 values(default,'Ali Can','Hasan Can',75.5);
insert into ogrenciler2 values(default,'Canan Gul','Ayse Sen',90.5);
SAVEPOINT x;
insert into ogrenciler2 values(default,'Kemal Can','Ahmet Can',85.5);
insert into ogrenciler2 values(default,'Ahmet Sen ','Ayse Can',65.5);

ROLLBACK TO x;

select * from ogrenciler2;

commit; -- transaction'dan cikis

-- Transaction kullaniminda serial data turu kullanimi tavsiye edilmez 
-- savpoint'ten sonra ekledigimiz veride sayac mantigi ile calistigi icin
-- sayacta en son hangi sayida kaldiysa ordan devam eder.

-- NOT: PostgreSQL'de transaction kullanimi icin BEGIN komutuyla baslariz, 
-- sonrasinda yanlis bir veriyi duzeltmek veya bizim icin onemli olan verilerden sonra 
-- ekleme yapabilmek icin 'SAVEPOINT savePointName' komutunu kullaniriz.
-- ve bu savepointe donebilmek icin 'ROLLBACK TO savePointName' komutunu kullaniriz. 
-- Ve rollback  calistirildiginda savepoint yazdigimiz satirin ustundeki verileri tabloda bize verir
-- Son olarak da transaction'i sonlandirmak icin mutlaka 'COMMIT' komutu kullaniriz. 
-- MySQL'de trancsaction olmadan da kullanilir.

-- DML - DELETE - 
-- DELETE FROM tablo_adi --> tablo'nun tum icerigini siler
-- Veriyi secerek silmek icin WHERE kosulu kullanilir
-- DELETE FROM tablo_adi WHERE sutun_adi = veri --> tablodaki istedigimiz veriyi siler

CREATE TABLE ogrenciler(
	id int,
	isim VARCHAR(50),
	veli_isim VARCHAR(50),
	yazili_notu int
);

INSERT INTO ogrenciler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Ali', 99);

select * from ogrenciler;

-- Soru: id'si 124 olan ogrenciyi silin
Delete from ogrenciler where id=124;

-- Soru: ismi Kemal Yasa olan satiri silin
Delete FROM ogrenciler where isim = 'Kemal Yasa';

-- Soru ismi Nesibe Yilmaz veya Mustafa Bak olan kayitleri silelim
Delete from ogrenciler where isim = 'Nesibe Yilmaz' OR isim ='Mustafa Bak';

-- Soru ismi Ali Can ve id'si 123 olan kaydi silin
Delete from ogrenciler where isim='Ali Can' and id=123;

-- Tablodaki tum verileri silelim
Delete From ogrenciler;

-- DELETE - TRUNCATE --

-- TRUNCATE komutu DELETE komutu gibi bir tablodaki VERILERIN tamamini siler.
-- Ancak, secmeli silme yapamaz.
select * from ogrenciler;
TRUNCATE TABLE ogrenciler;


-- DDL - Data Definition Lang.
-- CREATE - ALTER - DROP

-- ALTER TABLE 
-- ALTER TABLE  tabloda ADD, TYPE, SET, RENAME veya DROP COLUMN islemleri icin kullanilir

create table personel(
	pers_id int,
	isim varchar(30),
	sehir varchar(30),
	maas int,
	sirket varchar(20),
	adres varchar(50)
);

SELECT * from personel;

-- personel tablosuna  cinsiyet varchar(20) ve yas int seklinde yeni sutunlar ekleyin
alter table personel ADD cinsiyet varchar(20), add yas int;

-- personel tablosundan sirket field'ini siliniz
alter table personel DROP COLUMN sirket;

-- personel tablosundaki sehir sutununun adini ulke olarak degistirelim
alter table personel RENAME COLUMN sehir TO ulke;

-- personel tablosunun adini isciler olarak degistirelim
alter table personel RENAME TO isciler;

SELECT * from isciler;


-- DDL - DROP komutu
DROP TABLE isciler;


-- CONSTRAINT -- Kisitlamalar
-- Priary Key --> Bir sutunun NULL icermemesini ve sutundaki verilerin BENZERSIZ olmasini saglar(NOT NULL - UNIQUE)
-- Foreign Key --> Baska bir tablodaki PRIMARY KEY'i referans gostermek icin kullanilir
--				   boylelikle tablolar arasinda iliski kurmus oluruz
-- UNIQUE --> Bir sutundaki tum degerlerin BENZERSIZ yani tek olmasini saglar
-- NOT NULL --> Bir sutunun NULL icermemesini yani bos olmamasini saglar
--				NOT NULL kisitlamasi icin CONSTRAINT ismi tanimlanmaz. 
--				Bu kisitlama veri turunden hemen sonra yerlestirilir
-- CHECK --> Bir sutuna yerlestirilebilecek deger araligini sinirlamak icin kullanilir

CREATE TABLE calisanlar2(
	id CHAR(5),
	isim VARCHAR(50),
	maas int NOT NULL,
	ise_baslama DATE,
	CONSTRAINT pk_id PRIMARY KEY(id),
	CONSTRAINT isim_unq UNIQUE (isim)
);


CREATE TABLE calisanlar(
	id CHAR(5) PRIMARY KEY, -- not null + unique
	isim VARCHAR(50) UNIQUE,
	maas int NOT NULL,
	ise_baslama DATE
);

select * from calisanlar;

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', Mehmet Yılmaz, 5000, '2018-04-14');-- unique
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12');-- not null
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14');-- unique
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14');-- not null
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14');-- primary key
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14');-- primary key
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14');-- primary key


-- FOREIGN KEY 
create table adresler(
	adres_id char(5),
	sokak varchar(20),
	cadde VARCHAR(30),
	sehir varchar(20),
	CONSTRAINT id_fk FOREIGN KEY (adres_id) REFERENCES calisanlar(id)
);

INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

select * from adresler;

INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');
-- Parent tabloda olmayan id ile child tabloya ekleme yapamayiz

INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');


-- calisanlar id ile adresler tablosundaki adres_id ile eslesenlere bakmak icin
select * from calisanlar, adresler where calisanlar.id=adresler.adres_id;

DROP table calisanlar;
-- Parent tabloyu yani Primary key olan tabloyu silmek istedigimizde tabloyu silmez
-- Once child tabloyu silmemiz gerekir




