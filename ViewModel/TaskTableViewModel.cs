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
        public int? taskStatus { get; set; }

        [Required(ErrorMessage = "pleas enter description")]
        public string description { get; set; }

        public int? assigneeId { get; set; }
        public string userName { get; set; }

        public string statusName { get; set; }


        public List<CommonDropdownType> taskStatusList { get; set; } = new List<CommonDropdownType>();
        public List<CommonDropdownType> userList { get; set; } = new List<CommonDropdownType>();

        public List<CommonDropdownType> labelList { get; set; } = new List<CommonDropdownType>();

        public List<CommonDropdownType> sprintList { get; set; } = new List<CommonDropdownType>();

    }
}
