﻿
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
        public ActionResult Todo()
        {
            

            List<TaskTableViewModel> Todo = new BL_Todo().TodoList(1);

            return View("Todo", Todo);

           


        }

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

        public ActionResult Active()
        {
            List<TaskTableViewModel> Active = new BL_Todo().ActiveList(2);

            return View("Active", Active);
           


        }

       

        public ActionResult Completed()
        {
            List<TaskTableViewModel> Completed = new BL_Todo().CompletedList(3);

            return View("Completed", Completed);
          

        }
        public ActionResult CreateTeam()
        {
            //List<TaskTableViewModel> Completed = new BL_Todo().CompletedList(3);

            return View("CreateTeam");


        }

        [HttpGet]
        public ActionResult AddTeam()
        {
            ViewBag.Message = "Your application description page.";

            TaskTableViewModel model = new TaskTableViewModel();

            return View(model);
        }

        [HttpPost]
        public ActionResult AddTeam(TaskTableViewModel model)
        {
           

            //TaskTableViewModel model = new TaskTableViewModel();

            return View(model);
        }



        // Form show
        [HttpGet]
        public ActionResult AddTask()
        {
            ViewBag.Message = "Your application description page.";

            TaskTableViewModel model = new TaskTableViewModel();

            model.taskStatusList = new BL_Todo().GetStatusList();

            return View(model);
        }

        [HttpPost]
        public ActionResult AddTask(TaskTableViewModel model)
        {
            //create one
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
            //{


            //    foreach (var item in db.taskDataTables)
            //    {
            //        if (item.taskId == id)
            //        {
            //        }
            //    }
            //    db.SaveChanges();

            //    return RedirectToAction("Active");
            //}


            //{


        } 
        }
        }
        }
            //    foreach (var item in db.taskDataTables)
            //    {
            //        if (item.taskId == id)
            //        {
            //            item.taskStatus = 3;
            //        }
            //    }
            //    db.SaveChanges();

            //    return RedirectToAction("Completed");
            //}


            //            item.taskStatus = 2;
            //        }
            //    }
            //    db.SaveChanges();

            //    return RedirectToAction("Active");
            //}


            //{

            //    var res = db.taskDataTables.Where(x => x.taskId == id).First();
            //    db.taskDataTables.Remove(res);
            //    db.SaveChanges();
            //    return RedirectToAction("AddTask");
            //}
            return RedirectToAction("AddTask");
        }
            //        }
            //    }
            //    db.SaveChanges();

            //    return RedirectToAction("Active");
            //}


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


            //    var res = db.taskdatatables.where(x => x.taskid == id).first();
            //    db.taskdatatables.remove(res);
            //    db.savechanges();
            //}
            return RedirectToAction("AddTask");
        }


    }
}
