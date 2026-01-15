-- SQL Script ?? t?i ?u hóa hi?u n?ng tìm ki?m
-- Ch?y script này trong SQL Server Management Studio

-- T?o indexes ?? t?i ?u tìm ki?m thi?t b?
CREATE NONCLUSTERED INDEX [IX_Devices_DeviceName] 
ON [Devices] ([DeviceName])
WHERE [DeviceName] IS NOT NULL;

CREATE NONCLUSTERED INDEX [IX_Devices_DeviceCode] 
ON [Devices] ([DeviceCode])
WHERE [DeviceCode] IS NOT NULL;

CREATE NONCLUSTERED INDEX [IX_Devices_Status] 
ON [Devices] ([Status])
WHERE [Status] IS NOT NULL;

-- T?o indexes cho User
CREATE NONCLUSTERED INDEX [IX_Users_Name] 
ON [Users] ([Name])
WHERE [Name] IS NOT NULL;

CREATE NONCLUSTERED INDEX [IX_Users_Email] 
ON [Users] ([Email])
WHERE [Email] IS NOT NULL;

-- T?o index k?t h?p ?? t?i ?u tìm ki?m
CREATE NONCLUSTERED INDEX [IX_Devices_StatusAndUser] 
ON [Devices] ([Status], [UserId])
WHERE [Status] IS NOT NULL;

-- Xem thông tin các indexes
SELECT 
    OBJECT_NAME(i.object_id) AS [Table],
    i.name AS [Index Name],
    i.type_desc AS [Index Type],
    COUNT(*) AS [Columns]
FROM sys.indexes i
INNER JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
WHERE OBJECT_NAME(i.object_id) IN ('Devices', 'Users')
GROUP BY i.object_id, i.name, i.type_desc
ORDER BY [Table], [Index Name];

-- Ki?m tra fragment c?a indexes
SELECT 
    OBJECT_NAME(ps.object_id) AS [Table],
    i.name AS [Index],
    ps.avg_fragmentation_in_percent AS [Fragmentation %]
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') ps
INNER JOIN sys.indexes i ON ps.object_id = i.object_id AND ps.index_id = i.index_id
WHERE OBJECT_NAME(ps.object_id) IN ('Devices', 'Users')
    AND ps.index_id > 0
    AND ps.avg_fragmentation_in_percent > 0
ORDER BY ps.avg_fragmentation_in_percent DESC;
