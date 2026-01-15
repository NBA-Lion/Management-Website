using System.ComponentModel.DataAnnotations;

namespace DeviceManagerMVC.Models
{
    public class Device
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Mã thiết bị là bắt buộc")]
        [Display(Name = "Mã thiết bị")]
        public string DeviceCode { get; set; } = string.Empty;

        [Required(ErrorMessage = "Tên thiết bị là bắt buộc")]
        [Display(Name = "Tên thiết bị")]
        public string DeviceName { get; set; } = string.Empty;

        [Display(Name = "Loại thiết bị")]
        public string Category { get; set; } = string.Empty;

        [DataType(DataType.Date)]
        [Display(Name = "Ngày mua")]
        public DateTime PurchaseDate { get; set; }

        [Display(Name = "Tình trạng")]
        public string Status { get; set; } = string.Empty;

        // Khóa ngoại liên kết tới User
        [Display(Name = "Người sử dụng")]
        public int? UserId { get; set; }
        public virtual User? User { get; set; }
    }
}