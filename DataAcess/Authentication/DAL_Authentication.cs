using Dapper;
using DataAcess.entits;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAcess.Authentication
{
    public class DAL_Authentication
    {
        string connectionString = ConfigurationManager.ConnectionStrings["devconnection"].ConnectionString;
        public void SaveUserData(User adddata)
        {
            string sql = @"INSERT INTO [dbo].[User]
                            ([Username]
                            ,[Password]
                            ,[RoleId]
                            ,[FirstName]
                            ,[LastName]
                            ,[CreatedAt])
                        VALUES
                            (@Username
                            ,@Password
                            ,@RoleId
                            ,@FirstName
                            ,@LastName
                            ,@CreatedAt)";

            object sp = new
            {
                Username = adddata.Username,
                Password = adddata.Password,
                RoleId = adddata.RoleId,
                FirstName = adddata.FirstName,
                LastName = adddata.LastName,
                CreatedAt = System.DateTime.Now.ToString("yyyy-MM-dd")
            };

            using (var db = new SqlConnection(connectionString))
            {
                db.Open();
                db.Query(sql, sp);
                db.Close();
            }

        }

        public User GetSingleWithUsernameAndPassword(string username, string password)
        {
            string sql = "Select * from [dbo].[User] where [Username]=@username and [Password]=@password";
            //string connectionString = ConfigurationManager.ConnectionStrings["devconnection"].ConnectionString;
            using (var db = new SqlConnection(connectionString))
            {
                db.Open();
                List<User> users = db.Query<User>(sql, new { username = username, password = password }).AsList();
                db.Close();
                return users.FirstOrDefault();
            }
        }
        public List<Role> RoleList()
        {

            string sql = "Select * from Role";
            using (var db = new SqlConnection(connectionString))
            {
                List<Role> RoleList = db.Query<Role>(sql).AsList();
                return RoleList;

            }

        }
    }





}
