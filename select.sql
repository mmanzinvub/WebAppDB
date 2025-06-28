SELECT * FROM table_cameras;
SELECT * FROM table_lenses;
SELECT * FROM table_equipment;
SELECT * FROM table_films;
SELECT * FROM table_customers;
SELECT * FROM table_orders;
SELECT * FROM table_order_items;

UPDATE table_lenses SET PRICE = 112.00 AND STOCK = 12 WHERE NAME = 'Minolta MD Rokkor' AND APERTURE = '28 mm f2.8';
UPDATE table_lenses SET PRICE = 135.00 AND STOCK = 20 WHERE NAME = 'Minolta MD Rokkor' AND CATEGORY = 'Standard';
UPDATE table_lenses SET PRICE = 155.00 AND STOCK = 8 WHERE NAME = 'Canon EF Ultrasonic';
UPDATE table_lenses SET PRICE = 145.00 AND STOCK = 10 WHERE NAME = 'Canon EF' AND CATEGORY = 'Standard';
UPDATE table_lenses SET PRICE = 180.00 AND STOCK = 5 WHERE APERTURE = '43-86mm f3.5';
UPDATE table_lenses SET PRICE = 170.00 AND STOCK = 10 WHERE CATEGORY = 'Telephoto';

UPDATE table_equipment SET STOCK = 100;

UPDATE table_films SET STOCK = 777;