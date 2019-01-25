
Imports System.Collections.Generic
Imports System.Data
Imports System.Data.SqlClient


Partial Class MyNetsolaceClient_Controls_VitalInformationNetSolaceClients
    Inherits System.Web.UI.UserControl


    Public ListOfKey As List(Of KeyValuePair(Of String, String)) = New List(Of KeyValuePair(Of String, String))
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'hdnFranchiseID.Value = 503
        'If String.IsNullOrEmpty(Request.QueryString("FranchiseID")) = False AndAlso IsNumeric(Request.QueryString("FranchiseID")) Then
        '    hdnFranchiseID.Value = HttpContext.Current.Request.QueryString("FranchiseID").ToString()
        'End If
        'hdnSOWAttachmentTypeID.Value = 1
        'hdnBRDAttachmentTypeID.Value = 2


        hdnSOWAttachmentTypeID.Value = CType([Enum].Parse(GetType(Portal.BLL.Enumeration.AttachmentType), "SOW"), Integer)
        hdnBRDAttachmentTypeID.Value = CType([Enum].Parse(GetType(Portal.BLL.Enumeration.AttachmentType), "BRD"), Integer)

        If String.IsNullOrEmpty(Request.QueryString("ID")) = False AndAlso IsNumeric(Request.QueryString("ID")) Then
            hdnClientID.Value = Request.QueryString("ID").ToString()
        End If
    End Sub

    Public Shared Function GetImage(ByVal value As Boolean) As String
        If value Then
            Return "../images/icn_Viewed.png"
        Else
            Return "../images/icn_notViewed.png"
        End If
    End Function


    Protected Sub gvBRDLog_DataBound(sender As Object, e As EventArgs)
        'CountTest.Text = gvBRDLog.Rows.Count
    End Sub
    Protected Sub fvLeadVitals_DataBound(sender As Object, e As EventArgs)
        Dim frm As FormView = CType(sender, FormView)
        Dim gvBRDLog As GridView = CType(frm.FindControl("gvBRDLog"), GridView)
        If gvBRDLog.Rows.Count = 0 Then
            Dim brdrow As HtmlControl = CType(frm.FindControl("brdrow"), HtmlControl)
            Dim brdrowgrid As HtmlControl = CType(frm.FindControl("brdrowgrid"), HtmlControl)
            brdrow.Visible = False
            brdrowgrid.Visible = False
        End If




        Dim gvSOWLog As GridView = CType(frm.FindControl("gvSOWLog"), GridView)
        If gvSOWLog.Rows.Count = 0 Then
            Dim sowrow As HtmlControl = CType(frm.FindControl("sowrow"), HtmlControl)
            Dim sowrowgrid As HtmlControl = CType(frm.FindControl("sowrowgrid"), HtmlControl)
            sowrow.Visible = False
            sowrowgrid.Visible = False
        End If


        Dim gvAttachments As GridView = CType(frm.FindControl("gvAttachments"), GridView)
        If gvAttachments.Rows.Count = 0 Then
            Dim Attachmentsrow As HtmlControl = CType(frm.FindControl("Attachmentsrow"), HtmlControl)
            Dim Attachmentsrowgrid As HtmlControl = CType(frm.FindControl("Attachmentsrowgrid"), HtmlControl)
            Attachmentsrow.Visible = False
            Attachmentsrowgrid.Visible = False
        End If



        'Dim gridview2 As GridView = CType(frm.FindControl("gridview2"), GridView)

        'Dim showcreatedbycol As Boolean = False
        'Dim showpostedcol As Boolean = False
        'Dim showhourscol As Boolean = False
        'Dim Count As Boolean = False


        'For row As Integer = 0 To gridview2.Rows.Count - 1
        '    Dim lbl As Label = CType(gridview2.Rows(row).FindControl("CreatedBylbl"), Label)

        '    If lbl.Text.Trim() <> "" Then
        '        showcreatedbycol = True
        '    End If
        '    lbl = CType(gridview2.Rows(row).FindControl("Postedlbl"), Label)
        '    If lbl.Text.Trim() <> "" Then
        '        showpostedcol = True
        '    End If
        '    lbl = CType(gridview2.Rows(row).FindControl("Hourslbl"), Label)
        '    If lbl.Text.Trim() <> "" Then
        '        showhourscol = True

        '    End If
        'Next


        '    If showcreatedbycol = False And showpostedcol = False And showhourscol = False Then
        '        'gridview2.Rows(Count).Visible = False
        '        gridview2.Visible = False
        '        Count = True



        '        Dim EstHead As HtmlControl = CType(frm.FindControl("EstHead"), HtmlControl)
        '        Dim EstGrid As HtmlControl = CType(frm.FindControl("EstGrid"), HtmlControl)
        '        Dim totalrow As HtmlControl = CType(frm.FindControl("totalrow"), HtmlControl)

        '        EstHead.Visible = False
        '        EstGrid.Visible = False
        '        totalrow.Visible = False



        '    End If

    End Sub

    Public Shared Function StringShort(S As String) As String
        If S = "" Or S = Nothing Then
            Return Nothing

        End If
        Dim St As String
        Dim Str As String
        If S.Length >= 30 Then
            St = S.Substring(0, 30)
            Str = St + "..."


            Return Str
        End If
        Return S
    End Function

    Public Shared Function StringShort(S As String, Length As Integer) As String
        If S = "" Or S = Nothing Then
            Return Nothing

        End If
        Dim St As String
        Dim Str As String
        If Length >= 21 Then
            St = S.Substring(0, 20)
            Str = St + "..."


            Return Str
        End If
        Return S
    End Function

    'attachments
    Protected Sub gvAttachments_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            e.Row.Cells(0).ToolTip = DataBinder.Eval(e.Row.DataItem, "FileName")

            'Dim lbl As String = DataBinder.Eval(e.Row.DataItem, "FirstName")
            Dim lbl As Boolean = DataBinder.Eval(e.Row.DataItem, "Type")

            If lbl Then
                e.Row.Visible = False
            End If
        End If



    End Sub



    Protected Sub gvSOWLog_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            e.Row.Cells(0).ToolTip = DataBinder.Eval(e.Row.DataItem, "FileName")
            Dim lbl As Boolean = DataBinder.Eval(e.Row.DataItem, "Type")

            If lbl Then
                e.Row.Visible = False
            End If
        End If



    End Sub


    Protected Sub gvBRDLog_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            e.Row.Cells(0).ToolTip = DataBinder.Eval(e.Row.DataItem, "FileName")


            Dim lbl As Boolean = DataBinder.Eval(e.Row.DataItem, "Type")

            If lbl Then
                e.Row.Visible = False


            End If
        End If
    End Sub




    'Protected Sub GridView2_DataBound(sender As Object, e As GridViewRowEventArgs)


    '    ' Dim lbl As Integer = DataBinder.Eval(e.Row.DataItem, "Type")

    '    'Dim Type As String = CType(e.Row.FindControl("CreatedBylbl"), Label).Text

    'End Sub


    Protected Sub sdsProjectInformation_Selected(sender As Object, e As ObjectDataSourceStatusEventArgs)
        ListOfKey = CType(e.ReturnValue(0).ListResources, List(Of KeyValuePair(Of String, String)))
    End Sub
End Class

