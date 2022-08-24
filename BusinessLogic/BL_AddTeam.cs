﻿using ViewModel;
using DataAcess;
using DataAcess.entits;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace BusinessLogic
{
    public class BL_AddTeam
    {
        public void SaveTeam(TeamsViewModel model)
        {
            Team AddTeam = new Team();
            AddTeam.TeamName = model.TeamName;
            AddTeam.TeamLeder = model.TeamLeder;

            DataTable Members = new DataTable();
            Members.Columns.Add("userid", typeof(int));

            foreach (var item in model.TeamMember1)
            {
                Members.Rows.Add(item);
            }
            AddTeam.TeamMember = Members;
            new DAL_AddTeam().SaveTeam(AddTeam);

        }

        public List<CommonDropdownType> GetUserList()
        {

            List<CommonDropdownType> UserList = new List<CommonDropdownType>();
            foreach (var item in new DAL_AddTeam().UserList())
            {
                CommonDropdownType User = new CommonDropdownType();

                User.id = item.Id;
                User.text = item.FirstName;

                UserList.Add(User);
            }
            return UserList;



        }

    }
}