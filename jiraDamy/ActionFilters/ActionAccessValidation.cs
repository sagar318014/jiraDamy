using System.Web.Mvc;
using System.Collections.Generic;

namespace jiraDamy.ActionFilters
{
    public class ActionAccessValidation : ActionFilterAttribute
    {
        public int actionId { get; set; }
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            //List<int> Actions = new List<int>(((Controller)filterContext.Controller).Session["Actions"]);
            //foreach (var Action in Actions) {
            //    if (Action == actionId)
            //    {
            //        filterContext.Result = new RedirectResult("/Authentication/Login");
            //        break;
            //    }
            //}
        }
    }
}