DROP SCHEMA IF EXISTS factory CASCADE;

CREATE SCHEMA IF NOT EXISTS factory
    AUTHORIZATION nedobezhkin_pv;
	
COMMENT ON SCHEMA factory
    IS 'Factory';

GRANT ALL ON SCHEMA factory TO nedobezhkin_pv;

ALTER ROLE nedobezhkin_pv IN DATABASE nedobezhkin_pv_db
    SET search_path TO factory, public;

drop table if exists factory.Operation, factory.Process, factory.Product, factory.Product_type, factory.Unit, factory.Unit_type cascade;
	
CREATE TABLE  IF NOT EXISTS factory.Product_type  (
	 id  serial NOT NULL,
	 product_name  TEXT NOT NULL UNIQUE,
	CONSTRAINT Product_type_pk  PRIMARY KEY ( id )
) WITH (
  OIDS=FALSE
);
COMMENT ON TABLE factory.Product_type IS 'Тип продукта';
COMMENT ON COLUMN factory.Product_type.id IS 'Номер типа продукта';
COMMENT ON COLUMN factory.Product_type.product_name IS 'Название типа продукта';


CREATE TABLE  IF NOT EXISTS factory.Product  (
	 id  serial NOT NULL,
	 mass  integer NOT NULL,
	 volume  integer NOT NULL,
	 product_type  integer NOT NULL,
	 production_date  DATE,
	 death_date DATE,
	CONSTRAINT Product_pk  PRIMARY KEY ( id )
) WITH (
  OIDS=FALSE
);
COMMENT ON TABLE factory.Product IS 'Продукт';
COMMENT ON COLUMN factory.Product.id IS 'Номер продукта';
COMMENT ON COLUMN factory.Product.mass IS 'Масса продукта';
COMMENT ON COLUMN factory.Product.volume IS 'Объем продукта';
COMMENT ON COLUMN factory.Product.product_type IS 'Тип продукта';
COMMENT ON COLUMN factory.Product.production_date IS 'Дата производства';
COMMENT ON COLUMN factory.Product.death_date IS 'Дата смерти';

CREATE TABLE  IF NOT EXISTS factory.Unit_type  (
	 id  serial NOT NULL,
	 unit_name  TEXT NOT NULL UNIQUE,
	CONSTRAINT Unit_type_pk  PRIMARY KEY ( id )
) WITH (
  OIDS=FALSE
);
COMMENT ON TABLE factory.Unit_type IS 'Тип агрегата';
COMMENT ON COLUMN factory.Unit_type.id IS 'Номер типа агрегата';
COMMENT ON COLUMN factory.Unit_type.unit_name IS 'Название типа агрегата';


CREATE TABLE  IF NOT EXISTS factory.Process  (
	 id  serial NOT NULL,
	 time  TIME NOT NULL,
	 input_product  integer NOT NULL,
	 output_product  integer NOT NULL,
	 unit  integer NOT NULL,
	CONSTRAINT Process_pk  PRIMARY KEY ( id )
) WITH (
  OIDS=FALSE
);
COMMENT ON TABLE factory.Process IS 'Процесс';
COMMENT ON COLUMN factory.Process.id IS 'Номер процесса';
COMMENT ON COLUMN factory.Process.time IS 'Время производства';
COMMENT ON COLUMN factory.Process.input_product IS 'Номер типа продукта на входе';
COMMENT ON COLUMN factory.Process.output_product IS 'Номер типа продукта на выходе';
COMMENT ON COLUMN factory.Process.unit IS 'Номер агрегата';


CREATE TABLE  IF NOT EXISTS factory.Unit  (
	 id  serial NOT NULL,
	 name  TEXT NOT NULL,
	 type  integer NOT NULL,
	CONSTRAINT Unit_pk  PRIMARY KEY ( id )
) WITH (
  OIDS=FALSE
);
COMMENT ON TABLE factory.Unit IS 'Агрегат';
COMMENT ON COLUMN factory.Unit.id IS 'Номер агрегата';
COMMENT ON COLUMN factory.Unit.name IS 'Название агрегата';
COMMENT ON COLUMN factory.Unit.type IS 'Тип агрегата';


