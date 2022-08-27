using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ViewModel
{
    public class UserActions
    {
        public int ActionId { get; set; }

        public string ControllerName { get; set; }

        public string ActionName { get; set; }

        public Boolean ShowInSideBar { get; set; }
        public string DisplayName { get; set; }

        public List<int> AccessRolls { get; set; } = new List<int>();

    }



}
