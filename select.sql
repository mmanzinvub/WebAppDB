-- prikaz svih dostupnih kamera
SELECT camera_id, name, price, stock
FROM table_cameras
WHERE stock > 0;

-- prikaz objektiva koji su ispod ili 135 eura, silazno
SELECT lens_id, name, aperture, price, stock
FROM table_lenses
WHERE price <= 135
ORDER BY PRICE DESC;

-- prikaz svih dostupnih bjeskalica
SELECT TABLE_EQUIPMENT_ID, name, price, stock
FROM TABLE_EQUIPMENT
WHERE CATEGORY = 'Bjeskalica' AND stock > 0;

-- prikaz svih filmova koji su ISO 400
SELECT film_id, name, price, stock
FROM TABLE_FILMS
WHERE NAME LIKE '% 400';

