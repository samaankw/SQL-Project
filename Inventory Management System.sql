CREATE DATABASE inventory_management;
use inventory_management;
CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(255) NOT NULL,
    contact_info VARCHAR(255)
);
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    price DECIMAL(10, 2),
    quantity_in_stock INT,
    supplier_id INT,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

CREATE TABLE inventory_transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    transaction_type ENUM('purchase', 'sale'),
    quantity INT,
    transaction_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO suppliers (supplier_name, contact_info)
VALUES ('Supplier A', 'contact@supplier.com'),
	   ('Supplier B', 'contact@supplierB.com');
       
INSERT INTO products (name, category, price, quantity_in_stock,supplier_id)
VALUES ('Product 1', 'Category A', 10.00,100,1),
       ( 'Product 2', 'Category B', 15.50,200,2);
       
 INSERT INTO inventory_transactions (product_id, transaction_type, quantity, transaction_date)
 VALUES(1, 'purchase', 50, '2024-09-01'),
       (2, 'sale', 20, '2024-09-05');
       
  -- Write SQL queries and stored procedures for key functions
  Select name, quantity_in_stock
  from products;
  
  -- add a new product
  
  INSERT INTO products (name, category, price, quantity_in_stock, supplier_id)
  VALUES   ('New Product', 'Category C', 20.00, 150, 1);
  
  -- update inventory after a Sale or Purchase
  
  UPDATE products
  SET quantity_in_stock = quantity_in_stock + 50
  where product_id = 1;
  
  UPDATE products
  SET quantity_in_stock = quantity_in_stock - 20
  Where product_id = 2;
  
  -- Create Reports
  -- Low Stock Report
  
  Select name, quatity_in_stock
  from products
  where quantity_in_stock < 50;
  
  -- Inventory Value Report
  Select sum(price * quantity_in_stock) as total_inventory_value
  from products;

