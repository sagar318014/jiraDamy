using BusinessLogic.Authentication;
using jiraDamy.ActionFilters;
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
    }
}