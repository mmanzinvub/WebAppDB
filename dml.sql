-- dohvat.pks
CREATE OR REPLACE PACKAGE DOHVAT AS
    PROCEDURE get_customers_by_city(l_obj IN OUT JSON_OBJECT_T);
    PROCEDURE get_orders_by_status(l_obj IN OUT JSON_OBJECT_T);
    PROCEDURE get_products_by_price_range(l_obj IN OUT JSON_OBJECT_T);
END DOHVAT;
/

-- dohvat.pkb
CREATE OR REPLACE PACKAGE BODY DOHVAT AS
    -- get_customers_by_city
    PROCEDURE get_customers_by_city(l_obj IN OUT JSON_OBJECT_T) AS
        l_string VARCHAR2(4000);
        l_city   VARCHAR2(100);
        l_out    json_array_t := json_array_t('[]');
    BEGIN
        l_string := l_obj.TO_STRING;
        l_city := JSON_VALUE(l_string, '$.city' RETURNING VARCHAR2);

        FOR x IN (
            SELECT CUSTOMER_ID, FIRST_NAME, LAST_NAME, CITY
            FROM TABLE_CUSTOMERS
            WHERE CITY = l_city
        ) LOOP
            l_out.append(json_object_t(JSON_OBJECT(
                'customer_id' VALUE x.CUSTOMER_ID,
                'first_name' VALUE x.FIRST_NAME,
                'last_name' VALUE x.LAST_NAME,
                'city' VALUE x.CITY
            )));
        END LOOP;
        l_obj.put('data', l_out);
    EXCEPTION
        WHEN OTHERS THEN
            common.p_errlog('get_customers_by_city', dbms_utility.format_error_backtrace, sqlcode, sqlerrm, l_string);
            l_obj.put('h_message', 'Greška u dohvaćanju kupaca');
            l_obj.put('h_errcod', 91);
            RAISE;
    END;

    -- get_orders_by_status
    PROCEDURE get_orders_by_status(l_obj IN OUT JSON_OBJECT_T) AS
        l_string VARCHAR2(4000);
        l_status VARCHAR2(20);
        l_out    json_array_t := json_array_t();
    BEGIN
        l_string := l_obj.TO_STRING;
        l_status := JSON_VALUE(l_string, '$.status' RETURNING VARCHAR2);

        FOR x IN (
            SELECT ORDER_ID, CUSTOMER_ID, STATUS, ORDER_DATE
            FROM table_orders
            WHERE status = l_status
        ) LOOP
            l_out.append(json_object_t(JSON_OBJECT(
                'order_id' VALUE x.ORDER_ID,
                'customer_id' VALUE x.CUSTOMER_ID,
                'status' VALUE x.STATUS,
                'order_date' VALUE TO_CHAR(x.ORDER_DATE, 'YYYY-MM-DD')
            )));
        END LOOP;
        l_obj.put('data', l_out);
    EXCEPTION
        WHEN OTHERS THEN
            common.p_errlog('get_orders_by_status', dbms_utility.format_error_backtrace, sqlcode, sqlerrm, l_string);
            l_obj.put('h_message', 'Greška u dohvaćanju narudžbi');
            l_obj.put('h_errcod', 92);
            RAISE;
    END;

    -- get_products_by_price_range
    PROCEDURE get_products_by_price_range(l_obj IN OUT JSON_OBJECT_T) AS
        l_string    VARCHAR2(4000);
        l_min_price NUMBER;
        l_max_price NUMBER;
        l_out       json_array_t := json_array_t();
    BEGIN
        l_string := l_obj.TO_STRING;
        l_min_price := JSON_VALUE(l_string, '$.min_price' RETURNING NUMBER);
        l_max_price := JSON_VALUE(l_string, '$.max_price' RETURNING NUMBER);

        FOR x IN (
            SELECT CAMERA_ID AS product_id, NAME, PRICE FROM table_cameras
            WHERE PRICE BETWEEN l_min_price AND l_max_price
            UNION ALL
            SELECT LENS_ID AS product_id, NAME, PRICE FROM table_lenses
            WHERE PRICE BETWEEN l_min_price AND l_max_price
            UNION ALL
            SELECT TABLE_EQUIPMENT_ID AS product_id, NAME, PRICE FROM table_equipment
            WHERE PRICE BETWEEN l_min_price AND l_max_price
            UNION ALL
            SELECT FILM_ID AS product_id, NAME, PRICE FROM table_films
            WHERE PRICE BETWEEN l_min_price AND l_max_price
        ) LOOP
            l_out.append(json_object_t(JSON_OBJECT(
                'product_id' VALUE x.product_id,
                'name' VALUE x.NAME,
                'price' VALUE x.PRICE
            )));
        END LOOP;
        l_obj.put('data', l_out);
    EXCEPTION
        WHEN OTHERS THEN
            common.p_errlog('get_products_by_price_range', dbms_utility.format_error_backtrace, sqlcode, sqlerrm, l_string);
            l_obj.put('h_message', 'Greška u dohvaćanju proizvoda');
            l_obj.put('h_errcod', 93);
            RAISE;
    END;
