using DataAcess.entits;
using DataAcess.GenericEntity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAcess.Authentication
{
    public class DAL_Authentication : GenericEntity<User>
    {
        public void SaveUserData(User adddata)
        {
            using (var db = new taskDatabaseEntities())
            {

                db.Users.Add(adddata);
                db.SaveChanges();

            }

        }

    }

   



}
