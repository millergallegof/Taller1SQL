-- -----------------------------------------------------
-- CREACION TABLAS NECESARIAS PROYECTO
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS tienda DEFAULT CHARACTER SET utf8;
USE tienda ;

-- -----------------------------------------------------
-- Table products
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS products (
  product_id INT NOT NULL AUTO_INCREMENT,
  product_name VARCHAR(30) NOT NULL,
  product_quant INT NOT NULL,
  product_unit_price DECIMAL(20) NOT NULL,
  create_at DATETIME NOT NULL, 
  update_at DATETIME NULL,
  delete_at DATETIME NULL,
  PRIMARY KEY (product_id),
  UNIQUE INDEX product_id_UNIQUE (product_id ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table provider
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS provider (
  prov_id INT NOT NULL AUTO_INCREMENT,
  prov_name VARCHAR(45) NOT NULL,
  prov_phone VARCHAR(10) NOT NULL,
  create_at DATETIME NOT NULL,
  update_at DATETIME NULL,
  delete_at DATETIME NULL,
  PRIMARY KEY (prov_id),
  UNIQUE INDEX prov_id_UNIQUE (prov_id ASC) VISIBLE,
  UNIQUE INDEX prov_phone_UNIQUE (prov_phone ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table provider_product
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS provider_product (
  provider_product_prov_id INT NOT NULL,
  products_product_id INT NOT NULL,
  INDEX fk_table1_provider_product_idx (provider_product_prov_id ASC) VISIBLE,
  INDEX fk_table1_products1_idx (products_product_id ASC) VISIBLE,
  UNIQUE INDEX provider_product_prov_id_UNIQUE (provider_product_prov_id ASC, products_product_id ASC) VISIBLE,
  CONSTRAINT fk_table1_provider_product
    FOREIGN KEY (provider_product_prov_id)
    REFERENCES provider (prov_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_table1_products1
    FOREIGN KEY (products_product_id)
    REFERENCES products (product_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
    )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table type_id
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS type_id (
  typeid_id INT NOT NULL AUTO_INCREMENT,
  typeid_name VARCHAR(10) NOT NULL,
  create_at DATETIME NOT NULL,
  delete_at DATETIME NULL,
  PRIMARY KEY (typeid_id),
  UNIQUE INDEX typeid_id_UNIQUE (typeid_id ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table customer
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS customer (
  customer_id INT NOT NULL,
  type_id_typeid_id INT NOT NULL,
  customer_name VARCHAR(45) NOT NULL,
  create_at DATETIME NOT NULL,
  delete_at DATETIME NULL,
  PRIMARY KEY (customer_id),
  UNIQUE INDEX customer_id_UNIQUE (customer_id ASC, type_id_typeid_id ASC) INVISIBLE,
  INDEX fk_customer_type_id1_idx (type_id_typeid_id ASC) VISIBLE,
  CONSTRAINT fk_customer_type_id1
    FOREIGN KEY (type_id_typeid_id)
    REFERENCES type_id (typeid_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table salesman
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS salesman (
  salman_id INT NOT NULL,
  salman_name VARCHAR(20) NOT NULL,
  create_at DATETIME NOT NULL,
  update_at DATETIME NULL,
  delete_at DATETIME NULL,
  PRIMARY KEY (salman_id),
  UNIQUE INDEX salman_id_UNIQUE (salman_id ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table sale
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS sale (
  sale_id INT NOT NULL AUTO_INCREMENT,
  products_product_id INT NOT NULL,
  customer_customer_id INT NOT NULL,
  salesman_salman_id INT NOT NULL,
  sale_quant INT NOT NULL,
  sale_price DECIMAL(20) NOT NULL,
  create_at DATETIME NOT NULL,
  annulment_at DATETIME NULL,
  PRIMARY KEY (sale_id),
  UNIQUE INDEX sale_id_UNIQUE (sale_id ASC) VISIBLE,
  INDEX fk_sale_products1_idx (products_product_id ASC) VISIBLE,
  INDEX fk_sale_customer1_idx (customer_customer_id ASC) VISIBLE,
  INDEX fk_sale_salesman1_idx (salesman_salman_id ASC) VISIBLE,
  CONSTRAINT fk_sale_products1
    FOREIGN KEY (products_product_id)
    REFERENCES products (product_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_sale_customer1
    FOREIGN KEY (customer_customer_id)
    REFERENCES customer (customer_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_sale_salesman1
    FOREIGN KEY (salesman_salman_id)
    REFERENCES salesman (salman_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- SCRIP NO. 2 (COMANDOS SQL)
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Informacion de las tablas
-- -----------------------------------------------------

INSERT INTO products (product_name, product_quant, product_unit_price, create_at)
    VALUE
    ('Lapiz', 20, 1200, '2022-01-01'),
    ('Borrador', 15, 500, '2022-01-01'),
    ('Esfero', 25, 1500, '2022-01-01');

INSERT INTO provider (prov_name, prov_phone, create_at)
    VALUE
    ('Cajitas de Carton', '3138816148', '2022-01-01'),
    ('Lapiz y Papel SAS', '3107961838', '2022-01-01'),
    ('Tintas y papeleria SAS', '3148526897', '2022-01-01');

INSERT INTO provider_product (provider_product_prov_id, products_product_id)
    VALUE
    (2, 1),
    (1, 3),
    (3, 2);

INSERT INTO type_id (typeid_name, create_at)
    VALUE
    ('CC', '2022-01-01'),
    ('NIT', '2022-01-01'),
    ('CE', '2022-01-01'),
    ('TI', '2022-01-01');

INSERT INTO customer (customer_id, type_id_typeid_id, customer_name, create_at)
    VALUE
    (1032493691, 1, 'Miller Gallego', '2022-01-01'),
    (900375540, 2, 'Compra y venta SAS', '2022-01-01'),
    (1025357894, 4, 'Camila Casallas', '2022-01-01');

INSERT INTO salesman (salman_id, salman_name, create_at)
    VALUE
    (51643948, 'Arturo Corleone', '2022-01-01');

INSERT INTO sale (products_product_id, customer_customer_id, salesman_salman_id, sale_quant, sale_price, create_at)
    VALUE
    (1, 1032493691, 51643948, 10, 12000, '2022-02-15'),
    (2, 900375540, 51643948, 5, 2500, '2022-02-20'),
    (3, 1025357894, 51643948, 8, 12000, '2022-02-20'),
    (2, 1032493691, 51643948, 8, 4000, '2022-02-28'),
    (3, 900375540, 51643948, 2, 3000, '2022-03-01'),
    (1, 1032493691, 51643948, 10, 12000, '2022-02-15'),
    (2, 900375540, 51643948, 5, 2500, '2022-02-20'),
    (3, 1025357894, 51643948, 8, 12000, '2022-02-20'),
    (2, 1032493691, 51643948, 8, 4000, '2022-02-28'),
    (3, 900375540, 51643948, 2, 3000, '2022-03-01');

-- -----------------------------------------------------
-- Consulta producto vendido por cliente
-- -----------------------------------------------------

SELECT sale.sale_id               AS No_Venta,
       products.product_name      AS Producto_Vendido,
       customer.type_id_typeid_id AS Tipo_Id_Cliente,
       customer.customer_id       AS Id_Cliente
FROM sale
         INNER JOIN products
                    ON sale.products_product_id = products.product_id
         INNER JOIN customer
                    ON sale.customer_customer_id = customer.customer_id;

-- -----------------------------------------------------
-- Consulta producto por proveedor
-- -----------------------------------------------------

SELECT products.product_name AS Nombre_Producto,
       provider.prov_name    AS Nombre_Proveedor
FROM provider_product
         INNER JOIN products
                    ON provider_product.products_product_id = products.product_id
         INNER JOIN provider
                    ON provider_product.provider_product_prov_id = provider.prov_id;

-- -----------------------------------------------------
-- Consulta productos mas vendidos ordenados de mayor a menor
-- -----------------------------------------------------
SELECT products_product_id, SUM(sale_quant) AS cantidad_productos
FROM sale
GROUP BY products_product_id
ORDER BY cantidad_productos DESC ;