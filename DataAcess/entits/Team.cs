//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DataAcess.entits
{
    
    using System;
    using System.Collections.Generic;
    using System.Data;
    using ViewModel;

    public class Team
    {
        public int TeamID { get; set; }
        public string TeamName { get; set; }
        public Nullable<int> TeamLeder { get; set; }
        public string LeaderName { get; set; }
        public int MemberCount { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public DataTable TeamMember { get; set; }
    }
}
