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
-- Views
-- -----------------------------------------------------

-- Quais são os 5 produtos mais comprados pelo clientes? - VIEW 

CREATE VIEW vw_produtosMaisVendidos AS 
SELECT c.id_cpf_cliente, c.nome, itens.qtd_itens, prod.descricao_produto
FROM tb_cliente as c
JOIN tb_pedido as ped ON ped.id_cpf_cliente = c.id_cpf_cliente
JOIN tb_itens_pedido as itens ON itens.id_pedido = ped.id_pedido
JOIN tb_produto as prod ON prod.id_produto = itens.id_produto
ORDER BY itens.qtd_itens desc
LIMIT 5;

SELECT * FROM  vw_produtosMaisVendidos;
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Quais são os produtos que estão em falta no estoque em um determinado parceiro (88.990.0110001)? - VIEW

CREATE VIEW vw_produtoEmFalta AS
SELECT prod.id_produto, prod.descricao_produto, prod.qtd_total, par.id_cnpj
FROM tb_produto as prod
INNER JOIN tb_parceiro as par ON par.id_cnpj = prod.id_cnpj
WHERE par.id_cnpj = '88.990.0110001' AND qtd_total = 0;

SELECT * FROM  vw_produtoEmFalta;

-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Quais os clientes que tem no inicio o DDD 84?
CREATE VIEW vw_telefonesDDD_iguais AS
SELECT  tb_cliente.nome AS Cliente, tb_telefone.numero AS Telefone, tb_endereco.cidade
FROM tb_cliente
JOIN tb_telefone ON tb_telefone.id_cpf_cliente = tb_cliente.id_cpf_cliente
JOIN tb_endereco ON tb_endereco.id_cpf_cliente = tb_cliente.id_cpf_cliente
WHERE tb_telefone.numero LIKE "84%";

SELECT * FROM vw_telefonesDDD_iguais;

-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Quais os pedidos que foram feitos entre os meses 05 e 06 de 2023?
CREATE VIEW vw_pedidoFeitosEntreOsMeses AS
SELECT date(tb_pedido.data_hr_pedido) AS Pedido, tb_pagamento.tipo_pagamento AS 'Tipo Pagamento'
FROM tb_pedido
LEFT JOIN tb_pagamento ON tb_pagamento.id_pagamento = tb_pedido.id_pedido
WHERE month(data_hr_pedido) in(5, 6); 
           
SELECT * FROM  vw_pedidoFeitosEntreOsMeses;
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Quais os parceiros que estão com o estoque abaixo de 50 unidades?

CREATE VIEW vw_podrutodPoucaQt AS
SELECT tb_produto.id_produto as Produto, tb_produto.qtd_total AS "Quantidade em Estoque", tb_parceiro.nome AS Parceiro, tb_telefone.id_cnpj AS Contato
FROM tb_parceiro
JOIN tb_produto ON tb_produto.id_cnpj = tb_parceiro.id_cnpj
JOIN tb_telefone on tb_telefone.id_cnpj = tb_parceiro.id_cnpj
WHERE qtd_total < 50;

SELECT * FROM  vw_pedidoFeitosEntreOsMeses;


-- -----------------------------------------------------
-- SCRIPT JOIN
-- -----------------------------------------------------

-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- O o iten que teva a maior quantidade vendida em um único pedido
SELECT ip.id_pedido , p.descricao_produto 'Descricao Produto', p.valor_produto 'Valor produto', c.nome "Cliete", pa.nome "Parceiro", ip.qtd_itens "Quantidade Produto"
FROM tb_itens_pedido ip
JOIN tb_pedido pe ON pe.id_pedido = ip.id_pedido
JOIN tb_produto p ON p.id_produto = ip.id_produto
JOIN tb_cliente c ON c.id_cpf_cliente = pe.id_cpf_cliente
JOIN tb_parceiro pa ON pa.id_cnpj = p.id_cnpj
GROUP BY ip.id_pedido, p.descricao_produto, p.valor_produto, c.nome, pa.nome, ip.qtd_itens
ORDER BY sum(ip.qtd_itens) DESC limit 1;

