
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
            //read all
            //using (var db = new taskDatabaseEntities())
            //{
            //    List<taskDataTable> tbllist = db.taskDataTables.Where(x => x.taskStatus == 1).ToList();
            //    return View(tbllist);
            //}

            List<TaskTableViewModel> Todo = new BL_Todo().TodoList(1);

            return View("Todo", Todo);

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
            //using (var db = new taskDatabaseEntities())
            //{
            //    List<taskDataTable> tbllist = db.taskDataTables.Where(x => x.taskStatus == 2).ToList();
            //    return View(tbllist);
            //}


        }

        public ActionResult Completed()
        {
            List<TaskTableViewModel> Completed = new BL_Todo().CompletedList(3);

            return View("Completed", Completed);
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

            model.taskStatusList = new List<CommonDropdownType>() {
                    new CommonDropdownType(){id = 1, text =  "Todo"},
                    new CommonDropdownType(){id = 2, text =  "Active"},
                     new CommonDropdownType(){id = 3, text =  "Completed"}
            };

            model.userlist = new List<CommonDropdownType>() {
                    new CommonDropdownType(){id = 1, text =  "Sagar"},
                    new CommonDropdownType(){id = 2, text =  "Wrahul"},
                     new CommonDropdownType(){id = 3, text =  "rahulw"}
            };

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

            //    var res = db.taskdatatables.where(x => x.taskid == id).first();
            //    db.taskdatatables.remove(res);
            //    db.savechanges();
            //}
            return RedirectToAction("AddTask");
        }

        //public ActionResult GetUser()
        //{
        //    return Json(new
        //    {
        //        data = new List<dynamic>() {
        //            new {id = 1, text =  "Sagar"},
        //            new {id = 2, text =  "Wrahul"},
        //             new {id = 3, text =  "rahulw"},
        //    }
        //    }, JsonRequestBehavior.AllowGet);
        //}
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
