using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DeviceManagerMVC.Data;
using DeviceManagerMVC.Models;

namespace DeviceManagerMVC.Controllers
{
    public class DeviceController : Controller
    {
        private readonly ApplicationDbContext _context;

        public DeviceController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: Device
        public async Task<IActionResult> Index(string searchName = "", string searchCode = "", string searchStatus = "")
        {
            var devices = _context.Devices.Include(d => d.User).AsQueryable();

            // Search filters
            if (!string.IsNullOrEmpty(searchName))
            {
                devices = devices.Where(d => d.DeviceName.Contains(searchName));
            }

            if (!string.IsNullOrEmpty(searchCode))
            {
                devices = devices.Where(d => d.DeviceCode.Contains(searchCode));
            }

            if (!string.IsNullOrEmpty(searchStatus))
            {
                devices = devices.Where(d => d.Status.Contains(searchStatus));
            }

            var deviceList = await devices.ToListAsync();
            
            // Store search parameters in ViewBag for form persistence
            ViewBag.SearchName = searchName;
            ViewBag.SearchCode = searchCode;
            ViewBag.SearchStatus = searchStatus;

            return View(deviceList);
        }

        // GET: Device/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var device = await _context.Devices
                .Include(d => d.User)
                .FirstOrDefaultAsync(m => m.Id == id);

            if (device == null)
            {
                return NotFound();
            }

            return View(device);
        }

        // GET: Device/Create
        public async Task<IActionResult> Create()
        {
            var users = await _context.Users.ToListAsync();
            ViewBag.Users = users;
            return View();
        }

        // POST: Device/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,DeviceCode,DeviceName,Category,PurchaseDate,Status,UserId")] Device device)
        {
            if (ModelState.IsValid)
            {
                _context.Add(device);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }

            var users = await _context.Users.ToListAsync();
            ViewBag.Users = users;
            return View(device);
        }

        // GET: Device/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var device = await _context.Devices.FindAsync(id);
            if (device == null)
            {
                return NotFound();
            }

            var users = await _context.Users.ToListAsync();
            ViewBag.Users = users;
            return View(device);
        }

        // POST: Device/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Id,DeviceCode,DeviceName,Category,PurchaseDate,Status,UserId")] Device device)
        {
            if (id != device.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(device);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!DeviceExists(device.Id))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }

            var users = await _context.Users.ToListAsync();
            ViewBag.Users = users;
            return View(device);
        }

        // GET: Device/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var device = await _context.Devices
                .Include(d => d.User)
                .FirstOrDefaultAsync(m => m.Id == id);

            if (device == null)
            {
                return NotFound();
            }

            return View(device);
        }

        // POST: Device/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var device = await _context.Devices.FindAsync(id);
            if (device != null)
            {
                _context.Devices.Remove(device);
                await _context.SaveChangesAsync();
            }

            return RedirectToAction(nameof(Index));
        }

        private bool DeviceExists(int id)
        {
            return _context.Devices.Any(e => e.Id == id);
        }
    }
}
