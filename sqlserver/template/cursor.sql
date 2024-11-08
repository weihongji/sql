DECLARE @vendor_id INT, @vendor_name NVARCHAR(50);

DECLARE vendor_cursor CURSOR FOR
SELECT VendorID, Name FROM Vendor ORDER BY VendorID;

OPEN vendor_cursor

FETCH NEXT FROM vendor_cursor INTO @vendor_id, @vendor_name

WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT 'Vendor: ' + @vendor_name

	-- Declare an inner cursor based on vendor_id from the outer cursor.
	DECLARE product_cursor CURSOR FOR
	SELECT v.Name
	FROM ProductVendor pv inner join Product v on pv.ProductID = v.ProductID
	WHERE pv.VendorID = @vendor_id

	OPEN product_cursor
	FETCH NEXT FROM product_cursor INTO @product

	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT '    ' + @product
		FETCH NEXT FROM product_cursor INTO @product
	END

	CLOSE product_cursor
	DEALLOCATE product_cursor

	-- Get the next vendor.
	FETCH NEXT FROM vendor_cursor INTO @vendor_id, @vendor_name
END
CLOSE vendor_cursor;
DEALLOCATE vendor_cursor;