using jiraDamy.entits;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using Xunit;
using Xunit.Sdk;

namespace jiraDamy.viewModel
{
    public class TaskTableViewModel
    {
        public int taskId { get; set; }

        [Required(ErrorMessage = "please enter task name")]
        public string taskName { get; set; }
        public Nullable<int> taskStatus { get; set; }

        [Required(ErrorMessage = "pleas enter description")]
        public string description { get; set; }
        public virtual statusTable statusTable { get; set; }
    }
}