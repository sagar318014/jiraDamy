using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ViewModel
{
    public class CommonDropdownType
    {
        public int id { get; set; }
        public string text { get; set; }
    }
    public class Actions
    {
        public Boolean taskCreation { get; set; }
        public Boolean userCreation { get; set; }
        public Boolean teamCreation { get; set; }
    }
}
