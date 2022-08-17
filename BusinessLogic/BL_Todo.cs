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
            TaskDataTable AddTask = new TaskDataTable();
            AddTask.taskName = model.taskName;
            AddTask.description = model.description;
            AddTask.taskStatus = model.taskStatus;
            AddTask.assigneeId = model.assigneeId;
           

            new DAL_Todo().SaveTodo(AddTask);

        }

        public List<TaskTableViewModel> TodoList(int id)
        {

            List<TaskTableViewModel> Todo = new List<TaskTableViewModel>();

            List<TaskDataTable> TodoList = new DAL_Todo().TaskList(id);
            


            foreach (var item in TodoList)
            {
                TaskTableViewModel taskTableViewModel = new TaskTableViewModel();
               

                taskTableViewModel.description = item.description;
                taskTableViewModel.taskId = item.taskId;
                taskTableViewModel.taskName = item.taskName;
                taskTableViewModel.taskStatus = item.taskStatus;
                taskTableViewModel.assigneeId = item.assigneeId;
                taskTableViewModel.userName = item.userName;

                Todo.Add(taskTableViewModel);
            }
            return Todo;


        }

        public List<TaskTableViewModel> ActiveList(int id)
        {


            List<TaskTableViewModel> Active = new List<TaskTableViewModel>();

            List<TaskDataTable> ActiveList = new DAL_Todo().TaskList(id);

            foreach (var item in ActiveList)
            {
                TaskTableViewModel taskTableViewModel = new TaskTableViewModel();

                taskTableViewModel.description = item.description;
                taskTableViewModel.taskId = item.taskId;
                taskTableViewModel.taskName = item.taskName;
                taskTableViewModel.taskStatus = item.taskStatus;
                taskTableViewModel.assigneeId = item.assigneeId;
                taskTableViewModel.userName= item.userName;

                Active.Add(taskTableViewModel);
            }
            return Active;

        }
        public List<TaskTableViewModel> CompletedList(int id)
        {

            List<TaskTableViewModel> Completed = new List<TaskTableViewModel>();

            List<TaskDataTable> CompletedList = new DAL_Todo().TaskList(id);
            foreach (var item in CompletedList)
            {
                TaskTableViewModel taskTableViewModel = new TaskTableViewModel();

                taskTableViewModel.description = item.description;
                taskTableViewModel.taskId = item.taskId;
                taskTableViewModel.taskName = item.taskName;
                taskTableViewModel.taskStatus = item.taskStatus;
                taskTableViewModel.assigneeId = item.assigneeId;
                taskTableViewModel.userName = item.userName;


                Completed.Add(taskTableViewModel);
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

        public List<CommonDropdownType> GetStatusList()
        {

            List<CommonDropdownType> StatusList = new List<CommonDropdownType>();
            foreach (var item in new DAL_Todo().StatusList())
            {
                CommonDropdownType Status = new CommonDropdownType();

                Status.id = item.statusID;
                Status.text = item.statusName;

                StatusList.Add(Status);
            }
            return StatusList;



        }
        public List<CommonDropdownType> GetUserList()
        {

            List<CommonDropdownType> userList = new List<CommonDropdownType>();
            foreach (var item in new DAL_Todo().UserList())
            {
                CommonDropdownType user = new CommonDropdownType();

                user.id = item.Id;
                user.text = item.Username;

                userList.Add(user);
            }
            return userList;



        }

        public void Delete(int id)
        {

           new DAL_Todo().Delete(id);


           
        }

    }
}
