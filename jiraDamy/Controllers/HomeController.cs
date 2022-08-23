
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
            foreach (var item in Todo)
	        {
             item.taskStatusList = new BL_Todo().GetStatusList();
            item.userList = new BL_Todo().GetUserList();
	        }
            
            
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

        //public ActionResult GetResult()
        //{
        //    return Json(new
        //    {
        //        data = false

        //    }, JsonRequestBehavior.AllowGet) ;
        //}
            public ActionResult Active()
        {
            List<TaskTableViewModel> Active = new BL_Todo().ActiveList(2);
            foreach (var item in Active)
            {
                item.taskStatusList = new BL_Todo().GetStatusList();
                item.userList = new BL_Todo().GetUserList();
            }

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

            model.taskStatusList = new BL_Todo().GetStatusList();
            model.userList = new BL_Todo().GetUserList();

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

           
            try
            {
                new BL_Todo().Delete(id);
                return Json(new
                {
                    data = true

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


        [HttpPost]
        public ActionResult UpdateTask(TaskTableViewModel model)
        {
            try
            {
                if (model.assigneeId != null)
                {
                    new BL_Todo().UpdateTask(model);
                    return Json(new
                    {
                        data = true

                    }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new
                    {
                        data = false

                    }, JsonRequestBehavior.AllowGet);
                }
               

               

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