-- -------------------------------------------------------------------------------------------------------------------------------------------------
 -- Mostre os 5 pedidos com maior valor
SELECT pe.id_pedido, c.nome AS nome_cliente, pe.valor_total_pedido, pg.tipo_pagamento
FROM tb_pedido pe
JOIN tb_cliente c ON c.id_cpf_cliente = pe.id_cpf_cliente
JOIN tb_pagamento pg ON pg.id_pedido = pe.id_pedido
order by valor_total_pedido desc
LIMIT 5;

-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Mostre o pedido com maior valor
SELECT pe.id_pedido, c.nome AS nome_cliente, pe.valor_total_pedido, pg.tipo_pagamento
FROM tb_pedido pe
JOIN tb_cliente c ON c.id_cpf_cliente = pe.id_cpf_cliente
JOIN tb_pagamento pg ON pg.id_pedido = pe.id_pedido
WHERE pe.valor_total_pedido = (
    SELECT MAX(valor_total_pedido)
    FROM tb_pedido
)
LIMIT 1;

-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Produto com maior data de validade
SELECT p.id_produto, p.descricao_produto, p.valor_produto, p.data_validade, pa.nome AS nome_parceiro
FROM tb_produto p
JOIN tb_parceiro pa ON pa.id_cnpj = p.id_cnpj
WHERE p.data_validade = (
    SELECT MAX(data_validade)
    FROM tb_produto
)
LIMIT 1;

-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Produto com menor data de validade
SELECT p.id_produto, p.descricao_produto, p.valor_produto, p.data_validade, pa.nome AS nome_parceiro
FROM tb_produto p
JOIN tb_parceiro pa ON pa.id_cnpj = p.id_cnpj
WHERE p.data_validade = (
    SELECT min(data_validade)
    FROM tb_produto
)
LIMIT 1;
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Mostre CPF, nome completo, telefone e endereço dos clientes
SELECT c.id_cpf_cliente "CPF", CONCAT( c.nome, ' ', c.sobrenome) AS 'Nome Completo', t.numero "Número Telefone", e.logradouro "Logradouro",e.numero "Número",e.bairro "Bairro", e.cidade "Cidade" , e.cep "CEP", e.uf "UF"
FROM tb_cliente c
JOIN tb_telefone t ON t.id_cpf_cliente = c.id_cpf_cliente
JOIN tb_endereco e ON e.id_cpf_cliente = c.id_cpf_cliente;

-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Produto com a maior quantidade em estoque e nome do estabelecimento
SELECT p.id_produto, p.qtd_total, p.descricao_produto, p.valor_produto, p.data_validade, pa.nome AS nome_parceiro, p.id_cnpj
FROM tb_produto p
JOIN tb_parceiro pa ON pa.id_cnpj = p.id_cnpj
WHERE p.qtd_total = (SELECT MAX(qtd_total) FROM tb_produto);

-- -------------------------------------------------------------------------------------------------------------------------------------------------

-- Mostre todo os produtos que foram vendidos com a data de validade entre '2023-08-01' e '2023-09-01'.
SELECT ip.id_produto "ID Produto", p.data_validade "Data de Validade", pe.data_hr_pedido "Data do Pedido", p.descricao_produto "descricao do Produto", p.valor_produto "Valor Produto",
CONCAT( c.nome, ' ', c.sobrenome) AS 'Nome Completo', pa.nome AS "Nome Estabelecimento"
FROM tb_itens_pedido ip
JOIN tb_produto p ON p.id_produto = ip.id_produto
JOIN tb_pedido pe ON pe.id_pedido = ip.id_pedido
JOIN tb_cliente c ON c.id_cpf_cliente = pe.id_cpf_cliente
JOIN tb_parceiro pa ON pa.id_cnpj = p.id_cnpj
WHERE p.data_validade BETWEEN '2023-08-01' AND '2023-09-01';
-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- O dias que mais teve o pedido com mair numero de produtos
SELECT sub.data_hr_pedido "Data do Pedido", ip.id_pedido "ID Pedido", p.data_validade "Data da Validade", sub.data_hr_pedido  "Data do Pedido",
 p.descricao_produto "Descricao do Produto", p.valor_produto "Valor Produto",CONCAT( c.nome, ' ', c.sobrenome) , pa.nome "Nome do Estabelecimento"
