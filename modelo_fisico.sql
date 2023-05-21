-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`tb_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_cliente` (
  `cpf_cliente` VARCHAR(11) NOT NULL,
  `nome` VARCHAR(200) NOT NULL,
  `email` VARCHAR(200) NOT NULL,
  `sexo` ENUM('M', 'F', 'Nao informar') NOT NULL,
  PRIMARY KEY (`cpf_cliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tb_parceiro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_parceiro` (
  `cnpj` VARCHAR(20) NOT NULL,
  `nome` VARCHAR(60) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cnpj`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tb_telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_telefone` (
  `id_numero` INT NOT NULL,
  `numero` VARCHAR(11) NOT NULL,
  `alternativo` VARCHAR(11) NULL,
  `tb_cliente_cpf_cliente` VARCHAR(11) NULL,
  `tb_parceiro_cnpj` VARCHAR(20) NULL,
  PRIMARY KEY (`id_numero`),
  UNIQUE INDEX `id_numero_UNIQUE` (`id_numero` ASC) VISIBLE,
  UNIQUE INDEX `numero_UNIQUE` (`numero` ASC) VISIBLE,
  INDEX `fk_tb_telefone_tb_cliente1_idx` (`tb_cliente_cpf_cliente` ASC) VISIBLE,
  INDEX `fk_tb_telefone_tb_parceiro1_idx` (`tb_parceiro_cnpj` ASC) VISIBLE,
  CONSTRAINT `fk_tb_telefone_tb_cliente1`
    FOREIGN KEY (`tb_cliente_cpf_cliente`)
    REFERENCES `mydb`.`tb_cliente` (`cpf_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_telefone_tb_parceiro1`
    FOREIGN KEY (`tb_parceiro_cnpj`)
    REFERENCES `mydb`.`tb_parceiro` (`cnpj`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tb_endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_endereco` (
  `logradouro` VARCHAR(200) NOT NULL,
  `numero` INT NOT NULL,
  `bairro` VARCHAR(200) NOT NULL,
  `uf` VARCHAR(2) NOT NULL,
  `cep` VARCHAR(8) NOT NULL,
  `cidade` VARCHAR(100) NOT NULL,
  `tb_cliente_cpf` VARCHAR(11) NULL,
  `tb_parceiro_cnpj` VARCHAR(20) NULL,
  INDEX `fk_tb_endereco_tb_parceiro1_idx` (`tb_parceiro_cnpj` ASC) VISIBLE,
  CONSTRAINT `fk_tb_endereco_tb_cliente1`
    FOREIGN KEY (`tb_cliente_cpf`)
    REFERENCES `mydb`.`tb_cliente` (`cpf_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_endereco_tb_parceiro1`
    FOREIGN KEY (`tb_parceiro_cnpj`)
    REFERENCES `mydb`.`tb_parceiro` (`cnpj`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tb_pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_pagamento` (
  `id_pagamento` INT NOT NULL AUTO_INCREMENT,
  `tipo_pagamento` ENUM('credito', 'debito', 'pix') NOT NULL,
  `valor_total_pedido` DECIMAL(12,2) NOT NULL,
  `data_hr_pagamento` DATETIME NOT NULL,
  PRIMARY KEY (`id_pagamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tb_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_pedido` (
  `id_pedido` INT NOT NULL,
  `data_hr_pedido` DATETIME NOT NULL,
  `data_hr_retirada` DATETIME NULL,
  `data_hr_disp_retirada` DATETIME NOT NULL,
  `tb_pagamento_id_pagamento` INT NOT NULL,
  `tb_cliente_cpf_cliente` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`id_pedido`),
  UNIQUE INDEX `id_pedido_UNIQUE` (`id_pedido` ASC) VISIBLE,
  INDEX `fk_tb_pedido_tb_pagamento1_idx` (`tb_pagamento_id_pagamento` ASC) VISIBLE,
  INDEX `fk_tb_pedido_tb_cliente1_idx` (`tb_cliente_cpf_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_tb_pedido_tb_pagamento1`
    FOREIGN KEY (`tb_pagamento_id_pagamento`)
    REFERENCES `mydb`.`tb_pagamento` (`id_pagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_pedido_tb_cliente1`
    FOREIGN KEY (`tb_cliente_cpf_cliente`)
    REFERENCES `mydb`.`tb_cliente` (`cpf_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tb_produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_produto` (
  `id_produto` INT NOT NULL,
  `valor_produto` DECIMAL(6,2) NOT NULL,
  `descricao_produto` VARCHAR(140) NOT NULL,
  `qtd_max_venda` INT NULL,
  `qtd_total` INT NOT NULL,
  `tb_parceiro_cnpj` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_produto`, `tb_parceiro_cnpj`),
  INDEX `fk_tb_produto_tb_parceiro1_idx` (`tb_parceiro_cnpj` ASC) VISIBLE,
  CONSTRAINT `fk_tb_produto_tb_parceiro1`
    FOREIGN KEY (`tb_parceiro_cnpj`)
    REFERENCES `mydb`.`tb_parceiro` (`cnpj`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tb_itens_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tb_itens_pedido` (
  `tb_produto_id_produto` INT NOT NULL,
  `tb_pedido_id_pedido` INT NOT NULL,
  `qtd_itens` INT NOT NULL,
  `valor_total_itens` DECIMAL(12,2) NOT NULL,
  PRIMARY KEY (`tb_produto_id_produto`, `tb_pedido_id_pedido`),
  INDEX `fk_tb_produto_has_tb_pedido_tb_pedido1_idx` (`tb_pedido_id_pedido` ASC) VISIBLE,
  INDEX `fk_tb_produto_has_tb_pedido_tb_produto1_idx` (`tb_produto_id_produto` ASC) VISIBLE,
  CONSTRAINT `fk_tb_produto_has_tb_pedido_tb_produto1`
    FOREIGN KEY (`tb_produto_id_produto`)
    REFERENCES `mydb`.`tb_produto` (`id_produto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_produto_has_tb_pedido_tb_pedido1`
    FOREIGN KEY (`tb_pedido_id_pedido`)
    REFERENCES `mydb`.`tb_pedido` (`id_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
