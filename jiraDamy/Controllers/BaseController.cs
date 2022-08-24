﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace jiraDamy.Controllers
{
    public class BaseController : Controller
    {
        public string RenderPartialToString(string viewName, object model)
        {
            ControllerContext ControllerContext = this.ControllerContext;
            if (string.IsNullOrEmpty(viewName))
                viewName = ControllerContext.RouteData.GetRequiredString("action");
            ViewDataDictionary ViewData = new ViewDataDictionary();
            TempDataDictionary TempData = new TempDataDictionary();
            ViewData.Model = model;

            using (StringWriter sw = new StringWriter())
            {
                ViewEngineResult viewResult = ViewEngines.Engines.FindPartialView(ControllerContext, viewName);
                ViewContext viewContext = new ViewContext(ControllerContext, viewResult.View, ViewData, TempData, sw);
                viewResult.View.Render(viewContext, sw);

                return sw.GetStringBuilder().ToString();
            }

        }
    }
}