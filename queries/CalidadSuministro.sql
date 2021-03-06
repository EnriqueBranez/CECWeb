USE [CalidadSuministro]
GO
/****** Object:  Table [dbo].[SIR_CR2_CR2S]    Script Date: 03/07/2020 1:40:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SIR_CR2_CR2S](
	[EMPRESA] [varchar](3) NULL,
	[ANIO] [varchar](4) NULL,
	[SEMESTRE] [varchar](2) NULL,
	[CODIGOREVELADOR] [varchar](10) NULL,
	[CODIGOSUMINISTRO] [varchar](10) NULL,
	[ENERGIA] [decimal](18, 3) NULL,
	[COMPENSACION] [decimal](14, 4) NULL,
	[NOMBREPERIODO] [varchar](10) NULL,
	[CODSEMESTRE] [int] NULL,
	[ID_CABECERA] [int] NULL,
	[NroRegEnArchivoOrigen] [int] NULL,
	[FechaPeriodoReportado] [datetime] NULL,
	[FechaPeriodo]  AS ([dbo].[GetFechaInicioPeriodo]([NOMBREPERIODO]))
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[NormaRural_CR2_Semestral]    Script Date: 03/07/2020 1:40:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[NormaRural_CR2_Semestral] AS SELECT
	C.EMPRESA AS empresa
	, C.ANIO AS anio
	, C.SEMESTRE AS semestre
	, C.CODIGOREVELADOR AS codigorevelador
	, C.CODIGOSUMINISTRO AS codigosuministro
	, C.ENERGIA AS energia
	, C.COMPENSACION AS compensacion
	, C.NOMBREPERIODO AS nombreperiodo
	, C.CODSEMESTRE AS codigosemestre
	, C.ID_CABECERA AS codigo_cabecera
	, C.NroRegEnArchivoOrigen AS NroRegEnArchivoOrigen
	, T.NombreSemestre
	, E.nombre AS NombreEmpresa
	, SS.identificacion
	, SS.direccion
	, SS.subestacion
	, SS.ubicacion
	, SS.marca
	, SS.modelo
	, SS.medidor
	, SS.serie
	, SS.DistritoNombre
	, SS.DeptNombre as Departamento
	, SS.sistemaelectrico
	, SS.sectortipico
	, SS.nomsistema
	, SS.tiposistema
	, SS.Norma
	, SS.TipoClienteTension as TipoUsuario
	, SS.opcion as TarifaUsuario
	--, ISNULL(BT.identificacion,MT.identificacion) as identificacion
	--, ISNULL(BT.direccion,MT.direccion) as direccion
	--, ISNULL(BT.subestacion,MT.SETCODE) as subestacion
	--, ISNULL(BT.ubicacion, MT.ubicacion) as ubicacion
	--, ISNULL(BT.marca, MT.marca) as marca
	--, ISNULL(BT.modelo, MT.modelo) as modelo
	--, ISNULL(BT.medidor, MT.medidor) as medidor
	--, ISNULL(BT.serie, MT.serie) as serie
	--, ISNULL(UB.[Nombre], UM.[Nombre]) as  NombreDistrito
	--, ISNULL(UB.DeptUbigeo, UM.DeptUbigeo) as DeptUbigeo
	--, ISNULL(UB.DeptNombre, UM.DeptNombre) as Departamento
	--, ISNULL(UB.[PerteneceNombre], UM.[PerteneceNombre]) as Provincia
	--, ISNULL(BT.sistemaelectrico,ISNULL(MT.sistemaelectrico,'-')) as sistemaelectrico
	--, ISNULL(BT.sectortipico,ISNULL(MT.sectortipico,'-')) as sectortipico
	--, ISNULL(BT.nomsistema,ISNULL(MT.nomsistema,'-')) as nomsistema
	--, ISNULL(BT.tiposistema,ISNULL(MT.tiposistema,'-')) as tiposistema
	--, ISNULL(BT.Norma,ISNULL(MT.Norma,'-')) as Norma
	--, ISNULL(LEFT(BT.OPCION,2),ISNULL(LEFT(MT.OPCION,2),'-')) as TipoUsuario
	--, ISNULL(BT.OPCION,ISNULL(MT.OPCION,'-')) as TarifaUsuario
FROM SIR_CR2_CR2S AS C
	LEFT OUTER JOIN CalidadGenerales.dbo.Semestre AS T ON C.CODSEMESTRE = T.CodigoSemestre
	LEFT OUTER JOIN CalidadGenerales.dbo.Empresa AS E ON C.EMPRESA=E.codigo
	--left join [CalidadGenerales].[dbo].[SUMINBT] as BT on C.CODSEMESTRE=BT.[semestre] and C.empresa=BT.empresa and C.CODIGOSUMINISTRO=BT.suministro
	--left join [CalidadGenerales].[dbo].[UBIGEO] as UB on BT.ubicacion=UB.Ubigeo
	--left join [CalidadGenerales].[dbo].[SUMINMT] as MT on C.CODSEMESTRE=MT.[semestre] and C.empresa=MT.empresa and C.CODIGOSUMINISTRO=MT.suministro
	--left join [CalidadGenerales].[dbo].[UBIGEO] as UM on MT.ubicacion=UM.Ubigeo
	left join [CalidadGenerales].[dbo].suministros as SS on C.empresa=SS.empresa and C.CODIGOSUMINISTRO=SS.suministro
		and ( (SS.FechaDesde<=C.FechaPeriodo) and (C.FechaPeriodo<SS.FechaHasta) )
GO
/****** Object:  Table [dbo].[SIR_CR3_CR3T]    Script Date: 03/07/2020 1:40:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SIR_CR3_CR3T](
	[EMPRESA] [varchar](3) NOT NULL,
	[ANIO] [varchar](4) NULL,
	[SEMESTRE] [varchar](2) NULL,
	[CODIGOALIMENTADOR] [varchar](7) NULL,
	[CODIGOSUMINISTRO] [varchar](10) NULL,
	[NUMINTNO] [varchar](4) NULL,
	[NUMINTPROG] [varchar](4) NULL,
	[NUMINTEXP] [varchar](4) NULL,
	[DURINTNO] [decimal](8, 2) NULL,
	[DURINTPROG] [decimal](8, 2) NULL,
	[DURINTEXP] [decimal](8, 2) NULL,
	[ENERGIA] [decimal](18, 3) NULL,
	[COMPESACIONEXT] [decimal](14, 4) NULL,
	[COMPENSACIONLCE] [decimal](14, 4) NULL,
	[NOMBREPERIODO] [varchar](10) NULL,
	[CODSEMESTRE] [int] NULL,
	[ID_CABECERA] [int] NULL,
	[FechaPeriodo] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[NormaRural_CR3_Trimestral]    Script Date: 03/07/2020 1:40:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[NormaRural_CR3_Trimestral]
AS
SELECT --top 10
C.EMPRESA AS empresa, C.ANIO AS anio, C.SEMESTRE AS semestre, C.CODIGOALIMENTADOR AS CODIGOALIMENTADOR, C.CODIGOSUMINISTRO AS CODIGOSUMINISTRO
, C.NUMINTNO AS numintno, C.NUMINTPROG AS numintprog, C.NUMINTEXP AS numintexp, C.DURINTNO AS durintno, C.DURINTPROG AS durintprog, C.DURINTEXP AS durintexp
, C.ENERGIA AS energia, C.COMPESACIONEXT AS compensacionext, C.COMPENSACIONLCE AS compensacionlce
, C.NOMBREPERIODO AS nombreperiodo, C.CODSEMESTRE AS codigosemestre, C.ID_CABECERA AS codigo_cabecera
, IIF(C.COMPESACIONEXT - ISNULL(C.COMPENSACIONLCE, 0)>0,C.COMPESACIONEXT - ISNULL(C.COMPENSACIONLCE, 0),0) AS MontoACompensar
, T.NombreSemestre
, e.nombre AS NombreEmpresa
, C.FechaPeriodo
, SS.identificacion, SS.direccion, SS.subestacion, SS.ubicacion, SS.marca, SS.modelo, SS.medidor, SS.serie
, SS.DistritoNombre, SS.DeptNombre as Departamento
, SS.sistemaelectrico, SS.sectortipico, SS.nomsistema, SS.tiposistema, SS.Norma
FROM SIR_CR3_CR3T AS C
LEFT OUTER JOIN CalidadGenerales.dbo.Semestre AS T ON C.CODSEMESTRE = T.CodigoSemestre
LEFT OUTER JOIN CalidadGenerales.dbo.Empresa AS E ON C.EMPRESA=e.codigo
left join [CalidadGenerales].[dbo].suministros as SS on C.empresa=SS.empresa and C.CODIGOSUMINISTRO=SS.suministro
	and ( (SS.FechaDesde<=C.FechaPeriodo) and (C.FechaPeriodo<SS.FechaHasta) )
GO
/****** Object:  Table [dbo].[SIR_CR1_CR1S]    Script Date: 03/07/2020 1:40:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SIR_CR1_CR1S](
	[EMPRESA] [varchar](3) NOT NULL,
	[ANIO] [varchar](4) NULL,
	[SEMESTRE] [varchar](2) NULL,
	[CODIGOSISELEC] [varchar](10) NULL,
	[TENSION] [varchar](2) NULL,
	[NUMINTNO] [decimal](6, 2) NULL,
	[NUMINTPROGRAM] [decimal](6, 2) NULL,
	[NUMINTREDES] [decimal](6, 2) NULL,
	[DURINTNO] [decimal](8, 2) NULL,
	[DURINTPROGRAM] [decimal](8, 2) NULL,
	[DURINTREDES] [decimal](8, 2) NULL,
	[ENERGIA] [decimal](18, 3) NULL,
	[COMPENSACIONINT] [decimal](14, 4) NULL,
	[COMPENSACIONLEY] [decimal](14, 4) NULL,
	[NOMBREPERIODO] [varchar](10) NULL,
	[CODSEMESTRE] [int] NULL,
	[ID_CABECERA] [int] NULL,
	[NroRegEnArchivoOrigen] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[NormaRural_CR1_Semestral]    Script Date: 03/07/2020 1:40:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--SELECT * FROM [dbo].[FN_TBL_CR1_HistoricoCompensaciones_Empresa] ('ELS')
--GO

CREATE VIEW [dbo].[NormaRural_CR1_Semestral] AS
SELECT
	C.EMPRESA AS Empresa, C.ANIO AS anio, C.SEMESTRE AS Semestre, C.CODIGOSISELEC AS codigosiselec, C.TENSION AS tension
	, C.NUMINTNO AS numintno, C.NUMINTPROGRAM AS numintprogram, C.NUMINTREDES AS numintredes
	, C.DURINTNO AS durintno, C.DURINTPROGRAM AS durintprogram, C.DURINTREDES AS durintredes
	, C.ENERGIA AS energia, C.COMPENSACIONINT AS compensacionint, C.COMPENSACIONLEY AS compensacionley
	, C.NOMBREPERIODO AS nombreperiodo, C.CODSEMESTRE AS codigosemestre, C.ID_CABECERA AS codigo_cabecera
	, C.CODSEMESTRE,C.ID_CABECERA,C.NroRegEnArchivoOrigen
	, ROW_NUMBER() OVER (PARTITION BY C.EMPRESA,C.CODSEMESTRE,S.NombreSemestre ORDER BY C.EMPRESA,C.CODSEMESTRE,S.NombreSemestre,T.Ítem,RIGHT(C.CODIGOSISELEC,4),C.TENSION) AS Ítem
	,T.Ítem as ÍtemSDTRural
	,S.NombreSemestre
	,C.ANIO as Año
	,RIGHT(C.CODIGOSISELEC,4) as [Código de Sistema Eléctrico]
	,I.NOMSISTEMA as [Nombre de Sistema Eléctrico],I.SECTORTIPICO as [Sector Típico]
	,I.TIPOSISTEMA as [Tipo de Sistema]
	,C.TENSION as Tensión
	,C.NUMINTNO as [Nic NP],C.NUMINTPROGRAM as [Nic PM],C.NUMINTREDES as [Nic PE]
	,C.DURINTNO as [Dic NP],C.DURINTPROGRAM as [Dic PM],C.DURINTREDES as [Dic PE]
	,C.NUMINTNO+C.NUMINTPROGRAM+C.NUMINTREDES as NIC
	,C.DURINTNO+C.DURINTPROGRAM*0.5+C.DURINTREDES*0.25 as DIC
	,C.DURINTNO+C.DURINTPROGRAM+C.DURINTREDES as NHI
	,S.CantidadHoras as NHS
	,C.COMPENSACIONINT as [Compensación NTCSER US$]
	,C.COMPENSACIONLEY as [Compensación Ley US$]
	,TNIC.Tolerancia as [Tolerancia NIC]
	,TDIC.Tolerancia as [Tolerancia DIC]
	,iif(isnull(TNIC.Tolerancia/TNIC.Tolerancia*1,0)=1
		,iif(TNIC.Tolerancia<(C.NUMINTNO+C.NUMINTPROGRAM+C.NUMINTREDES) or TDIC.Tolerancia<(C.DURINTNO+C.DURINTPROGRAM*0.5+C.DURINTREDES*0.25),'Si','No')
		,'--'
		)as Transgredió
	,iif( (C.NUMINTNO+C.NUMINTPROGRAM+C.NUMINTREDES-TNIC.Tolerancia)>0,(C.NUMINTNO+C.NUMINTPROGRAM+C.NUMINTREDES-TNIC.Tolerancia)/TNIC.Tolerancia,0) as e1
	,iif( (C.DURINTNO+C.DURINTPROGRAM*0.5+C.DURINTREDES*0.25-TDIC.Tolerancia)>0,(C.DURINTNO+C.DURINTPROGRAM*0.5+C.DURINTREDES*0.25-TDIC.Tolerancia)/TDIC.Tolerancia,0) as e2
	,iif( iif( (C.NUMINTNO+C.NUMINTPROGRAM+C.NUMINTREDES-TNIC.Tolerancia)>0,(C.NUMINTNO+C.NUMINTPROGRAM+C.NUMINTREDES-TNIC.Tolerancia)/TNIC.Tolerancia,0)
			+iif( (C.DURINTNO+C.DURINTPROGRAM*0.5+C.DURINTREDES*0.25-TDIC.Tolerancia)>0,(C.DURINTNO+C.DURINTPROGRAM*0.5+C.DURINTREDES*0.25-TDIC.Tolerancia)/TDIC.Tolerancia,0)>0
		,1 + iif( (C.NUMINTNO+C.NUMINTPROGRAM+C.NUMINTREDES-TNIC.Tolerancia)>0,(C.NUMINTNO+C.NUMINTPROGRAM+C.NUMINTREDES-TNIC.Tolerancia)/TNIC.Tolerancia,0)
			+iif( (C.DURINTNO+C.DURINTPROGRAM*0.5+C.DURINTREDES*0.25-TDIC.Tolerancia)>0,(C.DURINTNO+C.DURINTPROGRAM*0.5+C.DURINTREDES*0.25-TDIC.Tolerancia)/TDIC.Tolerancia,0)
		,0) as E
	,(C.DURINTNO+C.DURINTPROGRAM+C.DURINTREDES)*C.ENERGIA/(S.CantidadHoras-(C.DURINTNO+C.DURINTPROGRAM+C.DURINTREDES)) as ENS
	,0.35*
		iif( iif( (C.NUMINTNO+C.NUMINTPROGRAM+C.NUMINTREDES-TNIC.Tolerancia)>0,(C.NUMINTNO+C.NUMINTPROGRAM+C.NUMINTREDES-TNIC.Tolerancia)/TNIC.Tolerancia,0)
				+iif( (C.DURINTNO+C.DURINTPROGRAM*0.5+C.DURINTREDES*0.25-TDIC.Tolerancia)>0,(C.DURINTNO+C.DURINTPROGRAM*0.5+C.DURINTREDES*0.25-TDIC.Tolerancia)/TDIC.Tolerancia,0)>0
			,1+iif( (C.NUMINTNO+C.NUMINTPROGRAM+C.NUMINTREDES-TNIC.Tolerancia)>0,(C.NUMINTNO+C.NUMINTPROGRAM+C.NUMINTREDES-TNIC.Tolerancia)/TNIC.Tolerancia,0)
				+iif( (C.DURINTNO+C.DURINTPROGRAM*0.5+C.DURINTREDES*0.25-TDIC.Tolerancia)>0,(C.DURINTNO+C.DURINTPROGRAM*0.5+C.DURINTREDES*0.25-TDIC.Tolerancia)/TDIC.Tolerancia,0)
			,0)*
		(C.DURINTNO+C.DURINTPROGRAM+C.DURINTREDES)*C.ENERGIA/(S.CantidadHoras-(C.DURINTNO+C.DURINTPROGRAM+C.DURINTREDES))
		as [Compensación Calculada del CR1]
	, S.FactorAplicacionNTCSER
	, iif(C.COMPENSACIONINT*S.FactorAplicacionNTCSER>C.COMPENSACIONLEY,C.COMPENSACIONINT*S.FactorAplicacionNTCSER-C.COMPENSACIONLEY,0) as [Compensación a pagar]
FROM SIR_CR1_CR1S as C
	left join CalidadGenerales.dbo.Semestre as S on S.NombreSemestre =rtrim(ltrim(C.ANIO))+rtrim(ltrim(C.SEMESTRE))
	left join CalidadGenerales.dbo.SRV_SISTEMAS as I on C.EMPRESA=I.EMPRESA and C.CODSEMESTRE=i.SEMESTRE AND C.CODIGOSISELEC=I.SISTEMA
	left join CalidadSuministro.dbo.TblG_Tolerancias as TNIC on TNIC.SectorTípico=I.SECTORTIPICO and TNIC.NivelTensión=C.TENSION and TNIC.Indicador='NIC'
	left join CalidadSuministro.dbo.TblG_Tolerancias as TDIC on TDIC.SectorTípico=I.SECTORTIPICO and TDIC.NivelTensión=C.TENSION and TDIC.Indicador='DIC'
	left join (
				SELECT  ROW_NUMBER() OVER (partition by C.EMPRESA,C.CODSEMESTRE,S.NOMBRE ORDER BY C.EMPRESA,C.CODSEMESTRE,S.NOMBRE,C.CODSEMESTRE,E.SECTORTIPICO,RIGHT(C.CODIGOSISELEC,4)) AS Ítem	 --,E.SECTORTIPICO,E.SISTEMA
					,C.EMPRESA,S.NOMBRE,C.CODSEMESTRE,E.SECTORTIPICO,RIGHT(C.CODIGOSISELEC,4) as [Código de Sistema Eléctrico] --,*
				FROM CalidadSuministro.dbo.SIR_CR1_CR1S AS C
					left join CalidadGenerales.dbo.SRV_SEMESTRE_SEM as S on C.CODSEMESTRE=S.CODIGO
					left join CalidadGenerales.dbo.SRV_SISTEMAS as E on C.[EMPRESA]=E.EMPRESA and C.CODSEMESTRE=E.SEMESTRE and RIGHT(C.CODIGOSISELEC,4)=E.SISTEMA
				GROUP BY C.EMPRESA,S.NOMBRE,C.CODSEMESTRE,E.SECTORTIPICO,RIGHT(C.CODIGOSISELEC,4)
				--ORDER BY C.EMPRESA,S.NOMBRE,C.CODSEMESTRE,E.SECTORTIPICO,RIGHT(C.CODIGOSISELEC,4)
		) AS T on C.EMPRESA=T.EMPRESA AND RIGHT(C.CODIGOSISELEC,4)=T.[Código de Sistema Eléctrico] AND C.CODSEMESTRE=T.CODSEMESTRE
--ORDER BY C.EMPRESA,C.CODSEMESTRE,S.NOMBRE,T.Ítem,RIGHT(C.CODIGOSISELEC,4),C.TENSION
GO
/****** Object:  Table [dbo].[SRV_RIN]    Script Date: 03/07/2020 1:40:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_RIN](
	[EMPRESA] [varchar](3) NOT NULL,
	[INTERRUPCION] [varchar](10) NOT NULL,
	[SUBESTACION] [varchar](7) NOT NULL,
	[NUMSUMINISTRO] [varchar](10) NOT NULL,
	[TENSION] [varchar](3) NOT NULL,
	[FECHAINICIO] [datetime] NOT NULL,
	[FECHAFIN] [datetime] NOT NULL,
	[UBIGEO] [varchar](6) NOT NULL,
	[SOLORURAL] [varchar](1) NOT NULL,
	[NOMBREPERIODO] [varchar](10) NOT NULL,
	[SEMESTRE] [int] NOT NULL,
	[ID_CABECERA] [int] NOT NULL,
	[NroRegEnArchivoOrigen] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[RIN]    Script Date: 03/07/2020 1:40:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[RIN] AS
SELECT
	R.EMPRESA AS empresa
	, R.INTERRUPCION AS interrupcion
	, R.SUBESTACION AS subestacion
	, R.NUMSUMINISTRO AS numsuministro
	, R.TENSION AS tension
	, R.FECHAINICIO AS fechainicio
	, R.FECHAFIN AS fechafin
	, R.UBIGEO AS ubigeo
	, R.SOLORURAL AS solorural
	, R.NOMBREPERIODO AS periodo
	, R.SEMESTRE AS semestre
	, R.ID_CABECERA AS codigo_cabecera
	, R.NroRegEnArchivoOrigen AS NroRegEnArchivoOrigen
	, S.NombreSemestre
	, DATEDIFF(SS,R.FECHAINICIO,R.FECHAFIN)/3600.00 AS Duración
FROM SRV_RIN as R
left join [dbo].[ControlCargaArchivos] as C on R.ID_CABECERA=C.CodigoArchivoOrigen
LEFT JOIN [CalidadGenerales].[dbo].Semestre AS S ON R.SEMESTRE=S.CodigoSemestre
where C.UltimoValido='S'
GO
/****** Object:  Table [dbo].[SRV_RDI]    Script Date: 03/07/2020 1:40:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_RDI](
	[EMPRESA] [varchar](3) NOT NULL,
	[CODINTERRUPCION] [varchar](10) NOT NULL,
	[MODALIDADDETECCION] [varchar](1) NULL,
	[CODIGOINTERRUPCION] [varchar](1) NULL,
	[SOLICITUDMAYOR] [varchar](1) NULL,
	[CODIGOCAUSAINTERRUPCION] [varchar](1) NULL,
	[FECHAINICIOINTERRUPCION] [datetime] NULL,
	[FECHAFININTERRUPCION] [datetime] NULL,
	[FASESINTERRUMPIDAS] [varchar](3) NULL,
	[POTENCIAINTERRUMPIDA] [decimal](10, 3) NULL,
	[ENERGIANOSUMINISTRADA] [decimal](14, 3) NULL,
	[SUMINISTROREGULADO] [int] NULL,
	[CLIENTESAFECTADO] [int] NULL,
	[UBIGEOFALLA] [varchar](7) NULL,
	[MOTIVOFALLA] [varchar](50) NULL,
	[LOCALIZACIONFALLA] [varchar](50) NULL,
	[RDI_AFECTADO] [varchar](1) NULL,
	[RDI_ORIGENINTERRUPCION] [varchar](1) NULL,
	[CODOSI] [int] NULL,
	[NOMBREPERIODO] [varchar](10) NULL,
	[SEMESTRE] [int] NULL,
	[ID_CABECERA] [int] NULL,
	[NroRegEnArchivoOrigen] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[RDI]    Script Date: 03/07/2020 1:40:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[RDI]
AS
SELECT
	D.EMPRESA, CODINTERRUPCION, MODALIDADDETECCION, CODIGOINTERRUPCION AS codigotipointerrupcion, SOLICITUDMAYOR, CODIGOCAUSAINTERRUPCION, FECHAINICIOINTERRUPCION, 
	FECHAFININTERRUPCION, FASESINTERRUMPIDAS, POTENCIAINTERRUMPIDA, ENERGIANOSUMINISTRADA, SUMINISTROREGULADO, CLIENTESAFECTADO, UBIGEOFALLA, MOTIVOFALLA, LOCALIZACIONFALLA, 
	RDI_AFECTADO AS afectado, RDI_ORIGENINTERRUPCION AS origeninterrupcion, CODOSI, NOMBREPERIODO, SEMESTRE, ID_CABECERA AS codigo_cabecera, [NroRegEnArchivoOrigen]
	, (24.0*(cast(FECHAFININTERRUPCION as float) - cast(FECHAINICIOINTERRUPCION as float))) as [Tiempo de Interrupción]
	, cast(year(FECHAINICIOINTERRUPCION) AS nvarchar(4)) + iif(month(FECHAINICIOINTERRUPCION) > 6, 'S2', 'S1') AS SemestreInicioInt
	, year(FECHAINICIOINTERRUPCION) as [Año]
	, NombreSemestre, E.actividad
	, case 
		when (24.0*(cast(FECHAFININTERRUPCION as float) - cast(FECHAINICIOINTERRUPCION as float))) >= 12.0 then '[Mayores o igual a 12 horas]'
		when (24.0*(cast(FECHAFININTERRUPCION as float) - cast(FECHAINICIOINTERRUPCION as float))) > 4.0  then '[entre 4 y 12 horas]'
		when (24.0*(cast(FECHAFININTERRUPCION as float) - cast(FECHAINICIOINTERRUPCION as float))) <= 4.0  then '[Menor o igual a 4 horas]'
		end
		as Rango
FROM dbo.SRV_RDI as D
left join [CalidadGenerales].[dbo].[Semestre] as S
	on D.SEMESTRE=S.CodigoSemestre
left join [CalidadGenerales].[dbo].Empresa as E
	on D.Empresa=E.Empresa
GO
/****** Object:  Table [dbo].[SRV_PIN]    Script Date: 03/07/2020 1:40:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_PIN](
	[EMPRESA] [varchar](3) NOT NULL,
	[CODINTERRUPCION] [varchar](10) NOT NULL,
	[FECHAINICIOINTERRUPCION] [datetime] NULL,
	[CODIGOPROGRAMACION] [varchar](1) NULL,
	[FECHAFININTERRUPCION] [datetime] NULL,
	[AVISO1] [varchar](1) NULL,
	[FECHANOTIFICACION1] [datetime] NULL,
	[AVISO2] [varchar](1) NULL,
	[FECHANOTIFICACION2] [datetime] NULL,
	[UBICACIONINTERRUPCION] [varchar](60) NULL,
	[NOMBRERESPONSABLE] [varchar](60) NULL,
	[RESUMENACTIVIDADES] [varchar](200) NULL,
	[SUSTENTEXP] [varchar](150) NULL,
	[NUMSUMINISTROS] [int] NULL,
	[ZONAAFECT] [varchar](200) NULL,
	[IDENTIFICADOR] [varchar](1) NULL,
	[BLOB1FILENAME] [varchar](100) NULL,
	[BLOB1SIZE] [int] NULL,
	[BLOB1FILE] [varbinary](max) NULL,
	[BLOB2FILENAME] [varchar](100) NULL,
	[BLOB2SIZE] [int] NULL,
	[BLOB2FILE] [varbinary](max) NULL,
	[BLOB3FILENAME] [varchar](100) NULL,
	[BLOB3SIZE] [int] NULL,
	[BLOB3FILE] [varbinary](max) NULL,
	[PERIODO] [varchar](10) NULL,
	[SEMESTRE] [int] NULL,
	[RH_ID] [int] NULL,
	[SUSPEN] [varchar](1) NULL,
	[MOTIVOSUS] [varchar](1000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[PIN]    Script Date: 03/07/2020 1:40:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[PIN]
AS
SELECT
	P.EMPRESA, P.CODINTERRUPCION, P.FECHAINICIOINTERRUPCION, P.CODIGOPROGRAMACION, P.FECHAFININTERRUPCION
	, P.AVISO1, P.FECHANOTIFICACION1, P.AVISO2, P.FECHANOTIFICACION2, P.UBICACIONINTERRUPCION, P.NOMBRERESPONSABLE, P.RESUMENACTIVIDADES
	, P.SUSTENTEXP, P.NUMSUMINISTROS, P.ZONAAFECT, P.IDENTIFICADOR
	, P.BLOB1FILENAME, P.BLOB1SIZE, P.BLOB1FILE, P.BLOB2FILENAME, P.BLOB2SIZE, P.BLOB2FILE, P.BLOB3FILENAME, P.BLOB3SIZE, P.BLOB3FILE, P.PERIODO, P.SEMESTRE, P.RH_ID AS idheader, P.SUSPEN AS suspendido, P.MOTIVOSUS
	, cast(year(P.[fechainiciointerrupcion]) AS nvarchar(4)) + iif(month(P.[fechainiciointerrupcion]) > 6, 'S2', 'S1') AS SemestreInicioInt
	, iif(P.SUSPEN = 'S', 1, 0) AS InterrupcionSuspendida
	, iif((len(P.BLOB1FILENAME) = 0 OR P.BLOB1FILENAME IS NULL) AND (len(P.BLOB2FILENAME) = 0 OR P.BLOB2FILENAME IS NULL) AND upper(P.SUSPEN) <> 'S', 1, 0) AS InterrupcionNoReportaNotificacion
	, ltrim(str(year(P.[FECHAINICIOINTERRUPCION]))) + RIGHT('0' + ltrim(str(month(P.[FECHAINICIOINTERRUPCION]))), 2) AS PeriodoMes
	, iif( (len(P.BLOB1FILENAME)>0 or len(P.BLOB2FILENAME)>0) and P.SUSPEN='S' and (len(P.BLOB3FILENAME)=0 or P.BLOB3FILENAME is null) , 1,0) as InterrupcionSuspendidaSinNotificacion
	, E.actividad, E.Norma, E.NombreEmpresa
	--, R.[EMPRESA] as RDI_Empresa, R.[CODINTERRUPCION] as RDI_CODINTERRUPCION
	--, R.[MODALIDADDETECCION], R.[codigotipointerrupcion], R.[SOLICITUDMAYOR], R.[CODIGOCAUSAINTERRUPCION]
	--, R.[FECHAINICIOINTERRUPCION] as RDI_FECHAINICIOINTERRUPCION, R.[FECHAFININTERRUPCION] as RDI_FECHAFININTERRUPCION
	--, R.[FASESINTERRUMPIDAS], R.[POTENCIAINTERRUMPIDA], R.[ENERGIANOSUMINISTRADA], R.[SUMINISTROREGULADO], R.[CLIENTESAFECTADO]
	--, R.[UBIGEOFALLA], R.[MOTIVOFALLA], R.[LOCALIZACIONFALLA], R.[afectado], R.[origeninterrupcion], R.[CODOSI]
	--, R.[NOMBREPERIODO] as RDI_NOMBREPERIODO, R.[SEMESTRE] as RDI_SEMESTRE, R.[codigo_cabecera] as RDI_codigo_cabecera, R.[SemestreInicioInt] as RDI_SemestreInicioInt
FROM dbo.SRV_PIN as P
left join CalidadGenerales.dbo.Empresa as E on P.EMPRESA=E.Empresa
--left join [dbo].[RDI] as R 	on R.SemestreInicioInt =cast(year(P.[fechainiciointerrupcion]) AS nvarchar(4)) + iif(month(P.[fechainiciointerrupcion]) > 6, 'S2', 'S1')
--	AND R.empresa=P.empresa AND R.codinterrupcion=P.codinterrupcion
GO
/****** Object:  Table [dbo].[SIR_CR3_CR3S]    Script Date: 03/07/2020 1:40:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SIR_CR3_CR3S](
	[EMPRESA] [varchar](3) NOT NULL,
	[ANIO] [varchar](4) NULL,
	[SEMESTRE] [varchar](2) NULL,
	[CODIGOALIMENTADOR] [varchar](7) NULL,
	[CODIGOSUMINISTRO] [varchar](10) NULL,
	[NUMINTNO] [varchar](4) NULL,
	[NUMINTPROG] [varchar](4) NULL,
	[NUMINTEXP] [varchar](4) NULL,
	[DURINTNO] [decimal](8, 2) NULL,
	[DURINTPROG] [decimal](8, 2) NULL,
	[DURINTEXP] [decimal](8, 2) NULL,
	[ENERGIA] [decimal](18, 3) NULL,
	[COMPESACIONEXT] [decimal](14, 4) NULL,
	[COMPENSACIONLCE] [decimal](14, 4) NULL,
	[NOMBREPERIODO] [varchar](10) NULL,
	[CODSEMESTRE] [int] NULL,
	[ID_CABECERA] [int] NULL,
	[FechaPeriodo]  AS ([dbo].[GetFechaInicioPeriodo]([NOMBREPERIODO])),
	[NroRegEnArchivoOrigen] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[NormaRural_CR3_Semestral]    Script Date: 03/07/2020 1:40:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[NormaRural_CR3_Semestral]
AS
SELECT --top 10
C.EMPRESA AS empresa, C.ANIO AS anio, C.SEMESTRE AS semestre, C.CODIGOALIMENTADOR AS CODIGOALIMENTADOR, C.CODIGOSUMINISTRO AS CODIGOSUMINISTRO
, C.NUMINTNO AS numintno, C.NUMINTPROG AS numintprog, C.NUMINTEXP AS numintexp, C.DURINTNO AS durintno, C.DURINTPROG AS durintprog, C.DURINTEXP AS durintexp
, C.ENERGIA AS energia, C.COMPESACIONEXT AS compensacionext, C.COMPENSACIONLCE AS compensacionlce
, C.NOMBREPERIODO AS nombreperiodo, C.CODSEMESTRE AS codigosemestre, C.ID_CABECERA AS codigo_cabecera
, IIF(C.COMPESACIONEXT - ISNULL(C.COMPENSACIONLCE, 0)>0,C.COMPESACIONEXT - ISNULL(C.COMPENSACIONLCE, 0),0) AS MontoACompensar
, T.NombreSemestre
, e.nombre AS NombreEmpresa
, C.FechaPeriodo
, SS.identificacion, SS.direccion, SS.subestacion, SS.ubicacion, SS.marca, SS.modelo, SS.medidor, SS.serie
, SS.DistritoNombre, SS.DeptNombre as Departamento
, SS.sistemaelectrico, SS.sectortipico, SS.nomsistema, SS.tiposistema, SS.Norma
FROM SIR_CR3_CR3S AS C
LEFT OUTER JOIN CalidadGenerales.dbo.Semestre AS T ON C.CODSEMESTRE = T.CodigoSemestre
LEFT OUTER JOIN CalidadGenerales.dbo.Empresa AS E ON C.EMPRESA=e.codigo
left join [CalidadGenerales].[dbo].suministros as SS on C.empresa=SS.empresa and C.CODIGOSUMINISTRO=SS.suministro
	and ( (SS.FechaDesde<=C.FechaPeriodo) and (C.FechaPeriodo<SS.FechaHasta) )
GO
/****** Object:  Table [dbo].[SRV_P074_Anexo2]    Script Date: 03/07/2020 1:40:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_P074_Anexo2](
	[empresa] [varchar](3) NULL,
	[numClientes] [int] NULL,
	[SAIFI_SISELEC] [float] NULL,
	[SAIFI_INTPROG] [float] NULL,
	[SAIFI_INT_NOPROG] [float] NULL,
	[SAIFI_RCHZ_CGA] [float] NULL,
	[SAIFI_INST_DIST] [float] NULL,
	[SAIFI_INST_TRAN] [float] NULL,
	[SAIFI_INST_GEN] [float] NULL,
	[SAIFI_CAU_PROP] [float] NULL,
	[SAIFI_CAU_TER] [float] NULL,
	[SAIFI_CAU_EXT] [float] NULL,
	[SAIFI_CAU_FN] [float] NULL,
	[SAIFI_CAU_FM] [float] NULL,
	[SAIDI_SISELEC] [float] NULL,
	[SAIDI_INT_PROG] [float] NULL,
	[SAIDI_INT_NO_PROG] [float] NULL,
	[SAIDI_RCHZ_CGA] [float] NULL,
	[SAIDI_INST_DIST] [float] NULL,
	[SAIDI_INST_TRANS] [float] NULL,
	[SAIDI_INST_GEN] [float] NULL,
	[SAIDI_CAU_PROP] [float] NULL,
	[SAIDI_CAU_TER] [float] NULL,
	[SAIDI_CAU_EXT] [float] NULL,
	[SAIDI_CAU_FN] [float] NULL,
	[SAIDI_CAU_FM] [float] NULL,
	[periodo] [datetime] NULL,
	[iddeclaracion] [int] NULL,
	[sistelec] [varchar](6) NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[P074_Anexo2]    Script Date: 03/07/2020 1:40:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[P074_Anexo2]
AS
SELECT
	A2.[empresa],A2.[numClientes]
	,A2.[SAIFI_SISELEC],A2.[SAIFI_INTPROG],A2.[SAIFI_INT_NOPROG],A2.[SAIFI_RCHZ_CGA],A2.[SAIFI_INST_DIST],A2.[SAIFI_INST_TRAN],A2.[SAIFI_INST_GEN],A2.[SAIFI_CAU_PROP],A2.[SAIFI_CAU_TER],A2.[SAIFI_CAU_EXT],A2.[SAIFI_CAU_FN],A2.[SAIFI_CAU_FM]
	,A2.[SAIDI_SISELEC],A2.[SAIDI_INT_PROG],A2.[SAIDI_INT_NO_PROG],A2.[SAIDI_RCHZ_CGA],A2.[SAIDI_INST_DIST],A2.[SAIDI_INST_TRANS],A2.[SAIDI_INST_GEN],A2.[SAIDI_CAU_PROP],A2.[SAIDI_CAU_TER],A2.[SAIDI_CAU_EXT],A2.[SAIDI_CAU_FN],A2.[SAIDI_CAU_FM]
	,A2.[periodo]
	,A2.[iddeclaracion]
	,A2.[sistelec]
	,ltrim(str(year(A2.[periodo]))) + RIGHT('0' + ltrim(str(month(A2.[periodo]))), 2) AS PeriodoMes
	,ltrim(str(year(A2.[periodo]))) + iif(month(A2.[periodo])>6,'S2','S1') AS NombreSemestre
	,M.[codigontcse], M.[sector]
FROM [dbo].[SRV_P074_Anexo2] as A2
left join CalidadGenerales.[dbo].[MaestroSistemas] as M
	on A2.[empresa]=M.empresa and A2.sistelec=M.[codigogfeit]
		and ltrim(str(year(A2.[periodo]))) + iif(month(A2.[periodo])>6,'S2','S1')=M.NombreSemestre
-- where ltrim(str(year(A2.[periodo]))) + iif(month(A2.[periodo])>6,'S2','S1')='2017S1'
	--and M.[codigontcse] is null
-- select * from CalidadGenerales.[dbo].[MaestroSistemas] where codigoSemestre=449 and empresa ='CHA'
-- select * from CalidadGenerales.[dbo].sistemas where Semestre=449 and empresa ='CHA'
-- select CodigoSemestre, count(*) from CalidadGenerales.[dbo].[MaestroSistemas] group by CodigoSemestre

GO
/****** Object:  Table [dbo].[SRV_CI2_S]    Script Date: 03/07/2020 1:40:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_CI2_S](
	[EMPRESA] [varchar](3) NULL,
	[ANIO] [varchar](4) NULL,
	[SEMESTRE] [varchar](2) NULL,
	[CODIGOREVELADOR] [varchar](10) NULL,
	[CODIGOSUMINISTRO] [varchar](10) NULL,
	[ENERGIA] [decimal](21, 3) NULL,
	[COMPENSACION] [decimal](18, 4) NULL,
	[NOMBREPERIODO] [varchar](10) NULL,
	[CODSEMESTRE] [int] NULL,
	[ID_CABECERA] [int] NULL,
	[NroRegEnArchivoOrigen] [int] NULL,
	[FechaPeriodo]  AS ([dbo].[GetFechaInicioPeriodo]([NOMBREPERIODO]))
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[CI2_S]    Script Date: 03/07/2020 1:40:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CI2_S] AS SELECT
C.EMPRESA AS empresa
, C.ANIO AS anio
, C.SEMESTRE AS semestre
, C.CODIGOREVELADOR AS codigorevelador
, C.CODIGOSUMINISTRO AS codigosuministro
, C.ENERGIA AS energia
, C.COMPENSACION AS compensacion
, C.NOMBREPERIODO AS nombreperiodo
, C.CODSEMESTRE AS codigosemestre
, C.ID_CABECERA AS codigo_cabecera
, C.NroRegEnArchivoOrigen AS NroRegEnArchivoOrigen
, C.FechaPeriodo
, T.NombreSemestre
, E.nombre AS NombreEmpresa
, SS.identificacion
, SS.direccion
, SS.subestacion
, SS.ubicacion
, SS.marca
, SS.modelo
, SS.medidor
, SS.serie
, SS.DistritoNombre
, SS.DeptNombre as Departamento
, SS.sistemaelectrico
, SS.sectortipico
, SS.nomsistema
, SS.tiposistema
, SS.Norma
, SS.TipoClienteTension as TipoUsuario
, SS.opcion as TarifaUsuario
FROM SRV_CI2_S AS C
	LEFT OUTER JOIN CalidadGenerales.dbo.Semestre AS T ON C.CODSEMESTRE = T.CodigoSemestre
	LEFT OUTER JOIN CalidadGenerales.dbo.Empresa AS E ON C.EMPRESA=E.codigo
	left join [dbo].[ControlCargaArchivos] as D on C.ID_CABECERA=D.CodigoArchivoOrigen
	left join [CalidadGenerales].[dbo].suministros as SS on C.empresa=SS.empresa and C.CODIGOSUMINISTRO=SS.suministro
		and ( (SS.FechaDesde<=C.FechaPeriodo) and (C.FechaPeriodo<SS.FechaHasta) )
where D.UltimoValido='S'
GO
/****** Object:  Table [dbo].[SRV_CI1_S]    Script Date: 03/07/2020 1:40:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_CI1_S](
	[EMPRESA] [varchar](3) NULL,
	[ANIO] [varchar](4) NULL,
	[SEMESTRE] [varchar](2) NULL,
	[UBIGEOCLIENTE] [varchar](10) NULL,
	[UBIGEOSUMINISTRO] [varchar](6) NULL,
	[TENSION] [varchar](2) NULL,
	[NUMINTNO] [int] NULL,
	[NUMINTPROGRAM] [int] NULL,
	[NUMINTREDES] [int] NULL,
	[DURINTNO] [decimal](10, 2) NULL,
	[DURINTPROGRAM] [decimal](10, 2) NULL,
	[DURINTREDES] [decimal](10, 2) NULL,
	[ENERGIA] [decimal](21, 3) NULL,
	[COMPENSACIONINT] [decimal](18, 4) NULL,
	[COMPENSACIONLEY] [decimal](18, 4) NULL,
	[NOMBREPERIODO] [varchar](10) NULL,
	[CODSEMESTRE] [int] NULL,
	[ID_CABECERA] [int] NULL,
	[NroRegEnArchivoOrigen] [int] NULL,
	[FechaPeriodo]  AS ([dbo].[GetFechaInicioPeriodo]([NOMBREPERIODO]))
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[CI1_S]    Script Date: 03/07/2020 1:40:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[CI1_S]
AS
SELECT --top 100
C.EMPRESA AS empresa, C.ANIO AS anio, C.SEMESTRE AS semestre
, C.UBIGEOCLIENTE AS ubigeocliente, C.UBIGEOSUMINISTRO AS ubigeosuministro
, C.TENSION AS tension
, C.NUMINTNO AS numintno, C.NUMINTPROGRAM AS numintprogram, C.NUMINTREDES AS numintredes, C.DURINTNO AS durintno, C.DURINTPROGRAM AS durintprogram, C.DURINTREDES AS durintredes
, C.ENERGIA AS energia, C.COMPENSACIONINT AS compensacionint, C.COMPENSACIONLEY AS compensacionley
, C.NOMBREPERIODO AS nombreperiodo, C.CODSEMESTRE AS codigosemestre, C.ID_CABECERA AS codigo_cabecera, C.NroRegEnArchivoOrigen AS NroRegEnArchivoOrigen
, C.UBIGEOCLIENTE AS suministro
, C.FechaPeriodo
, S.NombreSemestre
, E.actividad as ActividadEmpresa
, c.numintno+c.numintprogram+c.numintredes*0.5 as N
, c.durintno+c.durintprogram*0.5+c.durintredes*0.25 as D
, c.anio+c.semestre as SemestreEvaluado
, SS.identificacion
, SS.direccion
, SS.ubicacion
, SS.DistritoNombre
, SS.DeptNombre as Departamento
, SS.sistemaelectrico
, SS.sectortipico
, SS.nomsistema
, SS.tiposistema
, SS.Norma
, SS.opcion as TarifaUsuario
, SS.marca
, SS.modelo
, SS.medidor
, SS.serie
, SS.codsubestacion as SED_VNR
, SS.subestacion
, ss.UTMSedEste, ss.UTMSedNorte,ss.UbigeoSED, ss.alimentador
FROM SRV_CI1_S AS C
LEFT JOIN [CalidadGenerales].[dbo].Empresa AS E ON C.EMPRESA=E.Empresa
LEFT JOIN [CalidadGenerales].[dbo].Semestre AS S ON C.CODSEMESTRE=S.CodigoSemestre
left join [CalidadGenerales].[dbo].suministros as SS on C.empresa=SS.empresa and C.UBIGEOCLIENTE=SS.suministro
and ( (SS.FechaDesde<=C.FechaPeriodo) and (C.FechaPeriodo<SS.FechaHasta) )	
GO
/****** Object:  Table [dbo].[SRV_CI1_T]    Script Date: 03/07/2020 1:40:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_CI1_T](
	[EMPRESA] [varchar](3) NULL,
	[ANIO] [varchar](4) NULL,
	[SEMESTRE] [varchar](2) NULL,
	[UBIGEOCLIENTE] [varchar](10) NULL,
	[UBIGEOSUMINISTRO] [varchar](6) NULL,
	[TENSION] [varchar](2) NULL,
	[NUMINTNO] [int] NULL,
	[NUMINTPROGRAM] [int] NULL,
	[NUMINTREDES] [int] NULL,
	[DURINTNO] [decimal](10, 2) NULL,
	[DURINTPROGRAM] [decimal](10, 2) NULL,
	[DURINTREDES] [decimal](10, 2) NULL,
	[ENERGIA] [decimal](21, 3) NULL,
	[COMPENSACIONINT] [decimal](18, 4) NULL,
	[COMPENSACIONLEY] [decimal](18, 4) NULL,
	[NOMBREPERIODO] [varchar](10) NULL,
	[CODSEMESTRE] [int] NULL,
	[ID_CABECERA] [int] NULL,
	[NroRegEnArchivoOrigen] [int] NULL,
	[FechaPeriodo]  AS ([dbo].[GetFechaInicioPeriodo]([NOMBREPERIODO]))
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[CI1_T]    Script Date: 03/07/2020 1:40:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE VIEW [dbo].[CI1_T] AS SELECT
		EMPRESA AS empresa
		, ANIO AS anio
		, SEMESTRE AS semestre
		, UBIGEOCLIENTE AS ubigeocliente
		, UBIGEOSUMINISTRO AS ubigeosuministro
		, TENSION AS tension
		, NUMINTNO AS numintno
		, NUMINTPROGRAM AS numintprogram
		, NUMINTREDES AS numintredes
		, DURINTNO AS durintno
		, DURINTPROGRAM AS durintprogram
		, DURINTREDES AS durintredes
		, ENERGIA AS energia
		, COMPENSACIONINT AS compensacionint
		, COMPENSACIONLEY AS compensacionley
		, NOMBREPERIODO AS nombreperiodo
		, CODSEMESTRE AS codigosemestre
		, ID_CABECERA AS codigo_cabecera
		, NroRegEnArchivoOrigen AS NroRegEnArchivoOrigen
	FROM SRV_CI1_T
GO
/****** Object:  Table [dbo].[SIR_CR1_CR1S_Anterior]    Script Date: 03/07/2020 1:40:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SIR_CR1_CR1S_Anterior](
	[EMPRESA] [varchar](3) NOT NULL,
	[ANIO] [varchar](4) NULL,
	[SEMESTRE] [varchar](2) NULL,
	[CODIGOSISELEC] [varchar](10) NULL,
	[TENSION] [varchar](2) NULL,
	[NUMINTNO] [decimal](6, 2) NULL,
	[NUMINTPROGRAM] [decimal](6, 2) NULL,
	[NUMINTREDES] [decimal](6, 2) NULL,
	[DURINTNO] [decimal](8, 2) NULL,
	[DURINTPROGRAM] [decimal](8, 2) NULL,
	[DURINTREDES] [decimal](8, 2) NULL,
	[ENERGIA] [decimal](18, 3) NULL,
	[COMPENSACIONINT] [decimal](14, 4) NULL,
	[COMPENSACIONLEY] [decimal](14, 4) NULL,
	[NOMBREPERIODO] [varchar](10) NULL,
	[CODSEMESTRE] [int] NULL,
	[ID_CABECERA] [int] NULL,
	[NroRegEnArchivoOrigen] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SRV_CI2_S_txt]    Script Date: 03/07/2020 1:40:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_CI2_S_txt](
	[empresa ] [nvarchar](255) NULL,
	[anio ] [nvarchar](255) NULL,
	[semestre ] [nvarchar](255) NULL,
	[codigorevelador ] [nvarchar](255) NULL,
	[codigosuministro ] [nvarchar](255) NULL,
	[energia ] [nvarchar](255) NULL,
	[compensacion ] [float] NULL,
	[nombreperiodo ] [nvarchar](255) NULL,
	[codigosemestre ] [nvarchar](255) NULL,
	[codigo_cabecera ] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SRV_P074_Anexo1]    Script Date: 03/07/2020 1:40:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_P074_Anexo1](
	[empresa] [varchar](3) NOT NULL,
	[sistelec] [varchar](10) NOT NULL,
	[codimportante] [varchar](10) NOT NULL,
	[codintempresa] [varchar](10) NOT NULL,
	[tipoinstalacionsalio] [varchar](1) NULL,
	[codinstalacionsalio] [varchar](255) NULL,
	[tipoinstalacion] [varchar](1) NULL,
	[codinstalacionfalla] [varchar](255) NULL,
	[inicio] [datetime] NULL,
	[compuesta] [datetime] NULL,
	[fin] [datetime] NULL,
	[afectados] [int] NULL,
	[demandaafectada] [float] NULL,
	[horassuministro] [float] NULL,
	[codnaturaleza] [varchar](2) NULL,
	[niveltension] [varchar](1) NULL,
	[propiedadcausante] [varchar](1) NULL,
	[responsabilidad] [varchar](1) NULL,
	[codcausa] [varchar](2) NULL,
	[fuerzamayor] [varchar](1) NULL,
	[tipoelemento] [varchar](1) NULL,
	[iddeclaracion] [int] NULL,
	[periodo] [datetime] NULL,
	[codigosinergmin] [int] NULL,
	[Anio]  AS (datepart(year,[PERIODO])),
	[PeriodoSemestre]  AS (CONVERT([varchar](4),datepart(year,[PERIODO]))+case when datepart(month,[PERIODO])>(6) then 'S2' else 'S1' end),
	[SemestreInicioInt]  AS (CONVERT([varchar](4),datepart(year,[inicio]))+case when datepart(month,[inicio])>(6) then 'S2' else 'S1' end)
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SRV_RIN_Datos]    Script Date: 03/07/2020 1:40:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_RIN_Datos](
	[Empresa] [varchar](3) NOT NULL,
	[Interrupcion] [varchar](10) NOT NULL,
	[Subestacion] [varchar](7) NOT NULL,
	[Suministro] [varchar](10) NOT NULL,
	[NivelTension] [varchar](3) NOT NULL,
	[FechaIniReal] [datetime] NOT NULL,
	[FechaFinReal] [datetime] NOT NULL,
	[UbigeoRIN] [varchar](6) NOT NULL,
	[NormaRIN] [varchar](1) NOT NULL,
	[Periodo] [varchar](10) NOT NULL,
	[SemestreRIN] [int] NOT NULL,
	[ID_CABECERA] [int] NOT NULL,
	[NroRegEnArchivoOrigen] [int] NULL,
	[NombreSemestre] [varchar](6) NULL,
	[CodTipoIntRDI] [varchar](1) NULL,
	[CodigoCausaInterrrupcion] [varchar](1) NULL,
	[OrigenInterrupcion] [varchar](1) NULL,
	[FuerzaMayor] [varchar](1) NULL,
	[CODOSI] [int] NULL,
	[FechaIniRDI] [datetime] NULL,
	[FechaFinRDI] [datetime] NULL,
	[CodTipoIntPIN] [varchar](1) NULL,
	[FechaIniProg] [datetime] NULL,
	[FechaFinProg] [datetime] NULL,
	[Ubicacion] [varchar](6) NULL,
	[Opcion] [varchar](5) NULL,
	[TensionNominal] [decimal](5, 2) NULL,
	[SEDSuministros] [varchar](7) NULL,
	[Alimentador] [varchar](7) NULL,
	[Localidad] [varchar](4) NULL,
	[NombreLocalidad] [varchar](20) NULL,
	[SistemaElectrico] [varchar](4) NULL,
	[NombreSistema] [varchar](20) NULL,
	[TipoSistema] [varchar](4) NULL,
	[SectorTipico] [varchar](1) NULL,
	[Norma] [varchar](1) NULL,
	[Actividad] [varchar](2) NULL,
	[DeptNombre] [nvarchar](100) NULL,
	[DistritoNombre] [nvarchar](100) NULL,
	[AlimentadorMT] [varchar](7) NULL,
	[TipoClienteTension] [varchar](2) NULL,
	[UbigeoSED] [varchar](6) NULL,
	[UTMSedEste] [decimal](11, 3) NULL,
	[UTMSedNorte] [decimal](11, 3) NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[Proc_ActualizarRIN]    Script Date: 03/07/2020 1:40:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_ActualizarRIN]
	@NombreSemestre varchar(6),
	@CodigoArchivoOrigen int,
    @NombrePeriodo varchar(6), -- este dato se obtiene del nombre de archivo, que es segun formato de la BMR
	@NombreArchivo varchar(100),
	@ArchivoConRuta varchar(400), --ES EL ARCHIVO QUE SE QUIERE CARGAR, DEBE SER RIN PARA ESTE CASO
	@UltimoValido varchar(1)
AS	
begin
-- Bloque para pruebas
/*
EXECUTE dbo.Proc_ActualizarRIN '2017S2', 193602154, '2017T4', 'SEAA17T4.RIN', 'D:\BDatos\DatosPlanos\Suministro\RIN\2017S2\SEAA17T4.RIN_193602154.txt', 'S'
    Declare @NombreSemestre varchar(6),
	@CodigoArchivoOrigen varchar(14),
	@NombrePeriodo varchar(6),
	@NombreArchivo varchar(100),
	@ArchivoConRuta varchar(400), --ES EL ARCHIVO QUE SE QUIERE CARGAR, DEBE SER RIN PARA ESTE CASO
	@UltimoValido varchar(1)

	set @NombreSemestre = '2017S2'
	set @CodigoArchivoOrigen = 193602154
	set @NombrePeriodo = '2017T4'
	set @NombreArchivo= 'SEAA17T4.RIN'
	set @ArchivoConRuta = 'D:\BDatos\DatosPlanos\Suministro\RIN\2017S2\SEAA17T4.RIN_193602154.txt'
	set @UltimoValido= 'S'
*/
	-- Ver SiArchivoEstaCargado 
	DECLARE @CodigoArchivoOrigen2 int, @CantidadRegistros int, @CodigoSemestre int 
	set @CodigoSemestre=[CalidadGenerales].dbo.[GetCodigoSemestre](@NombreSemestre)
	select @CodigoArchivoOrigen2=CodigoArchivoOrigen, @CantidadRegistros=Cantidad from [dbo].[ControlCargaArchivos]
		where  CodigoArchivoOrigen=@CodigoArchivoOrigen
	if @CodigoArchivoOrigen2=@CodigoArchivoOrigen
		print 'archivo ya esta cargado: '+cast(@CodigoArchivoOrigen2 as varchar(20))+' y tiene '+cast(@CantidadRegistros as varchar(20))+' registros'
	else
	Begin
		print 'archivo aun no cargado, iniciamos carga de datos'
	--end
		-- VAriables de tiempo
		declare @tiempo1 datetime, @tiempo2 datetime
		set @tiempo1=GETDATE()
		-- Crea tablas temporales
		CREATE TABLE #Temp1([fuente] [nvarchar](max) NOT NULL) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
		CREATE TABLE #Temp2([NumOrden] [int] IDENTITY ( 1, 1 ),[fuente] [nvarchar](max) NOT NULL) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
		--Declare @ArchivoConRuta varchar(400) --ES EL ARCHIVO QUE SE QUIERE CARGAR, DEBE SER RIN PARA ESTE CASO
		--Set @ArchivoConRuta= '\\Isabelpc\d\NTCSE\EOR\CTR\Reporte RIN 2010_2016\EORA10T1.RIN'
		print 'Cargando tabla '+@ArchivoConRuta
		--Inserta los registros del archivo RIN Plano a la tabla temporal 1
		DECLARE @TableName varchar(400)
		SET @TableName = '#Temp1'
		DECLARE @SQL varchar(5000)
		SET @SQL = 'BULK INSERT ' + @TableName + ' FROM ''' + @ArchivoConRuta + '''' 
		EXEC (@SQL)
		--reporta cantidad de registros que hay en la tabla
		--DECLARE @CantidadRegistros int
		select @CantidadRegistros= count(*)  from #Temp1
		print 'Cantidad de registros :'+cast(@CantidadRegistros as varchar)+', en archivo plano'
		--Añade el numero de registro
		INSERT INTO #Temp2 select fuente from #Temp1
		-- Borramos los vacios que pudieran haber
		select @CantidadRegistros= count(*)  from #Temp2 WHERE fuente is null OR LEN(fuente)=0
		if @CantidadRegistros>0
		begin
			DELETE FROM #Temp2 WHERE fuente is null OR LEN(fuente)=0
			print 'Cantidad de registros vacios: '+cast(@CantidadRegistros as varchar)+', en archivo plano'
		end
		--reporta cantidad de registros que hay en la tabla
		--select @CantidadRegistros= count(*)  from #Temp2
		--print 'Cantidad de registros '+cast(@CantidadRegistros as varchar)+' en archivo plano con numero de orden'
		--INGRESA LA INFORMACION DEL TEMPORAL AL ARCHIVO RIN
/*		
		Declare @ArchivoConRuta varchar(400), --ES EL ARCHIVO QUE SE QUIERE CARGAR, DEBE SER RIN PARA ESTE CASO
		@NombreSemestre varchar(6),
		@CodigoArchivoOrigen varchar(14),
		@NombrePeriodo varchar(6)
		/*set @ArchivoConRuta = '\\Isabelpc\d\NTCSE\EOR\CTR\Reporte RIN 2010_2016\EORA16T2.RIN'
		set @NombreSemestre = '2016S1'
		set @CodigoArchivoOrigen = '77536707'*/

		set @ArchivoConRuta = 'T:\NTCSE\ESE\2014S2R\ArchivosPlanos\ESEA14T3.RIN 5629584.TXT'
		set @NombreSemestre = '2014S2'
		set @CodigoArchivoOrigen = '5629584'
		set @NombrePeriodo = '2014T3'
		--Declare @NombrePeriodo varchar(6) 
		--Set @NombrePeriodo= '20'+LEFT(RIGHT(@ArchivoConRuta,8),4)
*/
		--Verifica si existe la tabla RinTemporal y la Borra de ser el caso

		IF OBJECT_ID (N'DBO.RinTemporal', N'U') IS NOT NULL
			begin	
			DROP TABLE DBO.RinTemporal	
			end
		
		--Crea tabla Rin temporal y carga datos

		SELECT TOP 1 * INTO DBO.RinTemporal FROM SRV_RIN WHERE 0=1
		set dateformat dmy
		INSERT into RinTemporal
		SELECT 
			LTRIM(RTRIM(SUBSTRING(fuente,1,3))) as [EMPRESA]
			, LTRIM(RTRIM(SUBSTRING(fuente,4,10))) as [INTERRUPCION]
			, LTRIM(RTRIM(SUBSTRING(fuente,14,7))) as [SUBESTACION]
			, LTRIM(RTRIM(SUBSTRING(fuente,21,10))) as [NUMSUMINISTRO]
			, LTRIM(RTRIM(SUBSTRING(fuente,31,3))) as [TENSION]
			, DATETIMEFROMPARTS((SUBSTRING(fuente,38,4)),(SUBSTRING(fuente,36,2)),(SUBSTRING(fuente,34,2)),(SUBSTRING(fuente,42,2)),(SUBSTRING(fuente,44,2)),(SUBSTRING(fuente,46,2)),0) as [FECHAINICIO]
			, DATETIMEFROMPARTS((SUBSTRING(fuente,52,4)),(SUBSTRING(fuente,50,2)),(SUBSTRING(fuente,48,2)),(SUBSTRING(fuente,56,2)),(SUBSTRING(fuente,58,2)),(SUBSTRING(fuente,60,2)),0) as [FECHAFIN]
			, LTRIM(RTRIM(SUBSTRING(fuente,62,6))) as [UBIGEO]
			, LTRIM(RTRIM(SUBSTRING(fuente,68,1))) as [SOLORURAL]
			, @NombrePeriodo as [NOMBREPERIODO]
			, @CodigoSemestre as [SEMESTRE]
			, @CodigoArchivoOrigen
			, NumOrden
		FROM #Temp2
		--SELECT * FROM #Temp2

		-- Inserta los registros cargados a la tabla temporal
			-- Aca puede incluirse las validaciones para que no se cargue data inconsistente		
		INSERT INTO SRV_RIN
		SELECT [EMPRESA], [INTERRUPCION], [SUBESTACION], [NUMSUMINISTRO], [TENSION], [FECHAINICIO], [FECHAFIN], [UBIGEO], [SOLORURAL], [NOMBREPERIODO], [SEMESTRE], [ID_CABECERA], [NroRegEnArchivoOrigen]
		FROM [dbo].[RinTemporal]

		IF @@ERROR <> 0   
			BEGIN  
				-- Return 99 to the calling program to indicate failure.  
				PRINT N'Occurrio un error en el ingreso, no cumple alguna regla de admisión, error número '+cast(@@ERROR as varchar(15));  
			END
		ELSE  
			BEGIN  
				-- Actualiza el archivo de control
				IF @UltimoValido='S'
					BEGIN
						UPDATE ControlCargaArchivos
						SET UltimoValido='N'
						WHERE ([NombreArchivo]=@NombreArchivo) AND (UltimoValido='S')
					END
				--
				set @tiempo2=GETDATE()
				INSERT INTO ControlCargaArchivos
				SELECT 
					S.EMPRESA as CodEmpresa
				    ,@NombrePeriodo as NombrePeriodo
					,@NombreSemestre as NombreSemestre
					,S.ID_CABECERA as CodigoArchivoOrigen
					,count(*) as CANTIDAD
					,A.tipoarchivo
					,T.Norma
					, @tiempo1
					, @tiempo2
					, @NombreArchivo
					, @ArchivoConRuta
				    , @UltimoValido
				FROM RinTemporal as S
					left join RECEPTORArchivos.dbo.CabeceraEnvio as A on S.ID_CABECERA=A.codigointerno
					left join RECEPTORArchivos.dbo.TipoArchivos as T on A.tipoarchivo=T.TipoArchivoSirvan
				GROUP BY S.EMPRESA,S.ID_CABECERA,A.tipoarchivo,T.Norma --, @tiempo1, @tiempo2
				ORDER BY S.EMPRESA,S.ID_CABECERA,A.tipoarchivo,T.Norma --, @tiempo1, @tiempo2
	       END
		--Reporta Cantidad de registros procesados
		--select top 5 * from RIN
		-- Declare @CodigoArchivoOrigen varchar(200), @CantidadRegistros int, @NombreSemestre varchar(6)
		--set @CodigoArchivoOrigen='1657812'
		--set @NombreSemestre= '2010S2'
		--select @CantidadRegistros= count(*)  from RIN R WHERE (R.CodigoArchivoOrigen=@CodigoArchivoOrigen AND R.NombreSemestre= @NombreSemestre)
		--print 'Cantidad de registros '+cast(@CantidadRegistros as varchar)+' en tabla Tabla RIN procesado'
		--Libera temporales
		DROP TABLE #Temp1
		DROP TABLE #Temp2
		DROP TABLE RinTemporal
	end
end
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identificación de la Empresa Suministradora (según Anexo N° 3).' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR1_CR1S', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Año al que corresponde la compensación' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR1_CR1S', @level2type=N'COLUMN',@level2name=N'ANIO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Semestre al que corresponde la compensación S1 o S2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR1_CR1S', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código del Sistema Eléctrico, Alineado a la derecha' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR1_CR1S', @level2type=N'COLUMN',@level2name=N'CODIGOSISELEC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nivel de tensión a evaluar ( media o baja tensión), MT; BT' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR1_CR1S', @level2type=N'COLUMN',@level2name=N'TENSION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'No. de interrupciones NO PROGRAMADAS' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR1_CR1S', @level2type=N'COLUMN',@level2name=N'NUMINTNO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'No. de interrupciones PROGRAMADAS POR MANTENIMIENTO Interrupciones en el semestre, sin ponderar' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR1_CR1S', @level2type=N'COLUMN',@level2name=N'NUMINTPROGRAM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'No. de interrupciones PROGRAMADAS POR EXPANSIÓN O REFORZAMIENTO' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR1_CR1S', @level2type=N'COLUMN',@level2name=N'NUMINTREDES'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Duración de interrupciones NO PROGRAMADAS' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR1_CR1S', @level2type=N'COLUMN',@level2name=N'DURINTNO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Duración de interrupciones PROGRAMADAS POR MANTENIMIENTO DURACION REAL en el semestre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR1_CR1S', @level2type=N'COLUMN',@level2name=N'DURINTPROGRAM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Duración de interrupciones PROGRAMADAS POR EXPANSIÓN O REFORZAMIENTO DE REDES' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR1_CR1S', @level2type=N'COLUMN',@level2name=N'DURINTREDES'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Energía registrada en el semestre (ERS), expresada en kWh' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR1_CR1S', @level2type=N'COLUMN',@level2name=N'ENERGIA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Monto de compensación al Cliente por interrupciones en el punto de entrega En U.S. dólares.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR1_CR1S', @level2type=N'COLUMN',@level2name=N'COMPENSACIONINT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Monto de compensación por Ley de Concesiones. En dólares, acumulado del sem.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR1_CR1S', @level2type=N'COLUMN',@level2name=N'COMPENSACIONLEY'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del periodo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR1_CR1S', @level2type=N'COLUMN',@level2name=N'NOMBREPERIODO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo de semestre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR1_CR1S', @level2type=N'COLUMN',@level2name=N'CODSEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR1_CR1S', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identificación de la Empresa Suministradora (según Anexo N° 3). ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR2_CR2S', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Año al que corresponde la compensación' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR2_CR2S', @level2type=N'COLUMN',@level2name=N'ANIO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Semestre al que corresponde la compensación S1 o S2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR2_CR2S', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Código o número del revelador' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR2_CR2S', @level2type=N'COLUMN',@level2name=N'CODIGOREVELADOR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cliente, codigo de sumnistro Distribuidora' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR2_CR2S', @level2type=N'COLUMN',@level2name=N'CODIGOSUMINISTRO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Solo para el caso de distribuidoras' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR2_CR2S', @level2type=N'COLUMN',@level2name=N'ENERGIA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Monto de compensación al Cliente por interrupciones por rechazo de carga. En dolares' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR2_CR2S', @level2type=N'COLUMN',@level2name=N'COMPENSACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del periodo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR2_CR2S', @level2type=N'COLUMN',@level2name=N'NOMBREPERIODO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo del semestre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR2_CR2S', @level2type=N'COLUMN',@level2name=N'CODSEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR2_CR2S', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'NroRegEnArchivoOrigen' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR2_CR2S', @level2type=N'COLUMN',@level2name=N'NroRegEnArchivoOrigen'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identificación de la Empresa Suministradora (según Anexo N° 3).' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR3_CR3S', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Año al que corresponde la compensación' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR3_CR3S', @level2type=N'COLUMN',@level2name=N'ANIO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Semestre al que corresponde la compensación S1 o S2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR3_CR3S', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'codigoalimentador' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR3_CR3S', @level2type=N'COLUMN',@level2name=N'CODIGOALIMENTADOR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'codigosuministro' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR3_CR3S', @level2type=N'COLUMN',@level2name=N'CODIGOSUMINISTRO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nro. interrupciones no programadas, (Asociados al alimentador MT Sin ponderar)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR3_CR3S', @level2type=N'COLUMN',@level2name=N'NUMINTNO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nro. interrupciones programadas por mantenimiento(Asociados al alimentador MT Sin ponderar)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR3_CR3S', @level2type=N'COLUMN',@level2name=N'NUMINTPROG'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nro. interrupciones programadas por expansión' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR3_CR3S', @level2type=N'COLUMN',@level2name=N'NUMINTEXP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Duración de interrupciones NO PROGRAMADAS(Asociados al alimentador MT(en horas y decimales de hora)Sin ponderar)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR3_CR3S', @level2type=N'COLUMN',@level2name=N'DURINTNO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Duracion de interupciones programadas por Mantenimiento( Asociados al alimentador MT(en horas y decimales de hora)Sin ponderar)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR3_CR3S', @level2type=N'COLUMN',@level2name=N'DURINTPROG'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Duracion de interrupciones programadas por Expancion o Reforzamiento( Asociados al alimentador MT(en horas y decimales de hora) Sin ponderar)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR3_CR3S', @level2type=N'COLUMN',@level2name=N'DURINTEXP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Energia Registrada en el Semestre de Suministro(A ser Compensado)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR3_CR3S', @level2type=N'COLUMN',@level2name=N'ENERGIA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Monto de compesacion por aplicacion extensiva de la NTCSE(Del suministro compensado En U.S. dólares.)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR3_CR3S', @level2type=N'COLUMN',@level2name=N'COMPESACIONEXT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Monto de compensacion por LCE (Del suministro compensado En U.S. dólares.)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR3_CR3S', @level2type=N'COLUMN',@level2name=N'COMPENSACIONLCE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del periodo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR3_CR3S', @level2type=N'COLUMN',@level2name=N'NOMBREPERIODO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo de semestre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR3_CR3S', @level2type=N'COLUMN',@level2name=N'CODSEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SIR_CR3_CR3S', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identificación de la Empresa Suministradora (según Anexo N° 3).' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_S', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Año al que corresponde la compensación' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_S', @level2type=N'COLUMN',@level2name=N'ANIO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Semestre al que corresponde la compensación S1 o S2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_S', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código suministro afectado' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_S', @level2type=N'COLUMN',@level2name=N'UBIGEOCLIENTE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Según tabla INEI' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_S', @level2type=N'COLUMN',@level2name=N'UBIGEOSUMINISTRO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tensión de suministro MA (MAT y AT); MT; BT' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_S', @level2type=N'COLUMN',@level2name=N'TENSION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'No. de interrupciones NO PROGRAMADAS' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_S', @level2type=N'COLUMN',@level2name=N'NUMINTNO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'No. de interrupciones PROGRAMADAS POR MANTENIMIENTO Interrupciones en el semestre, sin ponderar' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_S', @level2type=N'COLUMN',@level2name=N'NUMINTPROGRAM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'No. de interrupciones PROGRAMADAS POR EXPANSIÓN O REFORZAMIENTO DE REDES' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_S', @level2type=N'COLUMN',@level2name=N'NUMINTREDES'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Duración de interrupciones NO PROGRAMADAS' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_S', @level2type=N'COLUMN',@level2name=N'DURINTNO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Duración de interrupciones PROGRAMADAS POR MANTENIMIENTO DURACION REAL en el semestre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_S', @level2type=N'COLUMN',@level2name=N'DURINTPROGRAM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Duración de interrupciones PROGRAMADAS POR EXPANSIÓN O REFORZAMIENTO DE REDES' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_S', @level2type=N'COLUMN',@level2name=N'DURINTREDES'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Energía registrada en el semestre (ERS), expresada en kWh' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_S', @level2type=N'COLUMN',@level2name=N'ENERGIA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Monto de compensación al Cliente por interrupciones en el punto de entrega En U.S. dólares.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_S', @level2type=N'COLUMN',@level2name=N'COMPENSACIONINT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Monto de compensación por Ley de Concesiones. En dólares, acumulado del sem.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_S', @level2type=N'COLUMN',@level2name=N'COMPENSACIONLEY'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del periodo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_S', @level2type=N'COLUMN',@level2name=N'NOMBREPERIODO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código del semestre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_S', @level2type=N'COLUMN',@level2name=N'CODSEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_S', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'NroRegEnArchivoOrigen' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_S', @level2type=N'COLUMN',@level2name=N'NroRegEnArchivoOrigen'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identificación de la Empresa Suministradora (según Anexo N° 3).' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_T', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Año al que corresponde la compensación' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_T', @level2type=N'COLUMN',@level2name=N'ANIO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Semestre al que corresponde la compensación S1 o S2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_T', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código suministro afectado' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_T', @level2type=N'COLUMN',@level2name=N'UBIGEOCLIENTE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Según tabla INEI' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_T', @level2type=N'COLUMN',@level2name=N'UBIGEOSUMINISTRO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tensión de suministro MA (MAT y AT); MT; BT' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_T', @level2type=N'COLUMN',@level2name=N'TENSION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'No. de interrupciones NO PROGRAMADAS' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_T', @level2type=N'COLUMN',@level2name=N'NUMINTNO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'No. de interrupciones PROGRAMADAS POR MANTENIMIENTO Interrupciones en el semestre, sin ponderar' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_T', @level2type=N'COLUMN',@level2name=N'NUMINTPROGRAM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'No. de interrupciones PROGRAMADAS POR EXPANSIÓN O REFORZAMIENTO DE REDES' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_T', @level2type=N'COLUMN',@level2name=N'NUMINTREDES'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Duración de interrupciones NO PROGRAMADAS' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_T', @level2type=N'COLUMN',@level2name=N'DURINTNO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Duración de interrupciones PROGRAMADAS POR MANTENIMIENTO DURACION REAL en el semestre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_T', @level2type=N'COLUMN',@level2name=N'DURINTPROGRAM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Duración de interrupciones PROGRAMADAS POR EXPANSIÓN O REFORZAMIENTO DE REDES' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_T', @level2type=N'COLUMN',@level2name=N'DURINTREDES'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Energía registrada en el semestre (ERS), expresada en kWh' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_T', @level2type=N'COLUMN',@level2name=N'ENERGIA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Monto de compensación al Cliente por interrupciones en el punto de entrega En U.S. dólares.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_T', @level2type=N'COLUMN',@level2name=N'COMPENSACIONINT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Monto de compensación por Ley de Concesiones. En dólares, acumulado del sem.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_T', @level2type=N'COLUMN',@level2name=N'COMPENSACIONLEY'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del periodo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_T', @level2type=N'COLUMN',@level2name=N'NOMBREPERIODO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código del semestre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_T', @level2type=N'COLUMN',@level2name=N'CODSEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_T', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'NroRegEnArchivoOrigen' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI1_T', @level2type=N'COLUMN',@level2name=N'NroRegEnArchivoOrigen'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identificación de la Empresa Suministradora (según Anexo N° 3).' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI2_S', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Año al que corresponde la compensación' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI2_S', @level2type=N'COLUMN',@level2name=N'ANIO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Semestre al que corresponde la compensación S1 o S2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI2_S', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código o número del revelador' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI2_S', @level2type=N'COLUMN',@level2name=N'CODIGOREVELADOR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Distribuidora: Código suministro Generadora: Código Distribuidora (Ver anexo 3)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI2_S', @level2type=N'COLUMN',@level2name=N'CODIGOSUMINISTRO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Solo para el caso de distribuidoras' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI2_S', @level2type=N'COLUMN',@level2name=N'ENERGIA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Monto de compensación al Cliente por interrupciones por rechazo de carga. En dolares' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI2_S', @level2type=N'COLUMN',@level2name=N'COMPENSACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del periodo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI2_S', @level2type=N'COLUMN',@level2name=N'NOMBREPERIODO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo del semestre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI2_S', @level2type=N'COLUMN',@level2name=N'CODSEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI2_S', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'NroRegEnArchivoOrigen' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CI2_S', @level2type=N'COLUMN',@level2name=N'NroRegEnArchivoOrigen'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identificación de la Empresa Suministradora (según Anexo N° 3).' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_PIN', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo asignado a la interrupcion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_PIN', @level2type=N'COLUMN',@level2name=N'CODINTERRUPCION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ddmmaaaahhmmss' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_PIN', @level2type=N'COLUMN',@level2name=N'FECHAINICIOINTERRUPCION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'M:mantenimiento, E: expansion o reforamiento' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_PIN', @level2type=N'COLUMN',@level2name=N'CODIGOPROGRAMACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ddmmaaaahhmmss' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_PIN', @level2type=N'COLUMN',@level2name=N'FECHAFININTERRUPCION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'C:por carta, P:por periodico, T:por TV, R:por radio, V:por volante, O:otro medio' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_PIN', @level2type=N'COLUMN',@level2name=N'AVISO1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ddmmaaaa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_PIN', @level2type=N'COLUMN',@level2name=N'FECHANOTIFICACION1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'C:por carta, P:por periodico, T:por TV, R:por radio, V:por volante, O:otro medio' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_PIN', @level2type=N'COLUMN',@level2name=N'AVISO2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ddmmaaaa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_PIN', @level2type=N'COLUMN',@level2name=N'FECHANOTIFICACION2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Direccion, locaclidad y denominacion de la instalacion donde se efectua el trabajo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_PIN', @level2type=N'COLUMN',@level2name=N'UBICACIONINTERRUPCION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Responsable de los trabajos programados' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_PIN', @level2type=N'COLUMN',@level2name=N'NOMBRERESPONSABLE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ser lo mas conciso posible teniendo en cuenta que se debe indicar las caracteristcas de la instalacion nueva y de las que sera cambiada.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_PIN', @level2type=N'COLUMN',@level2name=N'RESUMENACTIVIDADES'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Detalle de las razones por las que consideran tal interrupcion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_PIN', @level2type=N'COLUMN',@level2name=N'SUSTENTEXP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Estimado de suministros afectados' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_PIN', @level2type=N'COLUMN',@level2name=N'NUMSUMINISTROS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Relaciones de las zonas afectadas por la interrupcion programada, precisando duracion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_PIN', @level2type=N'COLUMN',@level2name=N'ZONAAFECT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'P=ambos, R=Rural solamente. NULL es Urbano' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_PIN', @level2type=N'COLUMN',@level2name=N'IDENTIFICADOR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del archivo adjunto 1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_PIN', @level2type=N'COLUMN',@level2name=N'BLOB1FILENAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tamanio del archivo adjunto 1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_PIN', @level2type=N'COLUMN',@level2name=N'BLOB1SIZE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Archivo BLOB' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_PIN', @level2type=N'COLUMN',@level2name=N'BLOB1FILE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del archivo adjunto 2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_PIN', @level2type=N'COLUMN',@level2name=N'BLOB2FILENAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tamanio del archivo adjunto 2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_PIN', @level2type=N'COLUMN',@level2name=N'BLOB2SIZE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Archivo BLOB' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_PIN', @level2type=N'COLUMN',@level2name=N'BLOB2FILE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del archivo adjunto 3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_PIN', @level2type=N'COLUMN',@level2name=N'BLOB3FILENAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tamanio del archivo adjunto 3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_PIN', @level2type=N'COLUMN',@level2name=N'BLOB3SIZE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Archivo BLOB' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_PIN', @level2type=N'COLUMN',@level2name=N'BLOB3FILE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del periodo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_PIN', @level2type=N'COLUMN',@level2name=N'PERIODO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código del semestre actual' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_PIN', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de la cabecera de envio' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_PIN', @level2type=N'COLUMN',@level2name=N'RH_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Indica si se suspendio la interrupcion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_PIN', @level2type=N'COLUMN',@level2name=N'SUSPEN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Detalle del motivo de suspensión' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_PIN', @level2type=N'COLUMN',@level2name=N'MOTIVOSUS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identificación de la Empresa Suministradora (según Anexo N° 3).' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RDI', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo asignado a la interrupcion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RDI', @level2type=N'COLUMN',@level2name=N'CODINTERRUPCION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1:llamada telefonica, 2: revision registros calidad, 3: analisis otro registro, T: mas de una modalidad, A: registro automatioc, P: interrupcion programada' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RDI', @level2type=N'COLUMN',@level2name=N'MODALIDADDETECCION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'M:mantenimiento, E:exp o reforzamiento, N: no programado, R:rechazo carga' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RDI', @level2type=N'COLUMN',@level2name=N'CODIGOINTERRUPCION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'En blanco: no se solicito, F: se solicito' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RDI', @level2type=N'COLUMN',@level2name=N'SOLICITUDMAYOR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ver tabla 10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RDI', @level2type=N'COLUMN',@level2name=N'CODIGOCAUSAINTERRUPCION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ddmmaaaa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RDI', @level2type=N'COLUMN',@level2name=N'FECHAINICIOINTERRUPCION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ddmmaaaa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RDI', @level2type=N'COLUMN',@level2name=N'FECHAFININTERRUPCION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'R, S,T,RS,RT,ST o RST' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RDI', @level2type=N'COLUMN',@level2name=N'FASESINTERRUMPIDAS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Potencia estimada interrumpida' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RDI', @level2type=N'COLUMN',@level2name=N'POTENCIAINTERRUMPIDA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Enegia estimada no suministrada' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RDI', @level2type=N'COLUMN',@level2name=N'ENERGIANOSUMINISTRADA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Suministros afectados' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RDI', @level2type=N'COLUMN',@level2name=N'SUMINISTROREGULADO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Clientes libres afectados' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RDI', @level2type=N'COLUMN',@level2name=N'CLIENTESAFECTADO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Na aplicacble a generadoas ni trasmisoras' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RDI', @level2type=N'COLUMN',@level2name=N'UBIGEOFALLA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Descripcion falla' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RDI', @level2type=N'COLUMN',@level2name=N'MOTIVOFALLA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'La SET, alimentador, etc' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RDI', @level2type=N'COLUMN',@level2name=N'LOCALIZACIONFALLA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'R=solo rutal, P=ambas.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RDI', @level2type=N'COLUMN',@level2name=N'RDI_AFECTADO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Origen de la Interrupción.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RDI', @level2type=N'COLUMN',@level2name=N'RDI_ORIGENINTERRUPCION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código OSINERGMIN' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RDI', @level2type=N'COLUMN',@level2name=N'CODOSI'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del periodo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RDI', @level2type=N'COLUMN',@level2name=N'NOMBREPERIODO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código del semestre actual' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RDI', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RDI', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identificación de la Empresa Suministradora (según Anexo N° 3).' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RIN', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo de la interrupcion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RIN', @level2type=N'COLUMN',@level2name=N'INTERRUPCION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SET:Para suministro MAT/AT/MT y SED: Para suministro BT' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RIN', @level2type=N'COLUMN',@level2name=N'SUBESTACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Suministro del cliente afectado' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RIN', @level2type=N'COLUMN',@level2name=N'NUMSUMINISTRO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MAT, AT, Mt o BT' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RIN', @level2type=N'COLUMN',@level2name=N'TENSION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha real de inicio de la interrupcion, ddmmaaaahhmmss' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RIN', @level2type=N'COLUMN',@level2name=N'FECHAINICIO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha real de termino de la interrupcion, ddmmaaaahhmmss' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RIN', @level2type=N'COLUMN',@level2name=N'FECHAFIN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ubigeo del suminsitro segun tabla del INEI' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RIN', @level2type=N'COLUMN',@level2name=N'UBIGEO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'R=sólo rural, VACIO=urbano/rural.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RIN', @level2type=N'COLUMN',@level2name=N'SOLORURAL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del periodo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RIN', @level2type=N'COLUMN',@level2name=N'NOMBREPERIODO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código del semestre actual' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RIN', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RIN', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RIN', @level2type=N'COLUMN',@level2name=N'NroRegEnArchivoOrigen'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[20] 2[19] 3) )"
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
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 35
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1560
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2550
         Alias = 1140
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PIN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PIN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "SRV_RDI"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 293
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
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'RDI'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'RDI'
GO
