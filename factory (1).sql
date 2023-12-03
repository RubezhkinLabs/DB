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
	 Product_name  TEXT NOT NULL UNIQUE,
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
	 Product_type  integer NOT NULL,
	 Production_date  DATE NOT NULL,
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


CREATE TABLE  IF NOT EXISTS factory.Unit_type  (
	 id  serial NOT NULL,
	 Unit_name  TEXT NOT NULL UNIQUE,
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
	 output_product  integer NOT NULL UNIQUE,
	 Unit  integer NOT NULL,
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
	 Unit  integer NOT NULL,
	 Process  integer NOT NULL,
	 Product_input  integer NOT NULL,
	 Product_output  integer NOT NULL,
	CONSTRAINT Operation_pk  PRIMARY KEY ( id )
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

