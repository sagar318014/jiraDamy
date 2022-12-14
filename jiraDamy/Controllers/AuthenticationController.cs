using BusinessLogic.Authentication;
using jiraDamy.ActionFilters;
using System.Collections.Generic;
using System.Web.Mvc;
using ViewModel;

namespace jiraDamy.Controllers
{
    public class AuthenticationController : Controller
    {

        /*Actions actions = new Actions()*/
        #region constructor
        private BL_Authentication AuthenticationBL;
        public AuthenticationController()
        {
            this.AuthenticationBL = new BL_Authentication();
        }
        #endregion

        // GET: Authentication
        [HttpGet]
        public ActionResult Login()
        {
            if (Session["Username"] != null)
            {
                return RedirectToAction("todo", "Home");
            }
            return View();
        }

        [HttpPost]
        [WithModelValidation]
        public ActionResult Login(UserLoginViewModel userLoginViewModel)
        {
            UserLoginViewModel authenticatedUserModel = AuthenticationBL.GetAutheticatedUser(userLoginViewModel);
            if(authenticatedUserModel == null)
            {
                return View(authenticatedUserModel);
            }
            Session["Username"] = authenticatedUserModel.Username;
            Session["UserId"] = authenticatedUserModel.Id;
            List<UserActions> Actions = new BL_Authentication().GetActionList(authenticatedUserModel.RoleId);
            Session["Actions"] = Actions;

            //this.actions.userCreation = false;
            //this.actions.taskCreation = false;
            //this.actions.teamCreation = false;
            //foreach (var Action in Actions.ActionId)
            //{
            //    if (Action == 1) {
            //        this.actions.userCreation = true;
            //    }
            //    if (Action == 3)
            //    {
            //        this.actions.taskCreation = true;
            //    }
            //    if (Action == 7)
            //    {
            //        this.actions.teamCreation = true;
            //    }
            //}
                return RedirectToAction("ShowHomePage", "Home");
        }

        public ActionResult Logout()
        {
            Session["Username"] = null;
            return RedirectToAction("Login");
        }
        public ActionResult Unathorized()
        {
            return View("Unathorized");
        }
        [SessionBaseAuthorize]
        [ActionAccessValidation(actionId = 1)]
        public ActionResult SignUp()
        
        {
            UserSignupViewModel model = new UserSignupViewModel();
            model.RoleIdList = new BL_Authentication().GetRoleList();
            return View(model);
        }
        [HttpPost]
        public ActionResult SignUp(UserSignupViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return View("SignUp");
            }
            new BL_Authentication().SaveUserData(model) ;
            return RedirectToAction("Login");
        }

        //    public ActionResult GetRoleIdTypeList()
        //    {
        //        return new BL_Authentication().GetRoleList();
        //}
    }
}