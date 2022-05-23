-- MySQL Script generated by MySQL Workbench
-- Sun May 22 20:06:49 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mascotitas
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mascotitas` ;

-- -----------------------------------------------------
-- Schema mascotitas
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mascotitas` DEFAULT CHARACTER SET utf8 COLLATE utf8_danish_ci ;
USE `mascotitas` ;

-- -----------------------------------------------------
-- Table `mascotitas`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mascotitas`.`category` (
  `idcategory` TINYINT(2) NOT NULL,
  `name` VARCHAR(50) NULL,
  PRIMARY KEY (`idcategory`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mascotitas`.`brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mascotitas`.`brand` (
  `idbrand` SMALLINT(5) NOT NULL,
  `name` VARCHAR(50) NULL,
  `email` VARCHAR(150) NULL,
  PRIMARY KEY (`idbrand`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mascotitas`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mascotitas`.`product` (
  `idproduct` INT NOT NULL,
  `name` VARCHAR(50) NULL,
  `description` VARCHAR(150) NULL,
  `price` SMALLINT(5) NULL,
  `size` CHAR(1) NULL,
  `weight` FLOAT NULL,
  `lifestage` VARCHAR(15) NULL,
  `Species` VARCHAR(15) NULL,
  `stock` INT NULL,
  `image` BLOB NULL,
  `idcategory` TINYINT(2) NULL,
  `idbrand` SMALLINT(5) NULL,
  PRIMARY KEY (`idproduct`),
  INDEX `idcategory_idx` (`idcategory` ASC) VISIBLE,
  INDEX `idbrand_idx` (`idbrand` ASC) VISIBLE,
  CONSTRAINT `idcategory`
    FOREIGN KEY (`idcategory`)
    REFERENCES `mascotitas`.`category` (`idcategory`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idbrand`
    FOREIGN KEY (`idbrand`)
    REFERENCES `mascotitas`.`brand` (`idbrand`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mascotitas`.`supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mascotitas`.`supplier` (
  `idsupplier` SMALLINT(6) NOT NULL,
  `name` VARCHAR(50) NULL,
  `lastname` VARCHAR(50) NULL,
  `phone` INT NULL,
  `idbrand` SMALLINT(5) NULL,
  PRIMARY KEY (`idsupplier`),
  INDEX `idbrand_idx` (`idbrand` ASC) VISIBLE,
  CONSTRAINT `idbrand`
    FOREIGN KEY (`idbrand`)
    REFERENCES `mascotitas`.`brand` (`idbrand`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mascotitas`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mascotitas`.`user` (
  `iduser` SMALLINT(4) NOT NULL,
  `name` VARCHAR(50) NULL,
  `lastname` VARCHAR(50) NULL,
  `email` VARCHAR(150) NULL,
  `password` VARCHAR(50) NULL,
  PRIMARY KEY (`iduser`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mascotitas`.`ordersupplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mascotitas`.`ordersupplier` (
  `idordersupplier` INT NOT NULL,
  `amount` MEDIUMBLOB NULL,
  `total` INT NULL,
  `idsupplier` SMALLINT(6) NULL,
  `idproduct` INT NULL,
  `iduser` SMALLINT(4) NULL,
  PRIMARY KEY (`idordersupplier`),
  INDEX `idsupplier_idx` (`idsupplier` ASC) VISIBLE,
  INDEX `idproduct_idx` (`idproduct` ASC) VISIBLE,
  INDEX `iduser_idx` (`iduser` ASC) VISIBLE,
  CONSTRAINT `idsupplier`
    FOREIGN KEY (`idsupplier`)
    REFERENCES `mascotitas`.`supplier` (`idbrand`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idproduct`
    FOREIGN KEY (`idproduct`)
    REFERENCES `mascotitas`.`product` (`idproduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `iduser`
    FOREIGN KEY (`iduser`)
    REFERENCES `mascotitas`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mascotitas`.`bitacora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mascotitas`.`bitacora` (
  `idactivity` INT NOT NULL,
  `action` VARCHAR(255) NULL,
  `date` DATE NULL,
  `time` TIME NULL,
  `iduser` SMALLINT(5) NULL,
  PRIMARY KEY (`idactivity`),
  INDEX `iduser_idx` (`iduser` ASC) VISIBLE,
  CONSTRAINT `iduser`
    FOREIGN KEY (`iduser`)
    REFERENCES `mascotitas`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mascotitas`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mascotitas`.`client` (
  `idclient` INT NOT NULL,
  `name` VARCHAR(50) NULL,
  `lastname` VARCHAR(50) NULL,
  `phone` VARCHAR(10) NULL,
  `email` VARCHAR(150) NULL,
  `password` VARCHAR(50) NULL,
  PRIMARY KEY (`idclient`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mascotitas`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mascotitas`.`order` (
  `idorder` INT NOT NULL,
  `total` MEDIUMBLOB NULL,
  `status` VARCHAR(20) NULL,
  `idclient` INT NULL,
  PRIMARY KEY (`idorder`),
  INDEX `idclient_idx` (`idclient` ASC) VISIBLE,
  CONSTRAINT `idclient`
    FOREIGN KEY (`idclient`)
    REFERENCES `mascotitas`.`client` (`idclient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '	';


-- -----------------------------------------------------
-- Table `mascotitas`.`review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mascotitas`.`review` (
  `idreview` INT NOT NULL,
  `date` DATE NULL,
  `description` VARCHAR(255) NULL,
  `status` VARCHAR(20) NULL,
  `score` TINYINT(1) NULL,
  `idclient` INT NULL,
  `idproduct` INT NULL,
  PRIMARY KEY (`idreview`),
  INDEX `idclient_idx` (`idclient` ASC) VISIBLE,
  INDEX `idproduct_idx` (`idproduct` ASC) VISIBLE,
  CONSTRAINT `idclient`
    FOREIGN KEY (`idclient`)
    REFERENCES `mascotitas`.`client` (`idclient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idproduct`
    FOREIGN KEY (`idproduct`)
    REFERENCES `mascotitas`.`product` (`idproduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mascotitas`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mascotitas`.`address` (
  `idaddress` INT NOT NULL,
  `street` VARCHAR(150) NULL,
  `number` SMALLINT(5) NULL,
  `Suburb` VARCHAR(100) NULL,
  `zipcode` SMALLINT(5) NULL,
  PRIMARY KEY (`idaddress`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mascotitas`.`card`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mascotitas`.`card` (
  `idcard` INT NOT NULL,
  `number` BIGINT(16) NULL,
  `date` DATE NULL,
  `ccv` SMALLINT(3) NULL,
  `cardholder` VARCHAR(200) NULL,
  PRIMARY KEY (`idcard`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mascotitas`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mascotitas`.`payment` (
  `idcard` INT NULL,
  `idclient` INT NULL,
  INDEX `idcard_idx` (`idcard` ASC) VISIBLE,
  INDEX `idclient_idx` (`idclient` ASC) VISIBLE,
  CONSTRAINT `idcard`
    FOREIGN KEY (`idcard`)
    REFERENCES `mascotitas`.`card` (`idcard`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idclient`
    FOREIGN KEY (`idclient`)
    REFERENCES `mascotitas`.`client` (`idclient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mascotitas`.`clientaddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mascotitas`.`clientaddress` (
  `idclient` INT NULL,
  `idaddress` INT NULL,
  INDEX `idclient_idx` (`idclient` ASC) VISIBLE,
  INDEX `idaddress_idx` (`idaddress` ASC) VISIBLE,
  CONSTRAINT `idclient`
    FOREIGN KEY (`idclient`)
    REFERENCES `mascotitas`.`client` (`idclient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idaddress`
    FOREIGN KEY (`idaddress`)
    REFERENCES `mascotitas`.`address` (`idaddress`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;