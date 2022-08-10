using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace ViewModel
{
    public class TaskTableViewModel
    {
        public int taskId { get; set; }

        [Required(ErrorMessage = "please enter task name")]
        public string taskName { get; set; }
        public Nullable<int> taskStatus { get; set; }

        [Required(ErrorMessage = "pleas enter description")]
        public string description { get; set; }
    }
}
