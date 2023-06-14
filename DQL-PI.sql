 -- -----------------------------------------------------
-- Scripts : Alterar as Estruturas das Tabelas (DDL)
-- -----------------------------------------------------

ALTER TABLE tb_endereco ADD COLUMN referencia VARCHAR(100); 

ALTER TABLE tb_cliente
MODIFY COLUMN sobrenome VARCHAR(50) NOT NULL;

ALTER TABLE tb_pagamento
ADD COLUMN tipo_de_cartao VARCHAR(50) AFTER tipo_pagamento;

ALTER TABLE tb_produto
MODIFY COLUMN qtd_max_venda INT NOT NULL;

ALTER TABLE tb_parceiro ADD COLUMN pontuacao INT; 

-- -----------------------------------------------------
-- script para alterar os dados da tabela 
-- -----------------------------------------------------

UPDATE tb_cliente
	SET email = 'cacaboto@example.com'
		WHERE id_cpf_cliente = '11122233332';
        
UPDATE tb_parceiro
	SET nome = 'Juca Alimentos'
		WHERE id_cnpj = '97.776.3530001';

UPDATE tb_telefone
	SET numero = '81987354321'
		WHERE id_cpf_cliente = '11122233332';

UPDATE tb_endereco
	SET logradouro = 'Rua do Centro Boto', numero = 908, bairro = 'Carririo'
		WHERE id_cnpj = '97.776.3530001';
        
UPDATE tb_pagamento
	SET tipo_pagamento = 'debito'
		WHERE id_pagamento = 1;

-- -----------------------------------------------------
-- script para deletar os dados da tabela 
-- -----------------------------------------------------
DELETE FROM tb_telefone WHERE id_cpf_cliente IS NULL;
DELETE FROM tb_endereco WHERE id_cpf_cliente IS NULL AND id_cnpj IS NULL;
DELETE FROM tb_telefone WHERE numero = '82212633406';
DELETE FROM tb_cliente WHERE id_cpf_cliente = '11122233332';
DELETE FROM tb_endereco WHERE logradouro = 'Rua A' AND numero = 123;

-- -----------------------------------------------------
-- script para destruir (DDL) todas as tabelas, views, procedimentos, funções e dependências do seu banco de dados;
-- -----------------------------------------------------
 
 -- Drop foreign key constraints
ALTER TABLE tb_telefone DROP FOREIGN KEY fk_tb_telefone;
ALTER TABLE tb_telefone DROP FOREIGN KEY fk_tb_telefone_2;
ALTER TABLE tb_endereco DROP FOREIGN KEY fk_tb_endereco;
ALTER TABLE tb_endereco DROP FOREIGN KEY fk_tb_endereco_2;
ALTER TABLE tb_pedido DROP FOREIGN KEY fk_tb_pedido;
ALTER TABLE tb_pedido DROP FOREIGN KEY fk_tb_cliente1;
ALTER TABLE tb_produto DROP FOREIGN KEY fk_tb_produto;
ALTER TABLE tb_itens_pedido DROP FOREIGN KEY fk_id_produto_id_produto;
ALTER TABLE tb_itens_pedido DROP FOREIGN KEY fk_id_produto_id_produto_2;

-- -----------------------------------------------------
-- Drop tables
-- -----------------------------------------------------

DROP TABLE IF EXISTS tb_itens_pedido;
DROP TABLE IF EXISTS tb_pedido;
DROP TABLE IF EXISTS tb_pagamento;
DROP TABLE IF EXISTS tb_produto;
DROP TABLE IF EXISTS tb_endereco;
DROP TABLE IF EXISTS tb_telefone;
DROP TABLE IF EXISTS tb_cliente;
DROP TABLE IF EXISTS tb_parceiro;


-- -----------------------------------------------------
-- Drop views, procedures, functions (if applicable):
-- -----------------------------------------------------


-- -----------------------------------------------------
-- DROP VIEW IF EXISTS view_name;
-- -----------------------------------------------------



-- -----------------------------------------------------
-- DROP PROCEDURE IF EXISTS procedure_name;
-- -----------------------------------------------------  



-- -----------------------------------------------------
-- DROP FUNCTION IF EXISTS function_name;
-- -----------------------------------------------------



-- -----------------------------------------------------
-- CREATE TRIGGER
-- -----------------------------------------------------
DELIMITER $$
CREATE TRIGGER `trg_atualizando_qtd_produto` AFTER INSERT ON `tb_itens_pedido` FOR EACH ROW BEGIN

