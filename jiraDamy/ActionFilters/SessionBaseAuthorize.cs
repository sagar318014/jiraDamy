using System.Web.Mvc;

namespace jiraDamy.ActionFilters
{
    public class SessionBaseAuthorize : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (((Controller)filterContext.Controller).Session["Username"] == null)
            {
                filterContext.Result = new RedirectResult("/Authentication/Login");
            }
        }
    }
}