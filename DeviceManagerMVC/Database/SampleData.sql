-- Script SQL ?? t?o d? li?u m?u cho h? th?ng Qu?n lý Thi?t b?
-- Th?c hi?n script này sau khi migration ?ã t?o các b?ng

-- Xóa d? li?u c? (n?u có)
DELETE FROM [Devices];
DELETE FROM [Users];

-- RESET IDENTITY
DBCC CHECKIDENT ('Users', RESEED, 0);
DBCC CHECKIDENT ('Devices', RESEED, 0);

-- Thêm d? li?u m?u cho b?ng Users
INSERT INTO [Users] (Name, Email, PhoneNumber, Department) VALUES
('Nguy?n V?n A', 'nguyenvana@company.com', '0123456789', 'Phòng IT'),
('Tr?n Th? B', 'tranthib@company.com', '0987654321', 'Phòng Nhân s?'),
('Lê V?n C', 'levanc@company.com', '0912345678', 'Phòng IT'),
('Ph?m Th? D', 'phamthid@company.com', '0934567890', 'Phòng K? toán'),
('Hoàng V?n E', 'hoangvane@company.com', '0945678901', 'Phòng Bán hàng'),
('V? Th? F', 'vuthif@company.com', '0956789012', 'Phòng IT'),
('??ng V?n G', 'dangvang@company.com', '0967890123', 'Phòng Qu?n lý d? án'),
('Tô Th? H', 'tothih@company.com', '0978901234', 'Phòng Hành chính');

-- Thêm d? li?u m?u cho b?ng Devices
INSERT INTO [Devices] (DeviceCode, DeviceName, Category, PurchaseDate, Status, UserId) VALUES
('DEV001', 'Laptop Dell XPS 13', 'Máy tính xách tay', '2024-01-15', 'Ho?t ??ng', 1),
('DEV002', 'Laptop HP Pavilion 15', 'Máy tính xách tay', '2024-02-10', 'Ho?t ??ng', 2),
('DEV003', 'Desktop PC Asus', 'Máy tính ?? bàn', '2023-08-20', 'Ho?t ??ng', 3),
('DEV004', 'Màn hình LG 24 inch', 'Màn hình', '2024-01-05', 'Ho?t ??ng', 1),
('DEV005', 'Bàn phím Logitech K380', 'Bàn phím', '2024-01-10', 'Ho?t ??ng', 1),
('DEV006', 'Chu?t Magic Mouse', 'Chu?t máy tính', '2024-01-15', 'Ho?t ??ng', 2),
('DEV007', 'Máy in HP LaserJet Pro', 'Máy in', '2023-11-30', 'B?o trì', NULL),
('DEV008', 'Scanner Fujitsu', 'Máy scan', '2023-09-15', 'Ho?t ??ng', 4),
('DEV009', 'Laptop MacBook Pro 16', 'Máy tính xách tay', '2024-03-20', 'Ho?t ??ng', 5),
('DEV010', 'Monitor Dell U2723DE', 'Màn hình', '2024-02-15', 'Ho?t ??ng', 6),
('DEV011', 'Bàn phím c? HHKB', 'Bàn phím', '2024-03-01', 'Ho?t ??ng', 5),
('DEV012', 'Chu?t Razer DeathAdder', 'Chu?t máy tính', '2024-02-28', 'Ho?t ??ng', 6),
('DEV013', 'Laptop Lenovo ThinkPad X1', 'Máy tính xách tay', '2023-12-10', 'H?ng', NULL),
('DEV014', 'Webcam Logitech C922', 'Webcam', '2024-01-20', 'Ho?t ??ng', 3),
('DEV015', 'Headphone Sony WH-1000XM5', 'Tai nghe', '2024-03-10', 'Ho?t ??ng', 7),
('DEV016', 'USB-C Hub Anker', 'Ph? ki?n', '2024-01-25', 'Ho?t ??ng', 1),
('DEV017', '? c?ng SSD Samsung 1TB', 'L?u tr?', '2024-02-05', 'Ho?t ??ng', 2),
('DEV018', 'Docking Station Lenovo', 'Ph? ki?n', '2024-01-30', 'Ho?t ??ng', 6),
('DEV019', 'Laptop ASUS VivoBook 15', 'Máy tính xách tay', '2023-10-15', 'B?o trì', NULL),
('DEV020', 'Màn hình BenQ PD2700U', 'Màn hình', '2024-03-05', 'Ho?t ??ng', 4);

-- Xem danh sách các ng??i dùng
SELECT 'Danh sách Ng??i dùng:' AS [Info];
SELECT Id, Name, Email, PhoneNumber, Department FROM [Users] ORDER BY Id;

-- Xem danh sách các thi?t b?
SELECT 'Danh sách Thi?t b?:' AS [Info];
SELECT 
    d.Id, 
    d.DeviceCode, 
    d.DeviceName, 
    d.Category, 
    d.PurchaseDate, 
    d.Status, 
    ISNULL(u.Name, 'Ch?a gán') AS [Ng??i s? d?ng]
FROM [Devices] d
LEFT JOIN [Users] u ON d.UserId = u.Id
ORDER BY d.Id;

-- Th?ng kê
SELECT 'Th?ng kê:' AS [Info];
SELECT 
    COUNT(DISTINCT d.Id) AS [T?ng thi?t b?],
    COUNT(DISTINCT CASE WHEN d.UserId IS NOT NULL THEN d.Id END) AS [Thi?t b? ?ã gán],
    COUNT(DISTINCT CASE WHEN d.UserId IS NULL THEN d.Id END) AS [Thi?t b? ch?a gán],
    COUNT(DISTINCT u.Id) AS [T?ng ng??i dùng]
FROM [Devices] d
FULL OUTER JOIN [Users] u ON d.UserId = u.Id;

-- Thi?t b? theo tình tr?ng
SELECT 'Thi?t b? theo Tình tr?ng:' AS [Info];
SELECT Status, COUNT(*) AS [S? l??ng]
FROM [Devices]
GROUP BY Status
ORDER BY [S? l??ng] DESC;

-- Thi?t b? gán cho ng??i dùng
SELECT 'Thi?t b? gán cho Ng??i dùng:' AS [Info];
SELECT 
    u.Name,
    COUNT(d.Id) AS [S? thi?t b?]
FROM [Users] u
LEFT JOIN [Devices] d ON u.Id = d.UserId
GROUP BY u.Name
ORDER BY [S? thi?t b?] DESC;
