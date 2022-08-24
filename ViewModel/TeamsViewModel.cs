﻿
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


        public int TeamID { get; set; }
        public string TeamName { get; set; }
        public Nullable<int> TeamLeder
        {
            get; set;


        }
        public List<int> TeamMember1 { get; set; } = new List<int>();
        public List<MemberType> TeamMember { get; set; } = new List<MemberType>();
        public List<CommonDropdownType> TeamLeders { get; set; } = new List<CommonDropdownType>();

        /*public string[] TeamLeders = { "Admin", "Production", "Purchase", "Sale" }*/
    }
}