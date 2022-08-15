using BusinessLogic.Authentication;
using jiraDamy.ActionFilters;
using System.Collections.Generic;
using System.Web.Mvc;
using ViewModel;

namespace jiraDamy.Controllers
{
    public class AuthenticationController : Controller
    {
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
            return RedirectToAction("todo", "Home");
        }

        public ActionResult Logout()
        {
            Session["Username"] = null;
            return RedirectToAction("Login");
        }

        public ActionResult SignUp()
        
        {
            UserSignupViewModel model = new UserSignupViewModel();
            //model.RoleIdList = new List<CommonDropdownType>() {
            //        new CommonDropdownType(){id = 1, text =  "Admin"},
            //        new CommonDropdownType(){id = 2, text =  "HR"},
            //         new CommonDropdownType(){id = 3, text =  "User"} };
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
        public ActionResult GetRoleIdTypeList()
        {
            return Json(new
            {
                data = new List<dynamic>() {
                    new {id = 1, text =  "Admin"},
                    new {id = 2, text =  "HR"},
                     new {id = 3, text =  "User"},
            }
            }, JsonRequestBehavior.AllowGet);
    }   }
}