
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET  FOREIGN_KEY_CHECKS = 1;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS fim_de_feira DEFAULT CHARACTER SET utf8 ;

-- -----------------------------------------------------
-- Table tb_cliente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS tb_cliente (
  id_cpf_cliente  VARCHAR(14) NOT NULL,
  nome VARCHAR(100) NOT NULL,
  sobrenome VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  sexo ENUM('M', 'F', 'Nao informar') NOT NULL,
  data_nasc date NOT NULL, 
  senha VARCHAR (45),
  PRIMARY KEY (id_cpf_cliente))
ENGINE = InnoDB;

insert into tb_cliente values ("11122233332","carlos","carlos@.com.br","M");
-- -----------------------------------------------------
-- Table tb_parceiro
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS tb_parceiro (
  id_cnpj VARCHAR(20) NOT NULL,
  nome VARCHAR(60) NOT NULL,
  email VARCHAR(200) NOT NULL,
  PRIMARY KEY (id_cnpj))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table tb_telefone
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS tb_telefone (
  id_numero INT NOT NULL,
  numero VARCHAR(11) NOT NULL,
  id_cpf_cliente VARCHAR(14) NULL,
  id_cnpj VARCHAR(20) NULL,
  PRIMARY KEY (id_numero),
  CONSTRAINT fk_tb_telefone
  
    FOREIGN KEY (id_cpf_cliente)
    REFERENCES tb_cliente (id_cpf_cliente)
	ON DELETE CASCADE
    ON UPDATE NO ACTION,
    
    FOREIGN KEY (id_cnpj)
    REFERENCES tb_parceiro (id_cnpj)
	ON DELETE CASCADE
    ON UPDATE NO ACTION)
    ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table tb_endereco
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS tb_endereco (
  logradouro VARCHAR(200) NOT NULL,
  numero INT NOT NULL,
  bairro VARCHAR(200) NOT NULL,
  uf VARCHAR(2) NOT NULL,
  cep VARCHAR(8) NOT NULL,
  cidade VARCHAR(100) NOT NULL,
  id_cpf_cliente VARCHAR(14) NULL,
  id_cnpj VARCHAR(20) NULL,
  CONSTRAINT fk_tb_endereco
  
    FOREIGN KEY (id_cpf_cliente)
    REFERENCES tb_cliente (id_cpf_cliente)
	ON DELETE CASCADE
    ON UPDATE NO ACTION,
    
  CONSTRAINT fk_tb_parceiro
    FOREIGN KEY (id_cnpj)
    REFERENCES tb_parceiro (id_cnpj)
	ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table tb_pagamento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS tb_pagamento (
  id_pagamento INT NOT NULL AUTO_INCREMENT,
  tipo_pagamento ENUM('credito', 'debito', 'pix') NOT NULL,
  valor_total_pedido DECIMAL(12,2) NOT NULL,
  data_hr_pagamento DATETIME NOT NULL,
  PRIMARY KEY (id_pagamento))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table tb_pedido
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS tb_pedido (
  id_pedido INT NOT NULL,
  data_hr_pedido DATETIME NOT NULL,
  data_hr_retirada DATETIME NULL,
  data_hr_disp_retirada DATETIME NOT NULL,
  id_pagamento INT NOT NULL,
  id_cpf_cliente VARCHAR(14) NOT NULL,
  PRIMARY KEY (id_pedido),
  CONSTRAINT fk_tb_pedido
  
    FOREIGN KEY (id_pagamento)
    REFERENCES tb_pagamento (id_pagamento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    
  CONSTRAINT fk_tb_cliente1
    FOREIGN KEY (id_cpf_cliente)
    REFERENCES tb_cliente (id_cpf_cliente)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table tb_produto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS tb_produto(
  id_produto INT NOT NULL,
  valor_produto DECIMAL(6,2) NOT NULL,
  descricao_produto VARCHAR(140) NOT NULL,
  qtd_max_venda INT NULL,
  qtd_total INT NOT NULL,
  id_cnpj VARCHAR(20) NOT NULL,
  PRIMARY KEY (id_produto, id_cnpj),
  CONSTRAINT fk_tb_produto
  
    FOREIGN KEY (id_cnpj)
    REFERENCES tb_parceiro (id_cnpj)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table tb_itens_pedido
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS tb_itens_pedido (
  id_produto INT NOT NULL,
  id_pedido INT NOT NULL,
  qtd_itens INT NOT NULL,
  valor_total_itens DECIMAL(12,2) NOT NULL,
  PRIMARY KEY (id_produto, id_pedido),
  CONSTRAINT fk_id_produto_id_produto
  
    FOREIGN KEY (id_produto)
    REFERENCES tb_produto (id_produto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    
    FOREIGN KEY (id_pedido)
    REFERENCES tb_pedido (id_pedido)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
