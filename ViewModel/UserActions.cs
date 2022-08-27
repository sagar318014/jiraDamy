using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ViewModel
{
    public class UserActions
    {
        [Required]
        public int ActionId { get; set; }


        [Required]
        public string ControllerName { get; set; }

        [Required]
        public string ActionName { get; set; }

        [Required]
        public Boolean ShowInSideBar { get; set; }
       
        [Required]
        public string DisplayName { get; set; }

        public List<int> AccessRolls { get; set; } = new List<int>();

    }



}
