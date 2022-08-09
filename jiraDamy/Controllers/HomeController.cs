
using BusinessLogic;
using DataAcess;
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
            using (var db = new taskDatabaseEntities())
            {
                List<taskDataTable> tbllist = db.taskDataTables.Where(x => x.taskStatus == 1).ToList();
                return View(tbllist);
            }



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
            using (var db = new taskDatabaseEntities())
            {
                List<taskDataTable> tbllist = db.taskDataTables.Where(x => x.taskStatus == 2).ToList();
                return View(tbllist);
            }


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

        public ActionResult Completed()
        {
            using (var db = new taskDatabaseEntities())
            {
                List<taskDataTable> tbllist = db.taskDataTables.Where(x => x.taskStatus == 3).ToList();
                return View(tbllist);
            }

        }

        public ActionResult MoveInToActive(int id)
        {
            using (var db = new taskDatabaseEntities())
            {


                foreach (var item in db.taskDataTables)
                {
                    if (item.taskId == id)
                    {
                        item.taskStatus = 2;
                    }
                }
                db.SaveChanges();

                return RedirectToAction("Active");
            }

        }

        public ActionResult MoveInToCompleted(int id)
        {
            using (var db = new taskDatabaseEntities())
            {
                foreach (var item in db.taskDataTables)
                {
                    if (item.taskId == id)
                    {
                        item.taskStatus = 3;
                    }
                }
                db.SaveChanges();

                return RedirectToAction("Completed");
            }

        }
        public ActionResult Delete(int id)
        {
            using (var db = new taskDatabaseEntities())
            {

                var res = db.taskDataTables.Where(x => x.taskId == id).First();
                db.taskDataTables.Remove(res);
                db.SaveChanges();
                return RedirectToAction("AddTask");
            }

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
