

INSERT INTO tb_itens_pedido values (1,1,100);
INSERT INTO tb_itens_pedido values (2,2,200);
insert into tb_pagamento values (1,"pix",0,'2023-06-12');

SELECT * FROM tb_pedido;
select * from tb_cliente;
select * from tb_parceiro;
select * from tb_produto;
select * from tb_telefone;
select * from tb_pagamento;
SELECT * from  tb_itens_pedido order by id_pedido ;
select * from tb_endereco;

    
DELETE from  tb_itens_pedido where id_produto = 1;
DELETE from  tb_itens_pedido;
delete from tb_pagamento;
delete  from tb_telefone;
delete  from tb_produto;
delete  from tb_cliente;
delete  from tb_pedido;
delete from tb_parceiro;
delete from tb_endereco;
delete  from tb_cliente where nome = "Joao Carlos" ;



UPDATE tb_itens_pedido
JOIN tb_produto ON tb_itens_pedido.id_produto = tb_produto.id_produto
SET valor_total_itens = tb_itens_pedido.qtd_itens * tb_produto.valor_produto;


SELECT 
	valor_produto,
    qtd_total As "Quantidade Restante",
    (qtd_total * valor_produto)* 0.5 AS "Varlor Total"
FROM tb_produto;


DROP TRIGGER IF EXISTS `fim_de_feira`.`trg_retonando_qtd_produto`;

DELIMITER $$
CREATE DEFINER = CURRENT_USER TRIGGER `trg_retonando_qtd_produto` BEFORE DELETE ON `tb_itens_pedido` FOR EACH ROW
BEGIN

DECLARE valor_inserido INT;
  
  SET valor_inserido = OLD.qtd_itens;
  
  UPDATE tb_produto
  SET qtd_total = qtd_total + valor_inserido;
END$$
DELIMITER ;

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
 -- Motre os 5 pedidos com maior valor
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

-- Mostre todo os produtos que foram vendidos com a daataa de validade entre '2023-08-01' e '2023-09-01'.
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
INSERT INTO tb_itens_pedido values (1,1,100);
INSERT INTO tb_itens_pedido values (2,2,200);
insert into tb_pagamento values (1,"pix",0,'2023-06-12');

SELECT * FROM tb_pedido;
select * from tb_cliente;
select * from tb_parceiro;
select * from tb_produto;
select * from tb_telefone;
select * from tb_pagamento;
SELECT * from  tb_itens_pedido order by id_pedido ;
select * from tb_endereco;

    
DELETE from  tb_itens_pedido where id_produto = 1;
DELETE from  tb_itens_pedido;
delete from tb_pagamento;
delete  from tb_telefone;
delete  from tb_produto;
delete  from tb_cliente;
delete  from tb_pedido;
delete from tb_parceiro;
delete from tb_endereco;
delete  from tb_cliente where nome = "Joao Carlos" ;



UPDATE tb_itens_pedido
JOIN tb_produto ON tb_itens_pedido.id_produto = tb_produto.id_produto
SET valor_total_itens = tb_itens_pedido.qtd_itens * tb_produto.valor_produto;


SELECT 
	valor_produto,
    qtd_total As "Quantidade Restante",
    (qtd_total * valor_produto)* 0.5 AS "Varlor Total"
FROM tb_produto;


DROP TRIGGER IF EXISTS `fim_de_feira`.`trg_retonando_qtd_produto`;

DELIMITER $$
CREATE DEFINER = CURRENT_USER TRIGGER `trg_retonando_qtd_produto` BEFORE DELETE ON `tb_itens_pedido` FOR EACH ROW
BEGIN

DECLARE valor_inserido INT;
  
  SET valor_inserido = OLD.qtd_itens;
  
  UPDATE tb_produto
  SET qtd_total = qtd_total + valor_inserido;
END$$
DELIMITER ;

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


