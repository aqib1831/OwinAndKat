<%
			'///////////////////////// Variables //////////////////////////
			Dim cstFransupportConnectionString
			Dim cstFrutationConnectionString
			Dim cstEAConnectionString
			Dim cstEAStatsConnectionString
			Dim cstEAUKConnectionString
			Dim cstSalesReportConnectionString 
			Dim cstLMSConnectionString
			Dim cstOCMConnectionString
			Dim cstPMConnectionString
			Dim cstEAStatsUKConnectionString
			Dim cstNetsolacePortalConnectionString
						
			'///////////////////////// Constants //////////////////////////
			Const cstPayModeCC = 1
			Const cstPayModeAC = 2
			Const cstPayModePO = 3
			Const cstPayModeEBT = 4
			Const cstPayModeCK = 5
			
			'---------------------------------------
			' Added By : 		Khurram Ali
			' Date :				2006-03-01
			' Usage :				Department IDs
			'---------------------------------------
			Const cstOperationsDeptID = 5
			Const cstMarketingDeptID = 3
			Const cstAccountingDeptID = 2
			Const cstEdibleIdeaDeptID = 8
			Const cstComplianceDeptID = 17
			Const cstNewStoreDeptID = 11
			Const cstTraniningDeptID = 12
			Const cstHRDeptID =  10
			'Const cstNetsolaceDeptID = 1
			
			'---------------------------------------
			' Added By : 		Khurram Ali
			' Date :		2006-03-10
			' Usage :		MOdule IDs
			'---------------------------------------
			Const cstCommunicationModuleID = 1
			Const cstMKTModuleID = 2
			Const cstOMModuleID = 4
			Const cstSCMModuleID = 5
			Const cstFormsandGuideModuleID = 6
			Const cstDiscussionsModuleID = 7
			Const cstAdministrationModuleID = 9
			Const cstNSMModuleID = 11
			Const cstFranMgmtModuleID = 12
			Const cstSalesReportModuleID = 14
			Const cstHRModuleID = 13
			Const cstLMSModuleID = 16
			Const cstFranAlertsModuleID = 22
			Const cstMyNetsolaceModuleID = 32
			'---------------------------------------
			' Added By : 		Hasan Rafiq
			' Date :				2006-03-13
			' Usage :				Supplier IDs
			'---------------------------------------
			Const cstJHCSupplierID = 30
			Const cstEACorpSupplierID = 67
			Const cstDMSSupplierID = 11
			
			Const cstDMSSupplierSendEmail = True
			Const cstDMSSupplierFromEmail = "support@netsolace.com"			' This variable needs to be modified with redesign.
			'---------------------------------------
			
			'---------------------------------------
			' Added By : 		Hasan Rafiq
			' Date :				2007-02-03
			' Usage :				Negotiation Settings
			'---------------------------------------
			Const cstNegotiationFromEmail = "support@netsolace.com"
