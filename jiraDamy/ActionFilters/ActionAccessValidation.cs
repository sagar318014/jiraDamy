using System.Web.Mvc;
using System.Collections.Generic;
using ViewModel;

namespace jiraDamy.ActionFilters
{
    public class ActionAccessValidation : ActionFilterAttribute
    {
        public int actionId { get; set; }
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            List<UserActions> Actions = (List<UserActions>)((Controller)filterContext.Controller).Session["Actions"];
            var IsPresent = true;
            foreach (var Action in Actions)
            {
                if (Action.ActionId == this.actionId)
                {
                    IsPresent = false;
                }
            }
            if (IsPresent == true)
            {
                filterContext.Result = new RedirectResult("/Authentication/Unathorized");
            }
        }
    }
}