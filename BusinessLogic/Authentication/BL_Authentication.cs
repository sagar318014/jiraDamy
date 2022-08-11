using DataAcess.Authentication;
using DataAcess.entits;
using ViewModel;

namespace BusinessLogic.Authentication
{
    public class BL_Authentication
    {
        public UserLoginViewModel GetAutheticatedUser(UserLoginViewModel userLoginViewModel)
        {
            User user = new DAL_Authentication()
                .GetSingle(x => x.Username == userLoginViewModel.Username && x.Password == userLoginViewModel.Password);
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
            };
            return authenticated;
        }
    }
}
