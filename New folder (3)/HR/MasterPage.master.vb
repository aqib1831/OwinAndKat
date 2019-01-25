
Partial Class HR_MasterPage
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If hdnRequestKey.Value <> "" Then
                If hdnPunchMode.Value = 0 Then
                    imgreferesh.Attributes.Add("onclick", "window.navigate('MainMasterPage.aspx?PunchMode=0&key=" & hdnRequestKey.Value & " ');")
                    'imgSwap.OnClientClick = "window.navigate('MainMasterPage.aspx?PunchMode=0&key=" & hdnRequestKey.Value & " ');"
                Else
                    imgreferesh.Attributes.Add("onclick", "window.navigate('MainMasterPage.aspx?PunchMode=1&key=" & hdnRequestKey.Value & " ');")
                    'imgSwap.OnClientClick = "window.navigate('MainMasterPage.aspx?PunchMode=1&key=" & hdnRequestKey.Value & " ');"
                End If
            Else
                If hdnPunchMode.Value = 0 Then
                    hdnRequestKey.Value = Request.QueryString("key")
                    imgreferesh.Attributes.Add("onclick", "window.navigate('MainMasterPage.aspx?PunchMode=0&key=" & Request.QueryString("key") & " ');")
                    'imgSwap.OnClientClick = "window.navigate('MainMasterPage.aspx?PunchMode=0&key=" & Request.QueryString("key") & " ');"
                Else
                    imgreferesh.Attributes.Add("onclick", "window.navigate('MainMasterPage.aspx?PunchMode=1&key=" & Request.QueryString("key") & " ');")
                    'imgSwap.OnClientClick = "window.navigate('MainMasterPage.aspx?PunchMode=1&key=" & Request.QueryString("key") & " ');"
                End If
            End If
        End If
    End Sub

    Protected Sub imgSwap_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgSwap.Click
        If hdnRequestKey.Value <> "" Then
            If Request.QueryString("PunchMode") = 0 Then

                imgreferesh.Attributes.Add("onclick", "window.navigate('MainMasterPage.aspx?PunchMode=1&key=" & hdnRequestKey.Value & " ');")
                'imgSwap.OnClientClick = "window.navigate('MainMasterPage.aspx?PunchMode=1&key=" & hdnRequestKey.Value & " ');"
                Response.Redirect("MainMasterPage.aspx?PunchMode=1&key=" & hdnRequestKey.Value)
            Else

                imgreferesh.Attributes.Add("onclick", "window.navigate('MainMasterPage.aspx?PunchMode=0&key=" & hdnRequestKey.Value & " ');")
                'imgSwap.OnClientClick = "window.navigate('MainMasterPage.aspx?PunchMode=0&key=" & hdnRequestKey.Value & " ');"
                Response.Redirect("MainMasterPage.aspx?PunchMode=0&key=" & hdnRequestKey.Value)
            End If
        Else
            hdnRequestKey.Value = Request.QueryString("key")
            If Request.QueryString("PunchMode") = 0 Then

                imgreferesh.Attributes.Add("onclick", "window.navigate('MainMasterPage.aspx?PunchMode=1&key=" & Request.QueryString("key") & " ');")
                'imgSwap.OnClientClick = "window.navigate('MainMasterPage.aspx?PunchMode=1&key=" & Request.QueryString("key") & " ');"
                Response.Redirect("MainMasterPage.aspx?PunchMode=1&key=" & Request.QueryString("key"))
            Else

                imgreferesh.Attributes.Add("onclick", "window.navigate('MainMasterPage.aspx?PunchMode=0&key=" & Request.QueryString("key") & " ');")
                'imgSwap.OnClientClick = "window.navigate('MainMasterPage.aspx?PunchMode=0&key=" & Request.QueryString("key") & " ');"
                Response.Redirect("MainMasterPage.aspx?PunchMode=0&key=" & Request.QueryString("key"))
            End If

        End If
        
    End Sub
End Class