'			Const cstNegotiationEmailSubject = "FranSupport Supplier Negotiation Alert"
			'---------------------------------------			


			'---------------------------------------
			' Added By : 		Khurram Ali
			' Date :				2006-04-18
			' Usage :				Account Types ID
			'---------------------------------------
			Const cstOwnerAccountID = 1
			Const cstStoreAccountID = 25
			'---------------------------------------
			' Added By : 		Hasan Rafiq
			' Date :				2006-02-13
			' Usage :				The credentials for 
			'								logging in to UK Admin.
			'---------------------------------------
			Const cstFranUKAdminURL = "http://localhost/fransupport_uk/admin/"
			Const cstFranUKCompanyCode = "EA"
			'---------------------------------------
			
			'---------------------------------------
			' Added By : 		Hasan Rafiq
			' Date :				2006-03-15
			' Usage :				The status for the 
			'								Specials Approval.
			'---------------------------------------
			Const cstSpecialStatusNQ = 0
			Const cstSpecialStatusPending = 1
			Const cstSpecialStatusApproved = 2
			'---------------------------------------
			
			'---------------------------------------
			' Added By : 		Khurram Ali
			' Date :				2006-03-20
			' Usage :				Franchises Status
			'---------------------------------------
			Const cstFranchiseStatusComingSoon = 1
			Const cstFranchiseStatusOperating = 2
			Const cstFranchiseStatusCorporate = 3
			Const cstFranchiseStatusTerminated = 4
			Const cstFranchiseStatusSuspended = 5
			Const cstFranchiseStatusTransferred = 6
			Const cstFranchiseStatusMaster = 7																		
			'---------------------------------------

			'---------------------------------------
			' Added By : 		Khurram Ali
			' Date :				2006-03-27
			' Usage :				Admin IDs
			'---------------------------------------
			Const cstKamranAdminID = 15
			Const cstKamranFaridAdminID = 15
			Const cstTariqFaridAdminID = 17
			Const cstTariqAdminID = 17
			Const cstKristyAdminID = 18
			Const cstSarjuAdminID = 20			
			Const cstFaisalAdminID = 22
			Const cstAsmaAdminID = 24
			Const cstChristinaAdminID = 39												
			Const cstKaitlinAdminID = 50
			Const cstJohnAdminID = 76
			Const cstKhurramAdminID = 98
			Const cstDianneAdminID = 25
			Const cstEAConferrenceAdminID = 59
			Const cstEAConferrence2AdminID = 97
			Const cstFaridsAdminID = 44
			Const cstMathewAdminID = 111
			Const cstIrfanFaridAdminID = 60
			Const cstRobertSchnurrAdminID = 119
			Const cstJillianAdminID = 62
			Const cstJeffreyAlexanderAdminID = 132
			Const cstAshleyMeyerAdminID = 40  
			Const cstJoelAdminID = 134
			Const cstDonnaAdminID = 172
			Const cstJBartlettAdminID = 143
			Const cstCourtneyBargerAdminID = 173
			Const cstRachelForsaAdminID = 234
			Const cstFranzMenaAdminID = 91
			Const cstSomiaFaridAdminID = 133	
			Const cstAjaPapalloAdminID = 171	
			Const cstJamesHillAdminID = 173
			Const cstChristineCentolaAdminID = 342
			Const cstPatriciaUrbanAdminID = 498
			Const cstStephenThomasAdminID = 181
			Const cstSGostinAdminID = 320
			
			Const cstlngHRManager = 124
			'---------------------------------------
			' Added By : 		Khurram Ali
			' Date :				2006-04-04
			' Usage :				Time Zones
			'---------------------------------------
			Const cstEasternTimeZone = -5
			Const cstCentralTimeZone = -6
			Const cstMountainTimeZone = -7
			Const cstPacificTimeZone = 	-8		
			'---------------------------------------			

			'---------------------------------------
			' Added By : 		Khurram Ali
			' Date :				2006-04-06
			' Usage :				SMS Sesstings
			'---------------------------------------
			Const cstSupportCharges = 55.00
			Const cstCanadaRoyalty	= 6.50
			Const cstDefaultRoyalty	= 5.00
			Const cstCandaMinRoyalty = 250.00
			Const cstDefaultMinRoyalty = 200.00
			Const cstDefaultNAF = 2.00
			Const cstDefaultHouseChargeAmount = 5000
			Const cstDefaultInterFranchiseDiscount = 20
			
			Const cstMaximumRoyaltyPercentage	= 10
			Const cstMaximumNAFPercentage	= 5
			'---------------------------------------			

			'---------------------------------------
			' Added By : 		Khurram Ali
			' Date :				2006-04-25
			' Usage :				Country IDs
			'---------------------------------------
			Const cstCanadaCountryID = 2
			Const cstUSCountryID	= 1
			Const cstUAECountryID = 217
			Const cstUKCountryID = 218
			
			'---------------------------------------			
			
			'---------------------------------------
			' Added By : 		Wajahat Talat
			' Date :				2006-06-12
			' Usage :				EdibleIdea ActivityType ID
			'---------------------------------------			
			Const cstActivityTypeEdibleIdea = 11
			'---------------------------------------
			
			'---------------------------------------
			' Added By : 		Khurram Ali
			' Date :				2006-05-05
			' Usage :				TaskType IDs
			'---------------------------------------
			Const cstStoreOpeningTaskTypeID = 4
			'---------------------------------------						

			'---------------------------------------
			' Added By : 		Hasan Rafiq
			' Date :				2006-05-11
			' Usage :				Default Language & EA Domain IDs
			'---------------------------------------
			Const cstMktDefaultLanguageID = 1
			'---------------------------------------						

			'---------------------------------------
			' Added By : 		Hasan Rafiq
			' Date :				2006-05-16
			' Usage :				Seperate PO Product
			'---------------------------------------
			Const cstSCMSeperatePOProductID = 705
			Const cstSCMSeperatePOMessage = "Delivery boxes can’t be placed on the same PO with other items – for your convince this has been automatically separated on a different PO."
			'---------------------------------------						

			'---------------------------------------
			' Added By : 		Hasan Rafiq
			' Date :				2006-05-23
			' Usage :				The Name of Company.
			'---------------------------------------
			Const cstCompanyName = "ABC Inc."
			'---------------------------------------						

			'---------------------------------------
			' Added By : 		Tahri Manzoor
			' Date :				2006-06-15
			' Usage :				FranSupport Owner Loing ID
			'---------------------------------------
			Const cstFranSupportOwnerLaunchPadLinkID = 18
			Const cstCorporateStoreFranchiseID = 410
			Const cstMundeleinFranchiseID = 72
			'---------------------------------------						

			'---------------------------------------
			' Added By : 		Khurram Ali
			' Date :				2006-06-27
			' Usage :				NSM Steps  ID
			'---------------------------------------
			Const lngFactSheetNSMStepID = 39
			'---------------------------------------						

			'---------------------------------------
			' Added By : 		Hasan Rafiq
			' Date :				2006-07-12
			' Usage :				Franchise Module IDs
			'---------------------------------------
			Const cstFranDiscussionBoardModuleID = 1
			'---------------------------------------						

			'---------------------------------------
			' Added By : 		Hasan Rafiq
			' Date :				2006-07-17
			' Usage :				Discussion Board Activity Type
			'---------------------------------------
			Const cstActivityTypeDiscussionBoard = 12
			'---------------------------------------						

			'------------------------------------------
			' Added By : 		Hasan Rafiq
			' Date :				2006-09-27
			' Usage :				Marketing Calender Product
			'------------------------------------------
			Const cstHortonCalenderProductID = 1146
			Const cstHortonCalenderMessage = "You are ordering a <b>Customized 2007 calendar</b> from Horton Printing. Please make sure to specify exactly how you want your store or stores (maximum of three stores per calendar) to appear on the calendar in the <b>Special Instructions</b> field. The order will not be processed if the <b>Special Instructions</b> field is left blank.<br><br>Press &ldquo;Continue Placing Order&rdquo; if you have provided instructions. <br>Press &ldquo;Review Instructions&rdquo; to give instructions."
			'------------------------------------------

			'---------------------------------------
			' Added By : 		Hasan Rafiq
			' Date :				2006-11-11
			' Usage :				Supplier / Products / Franchisee Types
			'---------------------------------------
			Const cstTypeStore = 1
			Const cstTypeStoreAndFrutation = 2
			Const cstTypeFrutation = 3
			'---------------------------------------
			
			Const cstTaxForCanada = 10
			
			'---------------------------------------
			' Added By : 		Hasan Rafiq
			' Date :				2007-08-13
			' Usage :				NSM Store Pictures
			'---------------------------------------
			Const cstNSMImagesViewPageURL = "http://localhost/FranSupport_new/FranchisePics/FolderView.aspx"
			'---------------------------------------

			'---------------------------------------
			' Added By : 		Hasan Rafiq
			' Date :			2008-04-11
			' Usage :			Netsolace ID, 
			'					Netsolace TTP Product ID
			'---------------------------------------
			Const cstNetsolaceTTPProductID = 749
			Const cstNetsolaceSupplierID = 100
			'---------------------------------------

			'///////////////////////// Conection Strings //////////////////
			
			cstFransupportConnectionString = "Provider=SQLOLEDB;" & _
											"Data Source=192.168.200.14; " & _
											"Initial Catalog=FranSupport_New; " & _
											"User ID=FranSupport_New; " & _
											"Password=%Fr@n904$upp0rt#;"




			cstFrutationConnectionString= "Provider=SQLOLEDB; " &_
											"Data Source=DS\SqlServer2000; " &_
											"Initial Catalog=FranSupport_Frutation_new; " &_
											"User ID=sa; " &_
											"Password=Net$olace; "

			
			cstEAConnectionString = "Provider=SQLOLEDB; " &_
																		"Data Source=DS\SqlServer2000; " &_
																		"Initial Catalog=EA_2005_10_05; " &_
																		"User ID=sa; " &_
																		"Password=Net$olace; "

			cstEAStatsConnectionString = "Provider=SQLOLEDB; " &_
																		"Data Source=DS\SqlServer2000; " &_
																		"Initial Catalog=EAStats; " &_
																		"User ID=sa; " &_
																		"Password=Net$olace; "


			cstEAUKConnectionString = "Provider=SQLOLEDB; " &_
																		"Data Source=DS\SqlServer2000; " &_
																		"Initial Catalog=EA_2005_10_05; " &_
																		"User ID=sa; " &_
																		"Password=Net$olace; "
																		
			cstEAStatsUKConnectionString = "Provider=SQLOLEDB; " &_
																		"Data Source=DS\SQLSERVER2000; " &_
																		"Initial Catalog=EAStates_UK; " &_
																		"User ID=sa; " &_
																		"Password=Net$olace; "
			
			cstSalesReportConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & Server.MapPath("../SalesReport.MDB")
			
			cstLMSConnectionString = "Provider=SQLOLEDB; " &_
																		"Data Source=DS\SqlServer2000; " &_
																		"Initial Catalog=LMS; " &_
																		"User ID=sa; " &_
																		"Password=Net$olace; "
			cstOCMConnectionString = "Provider=SQLOLEDB; " &_
																		"Data Source=DS\Test; " &_
																		"Initial Catalog=OCM_NEW; " &_
																		"User ID=sa; " &_
																		"Password=;"
			
			cstNetsolacePortalConnectionString = "Provider=SQLOLEDB; " &_
											"Data Source=DS\SqlServer2005; " &_
											"Initial Catalog=Portal; " &_
											"User ID=Fransupport; " &_
											"Password=Fransupport123; "
			
			cstPMConnectionString = "Provider=SQLOLEDB.1;Data Source=DS\SqlServer2000;Initial Catalog=PM;UID=sa;Pwd=Net$olace;"

			'Paths 
			
			Const cstOCMFilesPath = "https://www.fransupport.com/OCM/email/"
			Const cstFransupportImages = "/images/"
			Const cstMKTCurrentWorkFoldersPath =   "/Fransupport_Resources/mkt/CurrentWorkFolders/"
			Const cstMKTNewAdFoldersPath	 =  "/Fransupport_Resources/mkt/NewAds/"
			Const cstMKTCreateAdFoldersPath = "/Fransupport_Resources/mkt/CreatedAds/"
			Const cstMKTEditedAdFoldersPath = "/Fransupport_Resources/mkt/EditedAds/"
			Const strSubmittedReportsPath = "E:\WebSites\SalesReport\FTP"
			Const strArchivedReportsPath = "E:\WebSites\SalesReport\ReportsArchive"
			Const cstSCMProductUnavailableTemplate = "D:\Projects\FranSupport_New\admin\templates\scm_product_unavailable.html"
			
			'''''''''''''''''''''''''''''' Some Constants for Manage Resources (Paths) '''''''''''''''''''''''''''
			'''''''''''''''''''''''''''''' Added By: Rana Khuram '''''''''''''''''''''''''''''''''''''''''''''''''
			'''''''''''''''''''''''''''''' Date: 23 March, 2006 ''''''''''''''''''''''''''''''''''''''''''''''''''
			
			Const cstFransupportResourcesFolder = "../../../../Fransupport_Resources/"
			Const strFranSupportAdminLoginPostUrl = "http://localhost/Fransupport_new/supplier/login_submit.asp"
			Const strFranSupportFranchiseeLoginPostUrl = "http://localhost/Fransupport_new/Franchisee/login_submit.asp"
			Const strFranSupportStoreLoginPostUrl = "http://localhost/Fransupport_new/Franchisee/manager_login.asp"			
			Const strPortalURL = "http://frans-saqib/portal/"
			Const strEAClientID = 1
			''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
			
			'---------------------------------------
			' Added By : 		Tahir Manzoor
			' Date :				2006-07-27
			' Usage :				
			'---------------------------------------			
			Const strAdminStylesheet = "style/"
			Const strGridStylesheet = "style/grid_styles/"
			Const strAdminScripts = "scripts/"
			Const strFransupportImages = "images/"
			Const cstStrOnlinePath = "images/online.gif"
			Const cstStrOfflinePath = "images/offline.gif"
			
'******************************** Variable Assignment ********************************
			Const cstEAStatsKey = "1952"
			
			'''''''''''''''''''''''''''''' Constant for StoreImages subject '''''''''''''''''''''''''''''''''''''
			'''''''''''''''''''''''''''''' Added By: Aamir Habib '''''''''''''''''''''''''''''''''''''''''''''''''
			'''''''''''''''''''''''''''''' Date: 12 June, 2008 '''''''''''''''''''''''''''''''''''''''''''''''''''
			
			Const cstStoreImageSubject="Store Images Updated"
			
%>
