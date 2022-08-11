using DataAcess.entits;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace DataAcess.GenericEntity
{
    public class GenericEntity<T> where T : class
    {
        public T GetSingle(Expression<Func<T, bool>> predicate)
        {
            using (var db = new taskDatabaseEntities())
            {
                var entity = db.Set<T>().Where(predicate).FirstOrDefault();
                if (entity == null)
                {
                    return null;
                }
                else
                {
                    return entity;
                }
            }
        }
    }
}
