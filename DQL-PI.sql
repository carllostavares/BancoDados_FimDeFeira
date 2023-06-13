-- Scripts : Alterar as Estruturas das Tabelas (DDL)
 
ALTER TABLE tb_endereco ADD COLUMN referencia VARCHAR(100); 

ALTER TABLE tb_cliente
MODIFY COLUMN sobrenome VARCHAR(50) NOT NULL;

ALTER TABLE tb_pagamento
ADD COLUMN tipo_de_cartao VARCHAR(50) AFTER tipo_pagamento;

ALTER TABLE tb_produto
MODIFY COLUMN qtd_max_venda INT NOT NULL;

ALTER TABLE tb_parceiro ADD COLUMN pontuacao INT; 


-- script para destruir (DDL) todas as tabelas, views, procedimentos, funções e dependências do seu banco de dados;
 
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

-- Drop tables
DROP TABLE IF EXISTS tb_itens_pedido;
DROP TABLE IF EXISTS tb_pedido;
DROP TABLE IF EXISTS tb_pagamento;
DROP TABLE IF EXISTS tb_produto;
DROP TABLE IF EXISTS tb_endereco;
DROP TABLE IF EXISTS tb_telefone;
DROP TABLE IF EXISTS tb_cliente;
DROP TABLE IF EXISTS tb_parceiro;

-- Drop views, procedures, functions (if applicable):

-- DROP VIEW IF EXISTS view_name;

-- DROP PROCEDURE IF EXISTS procedure_name;

-- DROP FUNCTION IF EXISTS function_name;


-- CREATE TRIGGER

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


