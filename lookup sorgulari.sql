-- Jato olup ERp de olmayanlar onemli
--look up 
--Marka icin
select j.marka as JatoMarka,marka.Marka as ERPMarka from jatoagac as j
left join BayiOtomasyon_.dbo.DCAMarkalar as marka on replace(j.Marka,N'Tofas',N'TOFAS')=marka.marka collate SQL_Latin1_General_CP1_CI_AS
where marka.marka is null

--Model icin
select distinct j.model as JatoModel,model.Model as ERPModel from jatoagac as j
left join BayiOtomasyon_.dbo.DCAModeller as model on j.model=model.Model collate SQL_Latin1_General_CP1_CI_AS
where model.model is null

--model uzntisi lookup
select distinct j.modelUzantisi as JatoModelUzatisi,j.model as JatoModel ,modelu.ModelUzantisi as ERPModelUzantisi from jatoagac as j
left join BayiOtomasyon_.dbo.DCAModelUzantilari as modelu on j.modeluzantisi=modelu.ModelUzantisi collate SQL_Latin1_General_CP1_CI_AS
where modelu.ModelUzantisi is null --and  j.model like '%megan%'--and j.modeluzantisi like '%renault sport%'






select distinct modeluzantisi from jatoagac



select ModelUzantisi,model.Model from BayiOtomasyon_.[dbo].DCAModelUzantilari as uz
join BayiOtomasyon_.dbo.DCAMarkalar as marka on marka.ExtMarkaID=uz.ExtMarkaID
join BayiOtomasyon_.dbo.DCAModeller as model on model.ModelID=uz.ModelID
where ModelUzantisi like '%SPORT%' and marka.Marka like '%RENAULT%' and model.Model like '%Megan%'

--CLIO S.TOURER ICON 1.5DCI 90 BG
select * from BayiOtomasyon_.[dbo].[DCAArac]

select * from BayiOtomasyon_.dbo.DCAMarkalar
where MarkaLowerCase like '%RENAULT%'

select * from BayiOtomasyon_.dbo.DCAModeller
where model like '%XC%'


select * from  BayiOtomasyon_.[dbo].DCAModelUzantilari 

