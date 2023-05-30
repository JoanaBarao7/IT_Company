-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema it_company
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema it_company
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `it_company` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `it_company` ;

-- -----------------------------------------------------
-- Table `it_company`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `it_company`.`clients` (
  `client_id` INT NOT NULL,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `phone_number` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`client_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `it_company`.`departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `it_company`.`departments` (
  `department_id` INT NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`department_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `it_company`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `it_company`.`employees` (
  `employee_id` INT NOT NULL,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `department_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `department_id_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `department_id`
    FOREIGN KEY (`department_id`)
    REFERENCES `it_company`.`departments` (`department_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `it_company`.`tickets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `it_company`.`tickets` (
  `ticket_id` INT NOT NULL,
  `title` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  `priority` VARCHAR(45) NULL DEFAULT NULL,
  `status` VARCHAR(45) NULL DEFAULT NULL,
  `assigned_to` INT NULL DEFAULT NULL,
  PRIMARY KEY (`ticket_id`),
  INDEX `assigned_to_idx` (`assigned_to` ASC) VISIBLE,
  CONSTRAINT `assigned_to`
    FOREIGN KEY (`assigned_to`)
    REFERENCES `it_company`.`employees` (`employee_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `it_company`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `it_company`.`comments` (
  `comment_id` INT NOT NULL,
  `ticket_id` INT NULL DEFAULT NULL,
  `employee_id` INT NULL DEFAULT NULL,
  `comment_text` VARCHAR(400) NULL DEFAULT NULL,
  `created_at` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`comment_id`),
  INDEX `ticket_id_idx` (`ticket_id` ASC) VISIBLE,
  INDEX `employee_id_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `employee_id__`
    FOREIGN KEY (`employee_id`)
    REFERENCES `it_company`.`employees` (`employee_id`),
  CONSTRAINT `ticket_id`
    FOREIGN KEY (`ticket_id`)
    REFERENCES `it_company`.`tickets` (`ticket_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `it_company`.`skills`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `it_company`.`skills` (
  `skill_id` INT NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`skill_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `it_company`.`employee_skills`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `it_company`.`employee_skills` (
  `employee_id` INT NOT NULL,
  `skill_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `skill_id_idx` (`skill_id` ASC) VISIBLE,
  CONSTRAINT `employee_id_`
    FOREIGN KEY (`employee_id`)
    REFERENCES `it_company`.`employees` (`employee_id`),
  CONSTRAINT `skill_id`
    FOREIGN KEY (`skill_id`)
    REFERENCES `it_company`.`skills` (`skill_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `it_company`.`projects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `it_company`.`projects` (
  `project_id` INT NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `start_date` DATE NULL DEFAULT NULL,
  `end_date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`project_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `it_company`.`employees_projects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `it_company`.`employees_projects` (
  `employee_id` INT NOT NULL,
  `project_id` INT NULL DEFAULT NULL,
  INDEX `employee_id_idx` (`employee_id` ASC) VISIBLE,
  INDEX `project_id_idx` (`project_id` ASC) VISIBLE,
  CONSTRAINT `employee_id`
    FOREIGN KEY (`employee_id`)
    REFERENCES `it_company`.`employees` (`employee_id`),
  CONSTRAINT `project_id`
    FOREIGN KEY (`project_id`)
    REFERENCES `it_company`.`projects` (`project_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `it_company`.`invoices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `it_company`.`invoices` (
  `invoice_id` INT NOT NULL,
  `project_id` INT NULL DEFAULT NULL,
  `client_id` INT NULL DEFAULT NULL,
  `amount` DECIMAL(10,2) NULL DEFAULT NULL,
  `due_date` DATE NULL DEFAULT NULL,
  `status` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`invoice_id`),
  INDEX `project_id_idx` (`project_id` ASC) VISIBLE,
  INDEX `client_id_idx` (`client_id` ASC) VISIBLE,
  CONSTRAINT `cID`
    FOREIGN KEY (`client_id`)
    REFERENCES `it_company`.`clients` (`client_id`),
  CONSTRAINT `pro_id`
    FOREIGN KEY (`project_id`)
    REFERENCES `it_company`.`projects` (`project_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `it_company`.`it_company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `it_company`.`it_company` (
  `company_id` INT NOT NULL,
  `clients` INT NULL DEFAULT NULL,
  `departments` INT NULL DEFAULT NULL,
  `employees` INT NULL DEFAULT NULL,
  `invoices` INT NULL DEFAULT NULL,
  `projects` INT NULL DEFAULT NULL,
  PRIMARY KEY (`company_id`),
  INDEX `clients_id_idx` (`clients` ASC) VISIBLE,
  INDEX `departments_id_idx` (`departments` ASC) VISIBLE,
  INDEX `employees_id_idx` (`employees` ASC) VISIBLE,
  INDEX `invoices_id_idx` (`invoices` ASC) VISIBLE,
  INDEX `projects_id_idx` (`projects` ASC) VISIBLE,
  CONSTRAINT `clients_id`
    FOREIGN KEY (`clients`)
    REFERENCES `it_company`.`clients` (`client_id`),
  CONSTRAINT `departments_id`
    FOREIGN KEY (`departments`)
    REFERENCES `it_company`.`departments` (`department_id`),
  CONSTRAINT `employees_id`
    FOREIGN KEY (`employees`)
    REFERENCES `it_company`.`employees` (`employee_id`),
  CONSTRAINT `invoices_id`
    FOREIGN KEY (`invoices`)
    REFERENCES `it_company`.`invoices` (`invoice_id`),
  CONSTRAINT `projects_id`
    FOREIGN KEY (`projects`)
    REFERENCES `it_company`.`projects` (`project_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `it_company`.`payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `it_company`.`payments` (
  `payment_id` INT NOT NULL,
  `invoice_id` INT NULL DEFAULT NULL,
  `amount` DECIMAL(10,2) NULL DEFAULT NULL,
  `payment_date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `invoice_id_idx` (`invoice_id` ASC) VISIBLE,
  CONSTRAINT `invoice_id`
    FOREIGN KEY (`invoice_id`)
    REFERENCES `it_company`.`invoices` (`invoice_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `it_company`.`projects_clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `it_company`.`projects_clients` (
  `client_id` INT NULL DEFAULT NULL,
  `project_id` INT NULL DEFAULT NULL,
  INDEX `client_id_idx` (`client_id` ASC) VISIBLE,
  INDEX `project_id_idx` (`project_id` ASC) VISIBLE,
  CONSTRAINT `client_id`
    FOREIGN KEY (`client_id`)
    REFERENCES `it_company`.`clients` (`client_id`),
  CONSTRAINT `project_id_`
    FOREIGN KEY (`project_id`)
    REFERENCES `it_company`.`projects` (`project_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
