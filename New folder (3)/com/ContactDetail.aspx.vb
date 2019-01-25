
Partial Class com_ContactDetail
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim objConnectionStringSettings As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("FransupportConnectionString")
        If Not String.IsNullOrEmpty(Request.QueryString("ContactID")) AndAlso IsNumeric(Request.QueryString("ClientID")) Then
            hdnContactID.Value = Request.QueryString("ContactID")
            If Not String.IsNullOrEmpty(Request.QueryString("ClientID")) AndAlso IsNumeric(Request.QueryString("ClientID")) Then
                objConnectionStringSettings = ConfigurationManager.ConnectionStrings(Portal.DAL.DBFunction.GetConnectionStringName(Request.QueryString("ClientID")))
                sdsContactDetail.ConnectionString = objConnectionStringSettings.ConnectionString

                fvContactDetail.DataSourceID = sdsContactDetail.ID
                fvContactDetail.DataBind()
            End If
        End If

    End Sub
End Class
