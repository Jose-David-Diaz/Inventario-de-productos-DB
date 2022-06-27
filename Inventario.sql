-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema inventario
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema inventario
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `inventario` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci ;
USE `inventario` ;

-- -----------------------------------------------------
-- Table `inventario`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cedula` VARCHAR(50) NOT NULL,
  `nombre` VARCHAR(50) CHARACTER SET 'utf8mb3' NOT NULL,
  `dirección` VARCHAR(50) CHARACTER SET 'utf8mb3' NOT NULL,
  `teléfono` VARCHAR(50) CHARACTER SET 'utf8mb3' NOT NULL,
  `ciudad` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `inventario`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`proveedor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nit` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(50) CHARACTER SET 'utf8mb3' NOT NULL,
  `dirección` VARCHAR(50) CHARACTER SET 'utf8mb3' NOT NULL,
  `teléfono` VARCHAR(50) CHARACTER SET 'utf8mb3' NOT NULL,
  `ciudad` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `inventario`.`compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`compra` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `referencia` VARCHAR(45) NOT NULL,
  `fecha` DATETIME NOT NULL,
  `total` DECIMAL(10,2) NOT NULL,
  `descuento` DECIMAL(10,2) NOT NULL,
  `proveedor_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_compra_proveedor_idx` (`proveedor_id` ASC) VISIBLE,
  CONSTRAINT `fk_compra_proveedor`
    FOREIGN KEY (`proveedor_id`)
    REFERENCES `inventario`.`proveedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `inventario`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`productos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `precio` DECIMAL(10,2) NOT NULL,
  `stock` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 31
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `inventario`.`venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`venta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `referencia` VARCHAR(45) NOT NULL,
  `fecha` DATE NOT NULL,
  `total` DECIMAL(10,2) NOT NULL,
  `descuento` DECIMAL(10,2) NOT NULL,
  `cliente_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_venta_cliente1_idx` (`cliente_id` ASC) VISIBLE,
  CONSTRAINT `fk_venta_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `inventario`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


-- -----------------------------------------------------
-- Table `inventario`.`compra_producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`compra_producto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cantidad` INT NULL,
  `costo` DECIMAL(10,5) NULL,
  `compra_id` INT NOT NULL,
  `productos_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_compra_producto_compra1_idx` (`compra_id` ASC) VISIBLE,
  INDEX `fk_compra_producto_productos1_idx` (`productos_id` ASC) VISIBLE,
  CONSTRAINT `fk_compra_producto_compra1`
    FOREIGN KEY (`compra_id`)
    REFERENCES `inventario`.`compra` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_compra_producto_productos1`
    FOREIGN KEY (`productos_id`)
    REFERENCES `inventario`.`productos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventario`.`venta_producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventario`.`venta_producto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cantidad` INT NULL,
  `costo` DECIMAL(10,5) NULL,
  `venta_id` INT NOT NULL,
  `productos_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_venta_producto_venta1_idx` (`venta_id` ASC) VISIBLE,
  INDEX `fk_venta_producto_productos1_idx` (`productos_id` ASC) VISIBLE,
  CONSTRAINT `fk_venta_producto_venta1`
    FOREIGN KEY (`venta_id`)
    REFERENCES `inventario`.`venta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_venta_producto_productos1`
    FOREIGN KEY (`productos_id`)
    REFERENCES `inventario`.`productos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
