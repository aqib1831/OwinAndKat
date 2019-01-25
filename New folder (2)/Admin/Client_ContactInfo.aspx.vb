Imports System.Data
Imports System.Data.SqlClient
Partial Class Admin_Client_ContactInfo
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If String.IsNullOrEmpty(Request.QueryString("ClientID")) = False AndAlso IsNumeric(Request.QueryString("ClientID")) Then
            Me.hdnClientID.Value = Request.QueryString("ClientID")
        End If
    End Sub

    Protected Sub rptContacts_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptContacts.ItemDataBound
        If rptContacts.Items.Count = 0 Then
            If (e.Item.ItemType = ListItemType.Footer) Then
                Dim ltrl As Literal = CType(e.Item.FindControl("ltlNoRecordsFound"), Literal)
                ltrl.Visible = True
            End If
        Else
            If (e.Item.ItemType = ListItemType.Footer) Then
                Dim ltrl As Literal = CType(e.Item.FindControl("ltlNoRecordsFound"), Literal)
                ltrl.Visible = False
            End If
        End If
       
    End Sub
End Class
