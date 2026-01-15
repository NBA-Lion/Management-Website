using System.Diagnostics;
using DeviceManagerMVC.Data;
using DeviceManagerMVC.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace DeviceManagerMVC.Controllers
{
    public class HomeController : Controller
    {
        private readonly ApplicationDbContext _context;

        public HomeController(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            var totalDevices = await _context.Devices.CountAsync();
            var totalUsers = await _context.Users.CountAsync();
            var assignedDevices = await _context.Devices.Where(d => d.UserId.HasValue).CountAsync();
            var unassignedDevices = totalDevices - assignedDevices;

            ViewBag.TotalDevices = totalDevices;
            ViewBag.TotalUsers = totalUsers;
            ViewBag.AssignedDevices = assignedDevices;
            ViewBag.UnassignedDevices = unassignedDevices;

            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
