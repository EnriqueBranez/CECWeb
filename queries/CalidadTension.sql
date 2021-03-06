USE [CalidadTension]
GO
/****** Object:  Table [dbo].[SRV_MPE]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_MPE](
	[EMPRESA] [varchar](3) NOT NULL,
	[ANIO] [varchar](2) NULL,
	[PERIODO] [varchar](2) NULL,
	[TIPOMEDICION] [varchar](1) NULL,
	[LOCALIDAD] [varchar](4) NULL,
	[TIPOPUNTO] [varchar](1) NULL,
	[NROMEDICION] [varchar](1) NULL,
	[SUMINISTRO] [varchar](10) NOT NULL,
	[PARAMETROAMEDIR] [varchar](2) NULL,
	[FECHACRONOGRAMA] [datetime] NULL,
	[ID] [int] NULL,
	[TIPO] [varchar](10) NULL,
	[FECHAENVIO] [datetime] NULL,
	[COMENTARIO] [varchar](100) NULL,
	[FECHAINSTALACION] [datetime] NULL,
	[NOMBREPERIODO] [varchar](10) NULL,
	[SEMESTRE] [int] NULL,
	[FECHAVISUALIZACION] [datetime] NULL,
	[SINFUENTE] [varchar](1) NULL,
	[SUMINORIG] [varchar](10) NULL,
	[ID_CABECERA] [int] NULL,
	[CodigoIdentificador]  AS (((((([EMPRESA]+[ANIO])+[PERIODO])+[TIPOMEDICION])+[LOCALIDAD])+[TIPOPUNTO])+[NROMEDICION]),
	[FechaPeriodo]  AS ([dbo].[GetFechaInicioPeriodo]([NOMBREPERIODO]))
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[MPE]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[MPE] AS
SELECT
	M.EMPRESA AS empresa
	, M.ANIO AS anio
	, M.PERIODO AS periodo
	, M.TIPOMEDICION AS tipomedicion
	, M.LOCALIDAD AS localidad
	, M.TIPOPUNTO AS tipopunto
	, M.NROMEDICION AS nromedicion
	, M.SUMINISTRO AS suministro
	, M.PARAMETROAMEDIR AS parametroamedir
	, M.FECHACRONOGRAMA AS fechacronograma
	, M.ID AS id
	, M.TIPO AS extension
	, M.FECHAENVIO AS fechaenvio
	, M.COMENTARIO AS comentario
	, M.FECHAINSTALACION AS fechainstalacion
	, M.NOMBREPERIODO AS nombreperiodo
	, M.SEMESTRE AS semestre
	, M.FECHAVISUALIZACION AS fechavisualizacion
	, M.SINFUENTE AS sinfuente
	, M.SUMINORIG AS suminoriginal
	, M.ID_CABECERA AS codigo_cabecera
	, M.EMPRESA+M.ANIO+M.PERIODO+M.TIPOMEDICION+M.LOCALIDAD+M.TIPOPUNTO+M.NROMEDICION AS CodigoIdentificador
	, S.NombreSemestre

	, ISNULL(BT.sistemaelectrico,ISNULL(MT.sistemaelectrico,'-')) as sistemaelectrico
	, ISNULL(BT.sectortipico,ISNULL(MT.sectortipico,'-')) as sectortipico
	, ISNULL(BT.ubicacion,ISNULL(MT.UBICACION,'-')) as UBICACION
	, ISNULL(BT.Departamento ,ISNULL(MT.DeptNombre ,'-')) as Departamento
	, ISNULL(BT.seccionlinea ,ISNULL(MT.ALIMENTADOR ,'-')) as SeccionLinea
	, ISNULL(BT.seccionalimentador ,ISNULL(MT.seccionalimentador ,'-')) as seccionalimentador
	, ISNULL(BT.[SET] ,ISNULL(MT.SETCODE ,'-')) as [SET]
	--, BT.[SET] AS SETBT, MT.SETCODE AS SETMT
	--, ISNULL(BT.Norma,ISNULL(MT.Norma,'-')) as Norma
	--, ISNULL(LEFT(BT.OPCION,2),ISNULL(LEFT(MT.OPCION,2),'-')) as TipoUsuario
	--, ISNULL(LEFT(BT.OPCION,2),ISNULL(LEFT(MT.OPCION,2),'-')) as TarifaUsuario

FROM CalidadTension.dbo.SRV_MPE as M
LEFT JOIN [CalidadGenerales].[dbo].Semestre AS S
	ON M.SEMESTRE=S.CodigoSemestre

left join CalidadGenerales.dbo.SED_MTBT as BT
	on M.EMPRESA = BT.EMPRESA and M.SEMESTRE = BT.SEMESTRE and M.SUMINISTRO = BT.subestacion

left join CalidadGenerales.dbo.SUMINMT as MT
	on M.EMPRESA = MT.EMPRESA and M.SEMESTRE = MT.SEMESTRE and M.SUMINISTRO = MT.SUMINISTRO

--WHERE M.EMPRESA ='ELS' AND M.SEMESTRE =448 AND M.PERIODO = 11
--ORDER BY  M.FECHACRONOGRAMA


GO
/****** Object:  Table [dbo].[SR3_RURALMTXLS_XRM]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SR3_RURALMTXLS_XRM](
	[TRC_CORTRC] [int] NOT NULL,
	[TRX_SUMINISTRO] [varchar](100) NOT NULL,
	[TRX_NUMMES] [int] NULL,
	[ID_CABECERA] [int] NULL,
	[USUARIO_CREACION] [varchar](38) NULL,
	[TERMINAL_CREACION] [varchar](38) NULL,
	[FECHA_CREACION] [datetime] NULL,
	[USUARIO_ACTUALIZACION] [varchar](38) NULL,
	[TERMINAL_ACTUALIZACION] [varchar](38) NULL,
	[FECHA_ACTUALIZACION] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Sirvan3_TensionRuralMTCron]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Sirvan3_TensionRuralMTCron] AS SELECT
TRC_CORTRC AS idtensionrural
, TRX_SUMINISTRO AS suministro
, TRX_NUMMES AS numeromes
, ID_CABECERA AS idcabecera
, USUARIO_CREACION AS audit_usercreacion
, TERMINAL_CREACION AS audit_terminalcrea
, FECHA_CREACION AS audit_creado
, USUARIO_ACTUALIZACION AS audit_usuariomodif
, TERMINAL_ACTUALIZACION AS audit_updateorig
, FECHA_ACTUALIZACION AS audit_modificado
FROM SR3_RURALMTXLS_XRM
GO
/****** Object:  Table [dbo].[SRV_FTE]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_FTE](
	[EMPRESA] [varchar](3) NULL,
	[ANIO] [varchar](2) NULL,
	[PERIODO] [varchar](2) NULL,
	[TIPOMEDICION] [varchar](1) NULL,
	[LOCALIDAD] [varchar](4) NULL,
	[TIPOPUNTO] [varchar](1) NULL,
	[NROMEDICION] [varchar](1) NULL,
	[SUMINISTRO] [varchar](10) NULL,
	[RANGO1] [int] NULL,
	[RANGO2] [int] NULL,
	[RANGO3] [int] NULL,
	[RANGO4] [int] NULL,
	[RANGO5] [int] NULL,
	[RANGO6] [int] NULL,
	[RANGO7] [int] NULL,
	[RANGO8] [int] NULL,
	[RANGO9] [int] NULL,
	[RANGO10] [int] NULL,
	[RANGO11] [int] NULL,
	[RANGO12] [int] NULL,
	[NOMBREPERIODO] [varchar](10) NULL,
	[SEMESTRE] [int] NULL,
	[ID_CABECERA] [int] NULL,
	[CodigoIdentificador]  AS (((((([EMPRESA]+[ANIO])+[PERIODO])+[TIPOMEDICION])+[LOCALIDAD])+[TIPOPUNTO])+[NROMEDICION]),
	[FechaPeriodo]  AS ([dbo].[GetFechaInicioPeriodo]([NOMBREPERIODO]))
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[FTE]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




	CREATE VIEW [dbo].[FTE] AS SELECT
		EMPRESA AS empresa
		, ANIO AS anio
		, PERIODO AS periodo
		, TIPOMEDICION AS tipomedicion
		, LOCALIDAD AS localidad
		, TIPOPUNTO AS tipopunto
		, NROMEDICION AS nromedicion
		, SUMINISTRO AS suministro
		, RANGO1 AS rango1
		, RANGO2 AS rango2
		, RANGO3 AS rango3
		, RANGO4 AS rango4
		, RANGO5 AS rango5
		, RANGO6 AS rango6
		, RANGO7 AS rango7
		, RANGO8 AS rango8
		, RANGO9 AS rango9
		, RANGO10 AS rango10
		, RANGO11 AS rango11
		, RANGO12 AS rango12
		, NOMBREPERIODO AS nombreperiodo
		, SEMESTRE AS semestre
		, ID_CABECERA AS codigo_cabecera
		, EMPRESA+ANIO+PERIODO+TIPOMEDICION+LOCALIDAD+TIPOPUNTO+NROMEDICION AS CodigoIdentificador
		, RANGO1+RANGO2+RANGO3+RANGO4+RANGO5+RANGO6 AS RangoSO
		, RANGO7+RANGO8+RANGO9+RANGO10+RANGO11+RANGO12 AS RangoSU
		, RANGO2+RANGO3+RANGO4+RANGO5+RANGO6 AS RangoSOCRI
		, RANGO8+RANGO9+RANGO10+RANGO11+RANGO12 AS RangoSUCRI
		, RANGO3+RANGO4+RANGO5+RANGO6 AS RangoSOCRI2
		, RANGO9+RANGO10+RANGO11+RANGO12 AS RangoSUCRI2
	FROM SRV_FTE
GO
/****** Object:  Table [dbo].[SRV_TENSION_URB]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_TENSION_URB](
	[CODIGO] [int] NOT NULL,
	[EMPRESA] [varchar](3) NULL,
	[SEMESTRE] [int] NULL,
	[SUMIN_MEN_BT] [int] NULL,
	[SUMIN_MEN_MTATMAT] [int] NULL,
	[TOTAL_MEN_CPEBT] [int] NULL,
	[TOTAL_MEN_BT] [int] NULL,
	[TOTAL_MEN_MTATMAT] [int] NULL,
	[CUANDO] [datetime] NULL,
	[ACTIVO] [varchar](1) NULL,
	[USUARIO_CREACION] [varchar](38) NULL,
	[TERMINAL_CREACION] [varchar](38) NULL,
	[FECHA_CREACION] [datetime] NULL,
	[USUARIO_ACTUALIZACION] [varchar](38) NULL,
	[TERMINAL_ACTUALIZACION] [varchar](38) NULL,
	[FECHA_ACTUALIZACION] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Sirvan3_TensionUrbano]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE VIEW [dbo].[Sirvan3_TensionUrbano] AS
	SELECT
		T.CODIGO AS codigo
		, T.EMPRESA AS empresa
		, T.SEMESTRE AS semestre
		, T.SUMIN_MEN_BT AS sumbt
		, T.SUMIN_MEN_MTATMAT AS summtatmat
		, T.TOTAL_MEN_CPEBT AS totalcpebt
		, T.TOTAL_MEN_BT AS totalBT
		, T.TOTAL_MEN_MTATMAT AS totalmtatmat
		, T.CUANDO AS cuando
		, T.ACTIVO AS activo
		, T.USUARIO_CREACION AS audit_usercreacion
		, T.TERMINAL_CREACION AS audit_terminalcrea
		, T.FECHA_CREACION AS audit_creado
		, T.USUARIO_ACTUALIZACION AS audit_usuariomodif
		, T.TERMINAL_ACTUALIZACION AS audit_updateorig
		, T.FECHA_ACTUALIZACION AS audit_modificado
		, S.NombreSemestre
	FROM SRV_TENSION_URB as T
	left join  [CalidadGenerales].[dbo].[Semestre] as S on T.SEMESTRE=S.CodigoSemestre


GO
/****** Object:  Table [dbo].[SRV_TENDETALLE_URB]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_TENDETALLE_URB](
	[CODIGO] [int] NOT NULL,
	[EMPRESA] [varchar](3) NULL,
	[SEMESTRE] [int] NULL,
	[CODSISTEMA] [varchar](4) NULL,
	[NOMSISTEMA] [varchar](20) NULL,
	[DET_SUM_BT] [int] NULL,
	[DET_SUM_MTATMAT] [int] NULL,
	[DET_TOTAL_BT] [int] NULL,
	[DET_TOTAL_MTATMAT] [int] NULL,
	[USUARIO_CREACION] [varchar](38) NULL,
	[TERMINAL_CREACION] [varchar](38) NULL,
	[FECHA_CREACION] [datetime] NULL,
	[USUARIO_ACTUALIZACION] [varchar](38) NULL,
	[TERMINAL_ACTUALIZACION] [varchar](38) NULL,
	[FECHA_ACTUALIZACION] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Sirvan3_TensionDetalleUrbano]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE VIEW [dbo].[Sirvan3_TensionDetalleUrbano] AS SELECT
	CODIGO AS codigo
	, EMPRESA AS empresa
	, SEMESTRE AS semestre
	, CODSISTEMA AS codSistema
	, NOMSISTEMA AS nomSistema
	, DET_SUM_BT AS sumBT
	, DET_SUM_MTATMAT AS sumMTATMAT
	, DET_TOTAL_BT AS totalBT
	, DET_TOTAL_MTATMAT AS totalMTATMAT
	, USUARIO_CREACION AS audit_usercreacion
	, TERMINAL_CREACION AS audit_terminalcrea
	, FECHA_CREACION AS audit_creado
	, USUARIO_ACTUALIZACION AS audit_usuariomodif
	, TERMINAL_ACTUALIZACION AS audit_updateorig
	, FECHA_ACTUALIZACION AS audit_modificado
	FROM SRV_TENDETALLE_URB
GO
/****** Object:  Table [dbo].[SR3_TENSSORTEO_TSS]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SR3_TENSSORTEO_TSS](
	[TSS_CORTSS] [int] NOT NULL,
	[TSN_CORTSN] [int] NULL,
	[TSE_CORTSE] [int] NULL,
	[TSB_CORTSB] [int] NULL,
	[TSS_ACEPTACION] [varchar](20) NULL,
	[TSS_HASHCODE] [varchar](200) NULL,
	[USUARIO_CREACION] [varchar](38) NULL,
	[TERMINAL_CREACION] [varchar](38) NULL,
	[FECHA_CREACION] [datetime] NULL,
	[USUARIO_ACTUALIZACION] [varchar](38) NULL,
	[TERMINAL_ACTUALIZACION] [varchar](38) NULL,
	[FECHA_ACTUALIZACION] [datetime] NULL,
	[TSS_DIACRON] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Sirvan3_TensionSorteo]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE VIEW [dbo].[Sirvan3_TensionSorteo] AS SELECT
		TSS_CORTSS AS idestrato
		, TSN_CORTSN AS idcontraste
		, TSE_CORTSE AS idestato
		, TSB_CORTSB AS idbasecont
		, TSS_ACEPTACION AS aceptacion
		, TSS_HASHCODE AS hashcode
		, USUARIO_CREACION AS audit_usercreacion
		, TERMINAL_CREACION AS audit_terminalcrea
		, FECHA_CREACION AS audit_creado
		, USUARIO_ACTUALIZACION AS audit_usuariomodif
		, TERMINAL_ACTUALIZACION AS audit_updateorig
		, FECHA_ACTUALIZACION AS audit_modificado
		, TSS_DIACRON AS fechacron
	FROM SR3_TENSSORTEO_TSS
GO
/****** Object:  Table [dbo].[SR3_TENSCRONOGRAMA_TCR]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SR3_TENSCRONOGRAMA_TCR](
	[TCR_CORTCR] [int] NOT NULL,
	[TCR_HASHCODE] [varchar](200) NULL,
	[TSN_CORTSN] [int] NULL,
	[TSS_CORTSS] [int] NULL,
	[TCR_MESCRON] [int] NULL,
	[TCR_DIACRON] [datetime] NULL,
	[TCR_CANVIEW] [datetime] NULL,
	[ID_CABECERA] [int] NULL,
	[USUARIO_CREACION] [varchar](38) NULL,
	[TERMINAL_CREACION] [varchar](38) NULL,
	[FECHA_CREACION] [datetime] NULL,
	[USUARIO_ACTUALIZACION] [varchar](38) NULL,
	[TERMINAL_ACTUALIZACION] [varchar](38) NULL,
	[FECHA_ACTUALIZACION] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Sirvan3_TensionCronograma]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE VIEW [dbo].[Sirvan3_TensionCronograma] AS SELECT
		TCR_CORTCR AS id
		, TCR_HASHCODE AS hashcode
		, TSN_CORTSN AS idtension
		, TSS_CORTSS AS idsorteado
		, TCR_MESCRON AS nummes
		, TCR_DIACRON AS fechacron
		, TCR_CANVIEW AS puedever
		, ID_CABECERA AS idcabecera
		, USUARIO_CREACION AS audit_usercreacion
		, TERMINAL_CREACION AS audit_terminalcrea
		, FECHA_CREACION AS audit_creado
		, USUARIO_ACTUALIZACION AS audit_usuariomodif
		, TERMINAL_ACTUALIZACION AS audit_updateorig
		, FECHA_ACTUALIZACION AS audit_modificado
	FROM SR3_TENSCRONOGRAMA_TCR
GO
/****** Object:  Table [dbo].[SR3_TENSBASE_TSB]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SR3_TENSBASE_TSB](
	[TSN_CORTSN] [int] NOT NULL,
	[TSB_CORTSB] [int] NULL,
	[EMP_CODEMP] [varchar](3) NULL,
	[SEM_CODSEM] [int] NULL,
	[TSB_NORMA] [varchar](1) NULL,
	[TSB_LOCALI] [varchar](50) NULL,
	[TSB_SUMINISTRO] [varchar](50) NULL,
	[TSB_UBIGEO] [varchar](10) NULL,
	[TSB_FLAGEXCLUIDO] [varchar](1) NULL,
	[TSB_EXCLUYEMOTIV] [varchar](200) NULL,
	[TSB_TIPOMED] [varchar](10) NULL,
	[TSB_SUBEST] [varchar](50) NULL,
	[TSB_NIVELTEN] [varchar](20) NULL,
	[TSB_SISTEMA] [varchar](20) NULL,
	[TSB_FASES] [varchar](20) NULL,
	[USUARIO_CREACION] [varchar](38) NULL,
	[TERMINAL_CREACION] [varchar](38) NULL,
	[FECHA_CREACION] [datetime] NULL,
	[USUARIO_ACTUALIZACION] [varchar](38) NULL,
	[TERMINAL_ACTUALIZACION] [varchar](38) NULL,
	[FECHA_ACTUALIZACION] [datetime] NULL,
	[TSB_CTTALM] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Sirvan3_TensionBaseSuministro]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE VIEW [dbo].[Sirvan3_TensionBaseSuministro] AS SELECT
		TSN_CORTSN AS idtension
		, TSB_CORTSB AS codigo
		, EMP_CODEMP AS empresa
		, SEM_CODSEM AS semestre
		, TSB_NORMA AS norma
		, TSB_LOCALI AS localidad
		, TSB_SUMINISTRO AS suministro
		, TSB_UBIGEO AS ubigeo
		, TSB_FLAGEXCLUIDO AS excluido
		, TSB_EXCLUYEMOTIV AS motivoexclusion
		, TSB_TIPOMED AS tipomedidor
		, TSB_SUBEST AS subestacion
		, TSB_NIVELTEN AS nivelten
		, TSB_SISTEMA AS sistemaElectrico
		, TSB_FASES AS tipoMedicion
		, USUARIO_CREACION AS audit_usercreacion
		, TERMINAL_CREACION AS audit_terminalcrea
		, FECHA_CREACION AS audit_creado
		, USUARIO_ACTUALIZACION AS audit_usuariomodif
		, TERMINAL_ACTUALIZACION AS audit_updateorig
		, FECHA_ACTUALIZACION AS audit_modificado
		, TSB_CTTALM AS alimentador
	FROM SR3_TENSBASE_TSB
GO
/****** Object:  View [dbo].[Sirvan3_TensionDatosConsolidado]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[Sirvan3_TensionDatosConsolidado] AS
	SELECT 
		T.[codigo], T.[empresa], T.NombreSemestre --,[semestre]
		, T.[sumbt], T.[summtatmat], T.[totalcpebt], T.[totalBT], T.[totalmtatmat], T.[totalBT]*6 as MuestraSemestralBT, T.[totalmtatmat]*6 as MuestraSemestralMT
		--, T.[cuando], T.[activo] 
		, S.fechacron, S.idbasecont --, S.[idestrato], S.[idcontraste], S.[idestato], S.[idbasecont], S.[aceptacion], S.[hashcode], S.[fechacron]
		, D.sistemaElectrico, D.ubigeo, D.suministro, D.subestacion
		, D.[norma], D.[localidad], D.[excluido], D.[motivoexclusion], D.[tipomedidor], D.[nivelten], D.[alimentador], D.[tipoMedicion]
		, U.DeptNombre, U.DeptUbigeo
	FROM [dbo].[Sirvan3_TensionUrbano] as T
		left join [dbo].[Sirvan3_TensionSorteo] as S on T.codigo=S.idcontraste
		left join [dbo].[Sirvan3_TensionBaseSuministro] as D on S.idcontraste=D.idtension and S.idbasecont=D.codigo
		left join [CalidadGenerales].[dbo].[UBIGEO] as U on D.ubigeo=U.Ubigeo
		--left join [CalidadGenerales].[dbo].
	where T.[activo]='A' and S.aceptacion='FINAL'
GO
/****** Object:  Table [dbo].[SRV_CTE]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_CTE](
	[EMPRESA] [varchar](3) NULL,
	[ANIO] [varchar](2) NULL,
	[PERIODO] [varchar](2) NULL,
	[TIPOMEDICION] [varchar](1) NULL,
	[LOCALIDAD] [varchar](4) NULL,
	[TIPOPUNTO] [varchar](1) NULL,
	[NROMEDICION] [varchar](1) NULL,
	[SUMINISTRO] [varchar](10) NULL,
	[SUMINISTROCLIENTE] [varchar](10) NULL,
	[TIPOENERGIA] [varchar](1) NULL,
	[ENERGIASUMINISTRADA] [decimal](16, 3) NULL,
	[ENERGIATOTAL] [decimal](16, 3) NULL,
	[ENERGIATOTALRANGO2] [decimal](16, 3) NULL,
	[NUMEROINTERVALOS] [int] NULL,
	[NUMEROINTERVALOSRANGO2] [int] NULL,
	[SUMATORIAVALORES] [decimal](14, 2) NULL,
	[MONTOCOMPENSACION] [decimal](15, 4) NULL,
	[ANO] [varchar](4) NULL,
	[MES] [varchar](2) NULL,
	[NOMBREPERIODO] [varchar](10) NULL,
	[SEMESTRE] [int] NULL,
	[ID_CABECERA] [int] NULL,
	[NroRegEnArchivoOrigen] [int] NULL,
	[CodigoIdentificador]  AS (((((([EMPRESA]+[ANIO])+[PERIODO])+[TIPOMEDICION])+[LOCALIDAD])+[TIPOPUNTO])+[NROMEDICION]),
	[FechaPeriodo]  AS ([dbo].[GetFechaInicioPeriodo]([NOMBREPERIODO]))
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[CTE]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CTE] AS
SELECT
	-- select top 100
	C.EMPRESA AS empresa
	, C.ANIO AS anio
	, C.PERIODO AS periodo
	, C.TIPOMEDICION AS tipomedicion
	, C.LOCALIDAD AS localidad
	, C.TIPOPUNTO AS tipopunto
	, C.NROMEDICION AS nromedicion
	, C.SUMINISTRO AS suministro
	, C.SUMINISTROCLIENTE AS suministrocliente
	, C.TIPOENERGIA AS tipoenergia
	, C.ENERGIASUMINISTRADA AS energiasuministrada
	, C.ENERGIATOTAL AS energiatotal
	, C.ENERGIATOTALRANGO2 AS energiatotalrango2
	, C.NUMEROINTERVALOS AS numerointervalos
	, C.NUMEROINTERVALOSRANGO2 AS numerointervalosrango2
	, C.SUMATORIAVALORES AS sumatoriavalores
	, C.MONTOCOMPENSACION AS montocompensacion
	, C.ANO AS ano
	, C.MES AS mes
	, C.NOMBREPERIODO AS nombreperiodo
	, C.SEMESTRE AS semestre
	, C.ID_CABECERA AS codigo_cabecera
	, C.NroRegEnArchivoOrigen
	, C.CodigoIdentificador
	, C.FechaPeriodo
	, C.ANO+right('0'+C.MES,2) AS PeriodoMesPagoCompensacion
	, S.NombreSemestre
	, cast(iif(cast(C.ANIO as int)<80,2000,1900) + cast(C.ANIO as int) as nvarchar) + C.PERIODO AS PeriodoMesOrigenCompensacion
	, cast(iif(cast(C.ANIO as int)<80,2000,1900) + cast(C.ANIO as int) as nvarchar) + iif(cast(C.PERIODO as int)>6,'S2','S1') AS SemestreOrigenCompensacion
	, IIF(C.ANIO='99','1999',concat('20',c.anio)) as AñoDetectado
	, iif(len(c.mes)=2,C.ANO+C.MES,c.ano+'0'+c.mes) as PeriodoCompensado
	, CONCAT(C.ANO,IIF(cast(c.MES as int)<7,'S1','S2')) AS SemestreCompensado
	, SS.SISTEMAELECTRICO
	, SS.NOMSISTEMA
	, SS.SECTORTIPICO
	, SS.Norma
	, SS.TipoClienteTension
	, SS.OPCION as TarifaUsuario
	, SS.ubicacion
	, SS.DeptNombre
	, SS.subestacion as SED_SIRVAN
	, SS.codsubestacion as SED_VNR
	, SS.seccionlinea as AlimentadorMT
	, SS.UTMSedEste as UTM_SED_ESTE
	, SS.UTMSedNorte as UTM_SED_NORTE
	, SS.UbigeoSED as UbicacionSED
FROM SRV_CTE as C
	LEFT JOIN [CalidadGenerales].[dbo].Semestre AS S ON C.SEMESTRE=S.CodigoSemestre
	LEFT JOIN CalidadGenerales.dbo.Suministros AS SS ON C.EMPRESA=SS.empresa AND C.SUMINISTRO=SS.suministro and ( (SS.FechaDesde<=C.FechaPeriodo) and (C.FechaPeriodo<SS.FechaHasta) )
--	LEFT JOIN [CalidadGenerales].[dbo].[LOCALI] AS L ON C.EMPRESA=L.EMPRESA AND C.LOCALIDAD=L.LOCALIDAD AND C.SEMESTRE=L.SEMESTRE
	LEFT JOIN [CalidadTension].[dbo].[ControlCargaArchivos] AS A ON C.EMPRESA=A.CodEmpresa AND C.ID_CABECERA=A.CodigoArchivoOrigen
	--sselect * from CalidadGenerales.dbo.Suministros 73048934
WHERE A.UltimoValido='S'
GO
/****** Object:  Table [dbo].[SIR_MTR_MTR]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SIR_MTR_MTR](
	[EMP_CODEMP] [varchar](3) NOT NULL,
	[YEAR] [int] NOT NULL,
	[PERIODO] [varchar](2) NOT NULL,
	[TIPOMEDICION] [varchar](1) NOT NULL,
	[SISTEMA] [varchar](4) NOT NULL,
	[TIPOPUNTO] [varchar](1) NOT NULL,
	[NROMEDICION] [varchar](1) NOT NULL,
	[MTR_SUMINISTRO] [varchar](10) NOT NULL,
	[MTR_FECHACRONOGRAMA] [datetime] NULL,
	[MTR_SEDBAJA] [varchar](7) NULL,
	[MTR_CORMTR] [int] NULL,
	[MTR_SEMESTRE] [int] NULL,
	[NOMBREPERIODO] [varchar](10) NULL,
	[MTR_TIPO] [varchar](3) NOT NULL,
	[MTR_VISUALIZACION] [datetime] NULL,
	[MTR_COMENTARIO] [varchar](2000) NULL,
	[MTR_FECHAINSTALACION] [datetime] NULL,
	[TNS_CODIGO] [int] NULL,
	[MTR_SUMINISTROCOL] [varchar](10) NULL,
	[MTR_SUMINORIGCAB] [varchar](10) NULL,
	[MTR_SUMINORIGCOL] [varchar](10) NULL,
	[MTR_HAYFUENTECAB] [varchar](1) NULL,
	[MTR_HAYFUENTECOLA] [varchar](1) NULL,
	[MTR_FECHAENVIO] [datetime] NULL,
	[ID_CABECERA] [int] NULL,
	[CodigoIdentificador]  AS (((((([EMP_CODEMP]+str([year],(2)))+[periodo])+[tipomedicion])+[sistema])+[tipopunto])+[nromedicion])
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SIR_CCT_CCT]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SIR_CCT_CCT](
	[CCT_CODCCT] [int] NOT NULL,
	[EMP_CODEMP] [varchar](3) NOT NULL,
	[YEAR] [varchar](2) NOT NULL,
	[PERIODO] [varchar](2) NOT NULL,
	[TIPOMEDICION] [varchar](1) NOT NULL,
	[SISTEMA] [varchar](4) NOT NULL,
	[TIPOPUNTO] [varchar](1) NOT NULL,
	[NROMEDICION] [varchar](1) NOT NULL,
	[CCT_NOMBREFUENTE] [varchar](25) NULL,
	[CCT_SUMIMEDIDO] [varchar](10) NULL,
	[CCT_SUMREEMPLAZA] [varchar](10) NULL,
	[CCT_TENSION] [int] NULL,
	[CCT_MARCAMODELO] [varchar](25) NULL,
	[CCT_REGSERIE] [varchar](15) NULL,
	[CCT_FACTORTENSION] [decimal](7, 3) NULL,
	[CCT_FACTORCORR] [decimal](7, 3) NULL,
	[CCT_INSTALACION] [datetime] NULL,
	[CCT_FECHARETIRO] [datetime] NULL,
	[CCT_RESULTADO] [varchar](1) NULL,
	[CCT_OBSERVACIONES] [varchar](60) NULL,
	[CCT_MTBT] [varchar](7) NULL,
	[CCT_UBICACION] [varchar](1) NULL,
	[NOMBREPERIODO] [varchar](10) NULL,
	[CCT_IDSEMESTRE] [int] NULL,
	[ID_CABECERA] [int] NULL,
	[CodigoIdentificador]  AS (((((([EMP_CODEMP]+[YEAR])+[PERIODO])+[TIPOMEDICION])+[SISTEMA])+[TIPOPUNTO])+[NROMEDICION]),
	[FechaPeriodo]  AS ([dbo].[GetFechaInicioPeriodo]([NOMBREPERIODO]))
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SIR_FTR_FTR]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SIR_FTR_FTR](
	[FTR_CODFTR] [int] NOT NULL,
	[EMP_CODEMP] [varchar](3) NOT NULL,
	[YEAR] [varchar](2) NOT NULL,
	[PERIODO] [varchar](2) NOT NULL,
	[TIPOMEDICION] [varchar](1) NOT NULL,
	[SISTEMA] [varchar](4) NOT NULL,
	[TIPOPUNTO] [varchar](1) NOT NULL,
	[NROMEDICION] [varchar](1) NOT NULL,
	[FTR_SUMINISTRO] [varchar](10) NOT NULL,
	[FTR_RANGO1] [int] NULL,
	[FTR_RANGO2] [int] NULL,
	[FTR_RANGO3] [int] NULL,
	[FTR_RANGO4] [int] NULL,
	[FTR_RANGO5] [int] NULL,
	[FTR_RANGO6] [int] NULL,
	[FTR_RANGO7] [int] NULL,
	[FTR_RANGO8] [int] NULL,
	[FTR_RANGO9] [int] NULL,
	[FTR_RANGO10] [int] NULL,
	[FTR_RANGO11] [int] NULL,
	[FTR_RANGO12] [int] NULL,
	[FTR_VSO1] [decimal](5, 2) NULL,
	[FTR_VSO2] [decimal](5, 2) NULL,
	[FTR_VSU1] [decimal](5, 2) NULL,
	[FTR_VSU2] [decimal](5, 2) NULL,
	[NOMBREPERIODO] [varchar](10) NOT NULL,
	[FTR_IDSEMESTRE] [int] NOT NULL,
	[ID_CABECERA] [int] NOT NULL,
	[CodigoIdentificador]  AS (((((([EMP_CODEMP]+[YEAR])+[PERIODO])+[TIPOMEDICION])+[SISTEMA])+[TIPOPUNTO])+[NROMEDICION]),
	[FechaPeriodo]  AS ([dbo].[GetFechaInicioPeriodo]([NOMBREPERIODO]))
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[NormaRural_FTR]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[NormaRural_FTR] AS SELECT
	F.FTR_CODFTR AS id
	, F.EMP_CODEMP AS empresa
	, F.YEAR AS year
	, F.PERIODO AS periodo
	, F.TIPOMEDICION AS tipomedicion
	, F.SISTEMA AS sistema
	, IIF (F.TIPOPUNTO='A','B',F.TIPOPUNTO) AS tipopunto
	, F.NROMEDICION AS nromedicion
	, F.FTR_SUMINISTRO AS suministro
	, F.FTR_RANGO1 AS rango1, F.FTR_RANGO2 AS rango2, F.FTR_RANGO3 AS rango3, F.FTR_RANGO4 AS rango4, F.FTR_RANGO5 AS rango5, F.FTR_RANGO6 AS rango6
	, F.FTR_RANGO7 AS rango7, F.FTR_RANGO8 AS rango8, F.FTR_RANGO9 AS rango9, F.FTR_RANGO10 AS rango10, F.FTR_RANGO11 AS rango11, F.FTR_RANGO12 AS rango12
	, F.FTR_VSO1 AS vso1, F.FTR_VSO2 AS vso2
	, F.FTR_VSU1 AS vsu1, F.FTR_VSU2 AS vsu2
	, F.NOMBREPERIODO AS nombreperiodo
	, F.FTR_IDSEMESTRE AS idsemestre
	, F.ID_CABECERA AS codigo_cabecera
	, F.Codigoidentificador
	, IIF(F.tipomedicion='1',F.FTR_RANGO1+F.FTR_RANGO2+F.FTR_RANGO3+F.FTR_RANGO4+F.FTR_RANGO5+F.FTR_RANGO6,F.FTR_RANGO2+F.FTR_RANGO3+F.FTR_RANGO4+F.FTR_RANGO5+F.FTR_RANGO6) AS RangoSo	 
	, IIF(F.tipomedicion='1',F.FTR_RANGO7+F.FTR_RANGO8+F.FTR_RANGO9+F.FTR_RANGO10+F.FTR_RANGO11+F.FTR_RANGO12,F.FTR_RANGO8+F.FTR_RANGO9+F.FTR_RANGO10+F.FTR_RANGO11+F.FTR_RANGO12) AS RangoSu
	, IIF(F.tipomedicion='1',iif(F.FTR_RANGO2+F.FTR_RANGO3+F.FTR_RANGO4+F.FTR_RANGO5+F.FTR_RANGO6+F.FTR_RANGO8+F.FTR_RANGO9+F.FTR_RANGO10+F.FTR_RANGO11+F.FTR_RANGO12>9,'Superior a 7,5% Vn','Inferior a 7,5% Vn'),'Superior a 7,5% Vn') as Criticidad
	, C.[CCT_RESULTADO] as resultado
	, iif(C.[TIPOMEDICION]='1',C.CCT_SUMIMEDIDO, isnull(C.CCT_MTBT,C.CCT_SUMIMEDIDO) ) as ElementoMedido
	--, C.SemestreControl, C.SemestreMedido
	, str(cast(C.year AS int)+2000,4)
		+iif( isnumeric(C.periodo)=1
			, C.periodo
			, right('00'+ltrim(str(month(C.CCT_INSTALACION),2)),2)
			)
		as PeriodoMesControl
	, str(cast(C.year AS int)+2000,4)
		+iif( isnumeric(C.periodo)=1
			, iif((cast(C.periodo as int))<7,'S1','S2')
			, iif(month(C.CCT_INSTALACION)<7,'S1','S2') ) 
		as SemestreControl
	, iif( C.CCT_INSTALACION IS NULL,'---',str(year(C.CCT_INSTALACION),4)
		+iif(month(C.CCT_INSTALACION)<7,'S1','S2')) 
		as SemestreMedido
FROM SIR_FTR_FTR As F
left join [dbo].[SIR_CCT_CCT] as C
on F.[CodigoIdentificador]=C.CodigoIdentificador and F.FTR_SUMINISTRO=C.CCT_SUMIMEDIDO
GO
/****** Object:  View [dbo].[NormaRural_CCT]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[NormaRural_CCT] AS
SELECT
	CCT_CODCCT AS id
	, C.EMP_CODEMP AS empresa
	, C.YEAR AS year
	, C.PERIODO AS periodo
	, C.TIPOMEDICION AS tipomedicion
	, C.SISTEMA AS sistema
	, IIF (C.TIPOPUNTO='A','B',C.TIPOPUNTO) AS tipopunto
	, C.NROMEDICION AS nromedicion
	, C.CCT_NOMBREFUENTE AS nombrefuente
	, C.CCT_SUMIMEDIDO AS suministromedido
	, C.CCT_SUMREEMPLAZA AS suministroreemplaza
	, C.CCT_TENSION AS tension
	, C.CCT_MARCAMODELO AS marcamodelo
	, C.CCT_REGSERIE AS serie
	, C.CCT_FACTORTENSION AS factortension
	, C.CCT_FACTORCORR AS factorcorriente
	, C.CCT_INSTALACION AS fechainstalacion
	, C.CCT_FECHARETIRO AS fecharetiro
	, C.CCT_RESULTADO AS resultado
	, C.CCT_OBSERVACIONES AS observaciones
	, C.CCT_MTBT AS sedmtbt
	, C.CCT_UBICACION AS ubicacion
	, C.NOMBREPERIODO AS nombreperiodo
	, C.CCT_IDSEMESTRE AS idsemestre
	, C.ID_CABECERA AS codigo_cabecera
	, F.RangoSo AS IntervalosSobretensión
	, F.RangoSu AS IntervalosSubtensión
	, F.Criticidad as Criticidad
	, IIF(F.RangoSo IS NULL or f.rangoSo=0,iif(f.rangoSu IS NULL or f.rangosu=0,'','Subtensión'),iif(f.rangoSu IS NULL or f.rangosu=0,'Sobretensión','Sobretensión/Subtensión')) As TipoMalaCalidad
	, S.[NombreSemestre]
	, ISNULL(SS.sistemaelectrico,'-') as sistemaelectrico
	, ISNULL(ss.nomsistema,'-') as nombresistema
	, ISNULL(ss.alimentador,'-') as AlimentadorMT
	, ISNULL(SS.sectortipico,'-') as sectortipico
	, ISNULL(SS.Norma,'-') as Norma
	, ISNULL(LEFT(SS.OPCION,2),'-') as TipoUsuario
	, ISNULL(SS.OPCION,'-') as TarifaUsuario
	, ISNULL(SS.ubicacion,'-') as ubigeo
	--Datos adicionales
	, str(cast(C.year AS int)+2000,4)
		+iif( isnumeric(C.periodo)=1
			, C.periodo
			, right('00'+ltrim(str(month(C.CCT_INSTALACION),2)),2)
			)
		as PeriodoMesControl
	, str(cast(C.year AS int)+2000,4)
		+iif( isnumeric(C.periodo)=1
			, iif((cast(C.periodo as int))<7,'S1','S2')
			, iif(month(C.CCT_INSTALACION)<7,'S1','S2') ) 
		as SemestreControl
	, iif( C.CCT_INSTALACION IS NULL,'---',str(year(C.CCT_INSTALACION),4)
		+iif(month(C.CCT_INSTALACION)<7,'S1','S2')) 
		as SemestreMedido
	--nuevo campo
	, iif( C.CCT_INSTALACION IS NULL,'---',str(year(C.CCT_INSTALACION),4)
		+right('0'+ltrim(str(month(C.CCT_INSTALACION),2)),2) ) 
		as PeriodoMesMedido
	, iif(C.tipomedicion='1',C.CCT_SUMIMEDIDO, isnull(C.CCT_MTBT,C.CCT_SUMIMEDIDO) ) as ElementoMedido
	, C.CodigoIdentificador
	, C.EMP_CODEMP+C.year+C.periodo+C.tipomedicion+C.CCT_SUMIMEDIDO as CodIdentifSegSuministro -- sin C.sistema
	, C.EMP_CODEMP+C.year+C.periodo+C.tipomedicion+iif(C.tipomedicion='1',C.CCT_SUMIMEDIDO, isnull(C.CCT_MTBT,C.CCT_SUMIMEDIDO) ) as CodIdentifSegElementoMedido -- sin C.sistema
	, TipoPuntoAnterior = 
		CASE 
			WHEN C.nromedicion='0' THEN '-'
			WHEN C.nromedicion='1' THEN 'B'
			WHEN C.nromedicion<>'1' and C.tipopunto='F' THEN 'F'
			WHEN C.nromedicion<>'1' and C.tipopunto='X' THEN '?'
			ELSE '*'
		END
	, NroMedicionAnterior = 
		CASE 
			WHEN C.nromedicion='0' THEN '-'
			WHEN C.nromedicion='A' THEN '9'
			WHEN
			(ASCII(C.nromedicion)>48 and ASCII(C.nromedicion)<=57)
			or (ASCII(C.nromedicion)>65 and ASCII(C.nromedicion)<=90)
			THEN CHAR(ASCII(C.nromedicion)-1)
			ELSE '*'
		END
	, TipoPuntoSiguiente = 
		CASE 
			WHEN C.tipopunto='X' THEN 'X'
			WHEN UPPER(C.CCT_RESULTADO)='F' THEN 'F'
			ELSE '*'
		END
	, NroMedicionSiguiente = 
		CASE 
			WHEN C.nromedicion='9' THEN 'A'
			WHEN
			(ASCII(C.nromedicion)>=48 and ASCII(C.nromedicion)<57)
			or (ASCII(C.nromedicion)>=65 and ASCII(C.nromedicion)<90)
			THEN CHAR(ASCII(C.nromedicion)+1)
			ELSE '*'
		END
FROM SIR_CCT_CCT as C
LEFT JOIN CalidadGenerales.dbo.semestre as S
	ON C.CCT_IDSEMESTRE = S.CodigoSemestre
LEFT JOIN [CalidadGenerales].[dbo].[Suministros] AS SS
	ON C.EMP_CODEMP=SS.empresa AND  C.CCT_SUMIMEDIDO=SS.suministro AND (C.CCT_INSTALACION>SS.FechaDesde AND C.CCT_INSTALACION<SS.FechaHasta)
LEFT JOIN [CalidadTension].[dbo].[NormaRural_FTR] AS F
	ON C.EMP_CODEMP=F.empresa AND C.YEAR=F.year AND C.PERIODO=F.periodo AND C.TIPOPUNTO=F.tipopunto AND C.NROMEDICION=F.nromedicion
	AND C.CCT_SUMIMEDIDO=F.suministro AND C.NOMBREPERIODO=F.nombreperiodo
GO
/****** Object:  View [dbo].[NormaRural_MTR]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[NormaRural_MTR]
AS
SELECT
	M.EMP_CODEMP AS empresa
	, M.YEAR
	, M.PERIODO
	, M.TIPOMEDICION
	, M.SISTEMA
	, M.TIPOPUNTO
	, M.NROMEDICION
	, M.MTR_SUMINISTRO AS suministro
	, M.MTR_FECHACRONOGRAMA AS fechacronograma
	, M.MTR_SEDBAJA AS subestacion
	, M.MTR_CORMTR AS id
	, M.MTR_SEMESTRE AS idsemestre
	, M.NOMBREPERIODO
	, M.MTR_TIPO AS tipo
	, M.MTR_VISUALIZACION AS visualizacion
	, M.MTR_COMENTARIO AS comentario
	, M.MTR_FECHAINSTALACION AS fechainstalacion
	, M.TNS_CODIGO AS idsorteo
	, M.MTR_SUMINISTROCOL AS suministrocola
	, M.MTR_SUMINORIGCAB AS suminoriginalcab
	, M.MTR_SUMINORIGCOL AS suminoriginalcol
	, M.MTR_HAYFUENTECAB AS hayfuentecab
	, M.MTR_HAYFUENTECOLA AS hayfuentecola
	, M.MTR_FECHAENVIO AS fechaenvio
	, M.ID_CABECERA AS codigo_cabecera
	, S.NombreSemestre
	, SS.sistemaelectrico
	, SS.sectortipico
	, SS.Norma
	, SS.TipoClienteTension as TipoUsuario
	, SS.opcion as TarifaUsuario
	, SS.ubicacion as ubigeo
	--Datos adicionales
	, str(M.year+2000,4)+iif( isnumeric(M.periodo)=1, M.periodo, right('00'+ltrim(str(month(M.MTR_FECHACRONOGRAMA),2 )),2) )
		as PeriodoMesControl
	, str(M.year+2000,4)
		+iif( isnumeric(M.periodo)=1
			, iif((cast(M.periodo as int))<7,'S1','S2')
			, iif(month(M.MTR_FECHACRONOGRAMA)<7,'S1','S2') ) 
		as SemestreControl
	, iif(M.MTR_FECHACRONOGRAMA IS NULL,'---',str(year(M.MTR_FECHACRONOGRAMA),4)
		+iif(month(M.MTR_FECHACRONOGRAMA)<7,'S1','S2')) 
		as SemestreMedido
	--nuevo campo
	, iif(M.MTR_FECHACRONOGRAMA IS NULL,'---',str(year(M.MTR_FECHACRONOGRAMA),4)
		+right('0'+ltrim(str(month(M.MTR_FECHACRONOGRAMA),2)),2) ) 
		as PeriodoMesMedido
	, iif(M.tipomedicion='1',M.MTR_SUMINISTRO, isnull(M.MTR_SEDBAJA,M.MTR_SUMINISTRO) ) as ElementoMedido
	--, M.EMP_CODEMP+str(M.year,2)+M.periodo+M.tipomedicion+M.sistema+M.tipopunto+M.nromedicion as 
	, M.CodigoIdentificador
	, M.EMP_CODEMP+str(M.year,2)+M.periodo+M.tipomedicion+M.MTR_SUMINISTRO as CodIdentifSegSumCabecera --sin campo M.sistema
	, M.EMP_CODEMP+str(M.year,2)+M.periodo+M.tipomedicion+M.MTR_SUMINISTROCOL as CodIdentifSegSumCola --sin campo M.sistema
	, M.EMP_CODEMP+str(M.year,2)+M.periodo+M.tipomedicion
		+iif(M.tipomedicion='1',M.MTR_SUMINISTRO, isnull(M.MTR_SEDBAJA,M.MTR_SUMINISTRO) ) as CodIdentifSegElementoMedido --sin campo M.sistema
	, iif( ((M.MTR_FECHAINSTALACION is null) or (M.MTR_FECHAINSTALACION=0)) or ((M.MTR_HAYFUENTECAB is null) or M.MTR_HAYFUENTECAB='')
		,0,1) as CumpleMedicionCabecera
	, iif( ((M.MTR_FECHAINSTALACION is null) or (M.MTR_FECHAINSTALACION=0)) or ((M.MTR_HAYFUENTECOLA is null) or M.MTR_HAYFUENTECOLA='')
		,0,1) as CumpleMedicionCola
	, TipoPuntoAnterior = 
		CASE 
			WHEN M.nromedicion='0' THEN '-'
			WHEN M.nromedicion='1' THEN 'B'
			WHEN M.nromedicion<>'1' and M.tipopunto='F' THEN 'F'
			WHEN M.nromedicion<>'1' and M.tipopunto='X' THEN '?'
			ELSE '*'
		END
	, NroMedicionAnterior = 
		CASE 
			WHEN M.nromedicion='0' THEN '-'
			WHEN M.nromedicion='A' THEN '9'
			WHEN
			(ASCII(M.nromedicion)>48 and ASCII(M.nromedicion)<=57)
			or (ASCII(M.nromedicion)>65 and ASCII(M.nromedicion)<=90)
			THEN CHAR(ASCII(M.nromedicion)-1)
			ELSE '*'
		END
	, TipoPuntoSiguiente = 
		CASE 
			WHEN M.tipopunto='X' THEN 'X'
			WHEN M.tipopunto<>'B' and M.tipopunto='F' THEN '?'
			ELSE '*'
		END
	, NroMedicionSiguiente = 
		CASE 
			WHEN M.nromedicion='9' THEN 'A'
			WHEN
			(ASCII(M.nromedicion)>=48 and ASCII(M.nromedicion)<57)
			or (ASCII(M.nromedicion)>=65 and ASCII(M.nromedicion)<90)
			THEN CHAR(ASCII(M.nromedicion)+1)
			ELSE '*'
		END
/*	, C.CCT_RESULTADO
	, C.CCT_INSTALACION as CCT_FECHAINSTALACION
	, C.CCT_FECHARETIRO
	, C.CCT_MARCAMODELO
	, C.CCT_REGSERIE
	, C.CCT_NOMBREFUENTE
	, C.CCT_UBICACION
	, C.CCT_MTBT AS CCT_SEDMTBT
	, iif(C.tipomedicion='1',C.CCT_SUMIMEDIDO, isnull(C.CCT_MTBT,C.CCT_SUMIMEDIDO) ) as CCT_ElementoMedido
	*/
	, C.RESULTADO CCT_RESULTADO
	, C.FECHAINSTALACION CCT_FECHAINSTALACION
	, C.FECHARETIRO CCT_FECHARETIRO
	, C.MARCAMODELO CCT_MARCAMODELO
	, C.SERIE CCT_REGSERIE
	, C.NOMBREFUENTE CCT_NOMBREFUENTE
	, C.UBICACION CCT_UBICACION
	, C.SEDMTBT CCT_SEDMTBT
	, C.tension CCT_NivelTension
	, c.ElementoMedido AS CCT_ElementoMedido
	, C.TipoMalaCalidad as CCT_TipoMalaCalidad
	, C.IntervalosSobretensión as CCT_IntervalosSobretensión
	, C.IntervalosSubtensión as CCT_IntervalosSubtensión
