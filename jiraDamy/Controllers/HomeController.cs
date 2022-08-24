
using BusinessLogic;
using jiraDamy.ActionFilters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ViewModel;


namespace jiraDamy.Controllers
{
    [SessionBaseAuthorize]
    public class HomeController : Controller
    {
        [ActionAccessValidation(actionId = 4)]
        public ActionResult Todo()
        {
            //this.UpdateActions();
            List<TaskTableViewModel> Todo = new BL_Todo().TodoList(1);
            ViewData["UserActions"] = (List<UserActions>)Session["Actions"];
            return View("Todo",Todo);



        }


        //public void UpdateActions()
        //{
        //    List<int> Actions = (List<int>)Session["Actions"];
        //    this.actions.userCreation = false;
        //    this.actions.taskCreation = false;
        //    this.actions.teamCreation = false;
        //    this.actions.showTaskTable = false;
        //    foreach (var Action in Actions)
        //    {
        //        if (Action == 1)
        //        {
        //            this.actions.userCreation = true;
        //        }
        //        if (Action == 3)
        //        {
        //            this.actions.taskCreation = true;
        //        }
        //        if (Action == 7)
        //        {
        //            this.actions.teamCreation = true;
        //        }
        //        if (Action == 4|| Action == 5|| Action == 6)
        //        {
        //            this.actions.showTaskTable = true;
        //        }
        //    }
        //}
        //public ActionResult getdata()
        //{
        //    return Json(new
        //    {
        //        data = new List<dynamic>() {
        //            new {id = 1, text =  "sagar"},
        //            new {id = 2, text =  "gavand"},
        //    }
        //    }, JsonRequestBehavior.AllowGet);
        //}

        //public ActionResult GetTaskTypeList()
        //{
        //    return Json(new
        //    {
        //        data = new List<dynamic>() {
        //            new {id = 1, text =  "Todo"},
        //            new {id = 2, text =  "Active"},
        //             new {id = 3, text =  "Completed"},
        //    }
        //    }, JsonRequestBehavior.AllowGet);
        //}

        [ActionAccessValidation(actionId = 5)]
        public ActionResult Active()
        {
            //this.UpdateActions();
            List<TaskTableViewModel> Active = new BL_Todo().ActiveList(2);

            return View("Active", Active);
           


        }



        [ActionAccessValidation(actionId = 6)]
        public ActionResult Completed()
        {
            //this.UpdateActions();
            List<TaskTableViewModel> Completed = new BL_Todo().CompletedList(3);

            return View("Completed", Completed);
          

        }

        [ActionAccessValidation(actionId = 7)]
        public ActionResult CreateTeam()
        {
            //List<TaskTableViewModel> Completed = new BL_Todo().CompletedList(3);

            CreateTeamViewModel model = new CreateTeamViewModel();

            //this.UpdateActions();
            //model.actions = this.actions;

            return View("CreateTeam", model);


        }

        [HttpGet]
        public ActionResult AddTeam()
        {
            ViewBag.Message = "Your application description page.";

            TaskTableViewModel model = new TaskTableViewModel();

            //this.UpdateActions();
            //model.actions = this.actions;
            return View(model);
        }

        public ActionResult ShowHomePage()
        {
            TaskTableViewModel model = new TaskTableViewModel();

            //this.UpdateActions();
            //model.actions = this.actions;
            return View("Home",model);
        }


        [HttpPost]
        public ActionResult AddTeam(TaskTableViewModel model)
        {


            //TaskTableViewModel model = new TaskTableViewModel();

            //this.UpdateActions();
            //model.actions = this.actions;
            return View(model);
        }



        // Form show
        [HttpGet]
        public ActionResult AddTask()
        {
            ViewBag.Message = "Your application description page.";

            TaskTableViewModel model = new TaskTableViewModel();

            model.taskStatusList = new BL_Todo().GetStatusList();
            //this.UpdateActions();
            //model.actions = this.actions;

            return View(model);
        }

        [HttpPost]

        [ActionAccessValidation(actionId = 3)]
        public ActionResult AddTask(TaskTableViewModel model)
        {
            //create one
            //this.UpdateActions();
            //model.actions = this.actions;
            if (!ModelState.IsValid)
            {

                return View("AddTask", model);
            }

            new BL_Todo().SaveTodo(model);
            if (model.taskStatus == 1)
            {
                return RedirectToAction("Todo");
            }
            else if (model.taskStatus == 2)
            {
                return RedirectToAction("Active");
            }
            else if(model.taskStatus == 3)
            {
                return RedirectToAction("Completed");
            }

            return RedirectToAction("AddTask");

        }



        public ActionResult MoveInToActive(int Id)
        {           

            new BL_Todo().MoveToActive(Id);

            return RedirectToAction("Active");
        }

        public ActionResult MoveInToCompleted(int Id)
        {
            new BL_Todo().MoveToCompleted(Id);

            return RedirectToAction("Completed");
        }

        public void Delete(int id)
        {

           new BL_Todo().Delete(id);
        }


    }
}
