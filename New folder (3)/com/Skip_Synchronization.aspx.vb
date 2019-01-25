Imports System.Data.SqlClient

Partial Class com_Skip_Synchronization
    Inherits System.Web.UI.Page

    Dim reqStoreNumber As String
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        reqStoreNumber = Request.QueryString("StoreNumber").Trim
        txtStoreNumber.Text = reqStoreNumber
        hdnFranchiseID.Value = Request.QueryString("FranchiseID")

    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click

        Dim FranchiseContactID As Integer = 0
        Dim hasSmsXInstalled As Boolean = False
        Dim objFunctions As New Functions
        Dim drFranchises As SqlDataReader = Portal.DAL.SMSXLicenseManagement.SMSXFranchiseID_ByStoreNumber(hdnFranchiseID.Value)
        Dim FranchiseID As Integer = 0
        If drFranchises.Read Then
            FranchiseID = drFranchises("FranchiseId")
        End If
        drFranchises.Close()

        hasSmsXInstalled = objFunctions.VerifySMSXInstalled(FranchiseID)
        If hasSmsXInstalled = True Then
            lblAnswerKey.Text = Functions.Skip_Synch_KeyForNewSMSX(txtSkipRequestKey.Text, reqStoreNumber)
        ElseIf Request.QueryString("CountryID") = "1" Or Request.QueryString("CountryID") = "2" Then
            lblAnswerKey.Text = Functions.Skip_Synch_Key(txtSkipRequestKey.Text)
        Else
            lblAnswerKey.Text = Functions.Skip_Synch_KeyForNonUs(txtSkipRequestKey.Text, reqStoreNumber)
        End If
        btnSave.Visible = False
        btnClose.Visible = True
        'now add the closed activity for this franchisee also

        Dim objConnectionStringSettings As ConnectionStringSettings = ConfigurationManager.ConnectionStrings(Portal.DAL.DBFunction.GetConnectionStringName(Portal.BLL.Enumeration.ClientID.EA))
        Dim db As DBAccess = New DBAccess(objConnectionStringSettings.ConnectionString)
        Dim dr As SqlDataReader
        db.AddParameter("@FranchiseID", hdnFranchiseID.Value)
        dr = db.ExecuteReader("fran_FranchiseContactsByFranchiseID")
        While dr.Read()
            FranchiseContactID = dr("ID")
        End While
        dr.Close()

        Dim ObjectActivity As New Portal.BLL.Activities()
        Dim ActivityID As Integer = 0

        With ObjectActivity
            .Subject = "Skip Synchronization Key Request"
            .Type = 8   ' Other
            .SubType = 1 ' General
            .TimeSpent = TimeSpan.Parse("00:00:00")
            .FranchiseContactID = FranchiseContactID
            .FranchiseID = CInt(hdnFranchiseID.Value)
            .DepartmentID = Portal.BLL.Enumeration.EAI_DepartmentID.Netsolace
            .Description = "Synchronization Skip key has been generated. "
            .ActivityDate = DateTime.Now
            .ActivityState = 3 ' Completed
            .WaitingFor = "0"
            .Status = True
            .AdminInboxStatus = 1
            .PlacedBy = Portal.BLL.Enumeration.PlacedBy.PortalAdmin
            .ClientContactID = 0
            .RelatedTo = Portal.BLL.Enumeration.NSProductIDs.SMS
            .AdminID = Session("AdminID")
            ActivityID = .ActivitiesAdd(CInt(Portal.BLL.Enumeration.ClientID.EA), .FranchiseID, .AdminID, .DepartmentID, .FranchiseContactID, .TimeSpent.ToString(), .ActivityDate, .Type, .SubType, .Subject, .Description, .Status, .PlacedBy, .ActivityState, .WaitingFor, .AdminInboxStatus, False, .ClientContactID, .RelatedTo, 0)
        End With

    End Sub

End Class
