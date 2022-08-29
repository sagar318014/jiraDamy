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


        [Required(ErrorMessage = "please enter controller name")]
        public string ControllerName { get; set; }

        [Required(ErrorMessage = "please enter action name")]
        public string ActionName { get; set; }

        
        public Boolean ShowInSideBar { get; set; }

        [Required(ErrorMessage = "please enter display name")]
        public string DisplayName { get; set; }

        [Required(ErrorMessage = "please select role")]
        public List<int> AccessRolls { get; set; } = new List<int>();

    }



}
