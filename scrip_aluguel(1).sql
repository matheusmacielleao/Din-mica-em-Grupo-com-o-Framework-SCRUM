-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema easy_location
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema easy_location
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `easy_location` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `easy_location` ;

-- -----------------------------------------------------
-- Table `easy_location`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `easy_location`.`client` (
  `name` VARCHAR(45) NOT NULL,
  `cpf` CHAR(11) NOT NULL,
  `rg` CHAR(8) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `phone` CHAR(13) NOT NULL,
  `cnh` CHAR(11) NOT NULL,
  PRIMARY KEY (`cpf`),
  UNIQUE INDEX `rg_UNIQUE` (`rg` ASC),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC),
  UNIQUE INDEX `cnh_UNIQUE` (`cnh` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `easy_location`.`car`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `easy_location`.`car` (
  `board` CHAR(7) NOT NULL,
  `daily_price` DECIMAL(10,2) NOT NULL,
  `brand_model` INT NOT NULL,
  UNIQUE INDEX `board_UNIQUE` (`board` ASC),
  PRIMARY KEY (`board`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `easy_location`.`brand_model`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `easy_location`.`brand_model` (
  `brand` VARCHAR(50) NOT NULL,
  `model` VARCHAR(100) NOT NULL,
  `year` YEAR NOT NULL,
  `engine` DECIMAL(2,1) NOT NULL,
  `board_car` CHAR(7) NOT NULL,
  INDEX `board_idx` (`board_car` ASC),
  CONSTRAINT `board`
    FOREIGN KEY (`board_car`)
    REFERENCES `easy_location`.`car` (`board`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `easy_location`.`rental`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `easy_location`.`rental` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `delivery_date` DATE NOT NULL,
  `client` CHAR(11) NOT NULL,
  `board_car` CHAR(7) NOT NULL,
  `daily_price` DECIMAL(10,2) NOT NULL,
  `deadline_date` DATE NOT NULL,
  `final_price` DECIMAL(10,2) NOT NULL,
  `payment_method` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `board_idx` (`board_car` ASC),
  INDEX `client_idx` (`client` ASC),
  CONSTRAINT `client`
    FOREIGN KEY (`client`)
    REFERENCES `easy_location`.`client` (`cpf`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `board`
    FOREIGN KEY (`board_car`)
    REFERENCES `easy_location`.`car` (`board`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `easy_location`.`insurance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `easy_location`.`insurance` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rental` INT NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `date` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `rental_idx` (`rental` ASC),
  CONSTRAINT `rental`
    FOREIGN KEY (`rental`)
    REFERENCES `easy_location`.`rental` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
