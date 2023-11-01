CREATE TABLE  IF NOT EXISTS Product_type  (
	 id  serial NOT NULL,
	 Product_name  TEXT NOT NULL UNIQUE,
	CONSTRAINT  Product_type_pk  PRIMARY KEY ( id )
) WITH (
  OIDS=FALSE
);
COMMENT ON TABLE IF NOT EXISTS Product_type IS "Тип продукта"
COMMENT ON COLUMN Product_type.id ID "Номер типа продукта"
COMMENT ON COLUMN Product_type.product_name ID "Название типа продукта"


CREATE TABLE  IF NOT EXISTS Product  (
	 id  serial NOT NULL,
	 mass  integer NOT NULL,
	 volume  integer NOT NULL,
	 product_type  integer NOT NULL,
	 production_date  DATE NOT NULL,
	CONSTRAINT  Product_pk  PRIMARY KEY ( id )
) WITH (
  OIDS=FALSE
);
COMMENT ON TABLE IF NOT EXISTS Product_type IS
COMMENT ON COLUMN Product.id ID "Номер продукта"
COMMENT ON COLUMN Product.mass ID "Масса продукта"
COMMENT ON COLUMN Product.volume ID "Объем продукта"
COMMENT ON COLUMN Product.product_type ID "Тип продукта"
COMMENT ON COLUMN Product.production_date ID "Дата производства"


CREATE TABLE  IF NOT EXISTS Unit_type  (
	 id  serial NOT NULL,
	 unit_name  TEXT NOT NULL UNIQUE,
	CONSTRAINT  Unit_type_pk  PRIMARY KEY ( id )
) WITH (
  OIDS=FALSE
);
COMMENT ON TABLE IF NOT EXISTS Unit_type IS "Тип агрегата"
COMMENT ON COLUMN Unit_type.id ID "Номер типа агрегата"
COMMENT ON COLUMN Unit_type.unit_name ID "Название типа агрегата"


CREATE TABLE  IF NOT EXISTS Process  (
	 id  serial NOT NULL,
	 time  TIME NOT NULL,
	 input_product  integer NOT NULL,
	 output_product  integer NOT NULL UNIQUE,
	 unit  integer NOT NULL,
	CONSTRAINT  Process_pk  PRIMARY KEY ( id )
) WITH (
  OIDS=FALSE
);
COMMENT ON TABLE IF NOT EXISTS Process IS "Процесс"
COMMENT ON COLUMN Process.id ID "Номер процесса"
COMMENT ON COLUMN Process.time ID "Время производства"
COMMENT ON COLUMN Process.input_product ID "Номер типа продукта на входе"
COMMENT ON COLUMN Process.output_product ID "Номер типа продукта на выходе"
COMMENT ON COLUMN Process.unit ID "Номер агрегата"


CREATE TABLE  IF NOT EXISTS Unit  (
	 id  serial NOT NULL,
	 name  TEXT NOT NULL,
	 type  integer NOT NULL,
	CONSTRAINT  Unit_pk  PRIMARY KEY ( id )
) WITH (
  OIDS=FALSE
);
COMMENT ON TABLE IF NOT EXISTS Unit IS "Агрегат"
COMMENT ON COLUMN Unit.id ID "Номер агрегата"
COMMENT ON COLUMN Unit.name ID "Название агрегата"
COMMENT ON COLUMN Unit.type ID "Тип агрегата"


CREATE TABLE  IF NOT EXISTS Operation  (
	 id  serial NOT NULL,
	 unit  integer NOT NULL,
	 process  integer NOT NULL,
	 product_input  integer NOT NULL,
	 product_output  integer NOT NULL,
	CONSTRAINT  Operation_pk  PRIMARY KEY ( id )
) WITH (
  OIDS=FALSE
);
COMMENT ON TABLE IF NOT EXISTS Operation IS "Операция"
COMMENT ON COLUMN Operation.id ID "Номер операции"
COMMENT ON COLUMN Operation.unit ID "Номер агрегата"
COMMENT ON COLUMN Operation.process ID "Номер процесса"
COMMENT ON COLUMN Operation.product_input ID "Номер продукта на входе"
COMMENT ON COLUMN Operation.id ID "Номер продукта на выходе"



ALTER TABLE  Product  ADD CONSTRAINT  Product_fk_product_type  FOREIGN KEY ( product_type ) REFERENCES  Product_type ( id ) ON UPDATE CASCADE ON DELETE RESTRICT;


ALTER TABLE  Process  ADD CONSTRAINT  Process_fk_input_product  FOREIGN KEY ( input_product ) REFERENCES  Product_type ( id ) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE  Process  ADD CONSTRAINT  Process_fk_output_product  FOREIGN KEY ( output_product ) REFERENCES  Product_type ( id ) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE  Process  ADD CONSTRAINT  Process_fk_unit_id FOREIGN KEY ( unit ) REFERENCES  Unit_type ( id ) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE  Unit  ADD CONSTRAINT  Unit_fk_type  FOREIGN KEY ( type ) REFERENCES  Unit_type ( id ) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE  Operation  ADD CONSTRAINT  Operation_fk_unit  FOREIGN KEY ( unit ) REFERENCES  Unit ( id ) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE  Operation  ADD CONSTRAINT  Operation_fk_process  FOREIGN KEY ( process ) REFERENCES  Process ( id ) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE  Operation  ADD CONSTRAINT  Operation_fk_product_input FOREIGN KEY ( product_input ) REFERENCES  Product ( id ) ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE  Operation  ADD CONSTRAINT  Operation_fk_product_output  FOREIGN KEY ( product_output ) REFERENCES  Product ( id ) ON UPDATE CASCADE ON DELETE RESTRICT;







