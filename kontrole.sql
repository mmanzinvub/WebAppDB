-- filter.pks
CREATE OR REPLACE PACKAGE FILTER AS
    FUNCTION validate_customer(p_customer_id NUMBER) RETURN BOOLEAN;
    FUNCTION validate_stock(
        p_product_type VARCHAR2,
        p_product_id NUMBER,
        p_quantity NUMBER
    ) RETURN BOOLEAN;
    FUNCTION validate_order_status(p_status VARCHAR2) RETURN BOOLEAN;
END FILTER;
/

-- filter.pkb
CREATE OR REPLACE PACKAGE BODY FILTER AS
    -- validate_customer
    FUNCTION validate_customer(p_customer_id NUMBER) RETURN BOOLEAN IS
        l_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO l_count
        FROM table_customers
        WHERE CUSTOMER_ID = p_customer_id;
        RETURN (l_count = 1);
    EXCEPTION
        WHEN OTHERS THEN
            common.p_errlog('validate_customer', DBMS_UTILITY.FORMAT_ERROR_BACKTRACE, SQLCODE, SQLERRM, NULL);
            RETURN FALSE;
    END;

    -- validate_stock
    FUNCTION validate_stock(p_product_type VARCHAR2, p_product_id NUMBER, p_quantity NUMBER) RETURN BOOLEAN IS
        l_stock NUMBER;
    BEGIN
        CASE p_product_type
            WHEN 'Camera' THEN
                SELECT stock INTO l_stock FROM table_cameras WHERE camera_id = p_product_id;
            WHEN 'Lens' THEN
                SELECT stock INTO l_stock FROM table_lenses WHERE lens_id = p_product_id;
            WHEN 'table_equipment' THEN
                SELECT stock INTO l_stock FROM table_equipment WHERE table_equipment_id = p_product_id;
            WHEN 'Film' THEN
                SELECT stock INTO l_stock FROM table_films WHERE film_id = p_product_id;
            ELSE
                RETURN FALSE;
            END CASE;
        RETURN (l_stock >= p_quantity);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN FALSE;
        WHEN OTHERS THEN
            common.p_errlog('validate_stock', DBMS_UTILITY.FORMAT_ERROR_BACKTRACE, SQLCODE, SQLERRM, NULL);
            RETURN FALSE;
    END;

    -- validate_order_status
    FUNCTION validate_order_status(p_status VARCHAR2) RETURN BOOLEAN IS
    BEGIN
        RETURN p_status IN ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled');
    END;
END FILTER;
/

-- dohvati.pks
CREATE OR REPLACE PACKAGE DOHVATI AS
    e_iznimka EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_iznimka, -20001);
    PROCEDURE p_test(l_obj IN OUT JSON_OBJECT_T);
    PROCEDURE p_login(l_obj IN OUT JSON_OBJECT_T);
    PROCEDURE p_zupanije(l_obj IN OUT JSON_OBJECT_T);
    PROCEDURE p_get_products(l_obj IN OUT JSON_OBJECT_T);
    PROCEDURE p_create_order(l_obj IN OUT JSON_OBJECT_T);
END DOHVATI;
/