FROM dbo.SIR_MTR_MTR as M
LEFT OUTER JOIN CalidadGenerales.dbo.Semestre as S
	ON M.MTR_SEMESTRE = S.CodigoSemestre
--LEFT JOIN [CalidadGenerales].[dbo].[SUMINBT] AS BT
--	ON M.EMP_CODEMP=BT.empresa AND MTR_SEMESTRE=BT.semestre AND M.MTR_SUMINISTRO=BT.suministro
--LEFT JOIN [CalidadGenerales].[dbo].[SUMINMT] AS MT
--	ON M.EMP_CODEMP=MT.EMPRESA AND MTR_SEMESTRE=MT.SEMESTRE AND M.MTR_SUMINISTRO=MT.SUMINISTRO
left join CalidadGenerales.dbo.Suministros as SS on M.EMP_CODEMP=SS.empresa and M.MTR_SUMINISTRO=SS.suministro
	and ( (SS.FechaDesde<=M.MTR_FECHACRONOGRAMA) and (M.MTR_FECHACRONOGRAMA <SS.FechaHasta) )
left join dbo.NormaRural_CCT as C on M.CodigoIdentificador=C.CodigoIdentificador and M.MTR_SUMINISTRO=C.suministromedido
--where M.EMP_CODEMP='ELS' AND M.MTR_SEMESTRE=451
GO
/****** Object:  Table [dbo].[SRV_CCT]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_CCT](
	[NUMEROSECUENCIAL] [int] NULL,
	[EMPRESA] [varchar](3) NULL,
	[ANIO] [varchar](2) NULL,
	[PERIODO] [varchar](2) NULL,
	[TIPOMEDICION] [varchar](1) NULL,
	[LOCALIDAD] [varchar](4) NULL,
	[TIPOPUNTO] [varchar](1) NULL,
	[NROMEDICION] [varchar](1) NULL,
	[NOMBREARCHIVOFUENTE] [varchar](25) NULL,
	[NUMSUMINISTRO] [varchar](10) NULL,
	[TIPOALIMENTACION] [varchar](2) NULL,
	[NUMSUMINALTERNA] [varchar](10) NULL,
	[PARAMETROMEDIDO] [varchar](2) NULL,
	[TENSIONSUMIN] [int] NULL,
	[MARCAMODELO] [varchar](25) NULL,
	[NUMSERIEEQP] [varchar](15) NULL,
	[FACTORCORRECCIONTENSION] [decimal](10, 3) NULL,
	[FACTORCORRECCIONCORRIENTE] [decimal](10, 3) NULL,
	[FECHAINSTALEQP] [datetime] NULL,
	[FECHARETIROEQP] [datetime] NULL,
	[RESULTMED] [varchar](1) NULL,
	[PRESENCIAFLICKER] [varchar](2) NULL,
	[PRESENCIAARMONICA] [varchar](2) NULL,
	[OBSERVACIONES] [varchar](60) NULL,
	[NOMBREPERIODO] [varchar](10) NULL,
	[SEMESTRE] [int] NULL,
	[ID_CABECERA] [int] NULL,
	[CodigoIdentificador]  AS (((((([EMPRESA]+[ANIO])+[PERIODO])+[TIPOMEDICION])+[LOCALIDAD])+[TIPOPUNTO])+[NROMEDICION]),
	[FechaPeriodo]  AS ([dbo].[GetFechaInicioPeriodo]([NOMBREPERIODO]))
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SRV_MTE]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_MTE](
	[EMPRESA] [varchar](3) NULL,
	[ANIO] [varchar](2) NULL,
	[PERIODO] [varchar](2) NULL,
	[TIPOMEDICION] [varchar](1) NULL,
	[LOCALIDAD] [varchar](4) NULL,
	[TIPOPUNTO] [varchar](1) NULL,
	[NROMEDICION] [varchar](1) NULL,
	[SUMINISTRO] [varchar](10) NULL,
	[FECHACRONOGRAMA] [datetime] NULL,
	[TIPOTRABAJO] [varchar](2) NULL,
	[TIPO] [varchar](10) NULL,
	[ID] [int] NULL,
	[FECHAENVIO] [datetime] NULL,
	[COMENTARIO] [varchar](100) NULL,
	[FECHAINSTALACION] [datetime] NULL,
	[FECHAVISUALIZACION] [datetime] NULL,
	[NOMBREPERIODO] [varchar](10) NULL,
	[SEMESTRE] [int] NULL,
	[SINFUENTE] [varchar](1) NULL,
	[ID_CABECERA] [int] NULL,
	[SUMINORIG] [varchar](10) NULL,
	[CodigoIdentificador]  AS (((((([EMPRESA]+[ANIO])+[PERIODO])+[TIPOMEDICION])+[LOCALIDAD])+[TIPOPUNTO])+[NROMEDICION]),
	[FechaPeriodo]  AS ([dbo].[GetFechaInicioPeriodo]([NOMBREPERIODO]))
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[CCT]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[CCT] AS
SELECT --top 10 
	C.NUMEROSECUENCIAL AS numerosecuencial
	, C.EMPRESA AS empresa
	, C.ANIO AS anio
	, C.PERIODO AS periodo
	, C.TIPOMEDICION AS tipomedicion
	, C.LOCALIDAD AS localidad
	, C.TIPOPUNTO AS tipopunto
	, C.NROMEDICION AS nromedicion
	, C.NOMBREARCHIVOFUENTE AS nombrearchivofuente
	, C.NUMSUMINISTRO AS numsuministro
	, C.TIPOALIMENTACION AS tipoalimentacion
	, C.NUMSUMINALTERNA AS numsuminalterna
	, C.PARAMETROMEDIDO AS parametromedido
	, C.TENSIONSUMIN AS tensionsumin
	, C.MARCAMODELO AS marcamodelo
	, C.NUMSERIEEQP AS numserieeqp
	, C.FACTORCORRECCIONTENSION AS factorcorrecciontension
	, C.FACTORCORRECCIONCORRIENTE AS factorcorreccioncorriente
	, C.FECHAINSTALEQP AS fechainstaleqp
	, C.FECHARETIROEQP AS fecharetiroeqp
	, C.RESULTMED AS resultmed
	, C.PRESENCIAFLICKER AS presenciaflicker
	, C.PRESENCIAARMONICA AS presenciaarmonica
	, C.OBSERVACIONES AS observaciones
	, C.NOMBREPERIODO AS nombreperiodo
	, C.SEMESTRE AS semestre
	, C.ID_CABECERA AS codigo_cabecera
	, C.FechaPeriodo
	, C.CodigoIdentificador
	, M.[FECHACRONOGRAMA]
	, M.fechainstalacion as FechaDeclaracion
	, M.fechaenvio as FechaEnvioFuente
	, S.NombreSemestre
	, isnull(F.rango1,0) as 'R1',isnull(F.rango2,0) as 'R2' ,isnull(F.rango3,0) as  'R3' ,isnull(F.rango4,0) as  'R4'
	, isnull(F.rango5,0) as 'R5',isnull(F.rango6,0) as 'R6' ,isnull(F.rango7,0) as  'R7' ,isnull(F.rango8,0) as  'R8'
	, isnull(F.rango9,0) as 'R9',isnull(F.rango10,0) as'R10',isnull(F.rango11,0) as 'R11',isnull(F.rango12,0) as 'R12'
	, IIF(F.RangoSO+RangoSU>33,'SI','NO') AS MalaCalidad 
	, iif(f.rango1 is null,'',IIF(F.RANGOSO>33,IIF(F.RANGOSU>33,'SOBRETENSIÓN/SUBTENSIÓN','SOBRETENSIÓN'),IIF(F.RANGOSU>33,'SUBTENSIÓN',IIF(F.RANGOSO>RANGOSU,'SOBRETENSIÓN','SUBTENSIÓN')))) as TipoMCT
	, iif(f.rango1 is null,'',IIF(F.RANGOSOCRI+RANGOSUCRI>33,'SUPERIOR A 7,5% VN','INFERIOR A 7,5% VN')) AS CriticidadMCT
	, E.nombre AS NombreEmpresa
--	, L.nombrelocalidad, L.sistemaelectrico, L.nomsistema, L.sectortipico, L.Norma
	, SS.nombrelocalidad, SS.sistemaelectrico, SS.nomsistema, SS.sectortipico, SS.Norma
	, SS.subestacion as SED_SIRVAN
	, SS.codsubestacion as SED_VNR
	, SS.alimentador as AlimentadorMT
	, SS.UTMSedEste as UTM_SED_ESTE
	, SS.UTMSedNorte as UTM_SED_NORTE
	, SS.UbigeoSED as UbicacionSED
	, iif(c.tipopunto in ('B','A','F'),CONCAT('20',C.ANIO,IIF(c.PERIODO IN ('01','02','03','04','05','06'),'S1','S2')),'') AS CampañaMedicion
	, CONCAT(left(c.nombreperiodo,4),IIF(right(c.periodo,2) IN ('01','02','03','04','05','06'),'S1','S2')) AS SemestreMedido
FROM SRV_CCT AS C
	left join [CalidadGenerales].[dbo].[Semestre] as S on C.SEMESTRE=S.CodigoSemestre
	left join [CalidadGenerales].[dbo].[Empresa] as E on C.EMPRESA=E.codigo
--	left join [CalidadGenerales].[dbo].[LOCALI] as L on C.EMPRESA=L.empresa and C.SEMESTRE=L.semestre and C.LOCALIDAD=L.localidad
	left join [CalidadTension].[dbo].[SRV_MTE] as M on C.CodigoIdentificador=M.CodigoIdentificador AND C.NOMBREPERIODO=M.nombreperiodo AND C.NUMSUMINISTRO=M.suministro
	left join [CalidadTension].[dbo].[FTE] as F on C.CodigoIdentificador=F.CodigoIdentificador AND C.NOMBREPERIODO=F.nombreperiodo AND C.NUMSUMINISTRO=F.suministro
	left join CalidadGenerales.dbo.Suministros as SS on C.EMPRESA=SS.empresa AND C.NUMSUMINISTRO=SS.suministro and ( (SS.FechaDesde<=C.FechaPeriodo) and (C.FechaPeriodo<SS.FechaHasta) )

/*	left join [CalidadGenerales].[dbo].[SUMINBT] as BT1 on C.EMPRESA=BT1.empresa AND C.NUMSUMINISTRO=BT1.suministro AND C.SEMESTRE=BT1.semestre
	left join [CalidadGenerales].[dbo].[SUMINBT] as BT2 on C.EMPRESA=BT2.empresa AND C.NUMSUMINISTRO=BT2.suministro AND C.SEMESTRE+1=BT2.semestre
	left join [CalidadGenerales].[dbo].[SUMINMT] as MT1 on C.EMPRESA=MT1.empresa AND C.NUMSUMINISTRO=MT1.suministro AND C.SEMESTRE=MT1.semestre
	left join [CalidadGenerales].[dbo].[SUMINMT] as MT2 on C.EMPRESA=MT2.empresa AND C.NUMSUMINISTRO=MT2.suministro AND C.SEMESTRE+1=MT2.semestre
*/
--WHERE C.EMPRESA='ELS' and C.NOMBREPERIODO='201812'
GO
/****** Object:  View [dbo].[MTE]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[MTE] AS 
SELECT
	 --SELECT TOP 100
	M.EMPRESA AS empresa
	, M.ANIO AS anio
	, M.PERIODO AS periodo
	, M.TIPOMEDICION AS tipomedicion
	, M.LOCALIDAD AS localidad
	, M.TIPOPUNTO AS tipopunto
	, M.NROMEDICION AS nromedicion
	, M.SUMINISTRO AS suministro
	, M.FECHACRONOGRAMA AS fechacron
	, M.TIPOTRABAJO AS tipotrabajo
	, M.TIPO AS extension
	, M.ID AS id
	, M.FECHAENVIO AS fechaenvio
	, M.COMENTARIO AS comentario
	, M.FECHAINSTALACION AS fechainstalacion
	, M.FECHAVISUALIZACION AS fechavisualizacion
	, M.NOMBREPERIODO AS nombreperiodo
	, M.SEMESTRE AS semestre
	, M.SINFUENTE AS hayfuente
	, M.ID_CABECERA AS codigo_cabecera
	, M.SUMINORIG AS suminoriginal
	, M.CodigoIdentificador
	, M.FechaPeriodo
	, IIF(M.TIPOMEDICION='1','MT','BT') AS [Nivel Tensión]
	, IIF(  (M.SINFUENTE='N' OR M.SINFUENTE='S') AND (M.FECHAENVIO<>'1900-01-01 00:00:00' OR M.FECHAENVIO IS NOT NULL)  ,1,0) AS [Cumple Envío o Declaración Archivo Fuente] 
	, C.fechainstaleqp, C.fecharetiroeqp
	, C.resultmed
	, IIF(C.resultmed IS NOT NULL,1,0) AS [Cumple Reporte Resultado en CCT]
	, C.MalaCalidad, C.TipoMCT
	, S.NombreSemestre
	, E.nombre AS NombreEmpresa, E.actividad
	, SS.nombrelocalidad, SS.sistemaelectrico, SS.nomsistema, SS.sectortipico, SS.Norma
	, iif(M.FECHACRONOGRAMA IS NULL,'---',str(year(M.FECHACRONOGRAMA),4)+iif(month(M.FECHACRONOGRAMA)<7,'S1','S2')) as SemestreMedido
	, SS.identificacion
	, SS.direccion
	, SS.subestacion
	, SS.ubicacion
	, SS.marca
	, SS.modelo
	, SS.medidor
	, SS.serie
	, SS.DistritoNombre as  NombreDistrito
	, U.PerteneceNombre as Provincia
	, SS.DeptNombre as Departamento
FROM SRV_MTE AS M
	left join [CalidadGenerales].[dbo].[Semestre] as S on M.SEMESTRE=S.CodigoSemestre
	left join [CalidadGenerales].[dbo].[Empresa] as E on M.EMPRESA=E.codigo
	left join CalidadGenerales.dbo.Suministros as SS on M.empresa=SS.empresa and M.suministro=SS.suministro
		and ( (SS.FechaDesde<=M.FECHACRONOGRAMA) and (M.FECHACRONOGRAMA	<SS.FechaHasta) )
	left join [CalidadGenerales].[dbo].UBIGEO as U on SS.ubicacion=U.Ubigeo
	left join [CalidadTension].[dbo].[CCT] as C on M.CodigoIdentificador=C.CodigoIdentificador and M.suministro=C.numsuministro
--	WHERE M.empresa='ELS' and m.SEMESTRE=451 --and M.suministro='319025065' --AND S.NombreSemestre='2019S1'
		--and ( (SS.FechaDesde<=CalidadGenerales.dbo.getfechaInicioPeriodo(M.NOMBREPERIODO)) and (CalidadGenerales.dbo.getfechaInicioPeriodo(M.NOMBREPERIODO)<SS.FechaHasta) )
--	ORDER BY M.TIPOMEDICION, M.suministro, SS.FechaDesde
GO
/****** Object:  Table [dbo].[SIR_CTR_CTR]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SIR_CTR_CTR](
	[EMPRESA] [varchar](3) NOT NULL,
	[YEAR] [varchar](2) NOT NULL,
	[PERIODO] [varchar](2) NOT NULL,
	[TIPOMEDICION] [varchar](1) NOT NULL,
	[SISTEMA] [varchar](4) NOT NULL,
	[TIPOPUNTO] [varchar](1) NOT NULL,
	[NROMEDICION] [varchar](1) NOT NULL,
	[CTR_SUMINISTROMEDIDO1] [varchar](10) NOT NULL,
	[CTR_SUMINISTROMEDIDO2] [varchar](10) NULL,
	[CTR_ENERGIASUMINISTRADA] [decimal](13, 3) NULL,
	[CTR_SUMATORIAVALORES] [decimal](12, 2) NULL,
	[CTR_MONTOCOMPENSACION] [decimal](11, 4) NULL,
	[CTR_ANO] [varchar](4) NULL,
	[CTR_SEMESTRE] [varchar](2) NULL,
	[CTR_ALIMENTADORSOT] [decimal](5, 2) NULL,
	[CTR_ALIMENTADORSUT] [decimal](5, 2) NULL,
	[CTR_SUMATORIAAPTRAMOINICIAL] [decimal](12, 2) NULL,
	[CTR_SUMATORIAAPDISMINUIR] [decimal](12, 2) NULL,
	[CTR_SUMATORIAAPTRAMOFINAL] [decimal](12, 2) NULL,
	[CTR_SUMATORIAAPAUMENTAR] [decimal](12, 2) NULL,
	[NOMBREPERIODO] [varchar](10) NOT NULL,
	[CTR_IDSEMESTRE] [int] NOT NULL,
	[ID_CABECERA] [int] NOT NULL,
	[FechaPeriodoReportado]  AS ([dbo].[GetFechaInicioPeriodo]([NOMBREPERIODO])),
	[FechaPeriodoMesControl]  AS ([dbo].[GetFechaInicioPeriodo](str(CONVERT([int],[year])+(2000),(4))+case when isnumeric([periodo])=(1) then [periodo] else 'XX' end))
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[NormaRural_CTR]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[NormaRural_CTR]
AS
SELECT
--top 100
	T.EMPRESA AS empresa
	, T.YEAR AS year
	, T.PERIODO AS periodo
	, T.TIPOMEDICION AS tipomedicion
	, T.SISTEMA AS sistema
	, T.TIPOPUNTO AS tipopunto
	, T.NROMEDICION AS nromedicion
	, T.CTR_SUMINISTROMEDIDO1 AS suministromedido1
	, T.CTR_SUMINISTROMEDIDO2 AS suministromedido2
	, T.CTR_ENERGIASUMINISTRADA AS energiasuministrada
	, T.CTR_SUMATORIAVALORES AS sumatoriavalores
	, T.CTR_MONTOCOMPENSACION AS montocompensacion
	, T.CTR_ANO AS ano
	, T.CTR_SEMESTRE AS semestre
	, T.CTR_ALIMENTADORSOT AS alimentadorsot
	, T.CTR_ALIMENTADORSUT AS alimentadorsut
	, T.CTR_SUMATORIAAPTRAMOINICIAL AS sumatoriaaptramoinicial
	, T.CTR_SUMATORIAAPDISMINUIR AS sumatoriaapdisminuir
	, T.CTR_SUMATORIAAPTRAMOFINAL AS sumatoriaaptramofinal
	, T.CTR_SUMATORIAAPAUMENTAR AS sumatoriaapaumentar
	, T.NOMBREPERIODO AS nombreperiodo
	, T.CTR_IDSEMESTRE AS idsemestre
	, T.ID_CABECERA AS codigo_cabecera
	, T.FechaPeriodoReportado
	, T.FechaPeriodoMesControl
	--Adicionales
	, str(cast(T.year AS int)+2000,4)	+iif( isnumeric(T.periodo)=1, T.periodo, 'XX' ) as PeriodoMesControl
	, str(cast(T.year AS int)+2000,4)+iif( isnumeric(T.periodo)=1, iif((cast(T.periodo as int))<7,'S1','S2'), 'XX' ) as SemestreControl
	, T.empresa+T.year+T.periodo+T.tipomedicion+T.sistema+T.tipopunto+T.nromedicion as CodigoIdentificador
	, T.empresa+T.year+T.periodo+T.tipomedicion+T.CTR_SUMINISTROMEDIDO1 as CodIdentifSegSumCabecera -- sin +sistema
	, T.empresa+T.year+T.periodo+T.tipomedicion+T.CTR_SUMINISTROMEDIDO2 as CodIdentifSegSumCola -- sin +sistema
	, T.CTR_ANO+T.CTR_SEMESTRE as SemestrePago
	--Otras tablas Datos del Anexo 1
	--Datos del semestre en que se midió
	, S.sectortipico as SectorTipicoCodIdentif
	, SI.sectortipico as Sum1SectorTipico
	, SI.subestacion as Sum1Subestacion
	, SI.sistemaelectrico as Sum1SistemaElectrico
	--Datos del semestre en que se reporto (actual)
	, SS.sectortipico as Sum1SectorTipicoAct
	, SS.subestacion as Sum1SubestacionAct
	, SS.sistemaelectrico as Sum1SistemaElectricoAct
	, iif(T.TIPOMEDICION='1',T.CTR_SUMINISTROMEDIDO1, isnull(SI.subestacion,T.CTR_SUMINISTROMEDIDO1) ) as ElementoMedido
FROM SIR_CTR_CTR AS T
LEFT JOIN [CalidadGenerales].[dbo].[SISTEMAS] as S
	ON T.EMPRESA = S.empresa and T.SISTEMA = S.sistema and str(cast(T.year AS int)+2000,4)+iif( isnumeric(T.periodo)=1, iif((cast(T.periodo as int))<7,'S1','S2'), 'XX' )=S.NombreSemestre
left join CalidadGenerales.dbo.Suministros as SI
	on T.empresa=SI.empresa and T.CTR_SUMINISTROMEDIDO1=SI.suministro and ( (SI.FechaDesde<=T.FechaPeriodoMesControl) and (T.FechaPeriodoMesControl<SI.FechaHasta) )
left join CalidadGenerales.dbo.Suministros as SS
	on T.empresa=SS.empresa and T.CTR_SUMINISTROMEDIDO1=SS.suministro and ( (SS.FechaDesde<=T.FechaPeriodoReportado) and (T.FechaPeriodoReportado<SS.FechaHasta) )
--where T.CTR_IDSEMESTRE=450 and T.EMPRESA='ELS'
GO
/****** Object:  Table [dbo].[SRV_TENRURAL_SED]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_TENRURAL_SED](
	[TRC_CORTRC] [int] NULL,
	[EMPRESA] [varchar](3) NULL,
	[SEMESTRE] [int] NULL,
	[LOCALIDAD] [varchar](4) NULL,
	[SUCURSAL] [varchar](4) NULL,
	[SUBESTACION] [varchar](7) NULL,
	[NOMBRE_SUBESTACION] [varchar](35) NULL,
	[DIRECCION] [varchar](30) NULL,
	[UBICACION] [varchar](6) NULL,
	[TENSION_BAJA] [decimal](5, 2) NULL,
	[TENSION_MT] [decimal](5, 2) NULL,
	[CAPACIDAD_TRANSFORMACION] [decimal](6, 2) NULL,
	[UTM_NORTE] [decimal](11, 3) NULL,
	[UTM_ESTE] [decimal](11, 3) NULL,
	[SECCION_LINEA] [varchar](7) NULL,
	[ID_CABECERA] [int] NULL,
	[TRX_NUMMES] [int] NULL,
	[SED_FECHAMTR] [datetime] NULL,
	[SED_IDMTR] [int] NULL,
	[SISTEMA] [varchar](10) NULL,
	[NOMSISTEMA] [varchar](20) NULL,
	[USUARIO_CREACION] [varchar](38) NULL,
	[TERMINAL_CREACION] [varchar](38) NULL,
	[FECHA_CREACION] [datetime] NULL,
	[USUARIO_ACTUALIZACION] [varchar](38) NULL,
	[TERMINAL_ACTUALIZACION] [varchar](38) NULL,
	[FECHA_ACTUALIZACION] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SRV_TENRURAL_SED_MEDIDOS]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_TENRURAL_SED_MEDIDOS](
	[NombreSemestre] [varchar](6) NULL,
	[Empresa] [varchar](3) NOT NULL,
	[SEDsMTBT] [varchar](7) NULL,
	[CantVecesProgramadoMTR] [int] NULL,
	[CantVecesReporteCCR] [int] NULL,
	[CantVecesReporteCTR] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SRV_TENRURAL_SED_MEDIDOS_EXCLUSIONES]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_TENRURAL_SED_MEDIDOS_EXCLUSIONES](
	[Anexo1_CodSemestre] [int] NOT NULL,
	[Anexo1_NombreSemestre] [varchar](6) NULL,
	[Anexo1_Empresa] [varchar](3) NOT NULL,
	[Anexo1_SEDMTBT] [varchar](7) NOT NULL,
	[FueProgramadoMedido] [int] NOT NULL,
	[Empresa] [varchar](3) NULL,
	[SEDsMTBT] [varchar](7) NULL,
	[CantVecesProgramadoMTR] [int] NULL,
	[CantVecesReporteCCR] [int] NULL,
	[CantVecesReporteCTR] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SRV_TENRURALCAB_TRC]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_TENRURALCAB_TRC](
	[TRC_CORTRC] [int] NOT NULL,
	[SEMESTRE] [int] NOT NULL,
	[EMPRESA] [varchar](3) NULL,
	[ACTIVO] [varchar](1) NULL,
	[TRC_SEDSAMEDIR] [int] NULL,
	[TRC_MTAMEDIR] [int] NULL,
	[USUARIO_CREACION] [varchar](38) NULL,
	[TERMINAL_CREACION] [varchar](38) NULL,
	[FECHA_CREACION] [datetime] NULL,
	[USUARIO_ACTUALIZACION] [varchar](38) NULL,
	[TERMINAL_ACTUALIZACION] [varchar](38) NULL,
	[FECHA_ACTUALIZACION] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SRV_TENSION_SUMINMT]    Script Date: 03/07/2020 1:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_TENSION_SUMINMT](
	[TRC_CORTRC] [int] NULL,
	[EMPRESA] [varchar](3) NULL,
	[SEMESTRE] [int] NULL,
	[LOCALIDAD] [varchar](4) NULL,
	[IDENTIFICACION] [varchar](35) NULL,
	[DIRECCION] [varchar](30) NULL,
	[UBICACION] [varchar](6) NULL,
	[TELEFONO] [varchar](9) NULL,
	[SUMINISTRO] [varchar](10) NULL,
	[OPCION] [varchar](5) NULL,
	[MARCA] [varchar](3) NULL,
	[MODELO] [varchar](17) NULL,
	[SERIE] [varchar](10) NULL,
	[ANIO] [varchar](4) NULL,
	[POTENCIA] [decimal](10, 2) NULL,
	[TENSION] [decimal](4, 2) NULL,
	[SETCODE] [varchar](7) NULL,
	[ALIMENTADOR] [varchar](7) NULL,
	[PUNTOCONEXION] [varchar](16) NULL,
	[CODIGO_SUBESTACION] [varchar](16) NULL,
	[CODIGO_SUMINISTRO] [varchar](16) NULL,
	[ETIQUETA] [varchar](16) NULL,
	[TIPO_SUMINISTRO] [varchar](1) NULL,
	[MEDIDOR] [varchar](1) NULL,
	[NOMINAL] [varchar](6) NULL,
	[MAXIMA] [varchar](6) NULL,
	[CLASES] [varchar](4) NULL,
	[FECHA_AFERICION] [datetime] NULL,
	[FECHA_CONSTRASTACION] [datetime] NULL,
	[ID_CABECERA] [int] NULL,
	[XRM_NUMMES] [int] NULL,
	[XRM_FECHAMTR] [datetime] NULL,
	[XRM_IDMTR] [int] NULL,
	[USUARIO_CREACION] [varchar](38) NULL,
	[TERMINAL_CREACION] [varchar](38) NULL,
	[FECHA_CREACION] [datetime] NULL,
	[USUARIO_ACTUALIZACION] [varchar](38) NULL,
	[TERMINAL_ACTUALIZACION] [varchar](38) NULL,
	[FECHA_ACTUALIZACION] [datetime] NULL
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' ID interno, para referencia en otras tablas.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CCT_CCT', @level2type=N'COLUMN',@level2name=N'CCT_CODCCT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Identificación de la empresa suministradora.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CCT_CCT', @level2type=N'COLUMN',@level2name=N'EMP_CODEMP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Los dos últimos dígitos del año. 10 = 2010, 11=2011, etc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CCT_CCT', @level2type=N'COLUMN',@level2name=N'YEAR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Dos dígitos si es un mes, 01=enero, 02=febrero, o para los semestres' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CCT_CCT', @level2type=N'COLUMN',@level2name=N'PERIODO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Identificación del tipo de medición' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CCT_CCT', @level2type=N'COLUMN',@level2name=N'TIPOMEDICION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El código del sistema eléctrico, según se ha definido en el anexo1 del semestre correspondiente.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CCT_CCT', @level2type=N'COLUMN',@level2name=N'SISTEMA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Tipo de punto de medición, B=básico o seleccionado, R=reclamo, F=repetición de medición fallida, O=Solicitado por Osinergmin, X=remedición.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CCT_CCT', @level2type=N'COLUMN',@level2name=N'TIPOPUNTO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Número de medición. 0=1era. medición, 1,2,3..9,A,B,C...Z para sucesivas en el mismo punto hasta que la calidad sea aceptable.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CCT_CCT', @level2type=N'COLUMN',@level2name=N'NROMEDICION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Nombre del archivo Fuente.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CCT_CCT', @level2type=N'COLUMN',@level2name=N'CCT_NOMBREFUENTE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Número de suministro Medido.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CCT_CCT', @level2type=N'COLUMN',@level2name=N'CCT_SUMIMEDIDO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Suministro al que reemplaza. Sólo para casos de mediciones en BT en punto alternativo.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CCT_CCT', @level2type=N'COLUMN',@level2name=N'CCT_SUMREEMPLAZA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Tensión del suminsitro en Voltios.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CCT_CCT', @level2type=N'COLUMN',@level2name=N'CCT_TENSION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Marca y modelo del equipo registrador' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CCT_CCT', @level2type=N'COLUMN',@level2name=N'CCT_MARCAMODELO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Número de serie del equipo registrador.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CCT_CCT', @level2type=N'COLUMN',@level2name=N'CCT_REGSERIE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Factor de corrección TENSIÓN' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CCT_CCT', @level2type=N'COLUMN',@level2name=N'CCT_FACTORTENSION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Factor de corrección CORRIENTE.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CCT_CCT', @level2type=N'COLUMN',@level2name=N'CCT_FACTORCORR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Fecha de instalación del equipo.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CCT_CCT', @level2type=N'COLUMN',@level2name=N'CCT_INSTALACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Fecha de retiro del  equipo registrador.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CCT_CCT', @level2type=N'COLUMN',@level2name=N'CCT_FECHARETIRO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Resultado de la medición  V=válida, F=fallida.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CCT_CCT', @level2type=N'COLUMN',@level2name=N'CCT_RESULTADO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Observaciones de instalación/retiro.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CCT_CCT', @level2type=N'COLUMN',@level2name=N'CCT_OBSERVACIONES'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' SED MT/BT a la que pertenece sl suministro BT. Sólo cuando se realice mediciones en BT.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CCT_CCT', @level2type=N'COLUMN',@level2name=N'CCT_MTBT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Ubicación del suministro BT en la SED MT/BT. i=tramo inicial f=tramo final de la SED MT/BT.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CCT_CCT', @level2type=N'COLUMN',@level2name=N'CCT_UBICACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del Periodo.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CCT_CCT', @level2type=N'COLUMN',@level2name=N'NOMBREPERIODO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID para referencia con otras tablas.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CCT_CCT', @level2type=N'COLUMN',@level2name=N'CCT_IDSEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CCT_CCT', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identificación de la empresa suministradora.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CTR_CTR', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Los dos últimos dígitos del año. 10 = 2010, 11=2011, etc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CTR_CTR', @level2type=N'COLUMN',@level2name=N'YEAR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Dos dígitos según orden del mes' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CTR_CTR', @level2type=N'COLUMN',@level2name=N'PERIODO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identificación del tipo de medición (un ALFANUMÉRICO).' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CTR_CTR', @level2type=N'COLUMN',@level2name=N'TIPOMEDICION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El código del sistema eléctrico, según se ha definido en el anexo1 del semestre correspondiente.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CTR_CTR', @level2type=N'COLUMN',@level2name=N'SISTEMA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tipo punto de medición.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CTR_CTR', @level2type=N'COLUMN',@level2name=N'TIPOPUNTO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 para primera medición.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CTR_CTR', @level2type=N'COLUMN',@level2name=N'NROMEDICION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Número del suministro medido 1.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CTR_CTR', @level2type=N'COLUMN',@level2name=N'CTR_SUMINISTROMEDIDO1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Número del suministro medido 2.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CTR_CTR', @level2type=N'COLUMN',@level2name=N'CTR_SUMINISTROMEDIDO2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'La energia correpende al mes por el cual se compensa.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CTR_CTR', @level2type=N'COLUMN',@level2name=N'CTR_ENERGIASUMINISTRADA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sumatoria de todos los valores de AP.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CTR_CTR', @level2type=N'COLUMN',@level2name=N'CTR_SUMATORIAVALORES'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Monto de Compensación en dolares.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CTR_CTR', @level2type=N'COLUMN',@level2name=N'CTR_MONTOCOMPENSACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Anio al que corresponde la compensación.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CTR_CTR', @level2type=N'COLUMN',@level2name=N'CTR_ANO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Semestre al que corresponde la compensación (S1 o S2).' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CTR_CTR', @level2type=N'COLUMN',@level2name=N'CTR_SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Para caso de suministros BT (en %).' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CTR_CTR', @level2type=N'COLUMN',@level2name=N'CTR_ALIMENTADORSOT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Para caso de suministros BT (en %).' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CTR_CTR', @level2type=N'COLUMN',@level2name=N'CTR_ALIMENTADORSUT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sumatoria AP del suministro ubicado en el tramo inicial SET MT/BT.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CTR_CTR', @level2type=N'COLUMN',@level2name=N'CTR_SUMATORIAAPTRAMOINICIAL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sumatoria AP que corresponde al disminuir (V SO1 - V SOT). A la tensión registrada en el tramo inicial.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CTR_CTR', @level2type=N'COLUMN',@level2name=N'CTR_SUMATORIAAPDISMINUIR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sumatoria AP del suministro ubicado en el tramo final SET MT/BT.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CTR_CTR', @level2type=N'COLUMN',@level2name=N'CTR_SUMATORIAAPTRAMOFINAL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sumatoria AP que corresponde al aumentar (V SO2 - V SOT). A la tensión registrada en el tramo final.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CTR_CTR', @level2type=N'COLUMN',@level2name=N'CTR_SUMATORIAAPAUMENTAR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del Periodo.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CTR_CTR', @level2type=N'COLUMN',@level2name=N'NOMBREPERIODO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código del Semestre.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CTR_CTR', @level2type=N'COLUMN',@level2name=N'CTR_IDSEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CTR_CTR', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ID para referencia a otras tablas.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_FTR_FTR', @level2type=N'COLUMN',@level2name=N'FTR_CODFTR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Identificación de la empresa suministradora.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_FTR_FTR', @level2type=N'COLUMN',@level2name=N'EMP_CODEMP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Los dos últimos dígitos del año. 10 = 2010, 11=2011, etc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_FTR_FTR', @level2type=N'COLUMN',@level2name=N'YEAR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Dos dígitos si es un mes, 01=enero, 02=febrero, o para los semestres' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_FTR_FTR', @level2type=N'COLUMN',@level2name=N'PERIODO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Identificación del tipo de medición' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_FTR_FTR', @level2type=N'COLUMN',@level2name=N'TIPOMEDICION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El código del sistema eléctrico, según se ha definido en el anexo1 del semestre correspondiente.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_FTR_FTR', @level2type=N'COLUMN',@level2name=N'SISTEMA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Tipo de punto de medición, B=básico o seleccionado, R=reclamo, F=repetición de medición fallida, O=Solicitado por Osinergmin, X=remedición.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_FTR_FTR', @level2type=N'COLUMN',@level2name=N'TIPOPUNTO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Número de medición. 0=1era. medición, 1,2,3..9,A,B,C...Z para sucesivas en el mismo punto hasta que la calidad sea aceptable.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_FTR_FTR', @level2type=N'COLUMN',@level2name=N'NROMEDICION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Número de suministro.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_FTR_FTR', @level2type=N'COLUMN',@level2name=N'FTR_SUMINISTRO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Rango 1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_FTR_FTR', @level2type=N'COLUMN',@level2name=N'FTR_RANGO1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Rango 2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_FTR_FTR', @level2type=N'COLUMN',@level2name=N'FTR_RANGO2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Rango 3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_FTR_FTR', @level2type=N'COLUMN',@level2name=N'FTR_RANGO3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Rango 4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_FTR_FTR', @level2type=N'COLUMN',@level2name=N'FTR_RANGO4'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Rango 5' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_FTR_FTR', @level2type=N'COLUMN',@level2name=N'FTR_RANGO5'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Rango 6' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_FTR_FTR', @level2type=N'COLUMN',@level2name=N'FTR_RANGO6'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Rango 7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_FTR_FTR', @level2type=N'COLUMN',@level2name=N'FTR_RANGO7'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Rango 8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_FTR_FTR', @level2type=N'COLUMN',@level2name=N'FTR_RANGO8'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Rango 9' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_FTR_FTR', @level2type=N'COLUMN',@level2name=N'FTR_RANGO9'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Rango 10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_FTR_FTR', @level2type=N'COLUMN',@level2name=N'FTR_RANGO10'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Rango 11' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_FTR_FTR', @level2type=N'COLUMN',@level2name=N'FTR_RANGO11'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Rango 12' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_FTR_FTR', @level2type=N'COLUMN',@level2name=N'FTR_RANGO12'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Solo para suminstros ubicados en la cabecera.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_FTR_FTR', @level2type=N'COLUMN',@level2name=N'FTR_VSO1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Para suministros en cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_FTR_FTR', @level2type=N'COLUMN',@level2name=N'FTR_VSO2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Para suministros en cola.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_FTR_FTR', @level2type=N'COLUMN',@level2name=N'FTR_VSU1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Para suministros en cola.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_FTR_FTR', @level2type=N'COLUMN',@level2name=N'FTR_VSU2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del Periodo.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_FTR_FTR', @level2type=N'COLUMN',@level2name=N'NOMBREPERIODO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código del Semestre.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_FTR_FTR', @level2type=N'COLUMN',@level2name=N'FTR_IDSEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_FTR_FTR', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Identificación de la empresa suministradora.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_MTR_MTR', @level2type=N'COLUMN',@level2name=N'EMP_CODEMP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Los dos últimos dígitos del año. 10 = 2010, 11=2011, etc.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_MTR_MTR', @level2type=N'COLUMN',@level2name=N'YEAR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Dos dígitos si es un mes, 01=enero, 02=febrero, o para los semestres' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_MTR_MTR', @level2type=N'COLUMN',@level2name=N'PERIODO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Identificación del tipo de medición' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_MTR_MTR', @level2type=N'COLUMN',@level2name=N'TIPOMEDICION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El código del sistema eléctrico, según se ha definido en el anexo1 del semestre correspondiente.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_MTR_MTR', @level2type=N'COLUMN',@level2name=N'SISTEMA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Tipo de punto de medición, B=básico o seleccionado, R=reclamo, F=repetición de medición fallida, O=Solicitado por Osinergmin, X=remedición.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_MTR_MTR', @level2type=N'COLUMN',@level2name=N'TIPOPUNTO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Número de medición. 0=1era. medición, 1,2,3..9,A,B,C...Z para sucesivas en el mismo punto hasta que la calidad sea aceptable.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_MTR_MTR', @level2type=N'COLUMN',@level2name=N'NROMEDICION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Número de suministro de Cliente.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_MTR_MTR', @level2type=N'COLUMN',@level2name=N'MTR_SUMINISTRO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' La fecha del cronograma.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_MTR_MTR', @level2type=N'COLUMN',@level2name=N'MTR_FECHACRONOGRAMA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Código de SubEstacion, sólo cuando se realicen mediciones en BT. Debe coincidir con el campo SUBESTACION la tabla SED_MTBT del Anexo 1.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_MTR_MTR', @level2type=N'COLUMN',@level2name=N'MTR_SEDBAJA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' ID interno, para referencia en otras tablas.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_MTR_MTR', @level2type=N'COLUMN',@level2name=N'MTR_CORMTR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' ID del semestre al que pertenece el cronograma.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_MTR_MTR', @level2type=N'COLUMN',@level2name=N'MTR_SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del periodo al que corresponde' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_MTR_MTR', @level2type=N'COLUMN',@level2name=N'NOMBREPERIODO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El tipo de origen del registro ATR=Para archivo ATR y MTR=para el archivo MTR.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_MTR_MTR', @level2type=N'COLUMN',@level2name=N'MTR_TIPO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Fecha a partir de la cual esta medición es visible. Aplicable para los registros que provienen del SISA-rural, es decir para mediciones en SEDs.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_MTR_MTR', @level2type=N'COLUMN',@level2name=N'MTR_VISUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Un comentario asociado a esta medición.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_MTR_MTR', @level2type=N'COLUMN',@level2name=N'MTR_COMENTARIO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Fecha de instalación del equipo. Recibido en archivo texto como DDMMAAAA' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_MTR_MTR', @level2type=N'COLUMN',@level2name=N'MTR_FECHAINSTALACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El id de la Base Sorteada de Unidades Tension' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_MTR_MTR', @level2type=N'COLUMN',@level2name=N'TNS_CODIGO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' EL suministro de la cola' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_MTR_MTR', @level2type=N'COLUMN',@level2name=N'MTR_SUMINISTROCOL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' EL suministro original de la cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_MTR_MTR', @level2type=N'COLUMN',@level2name=N'MTR_SUMINORIGCAB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' EL suministro original de la cola' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_MTR_MTR', @level2type=N'COLUMN',@level2name=N'MTR_SUMINORIGCOL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' La fuente de la cabecera S' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_MTR_MTR', @level2type=N'COLUMN',@level2name=N'MTR_HAYFUENTECAB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' La fuente de la cola, S' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_MTR_MTR', @level2type=N'COLUMN',@level2name=N'MTR_HAYFUENTECOLA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' La fecha de envio de la cabecera.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_MTR_MTR', @level2type=N'COLUMN',@level2name=N'MTR_FECHAENVIO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_MTR_MTR', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El ID de la evaluacion de tension rural, este valor nos lleva encontrar el codigo de la empresa y/o semestre.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_RURALMTXLS_XRM', @level2type=N'COLUMN',@level2name=N'TRC_CORTRC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El codigo del suminstro MT a ser medido.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_RURALMTXLS_XRM', @level2type=N'COLUMN',@level2name=N'TRX_SUMINISTRO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El numero de mes para el cronograma, se espera un entero entre 1 y 12 para indicar enero-diciembre.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_RURALMTXLS_XRM', @level2type=N'COLUMN',@level2name=N'TRX_NUMMES'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El iD que indica el archivo XLS que fue enviado para el ingreso de este cronograma.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_RURALMTXLS_XRM', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Usuario creador' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_RURALMTXLS_XRM', @level2type=N'COLUMN',@level2name=N'USUARIO_CREACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El IP de la creacion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_RURALMTXLS_XRM', @level2type=N'COLUMN',@level2name=N'TERMINAL_CREACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Fecha y hora de creacion.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_RURALMTXLS_XRM', @level2type=N'COLUMN',@level2name=N'FECHA_CREACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El usuario modificador.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_RURALMTXLS_XRM', @level2type=N'COLUMN',@level2name=N'USUARIO_ACTUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Origen de la actualizacion, IP address' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_RURALMTXLS_XRM', @level2type=N'COLUMN',@level2name=N'TERMINAL_ACTUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Fecha de la modificacion.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_RURALMTXLS_XRM', @level2type=N'COLUMN',@level2name=N'FECHA_ACTUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El ID del tension al que pertenecen los datos de la tabla base.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSBASE_TSB', @level2type=N'COLUMN',@level2name=N'TSN_CORTSN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Codigo Interno del registro. constraint pk_SR3_TENSBASE_TSB primary key (TSB_CORTSB)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSBASE_TSB', @level2type=N'COLUMN',@level2name=N'TSB_CORTSB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El codigo de la empresa.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSBASE_TSB', @level2type=N'COLUMN',@level2name=N'EMP_CODEMP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El codigo del semestre.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSBASE_TSB', @level2type=N'COLUMN',@level2name=N'SEM_CODSEM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' valores posibles son U=urbana, R= rural.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSBASE_TSB', @level2type=N'COLUMN',@level2name=N'TSB_NORMA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Localidad.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSBASE_TSB', @level2type=N'COLUMN',@level2name=N'TSB_LOCALI'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El nro de suministro.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSBASE_TSB', @level2type=N'COLUMN',@level2name=N'TSB_SUMINISTRO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El codigo de ubigeo.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSBASE_TSB', @level2type=N'COLUMN',@level2name=N'TSB_UBIGEO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' S excluido del proceso de sorteo.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSBASE_TSB', @level2type=N'COLUMN',@level2name=N'TSB_FLAGEXCLUIDO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Motivo de la exclusion. Hay 04 motivos posible, son detalles del proceso.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSBASE_TSB', @level2type=N'COLUMN',@level2name=N'TSB_EXCLUYEMOTIV'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Tipo de medidor.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSBASE_TSB', @level2type=N'COLUMN',@level2name=N'TSB_TIPOMED'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Sub estacion.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSBASE_TSB', @level2type=N'COLUMN',@level2name=N'TSB_SUBEST'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Nivel de tension, valores son BT, MT, ATMAT segun el suministro haya sido tomado desde las tablas suminbt, sumint, o suminat_MAT' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSBASE_TSB', @level2type=N'COLUMN',@level2name=N'TSB_NIVELTEN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Codigo de sistema electrico del suministro.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSBASE_TSB', @level2type=N'COLUMN',@level2name=N'TSB_SISTEMA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Las fases del suministro, como se declara en suminbt.fases.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSBASE_TSB', @level2type=N'COLUMN',@level2name=N'TSB_FASES'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Usuario creador' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSBASE_TSB', @level2type=N'COLUMN',@level2name=N'USUARIO_CREACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El IP de la creacion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSBASE_TSB', @level2type=N'COLUMN',@level2name=N'TERMINAL_CREACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Fecha y hora de creacion.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSBASE_TSB', @level2type=N'COLUMN',@level2name=N'FECHA_CREACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El usuario modificador.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSBASE_TSB', @level2type=N'COLUMN',@level2name=N'USUARIO_ACTUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Origen de la actualizacion, IP address' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSBASE_TSB', @level2type=N'COLUMN',@level2name=N'TERMINAL_ACTUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Fecha de la modificacion.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSBASE_TSB', @level2type=N'COLUMN',@level2name=N'FECHA_ACTUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' alimentador' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSBASE_TSB', @level2type=N'COLUMN',@level2name=N'TSB_CTTALM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' ID del elemento de crongorama. Autognerador por modelador_seq.nextval constraint pk_SR3_TENSCRONOGRAMA_TCR primary key (TCR_CORTCR)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSCRONOGRAMA_TCR', @level2type=N'COLUMN',@level2name=N'TCR_CORTCR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El hash para el elemento sorteo, esto permite encontrar el ID del sorteo (CSE_CORCSE) durante el proceso de recepcion.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSCRONOGRAMA_TCR', @level2type=N'COLUMN',@level2name=N'TCR_HASHCODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El ID del contraste al que pertenecen los datos de la tabla base.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSCRONOGRAMA_TCR', @level2type=N'COLUMN',@level2name=N'TSN_CORTSN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El ID del elemento que se quiere cronogramas, es el ID en la tabla de sorteo.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSCRONOGRAMA_TCR', @level2type=N'COLUMN',@level2name=N'TSS_CORTSS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Numero de mes para el cronograma semestral, en el caso urbano se espera null, pero un valor notnull para el caso rural ya que se usa este mes para definir la fecha de visualizacion.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSCRONOGRAMA_TCR', @level2type=N'COLUMN',@level2name=N'TCR_MESCRON'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Fecha de cronograma para la medicion. Enviado por la empresa. se usa como base para el view del suministro.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSCRONOGRAMA_TCR', @level2type=N'COLUMN',@level2name=N'TCR_DIACRON'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El campo puede ver es el limite desde la fecha en que el dato completo del suministro seria visible para la empresa.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSCRONOGRAMA_TCR', @level2type=N'COLUMN',@level2name=N'TCR_CANVIEW'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' ID de cabecera de envio con el que ha llegado este registro.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSCRONOGRAMA_TCR', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Usuario creador' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSCRONOGRAMA_TCR', @level2type=N'COLUMN',@level2name=N'USUARIO_CREACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El IP de la creacion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSCRONOGRAMA_TCR', @level2type=N'COLUMN',@level2name=N'TERMINAL_CREACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Fecha y hora de creacion.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSCRONOGRAMA_TCR', @level2type=N'COLUMN',@level2name=N'FECHA_CREACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El usuario modificador.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSCRONOGRAMA_TCR', @level2type=N'COLUMN',@level2name=N'USUARIO_ACTUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Origen de la actualizacion, IP address' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSCRONOGRAMA_TCR', @level2type=N'COLUMN',@level2name=N'TERMINAL_ACTUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Fecha de la modificacion.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSCRONOGRAMA_TCR', @level2type=N'COLUMN',@level2name=N'FECHA_ACTUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' ID del elemento del sorteo, sera referido por el cronograma. constraint pk_SR3_TENSSORTEO_TSS primary key (TSS_CORTSS)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSSORTEO_TSS', @level2type=N'COLUMN',@level2name=N'TSS_CORTSS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El ID del contraste al que pertenecen los datos de la tabla base.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSSORTEO_TSS', @level2type=N'COLUMN',@level2name=N'TSN_CORTSN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' ID del estrato, lo cual define su ubicacion en la muestra.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSSORTEO_TSS', @level2type=N'COLUMN',@level2name=N'TSE_CORTSE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' ID de la base contraste que ha sido elegido.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSSORTEO_TSS', @level2type=N'COLUMN',@level2name=N'TSB_CORTSB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' DRAFT esta pendiente, FINAL= fue aceptado por la empresa. SE espera que audit tenga el update en sus registros.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSSORTEO_TSS', @level2type=N'COLUMN',@level2name=N'TSS_ACEPTACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El hash code ocultara al suministro hasta que se cumpla la fecha de visualizacion para la empresa. Es un MD5SUM.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSSORTEO_TSS', @level2type=N'COLUMN',@level2name=N'TSS_HASHCODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Usuario creador' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSSORTEO_TSS', @level2type=N'COLUMN',@level2name=N'USUARIO_CREACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El IP de la creacion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSSORTEO_TSS', @level2type=N'COLUMN',@level2name=N'TERMINAL_CREACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Fecha y hora de creacion.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSSORTEO_TSS', @level2type=N'COLUMN',@level2name=N'FECHA_CREACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El usuario modificador.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSSORTEO_TSS', @level2type=N'COLUMN',@level2name=N'USUARIO_ACTUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Origen de la actualizacion, IP address' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSSORTEO_TSS', @level2type=N'COLUMN',@level2name=N'TERMINAL_ACTUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Fecha de la modificacion.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSSORTEO_TSS', @level2type=N'COLUMN',@level2name=N'FECHA_ACTUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' dia del cronograma' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SR3_TENSSORTEO_TSS', @level2type=N'COLUMN',@level2name=N'TSS_DIACRON'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'001, 002, ........, n' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CCT', @level2type=N'COLUMN',@level2name=N'NUMEROSECUENCIAL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Identificación de la Empresa Suministradora (según Anexo N° 3).' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CCT', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Los dos últimos dígitos del año' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CCT', @level2type=N'COLUMN',@level2name=N'ANIO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Dos dígitos según orden del mes: 01,02,........,12 Para información semestral: S1 y S2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CCT', @level2type=N'COLUMN',@level2name=N'PERIODO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identificación del tipo de medición (un ALFANUMÉRICO )' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CCT', @level2type=N'COLUMN',@level2name=N'TIPOMEDICION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'localidad' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CCT', @level2type=N'COLUMN',@level2name=N'LOCALIDAD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tipo de punto de medición' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CCT', @level2type=N'COLUMN',@level2name=N'TIPOPUNTO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 para primera medición' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CCT', @level2type=N'COLUMN',@level2name=N'NROMEDICION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del archivo fuente Ej: xxxxxxxxxxxx.xxx' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CCT', @level2type=N'COLUMN',@level2name=N'NOMBREARCHIVOFUENTE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Número del suministro MEDIDO o código de la SED' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CCT', @level2type=N'COLUMN',@level2name=N'NUMSUMINISTRO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MO' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CCT', @level2type=N'COLUMN',@level2name=N'TIPOALIMENTACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sólo para casos de mediciones de TENSIÓN BT en punto alternativo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CCT', @level2type=N'COLUMN',@level2name=N'NUMSUMINALTERNA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'TE' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CCT', @level2type=N'COLUMN',@level2name=N'PARAMETROMEDIDO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'TENSIONSUMIN' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CCT', @level2type=N'COLUMN',@level2name=N'TENSIONSUMIN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'marcamodelo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CCT', @level2type=N'COLUMN',@level2name=N'MARCAMODELO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'NUMSERIEEQP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CCT', @level2type=N'COLUMN',@level2name=N'NUMSERIEEQP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Por transformador de medición de TENSIÓN, Este factor multiplicará a lo registrado por el equipo para la evaluación del indicador de tensión' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CCT', @level2type=N'COLUMN',@level2name=N'FACTORCORRECCIONTENSION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Por transformador de medición de CORRIENTE, Este factor multiplicará a lo registrado por el equipo para la evaluación' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CCT', @level2type=N'COLUMN',@level2name=N'FACTORCORRECCIONCORRIENTE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ddmmaaaa (dia, mes y año)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CCT', @level2type=N'COLUMN',@level2name=N'FECHAINSTALEQP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ddmmaaaa (dia, mes y año) Hhmm' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CCT', @level2type=N'COLUMN',@level2name=N'FECHARETIROEQP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'RESULTMED' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CCT', @level2type=N'COLUMN',@level2name=N'RESULTMED'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Si o No (Solo para medición de tensión en BT)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CCT', @level2type=N'COLUMN',@level2name=N'PRESENCIAFLICKER'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Si o No (Solo para medición de tensión en BT)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CCT', @level2type=N'COLUMN',@level2name=N'PRESENCIAARMONICA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'observaciones' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CCT', @level2type=N'COLUMN',@level2name=N'OBSERVACIONES'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del periodo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CCT', @level2type=N'COLUMN',@level2name=N'NOMBREPERIODO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo de semestre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CCT', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CCT', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identificación de la Empresa Suministradora (según Anexo N° 3).' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CTE', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Los dos últimos dígitos del año' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CTE', @level2type=N'COLUMN',@level2name=N'ANIO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Dos dígitos según orden del mes: 01,02,........,12 Para información semestral: S1 y S2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CTE', @level2type=N'COLUMN',@level2name=N'PERIODO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identificación del tipo de medición (un ALFANUMÉRICO )' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CTE', @level2type=N'COLUMN',@level2name=N'TIPOMEDICION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Localidad.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CTE', @level2type=N'COLUMN',@level2name=N'LOCALIDAD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tipo de punto' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CTE', @level2type=N'COLUMN',@level2name=N'TIPOPUNTO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 para primera medición' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CTE', @level2type=N'COLUMN',@level2name=N'NROMEDICION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Suminstro medido fuera de tolerancias' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CTE', @level2type=N'COLUMN',@level2name=N'SUMINISTRO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo o numero del suministro a compensar' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CTE', @level2type=N'COLUMN',@level2name=N'SUMINISTROCLIENTE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Segun 7ma Disp. Final NTCSE' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CTE', @level2type=N'COLUMN',@level2name=N'TIPOENERGIA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'La energia correpende al mes por el cual se compensa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CTE', @level2type=N'COLUMN',@level2name=N'ENERGIASUMINISTRADA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Rango 5<Vp(%)<' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CTE', @level2type=N'COLUMN',@level2name=N'ENERGIATOTAL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Rango A2 7.5<Vp(%)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CTE', @level2type=N'COLUMN',@level2name=N'ENERGIATOTALRANGO2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Rango A1 5<Vp(%)<' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CTE', @level2type=N'COLUMN',@level2name=N'NUMEROINTERVALOS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Rango A2 7.5<Vp(%)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CTE', @level2type=N'COLUMN',@level2name=N'NUMEROINTERVALOSRANGO2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'suma' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CTE', @level2type=N'COLUMN',@level2name=N'SUMATORIAVALORES'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'En dolares' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CTE', @level2type=N'COLUMN',@level2name=N'MONTOCOMPENSACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ano corresponde compensación' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CTE', @level2type=N'COLUMN',@level2name=N'ANO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Mes corresponde la compensación' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CTE', @level2type=N'COLUMN',@level2name=N'MES'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del periodo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CTE', @level2type=N'COLUMN',@level2name=N'NOMBREPERIODO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo Semestre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CTE', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CTE', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identificación de la Empresa Suministradora (según Anexo N° 3).' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_FTE', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Los dos últimos dígitos del año' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_FTE', @level2type=N'COLUMN',@level2name=N'ANIO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Dos dígitos según orden del mes: 01,02,........,12 Para información semestral: S1 y S2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_FTE', @level2type=N'COLUMN',@level2name=N'PERIODO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identificación del tipo de medición (un ALFANUMÉRICO )' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_FTE', @level2type=N'COLUMN',@level2name=N'TIPOMEDICION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Localidad.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_FTE', @level2type=N'COLUMN',@level2name=N'LOCALIDAD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tipo de punto' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_FTE', @level2type=N'COLUMN',@level2name=N'TIPOPUNTO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 para primera medición' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_FTE', @level2type=N'COLUMN',@level2name=N'NROMEDICION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Suminstro del Cliente' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_FTE', @level2type=N'COLUMN',@level2name=N'SUMINISTRO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Para 5%<v<7.5%' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_FTE', @level2type=N'COLUMN',@level2name=N'RANGO1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Para 7.5%<v<10%' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_FTE', @level2type=N'COLUMN',@level2name=N'RANGO2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Para 10%<v<12.5%' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_FTE', @level2type=N'COLUMN',@level2name=N'RANGO3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Para 12.5%<v<15%' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_FTE', @level2type=N'COLUMN',@level2name=N'RANGO4'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Para 15%<v<17.5%' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_FTE', @level2type=N'COLUMN',@level2name=N'RANGO5'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Para v>17.5%' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_FTE', @level2type=N'COLUMN',@level2name=N'RANGO6'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Para -7.5%<v<-5%' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_FTE', @level2type=N'COLUMN',@level2name=N'RANGO7'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Para -10%<v<-7.5%' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_FTE', @level2type=N'COLUMN',@level2name=N'RANGO8'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Para -12.5%<v<-10%' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_FTE', @level2type=N'COLUMN',@level2name=N'RANGO9'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Para -15%<v<-12.5%' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_FTE', @level2type=N'COLUMN',@level2name=N'RANGO10'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Para -17.5%<v<-15%' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_FTE', @level2type=N'COLUMN',@level2name=N'RANGO11'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Para v<-17.5%' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_FTE', @level2type=N'COLUMN',@level2name=N'RANGO12'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del periodo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_FTE', @level2type=N'COLUMN',@level2name=N'NOMBREPERIODO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo Semestre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_FTE', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_FTE', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identificación de la Empresa Suministradora (según Anexo N° 3).' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MPE', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Los dos últimos dígitos del año' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MPE', @level2type=N'COLUMN',@level2name=N'ANIO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Dos dígitos según orden del mes: 01,02,........,12 Para información semestral: S1 y S2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MPE', @level2type=N'COLUMN',@level2name=N'PERIODO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identificación del tipo de medición (un ALFANUMÉRICO )' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MPE', @level2type=N'COLUMN',@level2name=N'TIPOMEDICION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Localidad.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MPE', @level2type=N'COLUMN',@level2name=N'LOCALIDAD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tipo de punto de medicion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MPE', @level2type=N'COLUMN',@level2name=N'TIPOPUNTO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 para primera medición' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MPE', @level2type=N'COLUMN',@level2name=N'NROMEDICION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Suminstro del Cliente o Codigo de SED' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MPE', @level2type=N'COLUMN',@level2name=N'SUMINISTRO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Parametro a medir F,A,FA' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MPE', @level2type=N'COLUMN',@level2name=N'PARAMETROAMEDIR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha de cronograma del equipo Ddmmaaaa (día, mes y año)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MPE', @level2type=N'COLUMN',@level2name=N'FECHACRONOGRAMA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Id interno para pk' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MPE', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tipo de archivo de envio' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MPE', @level2type=N'COLUMN',@level2name=N'TIPO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha envio archivo fuente' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MPE', @level2type=N'COLUMN',@level2name=N'FECHAENVIO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Comentario' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MPE', @level2type=N'COLUMN',@level2name=N'COMENTARIO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha de instalacion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MPE', @level2type=N'COLUMN',@level2name=N'FECHAINSTALACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del periodo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MPE', @level2type=N'COLUMN',@level2name=N'NOMBREPERIODO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de semestre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MPE', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha de visualizacion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MPE', @level2type=N'COLUMN',@level2name=N'FECHAVISUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Flag que indica la existencia del archivo fuente' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MPE', @level2type=N'COLUMN',@level2name=N'SINFUENTE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Suministro original' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MPE', @level2type=N'COLUMN',@level2name=N'SUMINORIG'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MPE', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Codigo Interno del registro. constraint primary key (CODIGO)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENDETALLE_URB', @level2type=N'COLUMN',@level2name=N'CODIGO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El codigo de la empresa.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENDETALLE_URB', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El codigo del semestre.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENDETALLE_URB', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' codigo del sistema' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENDETALLE_URB', @level2type=N'COLUMN',@level2name=N'CODSISTEMA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' nombre del sistema.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENDETALLE_URB', @level2type=N'COLUMN',@level2name=N'NOMSISTEMA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' suma BT' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENDETALLE_URB', @level2type=N'COLUMN',@level2name=N'DET_SUM_BT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' suma MTATMAT.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENDETALLE_URB', @level2type=N'COLUMN',@level2name=N'DET_SUM_MTATMAT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' total BT' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENDETALLE_URB', @level2type=N'COLUMN',@level2name=N'DET_TOTAL_BT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' total MTATMAT' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENDETALLE_URB', @level2type=N'COLUMN',@level2name=N'DET_TOTAL_MTATMAT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Usuario creador' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENDETALLE_URB', @level2type=N'COLUMN',@level2name=N'USUARIO_CREACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El IP de la creacion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENDETALLE_URB', @level2type=N'COLUMN',@level2name=N'TERMINAL_CREACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Fecha y hora de creacion.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENDETALLE_URB', @level2type=N'COLUMN',@level2name=N'FECHA_CREACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El usuario modificador.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENDETALLE_URB', @level2type=N'COLUMN',@level2name=N'USUARIO_ACTUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Origen de la actualizacion, IP address' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENDETALLE_URB', @level2type=N'COLUMN',@level2name=N'TERMINAL_ACTUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Fecha de la modificacion.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENDETALLE_URB', @level2type=N'COLUMN',@level2name=N'FECHA_ACTUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Codigo de la evaluacion de tension rural al que pertenece esta SED.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURAL_SED', @level2type=N'COLUMN',@level2name=N'TRC_CORTRC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURAL_SED', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURAL_SED', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURAL_SED', @level2type=N'COLUMN',@level2name=N'LOCALIDAD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURAL_SED', @level2type=N'COLUMN',@level2name=N'SUCURSAL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURAL_SED', @level2type=N'COLUMN',@level2name=N'SUBESTACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURAL_SED', @level2type=N'COLUMN',@level2name=N'NOMBRE_SUBESTACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURAL_SED', @level2type=N'COLUMN',@level2name=N'DIRECCION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURAL_SED', @level2type=N'COLUMN',@level2name=N'UBICACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURAL_SED', @level2type=N'COLUMN',@level2name=N'TENSION_BAJA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURAL_SED', @level2type=N'COLUMN',@level2name=N'TENSION_MT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURAL_SED', @level2type=N'COLUMN',@level2name=N'CAPACIDAD_TRANSFORMACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURAL_SED', @level2type=N'COLUMN',@level2name=N'UTM_NORTE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURAL_SED', @level2type=N'COLUMN',@level2name=N'UTM_ESTE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURAL_SED', @level2type=N'COLUMN',@level2name=N'SECCION_LINEA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El ID cabecera que fija el ultimo valor (mientras esta en plazo) para la medicion en el semestre.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURAL_SED', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El numero de mes en el semestre indicado via XLS.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURAL_SED', @level2type=N'COLUMN',@level2name=N'TRX_NUMMES'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' La fecha recibida via el MTR cuando la empresa ha fijado una cabecera y cola para la medicion.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURAL_SED', @level2type=N'COLUMN',@level2name=N'SED_FECHAMTR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El ID del archivo MTR recibido via el receptor ASCII por parte de la empresa.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURAL_SED', @level2type=N'COLUMN',@level2name=N'SED_IDMTR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El codigo del sistema electrico a donde pertenece esta SED.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURAL_SED', @level2type=N'COLUMN',@level2name=N'SISTEMA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Nombre del sistema electrico.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURAL_SED', @level2type=N'COLUMN',@level2name=N'NOMSISTEMA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Usuario creador' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURAL_SED', @level2type=N'COLUMN',@level2name=N'USUARIO_CREACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El IP de la creacion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURAL_SED', @level2type=N'COLUMN',@level2name=N'TERMINAL_CREACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Fecha y hora de creacion.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURAL_SED', @level2type=N'COLUMN',@level2name=N'FECHA_CREACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El usuario modificador.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURAL_SED', @level2type=N'COLUMN',@level2name=N'USUARIO_ACTUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Origen de la actualizacion, IP address' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURAL_SED', @level2type=N'COLUMN',@level2name=N'TERMINAL_ACTUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Fecha de la modificacion.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURAL_SED', @level2type=N'COLUMN',@level2name=N'FECHA_ACTUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' constraint pk_SRV_TENRURALCAB_TRC primary key (TRC_CORTRC)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURALCAB_TRC', @level2type=N'COLUMN',@level2name=N'TRC_CORTRC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' código del semestre.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURALCAB_TRC', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' la empresa.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURALCAB_TRC', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Define si el juego de datos de la cabecera es el ultimo generado' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURALCAB_TRC', @level2type=N'COLUMN',@level2name=N'ACTIVO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El numero de SEDs a medir para ese periodo correspondientes a la empresa.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURALCAB_TRC', @level2type=N'COLUMN',@level2name=N'TRC_SEDSAMEDIR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El numero de mediciones mT a realizar por la empresa.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURALCAB_TRC', @level2type=N'COLUMN',@level2name=N'TRC_MTAMEDIR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Usuario creador' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURALCAB_TRC', @level2type=N'COLUMN',@level2name=N'USUARIO_CREACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El IP de la creacion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURALCAB_TRC', @level2type=N'COLUMN',@level2name=N'TERMINAL_CREACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Fecha y hora de creacion.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURALCAB_TRC', @level2type=N'COLUMN',@level2name=N'FECHA_CREACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El usuario modificador.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURALCAB_TRC', @level2type=N'COLUMN',@level2name=N'USUARIO_ACTUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Origen de la actualizacion, IP address' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURALCAB_TRC', @level2type=N'COLUMN',@level2name=N'TERMINAL_ACTUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Fecha de la modificacion.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENRURALCAB_TRC', @level2type=N'COLUMN',@level2name=N'FECHA_ACTUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El codigo de la cabecera al que pertenece esta lista de MTs disponibles para elegir por parte de la empresa.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'TRC_CORTRC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'LOCALIDAD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'IDENTIFICACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'DIRECCION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'UBICACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'TELEFONO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'SUMINISTRO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'OPCION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'MARCA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'MODELO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'SERIE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'ANIO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'POTENCIA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'TENSION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo SET' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'SETCODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'ALIMENTADOR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'PUNTOCONEXION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'CODIGO_SUBESTACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'CODIGO_SUMINISTRO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'ETIQUETA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'TIPO_SUMINISTRO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'MEDIDOR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Corriente Nominal del medidor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'NOMINAL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Corriente Máxima del medidor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'MAXIMA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'CLASES'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'FECHA_AFERICION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'FECHA_CONSTRASTACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El ID de la fijacion del mes (1-12) para el plan semestral.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El mes para la medicion, en el plan semestral.  El ID de la fijacion del mes (1-12) para el plan semestral.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'XRM_NUMMES'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' La fecha fijada en el MTR para la medicion MT. Siempre sera la ultima fecha recibida dentro del plazo.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'XRM_FECHAMTR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El ID del archvo MTR que ha fijado fecha definitiva en el mes para esta medicion.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'XRM_IDMTR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Usuario creador' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'USUARIO_CREACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El IP de la creacion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'TERMINAL_CREACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Fecha y hora de creacion.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'FECHA_CREACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El usuario modificador.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'USUARIO_ACTUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Origen de la actualizacion, IP address' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'TERMINAL_ACTUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Fecha de la modificacion.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_SUMINMT', @level2type=N'COLUMN',@level2name=N'FECHA_ACTUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Codigo Interno del registro. constraint primary key (CODIGO)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_URB', @level2type=N'COLUMN',@level2name=N'CODIGO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El codigo de la empresa.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_URB', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El codigo del semestre.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_URB', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' total de suministros de BT.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_URB', @level2type=N'COLUMN',@level2name=N'SUMIN_MEN_BT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Total de suministros de MT/AT/MAT en la cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_URB', @level2type=N'COLUMN',@level2name=N'SUMIN_MEN_MTATMAT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Total de puntos de entrega de BT' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_URB', @level2type=N'COLUMN',@level2name=N'TOTAL_MEN_CPEBT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Total BT mensual' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_URB', @level2type=N'COLUMN',@level2name=N'TOTAL_MEN_BT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Total MTATMAT mensual' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_URB', @level2type=N'COLUMN',@level2name=N'TOTAL_MEN_MTATMAT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Fecha en la que fue registrada' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_URB', @level2type=N'COLUMN',@level2name=N'CUANDO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Define si el juego de datos de la cabecera es el ultimo generado' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_URB', @level2type=N'COLUMN',@level2name=N'ACTIVO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Usuario creador' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_URB', @level2type=N'COLUMN',@level2name=N'USUARIO_CREACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El IP de la creacion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_URB', @level2type=N'COLUMN',@level2name=N'TERMINAL_CREACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Fecha y hora de creacion.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_URB', @level2type=N'COLUMN',@level2name=N'FECHA_CREACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' El usuario modificador.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_URB', @level2type=N'COLUMN',@level2name=N'USUARIO_ACTUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Origen de la actualizacion, IP address' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_URB', @level2type=N'COLUMN',@level2name=N'TERMINAL_ACTUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Fecha de la modificacion.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_TENSION_URB', @level2type=N'COLUMN',@level2name=N'FECHA_ACTUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[50] 4[11] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "SIR_MTR_MTR"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 262
               Right = 353
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "Semestre (CalidadGenerales.dbo)"
            Begin Extent = 
               Top = 39
               Left = 452
               Bottom = 237
               Right = 679
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'NormaRural_MTR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'NormaRural_MTR'
GO