CREATE TABLE  IF NOT EXISTS factory.Operation  (
	 id  serial NOT NULL,
	 unit  integer NOT NULL,
	 process  integer NOT NULL,
	 product_input  integer NOT NULL,
	 product_output  integer NOT NULL,
	 production_date DATE,
	CONSTRAINT operation_pk  PRIMARY KEY ( id )
) WITH (
  OIDS=FALSE
);
COMMENT ON TABLE factory.Operation IS 'Операция';
COMMENT ON COLUMN factory.Operation.id IS 'Номер операции';
COMMENT ON COLUMN factory.Operation.unit IS 'Номер агрегата';
COMMENT ON COLUMN factory.Operation.process IS 'Номер процесса';
COMMENT ON COLUMN factory.Operation.product_input IS 'Номер продукта на входе';
COMMENT ON COLUMN factory.Operation.id IS 'Номер продукта на выходе';

ALTER TABLE  factory.Product  ADD CONSTRAINT Product_fk_product_type  FOREIGN KEY ( Product_type ) REFERENCES  Product_type ( id ) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE  factory.Process  ADD CONSTRAINT Process_fk_input_product  FOREIGN KEY ( input_product ) REFERENCES  Product_type ( id ) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE  factory.Process  ADD CONSTRAINT Process_fk_output_product  FOREIGN KEY ( output_product ) REFERENCES  Product_type ( id ) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE  factory.Process  ADD CONSTRAINT Process_fk_unit_id FOREIGN KEY ( Unit ) REFERENCES  Unit_type ( id ) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE  factory.Unit  ADD CONSTRAINT Unit_fk_type  FOREIGN KEY ( type ) REFERENCES  Unit_type ( id ) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE  factory.Operation  ADD CONSTRAINT Operation_fk_unit  FOREIGN KEY ( Unit ) REFERENCES  Unit ( id ) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE  factory.Operation  ADD CONSTRAINT Operation_fk_process  FOREIGN KEY ( Process ) REFERENCES Process ( id ) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE  factory.Operation  ADD CONSTRAINT Operation_fk_product_input FOREIGN KEY ( Product_input ) REFERENCES Product ( id ) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE  factory.Operation  ADD CONSTRAINT Operation_fk_product_output  FOREIGN KEY ( Product_output ) REFERENCES Product ( id ) ON UPDATE CASCADE ON DELETE RESTRICT;

INSERT INTO factory.Product_type VALUES (1, 'Железная руда');
INSERT INTO factory.Product_type VALUES (2, 'Медная руда');
INSERT INTO factory.Product_type VALUES (3, 'Урановая руда');
INSERT INTO factory.Product_type VALUES (4, 'Сырая нефть');
INSERT INTO factory.Product_type VALUES (5, 'Железная пластина');
INSERT INTO factory.Product_type VALUES (6, 'Медная пластина');
INSERT INTO factory.Product_type VALUES (7, 'Уран-238');
INSERT INTO factory.Product_type VALUES (8, 'Уран-235');
INSERT INTO factory.Product_type VALUES (9, 'Газ');
INSERT INTO factory.Product_type VALUES (10, 'Дизель');
INSERT INTO factory.Product_type VALUES (11, 'Мазут');
INSERT INTO factory.Product_type VALUES (12, 'Железная труба');
INSERT INTO factory.Product_type VALUES (13, 'Медная проволока');
INSERT INTO factory.Product_type VALUES (14, 'Сера');

INSERT INTO factory.Unit_type VALUES (1, 'Печь');
INSERT INTO factory.Unit_type VALUES (2, 'Центрифуга');
INSERT INTO factory.Unit_type VALUES (3, 'Нефтеперерабатывающий завод');
INSERT INTO factory.Unit_type VALUES (4, 'Сборочный автомат');
INSERT INTO factory.Unit_type VALUES (5, 'Химический завод');

INSERT INTO factory.Product VALUES (1, 1, 1, 1, '2023-01-01');
INSERT INTO factory.Product VALUES (2, 1, 1, 5);
INSERT INTO factory.Product VALUES (3, 1, 1, 5, '2023-03-03');
INSERT INTO factory.Product VALUES (4, 1, 1, 12);
INSERT INTO factory.Product VALUES (5, 1, 1, 2, '2023-05-05');
INSERT INTO factory.Product VALUES (6, 1, 1, 6);
INSERT INTO factory.Product VALUES (7, 1, 1, 6, '2023-07-07');
INSERT INTO factory.Product VALUES (8, 1, 1, 13);

