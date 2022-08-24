﻿using DataAcess;
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

        public void UpdateTask(TaskTableViewModel model)
        { 
            TaskDataTable updateTable = new TaskDataTable();
            

            updateTable.taskId = model.taskId;
            updateTable.assigneeId = model.assigneeId;

            new DAL_Todo().UpdateTask(updateTable);


        }

        public List<UserSignupViewModel> GetAllUserList()
        { 
            List<UserSignupViewModel> user = new List<UserSignupViewModel>();
            List<User> userList = new DAL_Todo().GetAllUserList();

            foreach (var item in userList)
            {
                UserSignupViewModel userViewModel = new UserSignupViewModel();

                userViewModel.Id = item.Id;
                userViewModel.Username= item.Username;
                userViewModel.Name = item.Name;
                userViewModel.FirstName = item.FirstName;
                userViewModel.LastName = item.LastName;

                user.Add(userViewModel);

            }
            return user;


        }

        public List<CommonDropdownType> GetRoleList()
        {

            List<CommonDropdownType> roleList = new List<CommonDropdownType>();
            foreach (var item in new DAL_Todo().RoleList())
            {
                CommonDropdownType role = new CommonDropdownType();

                role.id = item.Id;
                role.text = item.Name;

                roleList.Add(role);
            }
            return roleList;

        }

        public List<UserSignupViewModel> GetEditUserList(int id)
        {
            List<UserSignupViewModel> user = new List<UserSignupViewModel>();
            List<User> userList = new DAL_Todo().GetEditUserList(id);

            foreach (var item in userList)
            {
                UserSignupViewModel userViewModel = new UserSignupViewModel();

                userViewModel.Id = item.Id;
                userViewModel.Username = item.Username;
                userViewModel.RoleId = item.RoleId;
                userViewModel.FirstName = item.FirstName;
                userViewModel.LastName = item.LastName;
                userViewModel.Password= item.Password;

                user.Add(userViewModel);

            }
            return user;


        }

        public void UpdateUser(UserSignupViewModel model)
        {
            User update = new User();

            update.Username = model.Username;
            update.RoleId = model.RoleId;
            update.FirstName = model.FirstName; 
            update.LastName = model.LastName;   
            update.Password = model.Password;
            update.Id = model.Id;

            new DAL_Todo().UpdateUser(update);
        }

        public int TaskList(int id)
        {
            List<TaskDataTable> taskList = new DAL_Todo().GetTaskList(id);
            List<TaskDataTable> tempTasklist = new List<TaskDataTable>();
            foreach(var task in taskList)
            {
                if(task.taskStatus == 1 || task.taskStatus == 2)
                {
                    tempTasklist.Add(task);
                }
            }
            int count = tempTasklist.Count();

            return count;

        }

        public void DeleteUser(int id)
        {
            new DAL_Todo().DeleteUser(id);
        }

        public List<TaskTableViewModel> UserTaskList(int id)
        {
            List<TaskTableViewModel> users = new List<TaskTableViewModel>();
            List<TaskDataTable> taskList = new DAL_Todo().GetUserTaskList(id);
            foreach (var item in taskList)
            {
                TaskTableViewModel model = new TaskTableViewModel();

                model.taskName=item.taskName;
                model.userName = item.userName;
                model.description = item.description;
                model.taskStatus= item.taskStatus;
                model.assigneeId = item.assigneeId;
                model.statusName = item.statusName;
                model.taskId = item.taskId;
               
                users.Add(model);   
                

            }
            return users;


        }

        public void UnassigneeUser(int id)
        {
            new DAL_Todo().UnassigneeUser(id);
        }


    }
}
