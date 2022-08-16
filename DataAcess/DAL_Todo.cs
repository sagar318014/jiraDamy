using Dapper;
using DataAcess.entits;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace DataAcess
{
    public class DAL_Todo
    {
        string connectionString = ConfigurationManager.ConnectionStrings["devconnection"].ConnectionString;
        public void SaveTodo(taskDataTable AddTask)
        {
            string sql = @"INSERT INTO [dbo].[taskDataTable]
                            ([taskName]
                            ,[description]
                            ,[taskStatus])
                        VALUES
                            (@taskName
                            ,@description
                            ,@taskStatus)";

            object ts = new
            {
                taskName = AddTask.taskName,
                description = AddTask.description,
                taskStatus = AddTask.taskStatus
            };
            using (var db = new SqlConnection(connectionString))
            {
                db.Open();
                db.Query(sql, ts);
                db.Close();
            }
        }

        //public void SaveActive(int id)
        //{
        //    //using (var db = new taskDatabaseEntities())
        //    //{


        //    //    foreach (var item in db.taskDataTables)
        //    //    {
        //    //        if (item.taskId == id)
        //    //        {
        //    //            item.taskStatus = 2;
        //    //        }
        //    //    }
        //    //    db.SaveChanges();

               
        //    //}

        //}



        public List<taskDataTable> TaskList(int id)
        {

            string sql = "Select * from taskDataTable where [taskStatus]=@taskStatus";
            using(var db = new SqlConnection(connectionString))
            {
                List<taskDataTable> TaskList = db.Query<taskDataTable>(sql, new { taskStatus = id }).AsList();
                return TaskList;

            }

        }


        public void MoveNext(int Id,int Status )
        {
            string sql = "update taskDataTable set taskStatus = @Status Where taskId = @Id";
            using (var db = new SqlConnection(connectionString))
            {
                db.Open();
                db.Query(sql,new { Id = Id, Status = Status });
                db.Close();
            }
            //using (var db = new taskDatabaseEntities())
            //{


            //    foreach (var item in db.taskDataTables)
            //    {
            //        if (item.taskId == Id)
            //        {
            //            item.taskStatus = Status;
            //        }
            //    }
            //    db.SaveChanges();


            //}

            //using (var db = new taskDatabaseEntities())
            //{

            //    db.taskDataTables.Add(AddTask);
            //    db.SaveChanges();

            //}
        }
        public void DeleteRecord(int Id)
        {
            string sql = "delete form taskDataTable Where taskId = @Id";
            using (var db = new SqlConnection(connectionString))
            {
                db.Open();
                db.Query(sql, new { Id = Id});
                db.Close();
            }
        }
        public List<statusTable> StatusList()
        {

            string sql = "Select * from statusTable";
            using (var db = new SqlConnection(connectionString))
            {
                List<statusTable> StatusList = db.Query<statusTable>(sql).AsList();
                return StatusList;

            }

        }

        public List<User> UserList()
        {

            string sql = "Select * from User";
            using (var db = new SqlConnection(connectionString))
            {
                List<User> UserList = db.Query<User>(sql).AsList();
                return UserList;

            }

        }




    }
}