INSERT INTO factory.Unit VALUES (1,'Печь 1',1);
INSERT INTO factory.Unit VALUES (2,'Печь 2',1);
INSERT INTO factory.Unit VALUES (3,'Автомат 1',4);
INSERT INTO factory.Unit VALUES (4,'Автомат 2',4);

INSERT INTO factory.Process VALUES (1, '00:10:00', 1,5,1);
INSERT INTO factory.Process VALUES (2, '00:10:00', 2,6,1);
INSERT INTO factory.Process VALUES (3, '00:15:00', 5,12,4);
INSERT INTO factory.Process VALUES (4, '00:15:00', 6,13,4);

INSERT INTO factory.Operation VALUES (1,1,1,1,2);
INSERT INTO factory.Operation VALUES (2,3,3,3,4);
INSERT INTO factory.Operation VALUES (3,2,2,5,6);
INSERT INTO factory.Operation VALUES (4,4,4,7,8);

CREATE VIEW processes AS
	select id, time, 
	(select product_name as input_product from product_type where id = process.input_product), 
	(select product_name as output_product from product_type where id = process.output_product) 
	from process;

CREATE VIEW units AS
	select id, name, 
	(select unit_name as type from unit_type where id = unit.type)
	from unit;

CREATE VIEW all_products AS
	select id, mass, volume, 
	(select product_name as product_type from product_type where id = product.product_type), 
	production_date, death_date 
	from product;

CREATE VIEW products_in_manufacturing AS
	select id, mass, volume, 
	(select product_name as product_type from product_type where id = product.product_type)
	from product
	where production_date IS NULL;
	
CREATE VIEW products_in_stock AS
	select id, mass, volume, 
	(select product_name as product_type from product_type where id = product.product_type), 
	production_date 
	from product
	where death_date IS NULL AND production_date IS NOT NULL;

CREATE VIEW products_archive AS
	select id, mass, volume, 
	(select product_name as product_type from product_type where id = product.product_type), 
	production_date, death_date 
	from product
	where death_date IS NOT NULL;

CREATE VIEW all_operations AS
	select id, unit, 
	(select name as unit_name from unit where id = operation.unit), 
	product_input,
	(select product_type as input_product from all_products where id = operation.product_input), 
	product_output,
	(select product_type as output_product from all_products where id = operation.product_output), 
	process, 
	production_date
	from operation;

CREATE VIEW current_operations AS
	select id, unit, 
	(select name as unit_name from unit where id = operation.unit), 
	product_input,
	(select product_type as input_product from all_products where id = operation.product_input), 
	product_output,
	(select product_type as output_product from all_products where id = operation.product_output), 
	process
	from operation
	where production_date IS NULL;

CREATE VIEW archive_operations AS
	select id, unit, 
	(select name as unit_name from unit where id = operation.unit), 
	product_input,
	(select product_type as input_product from all_products where id = operation.product_input), 
	product_output,
	(select product_type as output_product from all_products where id = operation.product_output), 
	process
	from operation
	where production_date IS NOT NULL;
	
CREATE OR REPLACE FUNCTION check_operation_availability() RETURNS TRIGGER AS $$
    DECLARE
        active_operation_exists INTEGER;
        product_exists INTEGER;
    BEGIN
        SELECT COUNT(*) INTO active_operation_exists FROM operation WHERE unit = NEW.unit AND production_date IS NULL;
        IF active_operation_exists > 0 THEN
            RAISE EXCEPTION 'There is already an active operation for the specified unit';
        END IF;

        SELECT COUNT(*) INTO product_exists FROM product WHERE id = NEW.product_input AND death_date IS NULL AND production_date IS NOT NULL AND product_type = (SELECT input_product FROM process WHERE id = NEW.process);
        IF product_exists = 0 THEN
            RAISE EXCEPTION 'The input product does not exist or does not match the recipe';
        END IF;

        INSERT INTO product (mass, volume, product_type) VALUES (1, 1, (SELECT output_product FROM process WHERE id = NEW.process)) RETURNING id INTO NEW.product_output;
        UPDATE operation SET product_output = NEW.product_output WHERE id = NEW.id;

		UPDATE product SET death_date = NOW() WHERE id = NEW.product_input;
    
        RETURN NEW;
    END;
 $$ LANGUAGE plpgsql;

