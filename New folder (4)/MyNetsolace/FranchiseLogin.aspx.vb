Imports System.Collections.Generic

Partial Class MyNetsolace_FranchiseLogin
    Inherits System.Web.UI.Page
    Dim colUsers As New List(Of Portal.BLL.Users)()
    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        If Not Page.IsPostBack Then
            If Request.QueryString("dt") <> String.Empty And Request.QueryString("FranchiseID") <> Nothing And IsNumeric(Request.QueryString("FranchiseID")) And Request.QueryString("ClientID") <> Nothing And IsNumeric(Request.QueryString("ClientID")) Then
                Dim dtstr As String = CStr(Request.QueryString("dt"))
                dtstr = Functions.DecryptData(dtstr)
                Dim dt As DateTime = CType(dtstr, DateTime)
                If dt < DateTime.Now.AddMinutes(10) AndAlso dt > DateTime.Now.AddMinutes(-10) Then
                    Dim FranchiseID As String = Request.QueryString("FranchiseID")
                    If FranchiseID <> String.Empty AndAlso IsNumeric(FranchiseID) Then
                        LoadUser(FranchiseID, CInt(Request.QueryString("ClientID")), CInt(Request.QueryString("ContactID")))
                    End If
                Else
                    Response.Redirect("AccessDenied.htm")
                End If
            Else
                Response.Redirect("AccessDenied.htm")
            End If
        End If
    End Sub

    Private Sub LoadUser(ByVal FranchiseID As Integer, ByVal ClientID As Integer, ByVal ContactID As Integer)

        'Getting the user detail from DB
        Dim objUser As Portal.BLL.Users = Portal.BLL.Franchises.GetFranchiseContactDetail(ContactID, FranchiseID, ClientID)

        If Not objUser Is Nothing Then
            Dim objContext As HttpContext = HttpContext.Current
            objContext.Session.Add("AdminCurrentobjUser", objUser) ' In session, we keep the logged-in User's ID with another key
            ' because it is frequently used and we are saved from creating object                        
            objContext.Session.Add("AdminID", 0)
            objContext.Session.Add("AdminName", objUser.UserName)
            objContext.Session.Add("Email", objUser.Email)
            Session.Add("FranchiseContactID", objUser.ID)
            Session.Add("MyNetsolace_ClientContactID", Nothing)
            Session.Add("MyNetsolace_ClientID", ClientID)
            Session.Add("FranchiseID", FranchiseID)
            objContext.Session.Add("MyNetsolace_IstVisit", False) 'Check if User has logged from this Fransupport Page        
            Response.Redirect("MainPage.aspx?FranchiseID=" & FranchiseID & "&ClientID=" & ClientID, True)
        Else
            Response.Redirect("AccessDenied.htm")
        End If
        
    End Sub

End Class