DECLARE valor_inserido INT;
  SET valor_inserido = NEW.qtd_itens;
	UPDATE tb_produto
		  SET qtd_total = qtd_total - valor_inserido
			WHERE tb_produto.id_produto = NEW.id_produto;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` TRIGGER `trg_retonando_qtd_produto` BEFORE DELETE ON `tb_itens_pedido` FOR EACH ROW BEGIN

DECLARE valor_inserido INT;
  SET valor_inserido = OLD.qtd_itens;
	UPDATE tb_produto
		SET qtd_total = qtd_total + valor_inserido
			WHERE tb_produto.id_produto = OLD.id_produto;
END$$
DELIMITER ;

DELIMITER //

CREATE DEFINER=`root`@`localhost` TRIGGER `trg_atualiza_valor_total_pedido` AFTER INSERT ON `tb_itens_pedido` FOR EACH ROW BEGIN
  DECLARE total DECIMAL(12,2);
  
  SELECT SUM(ip.qtd_itens * p.valor_produto)
    INTO total
    FROM tb_itens_pedido ip
    JOIN tb_produto p ON p.id_produto = ip.id_produto
    WHERE ip.id_pedido = NEW.id_pedido;
  
  IF total IS NULL THEN
    SET total = 0;
  END IF;
  
  UPDATE tb_pedido
    SET valor_total_pedido = total
    WHERE id_pedido = NEW.id_pedido;
END //

DELIMITER ;



DELIMITER $$
CREATE TRIGGER `trg_atualiza_valor_pagamento` AFTER UPDATE ON `tb_pedido` FOR EACH ROW
BEGIN

SELECT valor_total_pedido INTO @novo_valor  FROM tb_pedido
WHERE id_pedido = NEW.id_pedido;

UPDATE tb_pagamento 
	SET valor_total_pago = @novo_valor
		WHERE id_pedido = NEW.id_pedido;
END$$
DELIMITER ;


DELIMITER //

CREATE TRIGGER trg_deleta_valor_total_pedido
BEFORE DELETE ON tb_itens_pedido
FOR EACH ROW
BEGIN
  DECLARE valor_item DECIMAL(12,2);
  
  SELECT tb_itens_pedido.qtd_itens * tb_produto.valor_produto
    INTO valor_item
    FROM tb_itens_pedido
    JOIN tb_produto ON tb_itens_pedido.id_produto = tb_produto.id_produto
    WHERE tb_itens_pedido.id_pedido = OLD.id_pedido
    AND tb_itens_pedido.id_produto = OLD.id_produto
    LIMIT 1;
  
  IF valor_item IS NULL THEN
    SET valor_item = 0;
  END IF;
  
  UPDATE tb_pedido
    SET valor_total_pedido = valor_total_pedido - valor_item
    WHERE id_pedido = OLD.id_pedido;
END //

DELIMITER ;

-- -----------------------------------------------------
-- PROCEDURE
-- -----------------------------------------------------

delimiter //
create procedure inserir_cliente(in id_cpf_cliente varchar(14), in nome varchar(100), in sobrenome varchar(100), in email varchar(100),
in sexo enum('M','F','Nao informar'), in data_nasc date,in senha varchar(45), in id_numero int, in numero varchar(11))
	begin
		insert into tb_cliente value (id_cpf_cliente, nome, sobrenome, email, sexo, data_nasc,senha);
		insert into tb_telefone value(id_numero,numero,id_cpf_cliente,id_cnpj);
    end //
delimiter ;

call inserir_cliente("123.456.789-56", "Pedro", "Sebastião","pedroseb@gmail.com",'M','1984-07-09',"23232323", 1 ,"81988293122");
call inserir_cliente("000.456.789-56", "Carlos", "Gomes","tavares@gmail.com",'M','1996-07-09',"19191919", 2 ,"84988293122");
-- -----------------------------------------------------

DELIMITER //
CREATE PROCEDURE inserir_parceiro(IN id_cnpj varchar(20), IN nome varchar(60), IN email varchar(200),IN id_numero INT, IN numero VARCHAR(11))
	BEGIN
		INSERT  INTO tb_parceiro VALUES (id_cnpj,nome,email);
        INSERT INTO tb_telefone VALUES (id_numero,numero,id_cpf_cliente,id_cnpj);
	END //
DELIMITER ;

call inserir_parceiro("97.776.3530001","Mercado do Galego","compreAqui@gmail.com",1,"81988175025");

