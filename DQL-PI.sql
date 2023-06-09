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







