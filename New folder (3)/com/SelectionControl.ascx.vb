					 						 			
Partial Class com_SelectionControl
    Inherits System.Web.UI.UserControl

    Dim itemsCount As Integer = 0

    Public Property Width() As Unit
        Get
            Return SelectionCtrlMainPanel.Width
        End Get
        Set(ByVal value As Unit)
            SelectionCtrlMainPanel.Width = value

        End Set
    End Property
    Public Property Height() As Unit
        Get
            Return SelectionCtrlMainPanel.Height
        End Get
        Set(ByVal value As Unit)
            SelectionCtrlMainPanel.Height = value
            'selectionLftTbl.Height = value.ToString()
            'selectionRtTbl.Height = value.ToString()
            selectionLeftDiv.Style("height") = value.ToString()
            selectionRightDiv.Style("height") = value.ToString()
        End Set
    End Property
    Public ReadOnly Property SelectedValues() As String()
        Get
            Dim selValues As String = SelectedValuesField.Value
            Dim dels As String() = {"$%"}
            Dim selValuesArray As String() = selValues.Split(dels, StringSplitOptions.None)
            Dim selValuesList As New System.Collections.Generic.List(Of String)
            selValuesList.AddRange(selValuesArray)
            selValuesList.RemoveAt(0)
            Return selValuesList.ToArray()
        End Get
    End Property
    Public ReadOnly Property SelectedNames() As String()
        Get
            Dim selNames As String = SelectedNamesField.Value
            Dim dels As String() = {"$%"}
            Dim selNamesArray As String() = selNames.Split(dels, StringSplitOptions.None)
            Dim selNamesList As New System.Collections.Generic.List(Of String)
            selNamesList.AddRange(selNamesArray)
            selNamesList.RemoveAt(0)
            Return selNamesList.ToArray()
        End Get
    End Property
    Public ReadOnly Property GetSelectedCSValues() As String
        Get
            Dim selValues As New StringBuilder()
            Dim fieldValue As String = SelectedValuesField.Value
            selValues.Append(fieldValue)
            Dim indx As Integer = fieldValue.IndexOf("$%")
            If (indx = -1) Then
                Return ""
            End If
            selValues.Remove(0, indx + 2)
            selValues.Replace("$%", ",")
            Return selValues.ToString()
        End Get
    End Property

    Public Function GetSelectedCSNames(ByVal enclosingCharacter As String) As String
        Dim selNames As New StringBuilder()
        Dim fieldName As String = SelectedNamesField.Value
        selNames.Append(fieldName)
        Dim indx As Integer = fieldName.IndexOf("$%")
        If (indx = -1) Then
            Return ""
        End If
        selNames.Remove(0, indx + 2)
        selNames.Replace("$%", enclosingCharacter & "," & enclosingCharacter)
        selNames.Insert(0, enclosingCharacter)
        selNames.Insert(selNames.Length, enclosingCharacter)
        Return selNames.ToString()
    End Function

    Public Sub AddItem(ByVal itemText As String, ByVal itemValue As String)
        Dim rowTemp As New HtmlTableRow()
        Dim tdTemp As New HtmlTableCell()
        tdTemp.Attributes.Add("style", "width:350px")
        tdTemp.InnerText = Functions.StringTruncate(itemText, 27)
        rowTemp.Attributes.Add("id", itemValue)
        rowTemp.Controls.Add(tdTemp)
        rowTemp.Attributes.Add("onclick", "onSelectionRowSelectionLeft(this)")
        rowTemp.Attributes.Add("title", itemText)
        selectionLftTbl.Controls.Add(rowTemp)
        itemsCount = itemsCount + 1

    End Sub
    Public ReadOnly Property Count() As Integer
        Get
            Dim selValues As String = SelectedValuesField.Value
            Dim dels As String() = {"$%"}
            Dim selValuesArray As String() = selValues.Split(dels, StringSplitOptions.None)
            Return (selValuesArray.Length - 1)
        End Get
    End Property

    Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender

        ' ScriptManager.RegisterStartupScript(typeof(Page)Is , "ButtonAlert", "restoreSelectedValuesNames()", true)
        'ScriptManager.RegisterStartupScript(Me, GetType(Page), "js", "restoreSelectedValuesNames();", True)

    End Sub
    Public Sub ClearSelected()
        'SelectedNamesField.Value = "-1"
        'SelectedValuesField.Value = "-1"
    End Sub
End Class



