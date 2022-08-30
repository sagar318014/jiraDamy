using BusinessLogic.Authentication;
using jiraDamy.ActionFilters;
using System;
using BusinessLogic;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ViewModel;
namespace jiraDamy.Controllers
{
    [SessionBaseAuthorize]
    public class AddTeamController : BaseController
    {
        
        //public ActionResult AddTeam()
        //{
            

        //    TeamsViewModel model = new TeamsViewModel();

        //    model.TeamLeders = new BL_Todo().GetUserList();

        //    return View(model);
        //}
        [HttpPost]
        
        public ActionResult CreateTeam(TeamsViewModel model)
        {
            if (!ModelState.IsValid)
            {
                model.TeamLeders = new BL_Todo().GetUserList();
                return View("CreateTeam", model);
            }
            new BL_AddTeam().SaveTeam(model);
            //TaskTableViewModel model = new TaskTableViewModel();

            return RedirectToAction("TeamManagement");
        }
        [HttpGet]
        public ActionResult CreateTeam()
        {
            //List<TaskTableViewModel> Completed = new BL_Todo().CompletedList(3);
            TeamsViewModel model = new TeamsViewModel();

            model.TeamLeders = new BL_Todo().GetUserList();
            return View("CreateTeam", model);


        }
        [ActionAccessValidation(actionId = 7)]
        public ActionResult TeamManagement()
        {
            List<TeamsViewModel> TeamManagement = new BL_AddTeam().TeamsList();


            return View("TeamManagement", TeamManagement);


        }

        public ActionResult TeamMemberList(int TeamID)
        {


            try
            {
                List<TeamsViewModel> model = new BL_AddTeam().MemberList(TeamID);
                return Json(new
                {
                    data = RenderPartialToString("TeamMemberList", model)

                }, JsonRequestBehavior.AllowGet);

            }
            catch (Exception)
            {

                return Json(new
                {
                    data = false

                }, JsonRequestBehavior.AllowGet);

            }

        }


    }
}