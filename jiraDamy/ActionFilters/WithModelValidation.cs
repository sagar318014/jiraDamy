using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace jiraDamy.ActionFilters
{
    public class WithModelValidation : ActionFilterAttribute
    {
        public string ViewName { get; set; }
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (!filterContext.Controller.ViewData.ModelState.IsValid)
            {
                string actionName = (string)filterContext.RouteData.Values["action"];
                filterContext.Result = new ViewResult
                {
                    ViewName = ViewName ?? actionName,
                    ViewData = filterContext.Controller.ViewData,
                    TempData = filterContext.Controller.TempData
                };
            }
        }
    }
}