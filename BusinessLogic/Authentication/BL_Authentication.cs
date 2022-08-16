using DataAcess.Authentication;
using DataAcess.entits;
using ViewModel;
using System.Collections.Generic;

namespace BusinessLogic.Authentication
{
    public class BL_Authentication
    {
        public UserLoginViewModel GetAutheticatedUser(UserLoginViewModel userLoginViewModel)
        {
            User user = new DAL_Authentication()
                .GetSingleWithUsernameAndPassword(userLoginViewModel.Username, userLoginViewModel.Password);
            if (user == null)
            {
                return null;
            }
            UserLoginViewModel authenticated = new UserLoginViewModel()
            {
                Id = user.Id,
                Username = user.Username,
                Password = user.Password,
            };
            return authenticated;
        }

        public void SaveUserData(UserSignupViewModel model)
        {
            User adddata = new User();
            adddata.Username = model.Username;
            adddata.Password = model.Password;
            adddata.FirstName = model.FirstName;
            adddata.LastName = model.LastName;
            adddata.RoleId = model.RoleId;

            new DAL_Authentication().SaveUserData(adddata);



        }
        public List<CommonDropdownType> GetRoleList()
        {

            List<CommonDropdownType> roleList = new List<CommonDropdownType>();
            foreach (var item in new DAL_Authentication().RoleList())
            {
                CommonDropdownType role = new CommonDropdownType();

                role.id = item.Id;
                role.text = item.Name;

                roleList.Add(role);
            }
            return roleList;


        }
    }
}
