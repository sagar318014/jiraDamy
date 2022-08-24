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

 


            foreach (var item in TodoList)
            {
                TaskTableViewModel taskTableViewModel = new TaskTableViewModel();

                taskTableViewModel.description = item.description;
                taskTableViewModel.taskId = item.taskId;
                taskTableViewModel.taskName = item.taskName;
                taskTableViewModel.taskStatus = item.taskStatus;

                Todo.Add(taskTableViewModel);
            }
            return Todo;


        }

        public List<TaskTableViewModel> ActiveList(int id)
        {


            List<TaskTableViewModel> Active = new List<TaskTableViewModel>();

            List<taskDataTable> ActiveList = new DAL_Todo().TaskList(id);

            foreach (var item in ActiveList)
            {
                TaskTableViewModel taskTableViewModel = new TaskTableViewModel();

                taskTableViewModel.description = item.description;
                taskTableViewModel.taskId = item.taskId;
                taskTableViewModel.taskName = item.taskName;
                taskTableViewModel.taskStatus = item.taskStatus;

                Active.Add(taskTableViewModel);
            }
            return Active;

        }
        public List<TaskTableViewModel> CompletedList(int id)
        {

            List<TaskTableViewModel> Completed = new List<TaskTableViewModel>();

            List<taskDataTable> CompletedList = new DAL_Todo().TaskList(id);
            foreach (var item in CompletedList)
            {
                TaskTableViewModel taskTableViewModel = new TaskTableViewModel();

                taskTableViewModel.description = item.description;
                taskTableViewModel.taskId = item.taskId;
                taskTableViewModel.taskName = item.taskName;
                taskTableViewModel.taskStatus = item.taskStatus;

                Completed.Add(taskTableViewModel);
            }
            
            return Completed;

        }

        public void Delete(int id)
        {

            new DAL_Todo().DeleteRecord(id);
        }
        public List<CommonDropdownType> GetStatusList()
        {
            List<statusTable> StatusList = new DAL_Todo().StatusList();
            List<CommonDropdownType> statusDropdownList = new List<CommonDropdownType>();
            foreach (var item in StatusList)
            {
                CommonDropdownType status = new CommonDropdownType();

                status.id = item.statusID;
                status.text = item.statusName;

                statusDropdownList.Add(status);
            }

            return statusDropdownList;
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