FROM tb_itens_pedido ip
JOIN tb_produto p ON p.id_produto = ip.id_produto
JOIN tb_pedido pe ON pe.id_pedido = ip.id_pedido
JOIN tb_cliente c ON c.id_cpf_cliente = pe.id_cpf_cliente
JOIN tb_parceiro pa ON pa.id_cnpj = p.id_cnpj
JOIN (
  SELECT pe.data_hr_pedido
  FROM tb_itens_pedido ip
  JOIN tb_pedido pe ON pe.id_pedido = ip.id_pedido
  GROUP BY pe.data_hr_pedido
  ORDER BY COUNT(ip.id_pedido) DESC
  LIMIT 2
) sub ON sub.data_hr_pedido = pe.data_hr_pedido;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Produtos comprados por um determinado cliente com seus respectivos valores
SELECT c.nome AS "Nome Cliente", c.sobrenome AS "Sobrenome",p.descricao_produto AS "Produto", concat('R$',p.valor_produto) AS "Valor"
FROM tb_cliente c
JOIN tb_pedido pe ON c.id_cpf_cliente = pe.id_cpf_cliente
JOIN tb_itens_pedido ip ON pe.id_pedido = ip.id_pedido
JOIN tb_produto p ON ip.id_produto = p.id_produto
WHERE c.nome = 'Carlos' AND c.sobrenome = 'Tavares';

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Pedidos realizados por um determinado cliente
SELECT c.nome AS "Nome", c.sobrenome "Sobrenome", pe.id_pedido "Num Pedido", pe.data_hr_pedido "Data e Hora", 
concat('R$', pe.valor_total_pedido) "Valor Total"
FROM tb_cliente c
JOIN tb_pedido pe ON c.id_cpf_cliente = pe.id_cpf_cliente
WHERE c.nome = 'Carlos';

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Pedidos realizados para um determinado fornecedor
SELECT pa.nome AS "Fornecedor", count(pe.id_pedido) "Qtde Pedidos", 
concat("R$", pe.valor_total_pedido) "Valores Somados"
FROM tb_parceiro pa
JOIN tb_produto p ON pa.id_cnpj = p.id_cnpj
JOIN tb_itens_pedido ip ON p.id_produto = ip.id_produto
JOIN tb_pedido pe ON ip.id_pedido = pe.id_pedido
GROUP BY pa.nome
ORDER BY count(pe.id_pedido) DESC;

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- Qtde e valor pago por cada método de pagamento
SELECT pg.tipo_pagamento "Tipo de Pagamento", count(pe.id_pedido) "Qtde Pedidos", concat("R$", pe.valor_total_pedido) "Valor Total"
FROM tb_pedido pe
JOIN tb_pagamento pg ON pe.id_pedido = pg.id_pedido
GROUP BY pg.tipo_pagamento;

-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Quais são os produtos que estão em falta no estoque em um determinado parceiro (88.990.0110001)? - JOIN

SELECT prod.id_produto, prod.descricao_produto, prod.qtd_total, par.id_cnpj
FROM tb_produto as prod
INNER JOIN tb_parceiro as par ON par.id_cnpj = prod.id_cnpj
WHERE par.id_cnpj = '88.990.0110001' AND qtd_total = 0;

-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Quais são os 5 produtos mais comprados pelo clientes? - JOIN 

SELECT c.id_cpf_cliente, c.nome, itens.qtd_itens, prod.descricao_produto
FROM tb_cliente as c
JOIN tb_pedido as ped ON ped.id_cpf_cliente = c.id_cpf_cliente
JOIN tb_itens_pedido as itens ON itens.id_pedido = ped.id_pedido
JOIN tb_produto as prod ON prod.id_produto = itens.id_produto
ORDER BY itens.qtd_itens desc
LIMIT 5;

-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Onde está localizado a maioria dos clientes - JOIN 

