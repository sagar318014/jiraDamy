using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataAcess;
using DataAcess.entits;
using ViewModel;

namespace BusinessLogic
{
    public class BL_Action
    {

        public void SetAction(UserActions modal)
        {
            Actions Actions = new Actions();
            Actions.ActionName = modal.ActionName;
            Actions.ControllerName = modal.ControllerName;
            Actions.DisplayName = modal.DisplayName;
            Actions.ShowInSideBar = modal.ShowInSideBar;
           
            DataTable RollsList = new DataTable();
            RollsList.Columns.Add("userid", typeof(int));

            foreach (var item in modal.AccessRolls)
            {
                RollsList.Rows.Add(item);
            }
            Actions.ActionAccess = RollsList;


            new DAL_Action().SetAction(Actions);
           
        }
        public List<UserActions> GetActionList()
        {

            List<UserActions> ActionList2 = new List<UserActions>();
            List<Actions> ActionList = new DAL_Action().GetActionList();

            foreach (var item in ActionList)
            {
                UserActions Action = new UserActions();

                Action.ActionName = item.ActionName;
                Action.ControllerName = item.ControllerName;
                Action.DisplayName = item.DisplayName;

                ActionList2.Add(Action);
            }


            return ActionList2;

        }
    }
}