-- dohvati.pkb
CREATE OR REPLACE PACKAGE BODY DOHVATI AS
    -- p_test
    PROCEDURE p_test(l_obj IN OUT JSON_OBJECT_T) AS
        l_string VARCHAR2(4000);
    BEGIN
        l_string := l_obj.TO_STRING;
        common.p_logiraj('tu sam', 'evo ga tu je');
        l_obj.put('pozdrav', 'Hello World!');
        common.p_logiraj('tu sam', 'evo ga tu je 2');
    END p_test;

    -- p_login
    PROCEDURE p_login(l_obj IN OUT JSON_OBJECT_T) AS
        l_string   VARCHAR2(4000);
        l_username table_customers.EMAIL%type;
        l_password table_customers.PASSWORD%type;
        l_id       table_customers.CUSTOMER_ID%type;
        l_record   VARCHAR2(4000);
        l_out      json_array_t := json_array_t('[]');
    BEGIN
        l_string := l_obj.TO_STRING;
        l_username := JSON_VALUE(l_string, '$.username' RETURNING VARCHAR2);
        l_password := JSON_VALUE(l_string, '$.password' RETURNING VARCHAR2);

        IF (l_username IS NULL OR l_password IS NULL) THEN
            l_obj.put('h_message', 'Molimo unesite korisničko ime i zaporku');
            l_obj.put('h_errcod', 101);
            RAISE e_iznimka;
        ELSE
            SELECT COUNT(1) INTO l_id
            FROM table_customers
            WHERE EMAIL = l_username AND PASSWORD = l_password;

            IF l_id = 0 THEN
                l_obj.put('h_message', 'Nepoznato korisničko ime ili zaporka');
                l_obj.put('h_errcod', 96);
                RAISE e_iznimka;
            END IF;

            IF l_id > 1 THEN
                l_obj.put('h_message', 'Molimo javite se u Informatiku');
                l_obj.put('h_errcod', 42);
                RAISE e_iznimka;
            END IF;

            SELECT JSON_OBJECT(
                'customer_id' VALUE cus.CUSTOMER_ID,
                'first_name'  VALUE cus.FIRST_NAME,
                'last_name'   VALUE cus.LAST_NAME,
                'email'       VALUE cus.EMAIL,
                'city'        VALUE cus.CITY,
                'address'     VALUE cus.ADDRESS,
                'zip'         VALUE cus.ZIP
            ) INTO l_record
            FROM table_customers cus
            WHERE EMAIL = l_username AND PASSWORD = l_password;

            l_out.append(json_object_t(l_record));
            l_obj.put('data', l_out);
        END IF;
    EXCEPTION
        WHEN e_iznimka THEN
            RAISE;
        WHEN OTHERS THEN
            common.p_errlog('p_login', dbms_utility.format_error_backtrace, sqlcode, sqlerrm, l_string);
            l_obj.put('h_message', 'Greška u obradi podataka');
            l_obj.put('h_errcod', 91);
            RAISE;
    END p_login;

    -- p_zupanije
    PROCEDURE p_zupanije(l_obj IN OUT JSON_OBJECT_T) AS
        l_string VARCHAR2(4000);
        l_out    json_array_t := json_array_t('[]');
        l_slova  VARCHAR2(20) := 'SA';
    BEGIN
        l_string := l_obj.to_string;
        FOR x IN (
            SELECT json_object('ID' VALUE ID, 'ZUPANIJA' VALUE ZUPANIJA) as izlaz
            FROM common.zupanije
            WHERE ZUPANIJA like '%' || l_slova || '%'
            ) LOOP
                l_out.append(JSON_OBJECT_T(x.izlaz));
            END LOOP;
        l_obj.put('data', l_out);
    EXCEPTION
        WHEN OTHERS THEN
            common.p_errlog('p_main', dbms_utility.format_error_backtrace, sqlcode, sqlerrm, l_string);
            l_obj.put('h_message', 'Greška u obradi podataka');
            l_obj.put('h_errcod', 91);
            RAISE;
    END p_zupanije;

    -- p_get_products
    PROCEDURE p_get_products(l_obj IN OUT JSON_OBJECT_T) AS
        l_products JSON_ARRAY_T := JSON_ARRAY_T('[]');
    BEGIN
        FOR c IN
            (SELECT 'Camera' AS type, CAMERA_ID AS id, NAME, PRICE FROM table_cameras)
            LOOP
            l_products.append(JSON_OBJECT_T(JSON_OBJECT(
                    'type' VALUE c.type,
                    'id' VALUE c.id,
                    'name' VALUE c.NAME,
                    'price' VALUE c.PRICE)));
            END LOOP;

        FOR l IN
            (SELECT 'Lens' AS type, LENS_ID AS id, NAME, PRICE FROM table_lenses)
            LOOP
            l_products.append(JSON_OBJECT_T(JSON_OBJECT(
                    'type' VALUE l.type,
                    'id' VALUE l.id,
                    'name' VALUE l.NAME,
                    'price' VALUE l.PRICE)));
            END LOOP;

        FOR e IN
            (SELECT 'Equipment' AS type, TABLE_EQUIPMENT_ID AS id, NAME, PRICE FROM table_equipment)
            LOOP
            l_products.append(JSON_OBJECT_T(JSON_OBJECT(
                    'type' VALUE e.type,
                    'id' VALUE e.id,
                    'name' VALUE e.NAME,
                    'price' VALUE e.PRICE)));
            END LOOP;

        FOR f IN
            (SELECT 'Film' AS type, FILM_ID AS id, NAME, PRICE FROM table_films)
            LOOP
            l_products.append(JSON_OBJECT_T(JSON_OBJECT(
                    'type' VALUE f.type,
                    'id' VALUE f.id,
                    'name' VALUE f.NAME,
                    'price' VALUE f.PRICE)));
            END LOOP;
        l_obj.PUT('products', l_products);
    EXCEPTION
        WHEN OTHERS THEN
            l_obj.put('h_message', 'Greška u dohvaćanju proizvoda');
            l_obj.put('h_errcod', 92);
            RAISE;
    END p_get_products;

    -- p_create_order (rewrite it)
    PROCEDURE p_create_order(l_obj IN OUT JSON_OBJECT_T) AS
        l_string     VARCHAR2(4000);
        l_customer_id table_orders.CUSTOMER_ID%TYPE;
        l_order_id    table_orders.ORDER_ID%TYPE;
        l_items       JSON_ARRAY_T;
        l_item        JSON_OBJECT_T;
        l_type        VARCHAR2(20);
        l_id          NUMBER;
        l_quantity    NUMBER;
        l_price       NUMBER;
    BEGIN
        l_string := l_obj.TO_STRING;

        l_customer_id := JSON_VALUE(l_string, '$.customer_id' RETURNING NUMBER);

        IF NOT filter.validate_customer(l_customer_id) THEN
            l_obj.PUT('h_message', 'Nevažeći ID kupca');
            l_obj.PUT('h_errcod', 400);
            RAISE e_iznimka;
        END IF;

        INSERT INTO table_orders(CUSTOMER_ID, ORDER_DATE, STATUS, TOTAL_AMOUNT)
        VALUES (l_customer_id, SYSDATE, 'Pending', 0)
        RETURNING ORDER_ID INTO l_order_id;

        l_items := l_obj.get_array('items');

        FOR i IN 0 .. l_items.get_size() - 1 LOOP
            l_item := TREAT(l_items.get(i) AS JSON_OBJECT_T);

            l_type := l_item.get_string('product_type');
            l_id := l_item.get_number('product_id');
            l_quantity := l_item.get_number('quantity');
            l_price := l_item.get_number('unit_price');

            IF NOT filter.validate_stock(l_type, l_id, l_quantity) THEN
                l_obj.PUT('h_message', 'Nedovoljna zaliha za proizvod');
                l_obj.PUT('h_errcod', 401);
                RAISE e_iznimka;
            END IF;

            INSERT INTO table_order_items(ORDER_ID, PRODUCT_TYPE, PRODUCT_ID, QUANTITY, UNIT_PRICE, TOTAL_PRICE)
            VALUES (l_order_id, l_type, l_id, l_quantity, l_price, l_price * l_quantity);
        END LOOP;
        l_obj.PUT('order_id', l_order_id);
    EXCEPTION
        WHEN e_iznimka THEN
            RAISE;
        WHEN OTHERS THEN
            common.p_errlog('p_create_order', dbms_utility.format_error_backtrace, sqlcode, sqlerrm, l_string);
            l_obj.put('h_message', 'Greška u obradi narudžbe');
            l_obj.put('h_errcod', 91);
            RAISE;
    END p_create_order;
