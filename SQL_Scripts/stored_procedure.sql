-- ---------------------------
-- Stored Procedure
-- ---------------------------
/*
20. Final Task
Stored Procedure: Place a new sale and update inventory
create a function as soon as the product is sold the the same quantity should reduced from inventory table
after adding any sales records it should update the stock in the inventory table based on the product and qty purchased
This procedure:
- Checks if product has enough stock in inventory
- If yes, adds entries to `orders` and `order_items`
- Then deducts sold quantity from inventory
- Else, prints an "out of stock" message
*/

-- Step 1: Drop procedure if it already exists (for re-runs)
IF OBJECT_ID('add_sales', 'P') IS NOT NULL
    DROP PROCEDURE add_sales;
GO
-- Step 2: Create the procedure
CREATE PROCEDURE add_sales
    @p_order_id INT,
    @p_customer_id INT,
    @p_seller_id INT,
    @p_order_item_id INT,
    @p_product_id INT,
    @p_quantity INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @v_count INT;
    DECLARE @v_price FLOAT;
    DECLARE @v_product VARCHAR(50);
    -- Fetch product price and name
    SELECT 
        @v_price = price,
        @v_product = product_name
    FROM products
    WHERE product_id = @p_product_id;
    -- Check if enough stock exists
    SELECT 
        @v_count = COUNT(*) 
    FROM inventory
    WHERE 
        product_id = @p_product_id
        AND stock >= @p_quantity;
    -- If stock is sufficient
    IF @v_count > 0
    BEGIN
        -- Insert into orders
        INSERT INTO orders(order_id, order_date, customer_id, seller_id)
        VALUES(@p_order_id, GETDATE(), @p_customer_id, @p_seller_id);
        -- Insert into order_items
        INSERT INTO order_items(order_item_id, order_id, product_id, quantity, price_per_unit, total_sales)
        VALUES(@p_order_item_id, @p_order_id, @p_product_id, @p_quantity, @v_price, @v_price * @p_quantity);
        -- Update inventory stock
        UPDATE inventory
        SET stock = stock - @p_quantity
        WHERE product_id = @p_product_id;
        PRINT 'Thank you! Product "' + @v_product + '" has been sold and inventory updated.';
    END
    ELSE
    BEGIN
        PRINT 'Sorry! Product "' + @v_product + '" does not have enough stock.';
    END
END;
GO
-- Step 3: Test Execution Example
EXEC add_sales 
    @p_order_id = 25010, 
    @p_customer_id = 3, 
    @p_seller_id = 6, 
    @p_order_item_id = 25007, 
    @p_product_id = 1, 
    @p_quantity = 5;