END DOHVAT;
/

-- podaci.pks
CREATE OR REPLACE PACKAGE PODACI AS
    PROCEDURE insert_customer(l_obj IN OUT JSON_OBJECT_T);
    PROCEDURE update_order_status(l_obj IN OUT JSON_OBJECT_T);
    PROCEDURE delete_product(l_obj IN OUT JSON_OBJECT_T);
END PODACI;
/

-- podaci.pkb
CREATE OR REPLACE PACKAGE BODY PODACI AS
    -- insert_customer
    PROCEDURE insert_customer(l_obj IN OUT JSON_OBJECT_T) AS
        l_string    VARCHAR2(4000);
        l_first     VARCHAR2(50);
        l_last      VARCHAR2(50);
        l_email     VARCHAR2(100);
        l_password  VARCHAR2(100);
        l_address   VARCHAR2(200);
        l_city      VARCHAR2(50);
        l_zip       VARCHAR2(10);
    BEGIN
        l_string := l_obj.TO_STRING;
        l_first := JSON_VALUE(l_string, '$.first_name' RETURNING VARCHAR2);
        l_last := JSON_VALUE(l_string, '$.last_name' RETURNING VARCHAR2);
        l_email := JSON_VALUE(l_string, '$.email' RETURNING VARCHAR2);
        l_password := JSON_VALUE(l_string, '$.password' RETURNING VARCHAR2);
        l_address := JSON_VALUE(l_string, '$.address' RETURNING VARCHAR2);
        l_city := JSON_VALUE(l_string, '$.city' RETURNING VARCHAR2);
        l_zip := JSON_VALUE(l_string, '$.zip' RETURNING VARCHAR2);

        INSERT INTO table_customers (
            FIRST_NAME, LAST_NAME, EMAIL, PASSWORD, ADDRESS, CITY, ZIP
        ) VALUES (
            l_first, l_last, l_email, l_password, l_address, l_city, l_zip
        );

        l_obj.put('message', 'Kupac uspješno dodan');
    EXCEPTION
        WHEN OTHERS THEN
            common.p_errlog('insert_customer', dbms_utility.format_error_backtrace, sqlcode, sqlerrm, l_string);
            l_obj.put('h_message', 'Greška pri dodavanju kupca');
            l_obj.put('h_errcod', 94);
            RAISE;
    END;

    -- update_order_status
    PROCEDURE update_order_status(l_obj IN OUT JSON_OBJECT_T) AS
        l_string   VARCHAR2(4000);
        l_order_id NUMBER;
        l_status   VARCHAR2(20);
    BEGIN
        l_string := l_obj.TO_STRING;
        l_order_id := JSON_VALUE(l_string, '$.order_id' RETURNING NUMBER);
        l_status := JSON_VALUE(l_string, '$.status' RETURNING VARCHAR2);

        UPDATE table_orders
        SET STATUS = l_status
        WHERE ORDER_ID = l_order_id;

        l_obj.put('message', 'Status narudžbe uspješno ažuriran');
    EXCEPTION
        WHEN OTHERS THEN
            common.p_errlog('update_order_status', dbms_utility.format_error_backtrace, sqlcode, sqlerrm, l_string);
            l_obj.put('h_message', 'Greška pri ažuriranju statusa');
            l_obj.put('h_errcod', 95);
            RAISE;
    END;

    -- delete_product
    PROCEDURE delete_product(l_obj IN OUT JSON_OBJECT_T) AS
        l_string       VARCHAR2(4000);
        l_product_id   NUMBER;
        l_product_type VARCHAR2(20);
    BEGIN
        l_string := l_obj.TO_STRING;
        l_product_id := JSON_VALUE(l_string, '$.product_id' RETURNING NUMBER);
        l_product_type := JSON_VALUE(l_string, '$.product_type' RETURNING VARCHAR2);

    CASE l_product_type
        WHEN 'Camera' THEN
            DELETE FROM table_cameras WHERE camera_id = l_product_id;
        WHEN 'Lens' THEN
            DELETE FROM table_lenses WHERE lens_id = l_product_id;
        WHEN 'Equipment' THEN
            DELETE FROM table_equipment WHERE table_equipment_id = l_product_id;
        WHEN 'Film' THEN
            DELETE FROM table_films WHERE film_id = l_product_id;
        ELSE
            l_obj.put('h_message', 'Nepoznat tip proizvoda');
            l_obj.put('h_errcod', 97);
            RETURN;
    END CASE;

        l_obj.put('message', 'Proizvod uspješno obrisan');
    EXCEPTION
        WHEN OTHERS THEN
            common.p_errlog('delete_product', dbms_utility.format_error_backtrace, sqlcode, sqlerrm, l_string);
            l_obj.put('h_message', 'Greška pri brisanju proizvoda');
            l_obj.put('h_errcod', 96);
            RAISE;
    END;
END PODACI;
/
