
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace ViewModel
{
    public class TeamsViewModel
    {

        public int Id { get; set; }
        public int TeamID { get; set; }
        public string TeamName { get; set; }
        public Nullable<int> TeamLeder
        {
            get; set;


        }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string LeaderName { get; set; }
        public int MemberCount { get; set; }
        public List<int> TeamMember1 { get; set; } = new List<int>();
        public List<MemberType> TeamMember { get; set; } = new List<MemberType>();
        public List<CommonDropdownType> TeamLeders { get; set; } = new List<CommonDropdownType>();

        /*public string[] TeamLeders = { "Admin", "Production", "Purchase", "Sale" }*/
    }
}
