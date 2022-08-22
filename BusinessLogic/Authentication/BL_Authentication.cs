using DataAcess.Authentication;
using System.Collections.Generic;
using DataAcess.entits;
using ViewModel;

namespace BusinessLogic.Authentication
{
    public class BL_Authentication
    {

        public void SaveUserData(User adddata)
        {
            new DAL_Authentication().SaveUserData(adddata);
        }
        public UserLoginViewModel GetAutheticatedUser(UserLoginViewModel userLoginViewModel)
        {
            User user = new DAL_Authentication()
                .GetSingleWithUsernameAndPassword(userLoginViewModel.Username ,userLoginViewModel.Password);
            //UserLoginViewModel authenticated =  AutoMapper.Mapper.Map<User,UserLoginViewModel>(user);
            if (user == null)
            {
                return null;
            }
            UserLoginViewModel authenticated = new UserLoginViewModel()
            {
                Id = user.Id,
                Username = user.Username,
                Password = user.Password,
                RoleId = user.RoleId
            };
            return authenticated;
        }
        public List<Role> GetRoleList()
        {
            return new DAL_Authentication().RoleList();
        }
        public List<int> GetActionList(int RoleId)
        {
            return new DAL_Authentication().GetActionList(RoleId);
        }
    }
}
