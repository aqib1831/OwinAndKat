<%@ WebHandler Language="C#" Class="Editor.DBFileBrowserContentProvider.Handler" %>

using System;
using System.Data;
using System.Configuration;
using System.Web;
using Editor.DBFileBrowserContentProvider;

namespace Editor.DBFileBrowserContentProvider
{
	public class Handler : IHttpHandler
	{
		#region IHttpHandler Members

        private DataServer _dataServer;

        private DataServer DataServer
		{
			get
			{
				if(_dataServer == null)
				{
					string connectionString =
						string.Format("Provider=Microsoft.Jet.OLEDB.4.0;Data Source={0};User ID=;Password=;",
						Context.Server.MapPath(ConfigurationSettings.AppSettings["Telerik.WebControls.EditorExamples.FileBrowserDatabase"]));
					_dataServer = new DataServer(connectionString);
				}
				return _dataServer;
			}
		}

		private HttpContext _context;
		private HttpContext Context
		{
			get
			{
				return _context;
			}
			set
			{
				_context = value;
			}
		}

		
		public void ProcessRequest(HttpContext context)
		{
			Context = context;
		
			if(context.Request.QueryString["path"] == null)
			{
				return;
			}

			DataRow itemRow = DataServer.GetItemRow(context.Request.QueryString["path"]);
			if(itemRow == null)
			{
				return;
			}
		
			byte[] bytes = DataServer.GetContent(context.Request.QueryString["path"]);
			if (bytes == null)
			{
				return;
			}

			WriteFile(bytes, itemRow["Name"].ToString(), itemRow["MimeType"].ToString(), context.Response);
		}

		/// <summary>
		/// Sends a byte array to the client
		/// </summary>
		/// <param name="content">binary file content</param>
		/// <param name="fileName">the filename to be sent to the client</param>
		/// <param name="contentType">the file content type</param>
		private void WriteFile(byte[] content, string fileName, string contentType, HttpResponse response)
		{
			response.Buffer = true;
			response.Clear();
			response.ContentType = contentType;
            string extension = System.IO.Path.GetExtension(fileName);
            if (extension != ".htm" && extension != ".html" && extension != ".xml")
            {
			    response.AddHeader("content-disposition", "attachment; filename=" + fileName);
            }
            response.BinaryWrite(content);
			response.Flush();
			response.End();
		}

		public bool IsReusable
		{
			get
			{
				return false;
			}
		}

		#endregion
	}
	}