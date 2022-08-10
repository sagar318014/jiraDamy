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

        public List<TaskTableViewModel> TodoList(int id)
        {

            List<TaskTableViewModel> Todo = new List<TaskTableViewModel>();

            List<taskDataTable> TodoList = new DAL_Todo().TaskList(id);

            for (int i = 0; i < TodoList.Count; i++)
            {
                Todo[i].taskName = TodoList[i].taskName;
                Todo[i].description = TodoList[i].description;
            }
            return Todo;


        }

        public List<TaskTableViewModel> ActiveList(int id)
        {


            List<TaskTableViewModel> Active = new List<TaskTableViewModel>();

            List<taskDataTable> ActiveList = new DAL_Todo().TaskList(id);

            for (int i = 0; i < ActiveList.Count; i++)
            {
                Active[i].taskName = ActiveList[i].taskName;
                Active[i].description = ActiveList[i].description;
            }
            return Active;

        }
        public List<TaskTableViewModel> CompletedList(int id)
        {

            List<TaskTableViewModel> Completed = new List<TaskTableViewModel>();

            List<taskDataTable> CompletedList = new DAL_Todo().TaskList(id);
            
            for(int i = 0;i< CompletedList.Count; i++) 
            { 
                Completed[i].taskName = CompletedList[i].taskName;
                Completed[i].description = CompletedList[i].description;
            }




            return Completed;

        }

        public void MoveToActive(int Id)
        {

            new DAL_Todo().MoveNext(Id, 2);



        }

        public void MoveToCompleted(int Id)
        {

            new DAL_Todo().MoveNext(Id, 3);



        }

    }
}
