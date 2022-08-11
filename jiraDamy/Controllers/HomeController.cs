﻿
using BusinessLogic;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ViewModel;


namespace jiraDamy.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Todo()
        {
            

            List<TaskTableViewModel> Todo = new BL_Todo().TodoList(1);

            return View("Todo", Todo);

           


        }

        public ActionResult getdata()
        {
            return Json(new
            {
                data = new List<dynamic>() {
                    new {id = 1, text =  "sagar"},
                    new {id = 2, text =  "gavand"},
            }
            },JsonRequestBehavior.AllowGet);
        }

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

        // Form show
        [HttpGet]
        public ActionResult AddTask()
        {
            ViewBag.Message = "Your application description page.";

            TaskTableViewModel model = new TaskTableViewModel();

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

            return RedirectToAction("Todo");

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
        public ActionResult Delete(int id)
        {
            //using (var db = new taskDatabaseEntities())
            //{

            //    var res = db.taskDataTables.Where(x => x.taskId == id).First();
            //    db.taskDataTables.Remove(res);
            //    db.SaveChanges();
            //    return RedirectToAction("AddTask");
            //}
            return RedirectToAction("AddTask");
        }


    }
}
