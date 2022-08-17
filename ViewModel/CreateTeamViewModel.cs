using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace ViewModel
{
    public class CreateTeamViewModel
    {
       

        
        public string TeamName { get; set; }
        
        public string TeamLeader { get; set; }

        public string TeamMember { get; set; }
    }
}
