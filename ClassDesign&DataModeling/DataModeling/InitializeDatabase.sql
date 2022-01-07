-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema CNPM
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema CNPM
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CNPM` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `CNPM` ;

-- -----------------------------------------------------
-- Table `CNPM`.`Book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CNPM`.`Book` (
  `id` INT(11) NOT NULL,
  `author` VARCHAR(45) NOT NULL,
  `coverType` VARCHAR(45) NOT NULL,
  `publisher` VARCHAR(45) NOT NULL,
  `publishDate` DATETIME NOT NULL,
  `numOfPages` INT(11) NOT NULL,
  `language` VARCHAR(45) NOT NULL,
  `bookCategory` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Book_Media1`
    FOREIGN KEY (`id`)
    REFERENCES `CNPM`.`media` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CNPM`.`CD`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CNPM`.`CD` (
  `id` INT(11) NOT NULL,
  `artist` VARCHAR(45) NOT NULL,
  `recordLabel` VARCHAR(45) NOT NULL,
  `musicType` VARCHAR(45) NOT NULL,
  `releasedDate` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_CD_Media1`
    FOREIGN KEY (`id`)
    REFERENCES `CNPM`.`media` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CNPM`.`Card`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CNPM`.`Card` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `cardCode` VARCHAR(15) NOT NULL,
  `owner` VARCHAR(45) NOT NULL,
  `cvvCode` VARCHAR(3) NOT NULL,
  `dateExpired` VARCHAR(4) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CNPM`.`DVD`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CNPM`.`DVD` (
  `id` INT(11) NOT NULL,
  `discType` VARCHAR(45) NOT NULL,
  `director` VARCHAR(45) NOT NULL,
  `runtime` INT(11) NOT NULL,
  `studio` VARCHAR(45) NOT NULL,
  `subtitle` VARCHAR(45) NOT NULL,
  `releasedDate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_DVD_Media1`
    FOREIGN KEY (`id`)
    REFERENCES `CNPM`.`media` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CNPM`.`PaymentTransaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CNPM`.`PaymentTransaction` (
  `id` INT(11) NOT NULL,
  `createAt` DATETIME NOT NULL,
  `content` VARCHAR(45) NOT NULL,
  `method` VARCHAR(45) NULL DEFAULT NULL,
  `cardId` INT(11) NOT NULL,
  `invoiceId` INT(11) NOT NULL,
  `Card_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `cardId`, `invoiceId`, `Card_id`),
  INDEX `fk_PaymentTransaction_Card1_idx` (`cardId` ASC) VISIBLE,
  INDEX `fk_PaymentTransaction_Invoice1_idx` (`invoiceId` ASC) VISIBLE,
  INDEX `fk_PaymentTransaction_Card2_idx` (`Card_id` ASC) VISIBLE,
  CONSTRAINT `fk_PaymentTransaction_Card1`
    FOREIGN KEY (`cardId`)
    REFERENCES `CNPM`.`card` (`id`),
  CONSTRAINT `fk_PaymentTransaction_Invoice1`
    FOREIGN KEY (`invoiceId`)
    REFERENCES `CNPM`.`invoice` (`id`),
  CONSTRAINT `fk_PaymentTransaction_Card2`
    FOREIGN KEY (`Card_id`)
    REFERENCES `CNPM`.`Card` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CNPM`.`Invoice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CNPM`.`Invoice` (
  `id` INT(11) NOT NULL,
  `totalAmount` INT(11) NOT NULL,
  `orderId` INT(11) NOT NULL,
  `PaymentTransaction_id` INT(11) NOT NULL,
  `PaymentTransaction_cardId` INT(11) NOT NULL,
  `PaymentTransaction_invoiceId` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `PaymentTransaction_id`, `PaymentTransaction_cardId`, `PaymentTransaction_invoiceId`),
  INDEX `fk_Invoice_Order1_idx` (`orderId` ASC) VISIBLE,
  INDEX `fk_Invoice_PaymentTransaction1_idx` (`PaymentTransaction_id` ASC, `PaymentTransaction_cardId` ASC, `PaymentTransaction_invoiceId` ASC) VISIBLE,
  CONSTRAINT `fk_Invoice_Order1`
    FOREIGN KEY (`orderId`)
    REFERENCES `CNPM`.`orderdata` (`id`),
  CONSTRAINT `fk_Invoice_PaymentTransaction1`
    FOREIGN KEY (`PaymentTransaction_id` , `PaymentTransaction_cardId` , `PaymentTransaction_invoiceId`)
    REFERENCES `CNPM`.`PaymentTransaction` (`id` , `cardId` , `invoiceId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CNPM`.`OrderData`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CNPM`.`OrderData` (
  `id` INT(11) NOT NULL,
  `shippingFees` VARCHAR(45) NULL DEFAULT NULL,
  `deleveryInfoId` INT(11) NOT NULL,
  `Invoice_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `deleveryInfoId`),
  INDEX `fk_Order_DeleveryInfo1_idx` (`deleveryInfoId` ASC) VISIBLE,
  INDEX `fk_OrderData_Invoice1_idx` (`Invoice_id` ASC) VISIBLE,
  CONSTRAINT `fk_Order_DeleveryInfo1`
    FOREIGN KEY (`deleveryInfoId`)
    REFERENCES `CNPM`.`deleveryinfo` (`id`),
  CONSTRAINT `fk_OrderData_Invoice1`
    FOREIGN KEY (`Invoice_id`)
    REFERENCES `CNPM`.`Invoice` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CNPM`.`DeleveryInfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CNPM`.`DeleveryInfo` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `province` VARCHAR(45) NULL DEFAULT NULL,
  `instructions` VARCHAR(200) NULL DEFAULT NULL,
  `address` VARCHAR(100) NULL DEFAULT NULL,
  `OrderData_id` INT(11) NOT NULL,
  `OrderData_deleveryInfoId` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `OrderData_id`, `OrderData_deleveryInfoId`),
  INDEX `fk_DeleveryInfo_OrderData1_idx` (`OrderData_id` ASC, `OrderData_deleveryInfoId` ASC) VISIBLE,
  CONSTRAINT `fk_DeleveryInfo_OrderData1`
    FOREIGN KEY (`OrderData_id` , `OrderData_deleveryInfoId`)
    REFERENCES `CNPM`.`OrderData` (`id` , `deleveryInfoId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CNPM`.`Media`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CNPM`.`Media` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(45) NOT NULL,
  `price` INT(11) NOT NULL,
  `quantity` INT(11) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `value` INT(11) NOT NULL,
  `imageUrl` VARCHAR(45) NOT NULL,
  `DVD_id` INT(11) NOT NULL,
  `CD_id` INT(11) NOT NULL,
  `Book_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `DVD_id`, `CD_id`, `Book_id`),
  INDEX `fk_Media_DVD1_idx` (`DVD_id` ASC) VISIBLE,
  INDEX `fk_Media_CD1_idx` (`CD_id` ASC) VISIBLE,
  INDEX `fk_Media_Book1_idx` (`Book_id` ASC) VISIBLE,
  CONSTRAINT `fk_Media_DVD1`
    FOREIGN KEY (`DVD_id`)
    REFERENCES `CNPM`.`DVD` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Media_CD1`
    FOREIGN KEY (`CD_id`)
    REFERENCES `CNPM`.`CD` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Media_Book1`
    FOREIGN KEY (`Book_id`)
    REFERENCES `CNPM`.`Book` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CNPM`.`OrderMedia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CNPM`.`OrderMedia` (
  `orderID` INT(11) NOT NULL,
  `price` INT(11) NOT NULL,
  `quantity` INT(11) NOT NULL,
  `mediaId` INT(11) NOT NULL,
  `Invoice_id` INT(11) NOT NULL,
  `Media_id` INT(11) NOT NULL,
  PRIMARY KEY (`orderID`, `mediaId`, `Invoice_id`, `Media_id`),
  INDEX `fk_ordermedia_order_idx` (`orderID` ASC) VISIBLE,
  INDEX `fk_OrderMedia_Media1_idx` (`mediaId` ASC) VISIBLE,
  INDEX `fk_OrderMedia_Invoice1_idx` (`Invoice_id` ASC) VISIBLE,
  INDEX `fk_OrderMedia_Media2_idx` (`Media_id` ASC) VISIBLE,
  CONSTRAINT `fk_OrderMedia_Media1`
    FOREIGN KEY (`mediaId`)
    REFERENCES `CNPM`.`media` (`id`),
  CONSTRAINT `fk_ordermedia_order`
    FOREIGN KEY (`orderID`)
    REFERENCES `CNPM`.`orderdata` (`id`),
  CONSTRAINT `fk_OrderMedia_Invoice1`
    FOREIGN KEY (`Invoice_id`)
    REFERENCES `CNPM`.`Invoice` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrderMedia_Media2`
    FOREIGN KEY (`Media_id`)
    REFERENCES `CNPM`.`Media` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
