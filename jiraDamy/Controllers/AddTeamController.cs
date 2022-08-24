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
        [HttpGet]
        public ActionResult AddTeam()
        {
            ViewBag.Message = "Your application description page.";

            TeamsViewModel model = new TeamsViewModel();

            model.TeamLeders = new BL_Todo().GetUserList();

            return View(model);
        }
        [HttpPost]
       
        public ActionResult AddTeam(TeamsViewModel model)
        {

            new BL_AddTeam().SaveTeam(model);
            //TaskTableViewModel model = new TaskTableViewModel();

            return RedirectToAction("CreateTeam",model);
        }
        [ActionAccessValidation(actionId = 7)]
        public ActionResult CreateTeam()
        {
            //List<TaskTableViewModel> Completed = new BL_Todo().CompletedList(3);
            TeamsViewModel ViewMOdel = new TeamsViewModel();

            ViewMOdel.TeamLeders = new BL_Todo().GetUserList();
            return View("CreateTeam", ViewMOdel);


        }
      
        public ActionResult TeamManagement()
        {
            List<TeamsViewModel> TeamManagement = new BL_AddTeam().TeamsList();
            

            return View("TeamManagement", TeamManagement);


        }

        public ActionResult TeamMemberList()
        {
            int TeamID;
            //List<TeamsViewModel> TeamManagement = new BL_AddTeam().TeamsList();


            return View();


        }


    }
}