CREATE TRIGGER operation_availability_trigger 
BEFORE INSERT ON operation 
FOR EACH ROW EXECUTE FUNCTION 
check_operation_availability();

CREATE OR REPLACE FUNCTION set_prod_date(unit_id INTEGER)
RETURNS VOID AS $$
DECLARE
	operation_id integer;
BEGIN
	SELECT id INTO operation_id FROM operation WHERE unit = unit_id and production_date is null;	
	UPDATE operation set production_date = NOW() WHERE id = operation_id;
	UPDATE product set production_date = NOW() WHERE id in (select product_output  from operation where id = operation_id);
END;
$$ LANGUAGE plpgsql;

CREATE SEQUENCE	product_id_sequence
	START WITH 9;
	
DO $$
DECLARE
i integer;
BEGIN
	FOR i in 1..5 LOOP
		INSERT INTO PRODUCT VALUES(nextval('product_id_sequence'),1,1,floor(random()*14+1),NOW());
	END LOOP;
END;
$$ LANGUAGE plpgsql;

REVOKE ALL PRIVILEGES ON DATABASE nedobezhkin_pv_db FROM engineer;
REVOKE ALL PRIVILEGES ON SCHEMA factory FROM engineer;
REVOKE ALL PRIVILEGES ON TABLE Operation, Process, Product, Product_type, Unit, Unit_type FROM engineer;
REVOKE ALL PRIVILEGES ON DATABASE nedobezhkin_pv_db FROM petrovich;
REVOKE ALL PRIVILEGES ON SCHEMA factory FROM petrovich;
REVOKE ALL PRIVILEGES ON TABLE Operation, Process, Product, Product_type, Unit, Unit_type FROM petrovich;

DROP USER IF EXISTS petrovich;
DROP ROLE IF EXISTS engineer;

REVOKE ALL PRIVILEGES ON DATABASE nedobezhkin_pv_db FROM worker;
REVOKE ALL PRIVILEGES ON SCHEMA factory FROM worker;
REVOKE ALL PRIVILEGES ON TABLE Operation, Process, Product, Product_type, Unit, Unit_type FROM worker;
REVOKE ALL PRIVILEGES ON DATABASE nedobezhkin_pv_db FROM mihalych;
REVOKE ALL PRIVILEGES ON SCHEMA factory FROM mihalych;
REVOKE ALL PRIVILEGES ON TABLE Operation, Process, Product, Product_type, Unit, Unit_type FROM mihalych;


DROP USER IF EXISTS mihalych;
DROP ROLE IF EXISTS worker;

CREATE ROLE engineer;
GRANT CONNECT ON DATABASE nedobezhkin_pv_db TO engineer;
GRANT USAGE ON SCHEMA factory TO engineer;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Unit TO engineer;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Unit_type TO engineer;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Process TO engineer;
GRANT SELECT ON TABLE Operation TO engineer;
GRANT SELECT ON TABLE Product TO engineer;

CREATE ROLE worker;
GRANT CONNECT ON DATABASE nedobezhkin_pv_db TO worker;
GRANT USAGE ON SCHEMA factory TO worker;
GRANT SELECT ON TABLE Unit TO worker;
GRANT SELECT ON TABLE Unit_type TO worker;
GRANT SELECT ON TABLE Process TO worker;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Operation TO worker;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Product TO worker;

CREATE USER petrovich with password '1';
GRANT engineer TO petrovich;
GRANT CONNECT ON DATABASE nedobezhkin_pv_db to petrovich;
ALTER ROLE petrovich IN DATABASE nedobezhkin_pv_db SET search_path TO factory, public;

CREATE USER mihalych with password '1';
GRANT worker TO mihalych;
GRANT CONNECT ON DATABASE nedobezhkin_pv_db to mihalych;
ALTER ROLE mihalych IN DATABASE nedobezhkin_pv_db SET search_path TO factory, public;
