using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace ViewModel
{
    public class FlagViewModel
    {
        public int FlagId { get; set; }

        [Required(ErrorMessage = "please enter Flag name")]
        public string FlagName { get; set; }
    }
}
