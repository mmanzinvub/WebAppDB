-- INSERT

INSERT INTO table_cameras (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/minolta-srt-101.png', 'SLR', 'Minolta SRT 101', 180.00, 0);
INSERT INTO table_cameras (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/minolta-xe1.png', 'SLR', 'Minolta XE1', 180.00, 0);
INSERT INTO table_cameras (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/canon-ae-1.png', 'SLR', 'Canon AE1', 200.00, 0);
INSERT INTO table_cameras (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/canon-av-1.png', 'SLR', 'Canon AV1', 150.00, 0);
INSERT INTO table_cameras (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/yashica-tl-electro-x.png', 'SLR', 'Yashica TL Electro X', 130.00, 0);
INSERT INTO table_cameras (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/yashica-electro35-gsn.png', 'Rangefinder', 'Yashica Electro 35 GSN', 125.00, 0);
INSERT INTO table_cameras (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/olympus-xa2.png', 'Point & Shoot', 'Olympus XA2', 80.00, 0);
INSERT INTO table_cameras (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/pentax-67.png', 'Medium Format', 'Pentax 67', 750.00, 0);
INSERT INTO table_cameras (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/polaroid-supercolor1000.png', 'Instant Camera', 'Polaroid Supercolor 1000', 75.00, 0);
INSERT INTO table_cameras (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/fujifilm-finepix-jv100.png', 'Digital Camera', 'Fujifilm FinePix JV100', 69.00, 0);

INSERT INTO table_lenses (IMAGE_URL, CATEGORY, APERTURE, NAME, PRICE, STOCK)
VALUES ('img/minolta-md-rokkor-28mm-f28.png', 'Wide', '28mm f2.8', 'Minolta MD Rokkor', 90.00, 0);
INSERT INTO table_lenses (IMAGE_URL, CATEGORY, APERTURE, NAME, PRICE, STOCK)
VALUES ('img/minolta-md-rokkor-50mm-f14.png', 'Standard', '50mm f1.4', 'Minolta MD Rokkor', 100.00, 0);
INSERT INTO table_lenses (IMAGE_URL, CATEGORY, APERTURE, NAME, PRICE, STOCK)
VALUES ('img/canon-ef-28-105mm-f35-45.png', 'Wide / Standard / Telephoto', '28-105mm f3.5-4.5', 'Canon EF Ultrasonic', 120.00, 0);
INSERT INTO table_lenses (IMAGE_URL, CATEGORY, APERTURE, NAME, PRICE, STOCK)
VALUES ('img/canon-ef-50mm-f18.png', 'Standard', '50mm f1.8', 'Canon EF', 125.00, 0);
INSERT INTO table_lenses (IMAGE_URL, CATEGORY, APERTURE, NAME, PRICE, STOCK)
VALUES ('img/nikon-nikkor-43-86mm-f35.png', 'Standard / Telephoto', '43-86mm f3.5', 'Nikon NIKKOR', 150.00, 0);
INSERT INTO table_lenses (IMAGE_URL, CATEGORY, APERTURE, NAME, PRICE, STOCK)
VALUES ('img/revuenon-auto-mc-135mm-f28.png', 'Telephoto', '135mm f2.8', 'Revuenon Auto MC', 150.00, 0);

INSERT INTO table_equipment (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/vivitar283.png', 'Bjeskalica', 'Vivitar 283', 50.00, 0);
INSERT INTO table_equipment (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/vivitar285.png', 'Bjeskalica', 'Vivitar 285', 70.00, 0);
INSERT INTO table_equipment (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/cullmann-alpha-stativ.png', 'Stativ', 'Cullmann Alpha 1800', 40.00, 0);
INSERT INTO table_equipment (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/shutter-release-cable.png', 'Okidac', 'Okidac za fotoaparat 1m', 10.00, 0);
INSERT INTO table_equipment (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/lomography-scanner.png', 'Skener', 'Lomography skener za 35mm film', 40.00, 0);

INSERT INTO table_films (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/kodak-gold-200-36-exp.png', '35mm', 'Kodak Gold 200', 15.00, 0);
INSERT INTO table_films (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/agfa-apx-100-36-exp.png', '35mm', 'Agfa APX 100', 12.00, 0);
INSERT INTO table_films (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/candido400.png', '35mm', 'Candido 400', 17.00, 0);
INSERT INTO table_films (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/candido800.png', '35mm', 'Candido 800', 20.00, 0);
INSERT INTO table_films (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/wolfen-nc500.png', '35mm', 'Wolfen NC 500', 25.00, 0);
INSERT INTO table_films (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/polaroid-color600.png', 'Instant Film', 'Polaroid Color 600', 30.00, 0);

-- UPDATE
-- cameras
UPDATE table_cameras
SET STOCK = 25
WHERE CATEGORY = 'SLR';

UPDATE table_cameras
SET STOCK = 3
WHERE CATEGORY = 'Rangefinder';

UPDATE table_cameras
SET STOCK = 6
WHERE CATEGORY = 'Point & Shoot';

UPDATE table_cameras
SET STOCK = 2
WHERE CATEGORY = 'Medium Format';

UPDATE table_cameras
SET STOCK = 3
WHERE CATEGORY = 'Instant Camera';

UPDATE table_cameras
SET STOCK = 6
WHERE CATEGORY = 'Digital Camera';

UPDATE table_cameras
SET STOCK = 1
WHERE CATEGORY = 'Medium Format';

-- lenses
UPDATE table_lenses
SET PRICE = 112.00, STOCK = 12
WHERE NAME = 'Minolta MD Rokkor' AND APERTURE = '28mm f2.8';

UPDATE table_lenses
SET PRICE = 135.00, STOCK = 20
WHERE NAME = 'Minolta MD Rokkor' AND CATEGORY = 'Standard';

UPDATE table_lenses
SET PRICE = 155.00, STOCK = 8
WHERE NAME = 'Canon EF Ultrasonic';

UPDATE table_lenses
SET PRICE = 145.00, STOCK = 10
WHERE NAME = 'Canon EF' AND CATEGORY = 'Standard';

UPDATE table_lenses
SET PRICE = 180.00, STOCK = 5
WHERE APERTURE = '43-86mm f3.5';

UPDATE table_lenses
SET PRICE = 170.00, STOCK = 10
WHERE CATEGORY = 'Telephoto';

-- equipment
UPDATE TABLE_EQUIPMENT
SET STOCK = 20
WHERE CATEGORY = 'Bjeskalica';

UPDATE TABLE_EQUIPMENT
SET STOCK = 10
WHERE NAME = 'Cullmann Alpha 1800';

UPDATE TABLE_EQUIPMENT
SET STOCK = 35, PRICE = 65.00
WHERE PRICE = 40.00;

UPDATE TABLE_EQUIPMENT
SET STOCK = 150, PRICE = 15.00
WHERE CATEGORY = 'Okidac';

-- films
UPDATE TABLE_FILMS
SET STOCK = 777
WHERE CATEGORY = '35mm';

UPDATE TABLE_FILMS
SET STOCK = 27
WHERE CATEGORY = 'Instant Film';

UPDATE TABLE_FILMS
SET STOCK = 271
WHERE STOCK = 777;

UPDATE TABLE_FILMS
SET STOCK = 77, PRICE = 18.00
WHERE NAME LIKE '% APX 100';

UPDATE TABLE_FILMS
SET STOCK = 170
WHERE NAME LIKE 'Candido%';

UPDATE TABLE_FILMS
SET STOCK = 120
WHERE NAME = 'Wolfen NC 500' AND CATEGORY = '35mm';

-- DELETE
