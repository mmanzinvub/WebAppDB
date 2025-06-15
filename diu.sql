-- INSERT

INSERT INTO CAMERAS (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/minolta-srt-101.png', 'SLR', 'Minolta SRT 101', 180.00, 0);
INSERT INTO CAMERAS (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/minolta-xe1.png', 'SLR', 'Minolta XE1', 180.00, 0);
INSERT INTO CAMERAS (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/canon-ae-1.png', 'SLR', 'Canon AE1', 200.00, 0);
INSERT INTO CAMERAS (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/canon-av-1.png', 'SLR', 'Canon AV1', 150.00, 0);
INSERT INTO CAMERAS (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/yashica-tl-electro-x.png', 'SLR', 'Yashica TL Electro X', 130.00, 0);
INSERT INTO CAMERAS (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/yashica-electro35-gsn.png', 'Rangefinder', 'Yashica Electro 35 GSN', 125.00, 0);
INSERT INTO CAMERAS (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/olympus-xa2.png', 'Point & Shoot', 'Olympus XA2', 80.00, 0);
INSERT INTO CAMERAS (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/pentax-67.png', 'Medium Format', 'Pentax 67', 750.00, 0);
INSERT INTO CAMERAS (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/polaroid-supercolor1000.png', 'Instant Camera', 'Polaroid Supercolor 1000', 75.00, 0);
INSERT INTO CAMERAS (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/fujifilm-finepix-jv100.png', 'Digital Camera', 'Fujifilm FinePix JV100', 69.00, 0);

INSERT INTO LENSES (IMAGE_URL, CATEGORY, APERTURE, NAME, PRICE, STOCK)
VALUES ('img/minolta-md-rokkor-28mm-f28.png', 'Wide', '28mm f2.8', 'Minolta MD Rokkor', 90.00, 0);
INSERT INTO LENSES (IMAGE_URL, CATEGORY, APERTURE, NAME, PRICE, STOCK)
VALUES ('img/minolta-md-rokkor-50mm-f14.png', 'Standard', '50mm f1.4', 'Minolta MD Rokkor', 100.00, 0);
INSERT INTO LENSES (IMAGE_URL, CATEGORY, APERTURE, NAME, PRICE, STOCK)
VALUES ('img/canon-ef-28-105mm-f35-45.png', 'Wide / Standard / Telephoto', '28-105mm f3.5-4.5', 'Canon EF Ultrasonic', 120.00, 0);
INSERT INTO LENSES (IMAGE_URL, CATEGORY, APERTURE, NAME, PRICE, STOCK)
VALUES ('img/canon-ef-50mm-f18.png', 'Standard', '50mm f1.8', 'Canon EF', 125.00, 0);
INSERT INTO LENSES (IMAGE_URL, CATEGORY, APERTURE, NAME, PRICE, STOCK)
VALUES ('img/nikon-nikkor-43-86mm-f35.png', 'Standard / Telephoto', '43-86mm f3.5', 'Nikon NIKKOR', 150.00, 0);
INSERT INTO LENSES (IMAGE_URL, CATEGORY, APERTURE, NAME, PRICE, STOCK)
VALUES ('img/revuenon-auto-mc-135mm-f28.png', 'Telephoto', '135mm f2.8', 'Revuenon Auto MC', 150.00, 0);

INSERT INTO EQUIPMENT (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/vivitar283.png', 'Bjeskalica', 'Vivitar 283', 50.00, 0);
INSERT INTO EQUIPMENT (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/vivitar285.png', 'Bjeskalica', 'Vivitar 285', 70.00, 0);
INSERT INTO EQUIPMENT (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/cullmann-alpha-stativ.png', 'Stativ', 'Cullmann Alpha 1800', 40.00, 0);
INSERT INTO EQUIPMENT (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/shutter-release-cable.png', 'Okidac', 'Okidac za fotoaparat 1m', 10.00, 0);
INSERT INTO EQUIPMENT (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/lomography-scanner.png', 'Skener', 'Lomography skener za 35mm film', 40.00, 0);

INSERT INTO FILMS (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/kodak-gold-200-36-exp.png', '35mm', 'Kodak Gold 200', 15.00, 0);
INSERT INTO FILMS (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/agfa-apx-100-36-exp.png', '35mm', 'Agfa APX 100', 12.00, 0);
INSERT INTO FILMS (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/candido400.png', '35mm', 'Candido 400', 17.00, 0);
INSERT INTO FILMS (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/candido800.png', '35mm', 'Candido 800', 20.00, 0);
INSERT INTO FILMS (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/wolfen-nc500.png', '35mm', 'Wolfen NC 500', 25.00, 0);
INSERT INTO FILMS (IMAGE_URL, CATEGORY, NAME, PRICE, STOCK)
VALUES ('img/polaroid-color600.png', 'Instant Film', 'Polaroid Color 600', 30.00, 0);

-- UPDATE

UPDATE CAMERAS SET STOCK = 25;

UPDATE LENSES SET STOCK = 50;

UPDATE EQUIPMENT SET STOCK = 100;

UPDATE FILMS SET STOCK = 777;

-- DELETE

