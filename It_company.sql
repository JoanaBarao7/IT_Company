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
  `id` INT NOT NULL,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `phone_number` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `it_company`.`it_company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `it_company`.`it_company` (
  `id` INT NOT NULL,
  `departments_department_id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `it_company`.`departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `it_company`.`departments` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `it_company_company_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_departments_it_company1_idx` (`it_company_company_id` ASC) VISIBLE,
  CONSTRAINT `fk_departments_it_company1`
    FOREIGN KEY (`it_company_company_id`)
    REFERENCES `it_company`.`it_company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `it_company`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `it_company`.`employees` (
  `id` INT NOT NULL,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `department_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `department_id_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `department_id`
    FOREIGN KEY (`department_id`)
    REFERENCES `it_company`.`departments` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `it_company`.`tickets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `it_company`.`tickets` (
  `id` INT NOT NULL,
  `title` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  `priority` VARCHAR(45) NULL DEFAULT NULL,
  `status` VARCHAR(45) NULL DEFAULT NULL,
  `assigned_to` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `assigned_to_idx` (`assigned_to` ASC) VISIBLE,
  CONSTRAINT `assigned_to`
    FOREIGN KEY (`assigned_to`)
    REFERENCES `it_company`.`employees` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `it_company`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `it_company`.`comments` (
  `id` INT NOT NULL,
  `ticket_id` INT NULL DEFAULT NULL,
  `employee_id` INT NULL DEFAULT NULL,
  `comment_text` VARCHAR(400) NULL DEFAULT NULL,
  `created_at` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `ticket_id_idx` (`ticket_id` ASC) VISIBLE,
  INDEX `employee_id_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `employee_id__`
    FOREIGN KEY (`employee_id`)
    REFERENCES `it_company`.`employees` (`id`),
  CONSTRAINT `ticket_id`
    FOREIGN KEY (`ticket_id`)
    REFERENCES `it_company`.`tickets` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `it_company`.`skills`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `it_company`.`skills` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `it_company`.`employee_skills`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `it_company`.`employee_skills` (
  `employee_id` INT NOT NULL,
  `skill_id` INT NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `skill_id_idx` (`skill_id` ASC) VISIBLE,
  CONSTRAINT `employee_id_`
    FOREIGN KEY (`employee_id`)
    REFERENCES `it_company`.`employees` (`id`),
  CONSTRAINT `skill_id`
    FOREIGN KEY (`skill_id`)
    REFERENCES `it_company`.`skills` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `it_company`.`projects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `it_company`.`projects` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `start_date` DATE NULL DEFAULT NULL,
  `end_date` DATE NULL DEFAULT NULL,
  `clients_client_id` INT NOT NULL,
  `it_company_company_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_projects_clients1_idx` (`clients_client_id` ASC) VISIBLE,
  INDEX `fk_projects_it_company1_idx` (`it_company_company_id` ASC) VISIBLE,
  CONSTRAINT `fk_projects_clients1`
    FOREIGN KEY (`clients_client_id`)
    REFERENCES `it_company`.`clients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_projects_it_company1`
    FOREIGN KEY (`it_company_company_id`)
    REFERENCES `it_company`.`it_company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `it_company`.`employees_projects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `it_company`.`employees_projects` (
  `employees_employee_id` INT NOT NULL,
  `projects_project_id` INT NOT NULL,
  INDEX `employee_id_idx` (`employees_employee_id` ASC) VISIBLE,
  INDEX `project_id_idx` (`projects_project_id` ASC) VISIBLE,
  PRIMARY KEY (`projects_project_id`, `employees_employee_id`),
  CONSTRAINT `employee_id`
    FOREIGN KEY (`employees_employee_id`)
    REFERENCES `it_company`.`employees` (`id`),
  CONSTRAINT `project_id`
    FOREIGN KEY (`projects_project_id`)
    REFERENCES `it_company`.`projects` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `it_company`.`invoices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `it_company`.`invoices` (
  `id` INT NOT NULL,
  `projects_project_id` INT NOT NULL,
  `amount` DECIMAL(10,2) NULL DEFAULT NULL,
  `due_date` DATE NULL DEFAULT NULL,
  `status` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `project_id_idx` (`projects_project_id` ASC) VISIBLE,
  CONSTRAINT `pro_id`
    FOREIGN KEY (`projects_project_id`)
    REFERENCES `it_company`.`projects` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `it_company`.`payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `it_company`.`payments` (
  `id` INT NOT NULL,
  `invoice_id` INT NULL DEFAULT NULL,
  `amount` DECIMAL(10,2) NULL DEFAULT NULL,
  `payment_date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `invoice_id_idx` (`invoice_id` ASC) VISIBLE,
  CONSTRAINT `invoice_id`
    FOREIGN KEY (`invoice_id`)
    REFERENCES `it_company`.`invoices` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