SELECT c.nome, c.sobrenome, ende.cidade, ende.uf
FROM tb_cliente as c
JOIN tb_endereco as ende ON ende.id_cpf_cliente = c.id_cpf_cliente
ORDER BY ende.uf;

-- -------------------------------------------------------------------------------------------------------------------------------------------------
-- Quais são os produtos comprados por clientes que estão no mesmo estado? - JOIN

SELECT  c.nome, c.sobrenome, ende.uf, prod.descricao_produto, itens.qtd_itens
	FROM tb_cliente as c
        JOIN tb_endereco as ende ON ende.id_cpf_cliente = c.id_cpf_cliente
        JOIN tb_pedido as ped ON ped.id_cpf_cliente = c.id_cpf_cliente
        JOIN tb_itens_pedido as itens ON itens.id_pedido = ped.id_pedido
        JOIN tb_produto as prod ON prod.id_produto = itens.id_produto
        WHERE ende.uf = 'BA'
        ORDER BY itens.qtd_itens desc;
        
        
-- -------------------------------------------------------------------------------------------------------------------------------------------------
--  Quais os clientes que tem no inicio o DDD 84?

SELECT  tb_cliente.nome AS Cliente, tb_telefone.numero AS Telefone, tb_endereco.cidade
	FROM tb_cliente
		JOIN tb_telefone ON tb_telefone.id_cpf_cliente = tb_cliente.id_cpf_cliente
        JOIN tb_endereco ON tb_endereco.id_cpf_cliente = tb_cliente.id_cpf_cliente
			WHERE tb_telefone.numero LIKE "84%";
            
-- -------------------------------------------------------------------------------------------------------------------------------------------------
--  Quais os pedidos que foram feitos entre os meses 05 e 06 de 2023?
	SELECT date(tb_pedido.data_hr_pedido) AS Pedido, tb_pagamento.tipo_pagamento AS 'Tipo Pagamento'
	FROM tb_pedido
		LEFT JOIN tb_pagamento ON tb_pagamento.id_pagamento = tb_pedido.id_pedido
			WHERE month(data_hr_pedido) in(5, 6);
            
-- -------------------------------------------------------------------------------------------------------------------------------------------------
--  Quais os parceiros que estão com o estoque abaixo de 50 unidades?
	SELECT tb_produto.id_produto as Produto, tb_produto.qtd_total AS "Quantidade em Estoque", tb_parceiro.nome AS Parceiro, tb_telefone.id_cnpj AS Contato
	FROM tb_parceiro
		JOIN tb_produto ON tb_produto.id_cnpj = tb_parceiro.id_cnpj
		JOIN tb_telefone on tb_telefone.id_cnpj = tb_parceiro.id_cnpj
			WHERE qtd_total < 50;
	

-- -------------------------------------------------------------------------------------------------------------------------------------------------
--  Qual a quantidade vendida de cada produto?
	SELECT tb_produto.id_produto AS 'ID Produto', tb_produto.descricao_produto AS Nome, tb_itens_pedido.qtd_itens AS 'Quantidade vendida'
		FROM  tb_itens_pedido
		RIGHT JOIN tb_produto ON tb_produto.id_produto = tb_itens_pedido.id_produto;

-- -----------------------------------------------------
-- Funções
-- -----------------------------------------------------

-- obtendo idade dos clientes 

DELIMITER //

CREATE FUNCTION calcularIdadeCliente(data_nascimento DATE)
RETURNS INT
BEGIN
    DECLARE idade INT;
    SET idade = YEAR(CURDATE()) - YEAR(data_nascimento);
    IF MONTH(CURDATE()) < MONTH(data_nascimento) THEN
        SET idade = idade - 1;
    ELSEIF MONTH(CURDATE()) = MONTH(data_nascimento) AND DAY(CURDATE()) < DAY(data_nascimento) THEN
        SET idade = idade - 1;
    END IF;
    RETURN idade;
END //

DELIMITER ;

SELECT nome, calcularIdadeCliente(data_nasc) AS idade FROM tb_cliente;

