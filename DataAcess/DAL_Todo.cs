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
    }
}
