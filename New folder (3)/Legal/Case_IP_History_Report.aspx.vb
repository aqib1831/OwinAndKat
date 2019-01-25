Imports System.Data.SqlClient
Partial Class Case_IP_History_Report
    Inherits System.Web.UI.Page
    Dim blnHeader As Boolean = False

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        '     Admin.ValidateSession()
    End Sub
    '  Dim objdpt As New Department

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If Request.QueryString("RequestFrom") = 1 Then
                Dim caseObj As CaseMgmt = New CaseMgmt()
                Dim dr As SqlDataReader = caseObj.GetSingleCase(Request.QueryString("ID"))
                dr.Read()
                lblCase.Text = dr.Item("Title").ToString()
                dr.Close()
            Else
                Dim dr As SqlDataReader = IntellectualProperty.Legal_GetSingleIP(Convert.ToInt32(Request.QueryString("ID")))
                dr.Read()
                lblCase.Text = dr.Item("Title").ToString()
                dr.Close()
            End If
        End If
    End Sub

    Protected Sub rptHistoryReport_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptHistoryReport.ItemDataBound
      
        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim rpt As Repeater = CType(e.Item.FindControl("rptActivityNotes"), Repeater)
            If rpt.Items.Count = 0 Then
                CType(e.Item.FindControl("ltrEmptyMessage"), Literal).Visible = True
            Else
                CType(e.Item.FindControl("ltrEmptyMessage"), Literal).Visible = False

            End If


        End If
    End Sub

    Protected Sub rptHistoryReport_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles rptHistoryReport.PreRender

        If Me.rptHistoryReport.Items.Count = 0 Then
            ltrlNoRecord.Visible = True
            rptHistoryReport.Visible = False
        Else
            ltrlNoRecord.Visible = False
            rptHistoryReport.Visible = True
           
        End If

    End Sub

End Class
