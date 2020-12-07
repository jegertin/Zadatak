# c:\xampp\mysql\bin\mysql -uedunova -pedunova < d:\zadatak3.sql
drop database if exists zadatak3;
create database zadatak3 character set utf8mb4 COLLATE utf8mb4_croatian_ci;
use zadatak3;

create table svekar(
    sifra int not null primary key auto_increment,
    novcica decimal(16,8) not null,
    suknja varchar(44) not null,
    bojakose varchar(36),
    prstena int,
    narukvica int not null,
    cura int not null
);

create table cura(
    sifra int not null primary key auto_increment,
    dukserica varchar(49),
    maraka decimal(13,7),
    drugiputa datetime,
    majica varchar(49),
    novcica decimal(15,8),
    ogrlica int not null
);

create table snasa(
    sifra int not null primary key auto_increment,
    introvertno bit,
    kuna decimal(15,6) not null,
    eura decimal(12,9) not null,
    treciputa datetime,
    ostavljena int not null
);

create table punica(
    sifra int not null primary key auto_increment,
    asocijalno bit,
    kratkamajica varchar(44),
    kuna decimal(13,8) not null,
    vesta varchar(32) not null,
    snasa int
);

create table ostavljena(
    sifra int not null primary key auto_increment,
    kuna decimal(17,5),
    lipa decimal(15,6),
    majica varchar(36),
    modelnaocala varchar(31) not null,
    prijatelj int
);

create table prijatelj(
    sifra int not null primary key auto_increment,
    kuna decimal(16,10),
    haljina varchar(37),
    lipa decimal(13,10),
    dukserica varchar(31),
    indiferentno bit not null
);

create table prijatelj_brat(
    sifra int not null primary key auto_increment,
    prijatelj int not null,
    brat int not null
);

create table brat(
    sifra int not null primary key auto_increment,
    jmbag char(11),
    ogrlica int not null,
    ekstrovertno bit not null
);

alter table svekar add foreign key(cura) references cura(sifra);
alter table punica add foreign key(snasa) references snasa(sifra);
alter table snasa add foreign key(ostavljena) references ostavljena(sifra);
alter table ostavljena add foreign key(prijatelj) references prijatelj(sifra);
alter table prijatelj_brat add foreign key(prijatelj) references prijatelj(sifra);
alter table prijatelj_brat add foreign key(brat) references brat(sifra);

#1
insert into brat(sifra,ogrlica,ekstrovertno) values (null,'1',1),(null,'2',0),(null,'3',1);
insert into prijatelj(sifra,indiferentno) values (null,1);
insert into prijatelj_brat(sifra,prijatelj,brat)
values (null,1,1),(null,1,2),(null,1,3);
insert into ostavljena(sifra,modelnaocala) values (null,'rayban'),(null,'kirvaj'),(null,'police');
insert into snasa(sifra,kuna,eura,ostavljena)
values(null,'11.11','12.12',1),(null,'12.13','21.23',2),(null,'11.25','53.63',3);

#2
update svekar set suknja='Osijek';
#3
delete from punica where kratkamajica='AB';
#4
select majica from ostavljena where lipa not like '%9%' and lipa not like '%10%' and lipa not like '%20%' and lipa not like '%30%' and lipa not like '%35%';
#5
select a.ekstrovertno, f.vesta, f.kuna
from brat a inner join prijatelj_brat b on a.sifra=b.brat
inner join prijatelj c on b.prijatelj=c.sifra
inner join ostavljena d on c.sifra=d.prijatelj 
inner join snasa e on d.sifra=e.ostavljena 
inner join punica f on e.sifra=f.snasa where d.lipa !='91' and c.haljina like '%BA%';
#6
select haljina,lipa from prijatelj;