END DOHVATI;
/

-- router.pks
CREATE OR REPLACE PACKAGE ROUTER AS
    e_iznimka EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_iznimka, -20001);
    PROCEDURE p_main(p_in IN CLOB, p_out OUT CLOB);
END ROUTER;
/

-- router.pkb
CREATE OR REPLACE PACKAGE BODY ROUTER AS
    PROCEDURE p_main(p_in IN CLOB, p_out OUT CLOB) AS
        l_obj       JSON_OBJECT_T;
        l_string    VARCHAR2(4000);
        l_procedura VARCHAR2(40);
    BEGIN
        l_obj := JSON_OBJECT_T(p_in);
        l_string := l_obj.TO_CLOB();
        l_procedura := JSON_VALUE(l_string, '$.procedura' RETURNING VARCHAR2);

        CASE l_procedura
            WHEN 'p_login'                      THEN DOHVATI.p_login(l_obj);
            WHEN 'p_zupanije'                   THEN DOHVATI.p_zupanije(l_obj);
            WHEN 'p_test'                       THEN DOHVATI.p_test(l_obj);
            WHEN 'p_get_products'               THEN DOHVATI.p_get_products(l_obj);
            WHEN 'p_create_order'               THEN DOHVATI.p_create_order(l_obj);
            WHEN 'get_customers_by_city'        THEN DOHVAT.get_customers_by_city(l_obj);
            WHEN 'get_orders_by_status'         THEN DOHVAT.get_orders_by_status(l_obj);
            WHEN 'get_products_by_price_range'  THEN DOHVAT.get_products_by_price_range(l_obj);
            WHEN 'insert_customer'              THEN PODACI.insert_customer(l_obj);
            WHEN 'update_order_status'          THEN PODACI.update_order_status(l_obj);
            WHEN 'delete_product'               THEN PODACI.delete_product(l_obj);
            ELSE
                l_obj.PUT('h_message', 'Nepoznata metoda ' || l_procedura);
                l_obj.PUT('h_errcod', 997);
            END CASE;

        p_out := l_obj.TO_CLOB();
    EXCEPTION
        WHEN e_iznimka THEN
            p_out := l_obj.TO_CLOB();
        WHEN OTHERS THEN
            DECLARE
                l_error PLS_INTEGER := SQLCODE;
            BEGIN
                CASE l_error
                    WHEN -2292 THEN
                        l_obj.put('h_message', 'Navedeni zapis se ne može obrisati jer postoje veze na druge zapise');
                        l_obj.put('h_errcod', 99);
                    ELSE
                        common.p_errlog('p_main', DBMS_UTILITY.FORMAT_ERROR_BACKTRACE, SQLCODE, SQLERRM, l_string);
                        l_obj.put('h_message', 'Greška u obradi podataka');
                        l_obj.put('h_errcod', 100);
                        ROLLBACK;
                    END CASE;
                p_out := l_obj.TO_CLOB();
            END;
    END p_main;
END ROUTER;
/