-- -------------------------------------------------------------------------------------------------
-- obtendo prazo de validade 

DELIMITER //

CREATE FUNCTION calcularDiasRestantesValidade(data_validade DATE)
RETURNS INT
BEGIN
    DECLARE dias_restantes INT;
    SET dias_restantes = DATEDIFF(data_validade, CURDATE());
    RETURN dias_restantes;
END //

DELIMITER ;

SELECT p.id_produto "ID Produto", p.descricao_produto "Nome Produto",
calcularDiasRestantesVAlidade(p.data_validade) " Dias Restantes para o Vencimento"
FROM tb_produto p;

DELIMITER //

CREATE FUNCTION mostraProdutoVencido(data_validade DATE)
RETURNS VARCHAR(5)
BEGIN
    DECLARE dias_restantes INT;
    DECLARE vencido VARCHAR(5);
    
    SET dias_restantes = DATEDIFF(data_validade, CURDATE());
    
    IF dias_restantes < 0 THEN
        SET vencido = 'TRUE';
    ELSE
        SET vencido = 'FALSE';
    END IF;
    
    RETURN vencido;
END //

DELIMITER ;



SELECT id_produto "ID Produto", descricao_produto "Nome do Produto", mostraProdutoVencido(data_validade) "Vencido"
FROM tb_produto;


-- -----------------------------------------------------
-- Drop Function;
-- -----------------------------------------------------
-- Drop da função calcularIdadeCliente
DROP FUNCTION IF EXISTS calcularIdadeCliente;

-- Drop da função calcularDiasRestantesValidade
DROP FUNCTION IF EXISTS calcularDiasRestantesValidade;

-- Drop da função mostraProdutoVencido
DROP FUNCTION IF EXISTS mostraProdutoVencido;


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

-----------------------------------------------------

DELIMITER //

CREATE PROCEDURE adicionarPedido(IN p_id_pedido INT,IN p_data_hr_pedido DATETIME,IN p_data_hr_retirada DATETIME,IN p_data_hr_disp_retirada DATETIME,
IN p_id_cpf_cliente VARCHAR(14),IN p_valor_total_pedido DECIMAL(12,2),IN p_id_produto INT,IN p_qtd_itens INT,IN p_tipo_pagamento ENUM('credito', 'debito', 'pix'),
IN p_valor_total_pago DECIMAL(12,2),IN p_data_hr_pagamento DATETIME
)
BEGIN
    -- Inserir dados na tabela tb_pedido
    INSERT INTO tb_pedido (id_pedido, data_hr_pedido, data_hr_retirada, data_hr_disp_retirada, id_cpf_cliente, valor_total_pedido)
    VALUES (p_id_pedido, p_data_hr_pedido, p_data_hr_retirada, p_data_hr_disp_retirada, p_id_cpf_cliente, p_valor_total_pedido);
    
    -- Inserir dados na tabela tb_itens_pedido
    INSERT INTO tb_itens_pedido (id_produto, id_pedido, qtd_itens)
    VALUES (p_id_produto, p_id_pedido, p_qtd_itens);
    
    -- Inserir dados na tabela tb_pagamento
    INSERT INTO tb_pagamento (id_pagamento, tipo_pagamento, valor_total_pago, data_hr_pagamento, id_pedido) 
    VALUES (p_id_pedido, p_tipo_pagamento, p_valor_total_pago, p_data_hr_pagamento, p_id_pedido);
    
END //

DELIMITER ;


CALL adicionarPedido(
    1,
    '2023-06-19 09:00:00',
    NULL,
    NULL,
    "11122233332",
    0,
    1,
    5,
    'credito',
    0,
    '2023-06-19 09:30:00'
);


-- -----------------------------------------------------
-- DROP PROCEDURE
-- ----------------------------------------------------

-- Drop da procedure inserir_cliente
DROP PROCEDURE IF EXISTS inserir_cliente;

-- Drop da procedure inserir_parceiro
DROP PROCEDURE IF EXISTS inserir_parceiro;

-- Drop da procedure adicionarPedido
DROP PROCEDURE IF EXISTS adicionarPedido;
