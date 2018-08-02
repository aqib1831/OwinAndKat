using Microsoft.Owin;
using Owin;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
[assembly: OwinStartup(typeof(OwinAndkatana.Startup))]
namespace OwinAndkatana
{
    public class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            //xample runs in the ASP.NET request pipeline, which uses System.Web in the context of IIS
            //app.Run(context =>
            //{
            //    context.Response.ContentType = "text/plain";
            //    return context.Response.WriteAsync("Helloworld");
            //});
            app.Use((context, next) =>
            {
                PrintCurrentIntegratedPipelineStage(context, "Middleware 1");
                return next.Invoke();
            });
            app.Use((context, next) =>
            {
                PrintCurrentIntegratedPipelineStage(context, "2nd MW");
                return next.Invoke();
            });
            app.Run(context =>
            {
                PrintCurrentIntegratedPipelineStage(context, "3rd MW");
                return context.Response.WriteAsync("Hello world");
            });
        }

        private void PrintCurrentIntegratedPipelineStage(IOwinContext context, string v)
        {
            var currentIntegratedpipelineStage = HttpContext.Current.CurrentNotification;
            context.Get<TextWriter>("host.TraceOutput").WriteLine(
                "Current IIS event: " + currentIntegratedpipelineStage
                + " Msg: " + v);
        }
    }
}