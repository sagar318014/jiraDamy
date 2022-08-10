using DataAcess;
using DataAcess.entits;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ViewModel;

namespace BusinessLogic
{
    public class BL_Todo
    {
      public void SaveTodo(TaskTableViewModel model)
        {
            taskDataTable AddTask = new taskDataTable();
            AddTask.taskName = model.taskName;
            AddTask.description = model.description;
            AddTask.taskStatus = 1;

            new DAL_Todo().SaveTodo(AddTask);

        }

       
    }
}
