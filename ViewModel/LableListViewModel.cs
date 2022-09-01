using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;


namespace ViewModel
{
    public class LableListViewModel
    {
        public int LableId { get; set; }

        [Required(ErrorMessage = "please enter Lable name")]
        public string LableName { get; set; }
    }
}
