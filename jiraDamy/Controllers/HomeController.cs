using jiraDamy.entits;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace jiraDamy.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
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

        public ActionResult About()
        {
            using (var db = new taskDatabaseEntities())
            {
                List<taskDataTable> tbllist = db.taskDataTables.Where(x => x.taskStatus == 2).ToList();
                return View(tbllist);
            }

            
        }

        public ActionResult FilForm()
        {
            ViewBag.Message = "Your application description page.";
            
            taskDataTable obj = new taskDataTable();
            
            return View(obj);
        }

        public ActionResult Contact()
        {
            using (var db = new taskDatabaseEntities())
            {
                List<taskDataTable> tbllist = db.taskDataTables.Where(x => x.taskStatus == 3).ToList();
                return View(tbllist);
            }

        }
        [HttpPost]
        public ActionResult AddTask(taskDataTable model)
        {
            //create one
            if (!ModelState.IsValid)
            {

                return View("FilForm", model);
            }

            using (var db = new taskDatabaseEntities())
            {
                taskDataTable AddTask = new taskDataTable();
                AddTask.taskName = model.taskName;
                AddTask.description = model.description;
                AddTask.taskStatus = 1;


                db.taskDataTables.Add(AddTask);
                db.SaveChanges();
                List<taskDataTable> tbllist = db.taskDataTables.Where(x => x.taskStatus == 1).ToList();

                return View("Index", tbllist);
            }
        }
        public ActionResult MoveInToActive(int id)
        {
            using (var db = new taskDatabaseEntities())
            {


                foreach (var item in db.taskDataTables)
                {
                    if(item.taskId == id)
                    {
                        item.taskStatus = 2;
                    }
                }
                db.SaveChanges();

                var list = db.taskDataTables.Where(x => x.taskStatus == 2).ToList(); 
                return View("About", list);
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

                var list = db.taskDataTables.Where(x => x.taskStatus == 3).ToList();
                return View("Contact", list);
            }

        }
        public ActionResult Delete(int id)
        {
            using (var db = new taskDatabaseEntities())
            {

                var res = db.taskDataTables.Where(x => x.taskId == id).First();
                db.taskDataTables.Remove(res);
                db.SaveChanges();

                var list = db.taskDataTables.ToList();
                return View("Index", list);
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
