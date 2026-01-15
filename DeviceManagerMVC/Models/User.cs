using System.ComponentModel.DataAnnotations;

namespace DeviceManagerMVC.Models
{
    public class User
    {
        public int Id { get; set; }
        [Required]
        public string Name { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string PhoneNumber { get; set; } = string.Empty;
        public string Department { get; set; } = string.Empty;

        public virtual ICollection<Device>? Devices { get; set; }
    }
}