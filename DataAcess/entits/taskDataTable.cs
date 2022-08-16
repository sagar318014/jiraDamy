using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAcess.entits
{
    public class taskDataTable
    {
        public int taskId { get; set; }
        public string taskName { get; set; }
        public Nullable<int> taskStatus { get; set; }
        public string description { get; set; }

        public virtual statusTable statusTable { get; set; }
    }
}
