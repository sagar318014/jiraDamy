using jiraDamy.ActionFilters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ViewModel;
using BusinessLogic;
using BusinessLogic.Authentication;

namespace jiraDamy.Controllers
{
    public class ActionController : Controller
    {
        // GET: Action
        [SessionBaseAuthorize]
        [HttpGet]
        [ActionAccessValidation(actionId = 11)]

        public ActionResult ActionList ()
        {
            List<UserActions> model = new BL_Action().GetActionList();
            return View("ActionList", model);
        }
        public ActionResult SetAction()
        {
            UserActions modal = new UserActions();
            List<UserActions> Actions = new BL_Authentication().GetActionList((int)Session["RoleId"]);
            Session["Actions"] = Actions;
            return View(modal);
        }
        [HttpPost]
       
        [WithModelValidation]
        public ActionResult SetAction(UserActions model)
        {
            new BL_Action().SetAction(model);
            return RedirectToAction("SetAction");
        }
    }
}