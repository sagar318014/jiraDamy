using jiraDamy.ActionFilters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ViewModel;
using BusinessLogic;




namespace jiraDamy.Controllers
{
    public class ActionController : Controller
    {
        // GET: Action
        [SessionBaseAuthorize]
        [HttpGet]
        public ActionResult SetAction()
        {
            UserActions modal = new UserActions();
            return View(modal);
        }
        [HttpPost]
        [ActionAccessValidation(actionId = 11)]
        [WithModelValidation]
        public ActionResult SetAction(UserActions model)
        {
            new BL_Action().SetAction(model);
            return RedirectToAction("SetAction");
        }
    }
}