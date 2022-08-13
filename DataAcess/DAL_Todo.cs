using DataAcess.entits;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAcess
{
    public class DAL_Todo
    {
        public void SaveTodo(taskDataTable AddTask)
        {
            using (var db = new taskDatabaseEntities())
            {
               
                db.taskDataTables.Add(AddTask);
                db.SaveChanges();
               
            }
        }

        public void SaveActive(int id)
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

               
            }

        }



        public List<taskDataTable> TaskList(int id)
        {
            using (var db = new taskDatabaseEntities())
            {
                List<taskDataTable> TaskList = db.taskDataTables.Where(x => x.taskStatus == id).ToList();
                return TaskList;

            }
        
        }


        public void MoveNext(int Id,int Status )
        {

            using (var db = new taskDatabaseEntities())
            {


                foreach (var item in db.taskDataTables)
                {
                    if (item.taskId == Id)
                    {
                        item.taskStatus = Status;
                    }
                }
                db.SaveChanges();

                
            }

            //using (var db = new taskDatabaseEntities())
            //{

            //    db.taskDataTables.Add(AddTask);
            //    db.SaveChanges();

            //}
        }

        

        public void Delete(int id)
        {

            using (var db = new taskDatabaseEntities())
            {
                
                //foreach (var item in db.taskDataTables)
                //{
                //    if (item.taskId == id)
                //    {
                //        ts = item.taskStatus;
                //    }
                //}

                var res = db.taskDataTables.Where(x => x.taskId == id).First();
                
                db.taskDataTables.Remove(res);
                db.SaveChanges();
               
            }


        }

    }
}
