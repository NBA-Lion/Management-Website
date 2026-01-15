using Microsoft.EntityFrameworkCore;
using DeviceManagerMVC.Models;

namespace DeviceManagerMVC.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }
        public DbSet<User> Users { get; set; }
        public DbSet<Device> Devices { get; set; }
    }
}