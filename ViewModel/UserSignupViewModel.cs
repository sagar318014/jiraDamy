using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace ViewModel
{
    public class UserSignupViewModel
    {
        public int Id { get; set; }
        [Required]
        [StringLength(20,ErrorMessage = "User name lenght is not more than 20 character")]
        public string Username { get; set; }

        [Required]
        [StringLength(10, ErrorMessage = "Password lenght is more than 6 and lass than 10  character",MinimumLength =6)]
        public string Password { get; set; }
        public int RoleId { get; set; }

        [Required]
        [StringLength(20, ErrorMessage = "First name lenght is not more than 20 character")]
        [RegularExpression(@"^[a-zA-Z]+$", ErrorMessage = "Enter only character")]
        public string FirstName { get; set; }
        [Required]
        [StringLength(20, ErrorMessage = "Last name lenght is not more than 20 character")]
        [RegularExpression(@"^[a-zA-Z]+$",ErrorMessage ="Enter only character")]
        public string LastName { get; set; }
        public string Name { get; set; }

        public List<CommonDropdownType> RoleIdList { get; set; } = new List<CommonDropdownType>();
    }

    
}
