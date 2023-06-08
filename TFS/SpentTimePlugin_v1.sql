USE [ETR.TFS.WebService]
GO

/****** Object:  View [dbo].[SpentTimePlugin_v1]    Script Date: 28.07.2022 17:27:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





ALTER VIEW [dbo].[SpentTimePlugin_v1]
as
SELECT
TWDP.Alias																as [AssignedTo]
,TWDP.Email																as [AssignedToEmail]
,TWDTPP.ProjectNodeName	as Collection
,TWDWI.TeamProjectSK as SK
,case when (PD.ProjectDescription is null AND PD_sb.ProjectDescription is null AND PD_slb.ProjectDescription is null AND PD_sm.ProjectDescription is null AND PD_ims.ProjectDescription is null AND PD_oms.ProjectDescription is null 
AND PD_smt.ProjectDescription is null AND PD_sgm.ProjectDescription is null AND PD_lms.ProjectDescription is null AND PD_vsm.ProjectDescription is null AND PD_rsa.ProjectDescription is null AND PD_efk.ProjectDescription is null 
AND PD_mps.ProjectDescription is null AND PD_tes.ProjectDescription is null AND PD_nba.ProjectDescription is null AND PD_scs.ProjectDescription is null AND PD_u6.ProjectDescription IS NULL AND PD_arc.ProjectDescription IS NULL) then null 
when PD.ProjectDescription is not null then
cast(coalesce(
(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = CWI.AreaPath)
,(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = 'DEFAULT')
, PD.ProjectDescription) as varchar(max)) 
when PD_slb.ProjectDescription is not null then
cast(coalesce(
(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_slb.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = CWI.AreaPath)
,(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_slb.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = 'DEFAULT')
, PD_slb.ProjectDescription) as varchar(max)) 
when PD_ims.ProjectDescription is not null then
cast(coalesce(
(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_ims.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = CWI.AreaPath)
,(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_ims.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = 'DEFAULT')
, PD_ims.ProjectDescription) as varchar(max)) 
when PD_sm.ProjectDescription is not null then
cast(coalesce(
(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_sm.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = CWI.AreaPath)
,(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_sm.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = 'DEFAULT')
, PD_sm.ProjectDescription) as varchar(max)) 
when PD_smt.ProjectDescription is not null then
cast(coalesce(
(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_smt.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = CWI.AreaPath)
,(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_smt.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = 'DEFAULT')
, PD_smt.ProjectDescription) as varchar(max)) 
when PD_sgm.ProjectDescription is not null then
cast(coalesce(
(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_sgm.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = CWI.AreaPath)
,(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_sgm.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = 'DEFAULT')
, PD_sgm.ProjectDescription) as varchar(max)) 
when PD_lms.ProjectDescription is not null then
cast(coalesce(
(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_lms.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = CWI.AreaPath)
,(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_lms.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = 'DEFAULT')
, PD_lms.ProjectDescription) as varchar(max)) 
when PD_vsm.ProjectDescription is not null then
cast(coalesce(
(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_vsm.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = CWI.AreaPath)
,(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_vsm.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = 'DEFAULT')
, PD_vsm.ProjectDescription) as varchar(max)) 
when PD_rsa.ProjectDescription is not null then
cast(coalesce(
(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_rsa.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = CWI.AreaPath)
,(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_rsa.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = 'DEFAULT')
, PD_rsa.ProjectDescription) as varchar(max)) 
when PD_efk.ProjectDescription is not null then
cast(coalesce(
(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_efk.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = CWI.AreaPath)
,(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_efk.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = 'DEFAULT')
, PD_efk.ProjectDescription) as varchar(max)) 
when PD_mps.ProjectDescription is not null then
cast(coalesce(
(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_mps.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = CWI.AreaPath)
,(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_mps.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = 'DEFAULT')
, PD_mps.ProjectDescription) as varchar(max)) 
when PD_tes.ProjectDescription is not null then
cast(coalesce(
(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_tes.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = CWI.AreaPath)
,(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_tes.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = 'DEFAULT')
, PD_tes.ProjectDescription) as varchar(max)) 
when PD_nba.ProjectDescription is not null then
cast(coalesce(
(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_nba.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = CWI.AreaPath)
,(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_nba.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = 'DEFAULT')
, PD_nba.ProjectDescription) as varchar(max)) 
when PD_scs.ProjectDescription is not null then
cast(coalesce(
(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_scs.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = CWI.AreaPath)
,(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_scs.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = 'DEFAULT')
, PD_scs.ProjectDescription) as varchar(max))
when PD_arc.ProjectDescription is not null then
cast(coalesce(
(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_arc.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = CWI.AreaPath)
,(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_arc.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = 'DEFAULT')
, PD_arc.ProjectDescription) as varchar(max))
when PD_u6.ProjectDescription is not null then
cast(coalesce(
(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_u6.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = CWI.AreaPath)
,(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_u6.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = 'DEFAULT')
, PD_u6.ProjectDescription) as varchar(max))
when PD_oms.ProjectDescription is not null then
cast(coalesce(
(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_oms.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = CWI.AreaPath)
,(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_oms.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = 'DEFAULT')
, PD_oms.ProjectDescription) as varchar(max))
else
cast(coalesce(
(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_sb.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = CWI.AreaPath)
,(SELECT item.value('@pswa', 'VARCHAR(max)') value FROM PD_sb.ProjectDescription.nodes('//mapping') t (item) WHERE item.value('@area', 'varchar(max)') = 'DEFAULT')
, PD_sb.ProjectDescription) as varchar(max))
end							as [PswaProjectName]
,CWI.AreaPath
,null																	as [DoneRatio]
,null																	as [DueDate]
,CWI.Microsoft_VSTS_Scheduling_Effort									as [Estimation]
,CWI.Microsoft_VSTS_Scheduling_RemainingWork							as [Remaining]
,TWDWI.System_Id														as [ID]
,TWDWI.System_WorkItemType												as [IssueType]
,cast(floor(cast(TWDWI.LastUpdatedDateTime as float)) as datetime)		as [LastModifyDate]
,DATEPART(MONTH, TWDWI.LastUpdatedDateTime)								as [LastModifyMonth]
,DATEPART(YEAR, TWDWI.LastUpdatedDateTime)								as [LastModifyYear]
,TWDTP.ProjectNodeName													as Project
,case when PWI.System_Id is null then TWDWI.System_WorkItemType + ' ' + cast(TWDWI.System_Id as varchar) + ':' + TWDWI.System_Title
else PWI.System_WorkItemType + ' ' +  cast(PWI.System_Id as varchar) + ':' + PWI.System_Title
end																		as [Root]
,coalesce(PWI.System_Id, TWDWI.System_Id)								as [root_id]
,case when PWI.System_Id is null then TWDWI.System_WorkItemType
else PWI.System_WorkItemType
end																		as [RootType]
,ETFL.SpentOn															as SpentOn
,ETFL.Spent																as SpentTime 
,ETFL.SpentBy															as SpentTimeBy
,TWDP.Email																as [SpentTimeByEmail]
,CWI.IterationName														as Sprint
,null																	as StartDate
,CWI.System_State														as [Status]
,TWDWI.System_WorkItemType + ' ' + cast(TWDWI.System_Id as varchar)
 + ':' + TWDWI.System_Title												as [Subject]
,case when PWI.System_Id is null then TWDWI.System_WorkItemType + ' ' + cast(TWDWI.System_Id as varchar) + ':' + TWDWI.System_Title
else PWI.System_WorkItemType + ' ' +  cast(PWI.System_Id as varchar) + ':' + PWI.System_Title + '/' + TWDWI.System_WorkItemType + ' ' +  cast(TWDWI.System_Id as varchar) + ':' + TWDWI.System_Title 
end																		as [Title]
,YearString + '-' + cast(WeekOfYear as varchar) + '(' + convert(varchar, DATEADD(DAY,-1,Week), 101)  + ' - ' + convert(varchar, DATEADD(DAY,5,Week), 101) + ')'				as [Week]
,case CHARINDEX('\', CWI.IterationPath, 2)
		when 0 then ''
		else SUBSTRING(CWI.IterationPath,
		 CHARINDEX('\', CWI.IterationPath, 2) + 1,
		 case CHARINDEX('\', CWI.IterationPath, CHARINDEX('\', CWI.IterationPath, 2) + 1)
		 when 0 then LEN(CWI.IterationPath) - CHARINDEX('\', CWI.IterationPath, 2)
		 else CHARINDEX('\', CWI.IterationPath, CHARINDEX('\', CWI.IterationPath, 2) + 1) - CHARINDEX('\', CWI.IterationPath, 2) - 1 end)
		end																as ReleaseName
,case I.Depth
		when 0 then null
		when 1 then I.StartDate
		else PI.StartDate
		end																as ReleaseStartDate
,case I.Depth
		when 0 then null
		when 1 then I.FinishDate
		else PI.FinishDate
		end																as ReleaseEndDate
, CWI.AreaPath																		as CategoryName
,case when CWI.System_Id is null then CWI.System_State
else CWI.System_State
end																		as RootStatus
,CWI.[ETR_S7_BusinessTask]												as BusinessTask

,case when PWI_2.System_Id is null then null
else PWI_2.System_WorkItemType + ' ' +  cast(PWI_2.System_Id as varchar) + ':' + PWI_2.System_Title
end																		as [Root_2]
,PWI_2.System_Id							as [root_id_2]
,PWI_2.System_WorkItemType																	as [RootType_2]

,case when PWI_3.System_Id is null then null
else PWI_3.System_WorkItemType + ' ' +  cast(PWI_3.System_Id as varchar) + ':' + PWI_3.System_Title
end																		as [Root_3]
,PWI_3.System_Id							as [root_id_3]
,PWI_3.System_WorkItemType																		as [RootType_3]
 
 FROM
  Tfs_Warehouse.dbo.FactCurrentWorkItem TWFCWI
	join [Tfs_Warehouse].[dbo].[DimWorkItem] TWDWI on TWDWI.WorkItemSK = TWFCWI.WorkItemSK  
	join [Tfs_Warehouse].[dbo].[DimTeamProject] TWDTP on TWDWI.TeamProjectSK = TWDTP.ProjectNodeSK   --проджект
	join [Tfs_Warehouse].[dbo].[DimTeamProject] TWDTPP on TWDTP.ParentNodeSK = TWDTPP.ProjectNodeSK   --проджект ParentNode
	join [ETR.TFS.WebService].[dbo].Lines ETFL on  TWDWI.System_Id = ETFL.TaskId AND TWDTPP.ProjectNodeName = ETFL.CollectionName--наша таблица
	join (SELECT * FROM [Tfs_Warehouse].[dbo].[DimPerson] WHERE Domain = 'ETR') TWDP on REPLACE(ETFL.SpentBy, N'ETR\', N'') = TWDP.Alias

	join [Tfs_Warehouse].dbo.DimDate TWDD on ETFL.SpentOn=TWDD.DateSK --дата	
	cross apply 
	(SELECT 
	[RootWorkItemSK]

	,MAX([1_1]) AS ChildWorkItemSK
	,MAX([2_1]) AS ChildWorkItemSK_2
	,MAX([3_1]) AS ChildWorkItemSK_3

	FROM

	(
	SELECT 
	[RootWorkItemSK]
	,[ChildWorkItemSK]
	,[ParentWorkItemSK]
	,CONVERT(varchar(1),Level) + '_1' AS Level1
	,CONVERT(varchar(1),Level) + '_2' AS Level2
	from 
	--[Tfs_Warehouse].[dbo].GetWorkItemsTree('E3C978D9-6EA1-406F-987D-5B03E24973A1', TWDWI.System_Id, N'Parent', GETDATE())
	[Tfs_Warehouse].[dbo].GetWorkItemsTree(TWDTPP.ProjectNodeGUID, TWDWI.System_Id, N'Parent', GETDATE())
	)As Childs

	PIVOT
	(MAX([ChildWorkItemSK])
	FOR Level1 in ([1_1],[2_1],[3_1])
	) AS PVT_Child

	GROUP BY [RootWorkItemSK]) wit
	left join [Tfs_Warehouse].[dbo].[DimWorkItem] PWI ON PWI.WorkItemSK = wit.ChildWorkItemSK 
	left join [Tfs_Warehouse].[dbo].[DimWorkItem] PWI_2 ON PWI_2.WorkItemSK = wit.ChildWorkItemSK_2
	left join [Tfs_Warehouse].[dbo].[DimWorkItem] PWI_3 ON PWI_3.WorkItemSK = wit.ChildWorkItemSK_3 
	left join (select project_id, convert(xml,ProjectDescription,1) as ProjectDescription  from [ETR-TFS-DB-01].[Tfs_ETR_2010].[dbo].[tbl_projects]) PD ON PD.project_id = TWDTP.ProjectNodeGUID
	left join (select project_id, convert(xml,ProjectDescription,1) as ProjectDescription  from [ETR-TFS-DB-02].[AzureDevOps_sb].[dbo].[tbl_projects]) PD_sb ON PD_sb.project_id = TWDTP.ProjectNodeGUID
	left join (select project_id, convert(xml,ProjectDescription,1) as ProjectDescription  from [ETR-TFS-DB-02].[AzureDevOps_slb].[dbo].[tbl_projects]) PD_slb ON PD_slb.project_id = TWDTP.ProjectNodeGUID
	left join (select project_id, convert(xml,ProjectDescription,1) as ProjectDescription  from [ETR-TFS-DB-02].[AzureDevOps_sm].[dbo].[tbl_projects]) PD_sm ON PD_sm.project_id = TWDTP.ProjectNodeGUID
	left join (select project_id, convert(xml,ProjectDescription,1) as ProjectDescription  from [ETR-TFS-DB-02].[AzureDevOps_ims].[dbo].[tbl_projects]) PD_ims ON PD_ims.project_id = TWDTP.ProjectNodeGUID
	left join (select project_id, convert(xml,ProjectDescription,1) as ProjectDescription  from [ETR-TFS-DB-02].[AzureDevOps_oms].[dbo].[tbl_projects]) PD_oms ON PD_oms.project_id = TWDTP.ProjectNodeGUID
	left join (select project_id, convert(xml,ProjectDescription,1) as ProjectDescription  from [ETR-TFS-DB-02].[AzureDevOps_smt].[dbo].[tbl_projects]) PD_smt ON PD_smt.project_id = TWDTP.ProjectNodeGUID
	left join (select project_id, convert(xml,ProjectDescription,1) as ProjectDescription  from [ETR-TFS-DB-02].[AzureDevOps_sgm].[dbo].[tbl_projects]) PD_sgm ON PD_sgm.project_id = TWDTP.ProjectNodeGUID
	left join (select project_id, convert(xml,ProjectDescription,1) as ProjectDescription  from [ETR-TFS-DB-02].[AzureDevOps_lms].[dbo].[tbl_projects]) PD_lms ON PD_lms.project_id = TWDTP.ProjectNodeGUID
	left join (select project_id, convert(xml,ProjectDescription,1) as ProjectDescription  from [ETR-TFS-DB-02].[AzureDevOps_vsm].[dbo].[tbl_projects]) PD_vsm ON PD_vsm.project_id = TWDTP.ProjectNodeGUID
	left join (select project_id, convert(xml,ProjectDescription,1) as ProjectDescription  from [ETR-TFS-DB-02].[AzureDevOps_rsa].[dbo].[tbl_projects]) PD_rsa ON PD_rsa.project_id = TWDTP.ProjectNodeGUID
	left join (select project_id, convert(xml,ProjectDescription,1) as ProjectDescription  from [ETR-TFS-DB-02].[AzureDevOps_efk].[dbo].[tbl_projects]) PD_efk ON PD_efk.project_id = TWDTP.ProjectNodeGUID
	left join (select project_id, convert(xml,ProjectDescription,1) as ProjectDescription  from [ETR-TFS-DB-02].[AzureDevOps_mps].[dbo].[tbl_projects]) PD_mps ON PD_mps.project_id = TWDTP.ProjectNodeGUID
	left join (select project_id, convert(xml,ProjectDescription,1) as ProjectDescription  from [ETR-TFS-DB-02].[AzureDevOps_tes].[dbo].[tbl_projects]) PD_tes ON PD_tes.project_id = TWDTP.ProjectNodeGUID
	left join (select project_id, convert(xml,ProjectDescription,1) as ProjectDescription  from [ETR-TFS-DB-02].[AzureDevOps_nba].[dbo].[tbl_projects]) PD_nba ON PD_nba.project_id = TWDTP.ProjectNodeGUID
	left join (select project_id, convert(xml,ProjectDescription,1) as ProjectDescription  from [ETR-TFS-DB-02].[AzureDevOps_scs].[dbo].[tbl_projects]) PD_scs ON PD_scs.project_id = TWDTP.ProjectNodeGUID
	left join (select project_id, convert(xml,ProjectDescription,1) as ProjectDescription  from [ETR-TFS-DB-02].[AzureDevOps_u6].[dbo].[tbl_projects]) PD_u6 ON PD_u6.project_id = TWDTP.ProjectNodeGUID
	left join (select project_id, convert(xml,ProjectDescription,1) as ProjectDescription  from [ETR-TFS-DB-02].[AzureDevOps_arc].[dbo].[tbl_projects]) PD_arc ON PD_arc.project_id = TWDTP.ProjectNodeGUID
	join [Tfs_Warehouse].[dbo].[CurrentWorkItemView] CWI ON CWI.System_Id = TWDWI.System_Id AND CWI.ProjectNodeSK = TWDWI.TeamProjectSK--текущий work item
	left join [Tfs_Warehouse].[dbo].[DimIteration] I on I.IterationGUID = cwi.IterationGUID
	left join [Tfs_Warehouse].[dbo].DimIteration PI ON PI.IterationGUID = cwi.ParentIterationGUID
	
	


GO

