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
            //read all
            //using (var db = new taskDatabaseEntities())
            //{
            //    List<taskDataTable> tbllist = db.taskDataTables.Where(x => x.taskStatus == 1).ToList();
            //    return View(tbllist);
            //}

            List < TaskTableViewModel > Todo  = new BL_Todo().TodoList(1);

            return RedirectToAction("Todo", Todo); 

            //get single
            //using (var db = new TaskManagementEntities())
            //{
            //  var tasks = db.tasks.where(x => x.status_id == 1).tolist();
            //}

            //get single
            //using (var db = new TaskManagementEntities())
            //{
            //    foreach (var item in db.tasks)
            //    {

            //    };
            //}


        }

        public ActionResult Active()
        {
            List<TaskTableViewModel> Active = new BL_Todo().ActiveList(2);

            return RedirectToAction("Active", Active);
            //using (var db = new taskDatabaseEntities())
            //{
            //    List<taskDataTable> tbllist = db.taskDataTables.Where(x => x.taskStatus == 2).ToList();
            //    return View(tbllist);
            //}


        }

        public ActionResult Completed()
        {
            List < TaskTableViewModel > Completed = new BL_Todo().CompletedList(3);

            return RedirectToAction("Completed", Completed);
            //using (var db = new taskDatabaseEntities())
            //{
            //    List<taskDataTable> tbllist = db.taskDataTables.Where(x => x.taskStatus == 3).ToList();
            //    return View(tbllist);
            //}

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
            //using (var db = new taskDatabaseEntities())
            //{


            //    foreach (var item in db.taskDataTables)
            //    {
            //        if (item.taskId == id)
            //        {
            //            item.taskStatus = 2;
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
            //using (var db = new taskDatabaseEntities())
            //{
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
//@model jiraDamy.entits.taskDataTable


//@Html.TextBoxFor(x => x.taskName)

//List<jiraDamy.entits.taskDataTable>

//@model List<jiraDamy.entits.taskDataTable>

// public ActionResult taskList()
//{


//    var tlist = db.taskDataTables.ToList();


//    return View(tlist);
//}
