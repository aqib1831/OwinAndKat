using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OwinAndkatana
{
    public class MyModule : IHttpModule
    {
        public void Dispose()
        {
           // throw new NotImplementedException();
        }

        public void Init(HttpApplication context)
        {
            context.AuthenticateRequest += ctx_AuthRequest;
        }

        private void ctx_AuthRequest(object sender, EventArgs e)
        {
          
        }
    }
}