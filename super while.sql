

--ilk makyaja kadar olan data.
create view ilk_Makyaj_oncesi 
as

select 
v.id_101,
v.id_104,
v.id_108,
e.data_value
from version as v
left join equipment as e on e.vehicle_id=v.vehicle_id and e.schema_id =105 and (data_value='F' or data_value = 'N')
 join (

select * from
(
select  
id_101,
id_104,
id_108,
data_value,
ROW_NUMBER() over(partition by id_101 order by id_104) as SiraNo
from equipment AS e
join version as v on v.vehicle_id=e.vehicle_id
where data_value = 'F' and schema_id = 105 ) as c where c.SiraNo = 1 
) as tablo on v.id_104<tablo.id_104 and v.id_101=tablo.id_101
order by id_101,id_104


--ilk makyajdan sonraki data seti al. ilk n gördugu yer de makyajsizda donecek.






-- Hic makyaj gormemis araclar. --185.749
create view makyajsiz_data
as
select 
data_value,
id_101, 
id_104,
id_108
--into #makyajsiz
from version as v
left join equipment as e on v.vehicle_id=e.vehicle_id and schema_id=105 and (data_value = 'F' or data_value = 'N')
where id_101 not in (
select distinct id_101  from version as v
join equipment as e on v.vehicle_id=e.vehicle_id and schema_id=105 and (data_value = 'F')) --and id_101 = 128333
--order by id_101,id_104


--Makyajli olan araclar --75.227
select 
	 e.data_value,
	id_101,
	id_104,
	id_108
from dbo.version as v 
 left join dbo.equipment as e on e.vehicle_id=v.vehicle_id and schema_id = 105 and (data_value = 'F'  or data_value = 'N')
 where id_101 not in

 ( --Hic makyaj gormemis araclar.
 select distinct id_101 from version as v
left join equipment as e on v.vehicle_id=e.vehicle_id and schema_id=105 and (data_value = 'F' or data_value = 'N')
where id_101 not in (
select distinct id_101  from version as v
join equipment as e on v.vehicle_id=e.vehicle_id and schema_id=105 and (data_value = 'F')) 
)-- and id_101 = 653608


---- ilk makyaj oncesi
--select * from ilk_Makyaj_oncesi



create view while_Data
--ilk Makyaj sonrasi
as 
select 
	e.data_value,
	id_101,
	id_104,
	id_108
from dbo.version as v 
left join dbo.equipment as e on e.vehicle_id=v.vehicle_id and schema_id = 105 and (data_value = 'F'  or data_value = 'N')
except
select 
	data_value,
	id_101,
	id_104,
	id_108
from ilk_Makyaj_oncesi
except
select 
	data_value,
	id_101,
	id_104,
	id_108
from makyajsiz_data
--order by 2,3


--order by id_101, id_104





-----------------------------------------------------------------------------------

--ilk makyaj sonrasi --37.113
select 
v.id_101,
v.id_104,
v.id_108,
e.data_value,
RANK() over(partition by v.id_101,e.data_value order by v.id_104 asc) as SiraNo
from version as v
left join equipment as e on e.vehicle_id=v.vehicle_id and e.schema_id =105 and (data_value='F' or data_value = 'N')
join (
select * from -- makyajli araclarin ilk makyajlandigi tarih.
(
select  
id_101,
id_104,
id_108,
data_value,
ROW_NUMBER() over(partition by id_101 order by id_104) as SiraNo
from equipment AS e
join version as v on v.vehicle_id=e.vehicle_id
where data_value = 'F' and schema_id = 105 ) as c where c.SiraNo = 1 
) as tablo on v.id_104>tablo.id_104 and v.id_101=tablo.id_101
order by id_101,id_104





--herhangi bir yilda F goren araclar
select distinct id_101  from version as v
join equipment as e on v.vehicle_id=e.vehicle_id and schema_id=105 and (data_value = 'F' or data_value= 'N')
order by id_101,id_104




-- makyajli araclar
select data_value from version as v
left join equipment as e on v.vehicle_id=e.vehicle_id and schema_id=105 and (data_value = 'F' or data_value = 'N')
where id_101  in (
select distinct id_101  from version as v
join equipment as e on v.vehicle_id=e.vehicle_id and schema_id=105 and (data_value = 'F'))
order by id_101,id_104





select (260976)-(185749+37113)




