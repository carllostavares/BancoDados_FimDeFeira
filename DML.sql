
-- -----------------------------------------------------
-- Table tb_cliente
-- -----------------------------------------------------
INSERT INTO tb_cliente (id_cpf_cliente, nome, sobrenome, email, sexo, data_nasc, senha) VALUES 
    ("11122233332", "Carlos", "Tavares", "carlos@.com.br", "M", '1996-10-02', 78462346),
    ("22233344455", "Maria", "Silva", "maria@.com.br", "F", '1990-05-15', 98765432),
    ("33344455566", "João", "Santos", "joao@.com.br", "M", '1985-12-30', 12345678),
    ("44455566677", "Ana", "Costa", "ana@.com.br", "F", '1998-07-18', 87654321),
    ("55566677788", "Pedro", "Oliveira", "pedro@.com.br", "M", '1992-03-25', 56789123),
    ("66677788899", "Sofia", "Rodrigues", "sofia@.com.br", "F", '1994-09-05', 43218765),
    ("77788899900", "Luís", "Ferreira", "luis@.com.br", "M", '1988-11-12', 21987654),
    ("88899900011", "Mariana", "Gomes", "mariana@.com.br", "F", '1991-06-20', 65432198),
    ("99900011122", "Rafael", "Almeida", "rafael@.com.br", "M", '1997-04-08', 34567891),
    ("00011122233", "Camila", "Pereira", "camila@.com.br", "F", '1993-08-14', 98765431);

-- -----------------------------------------------------
-- Table tb_parceiro
-- -----------------------------------------------------
INSERT INTO tb_parceiro (cnpj_parceiro, nome_parceiro, email_parceiro) VALUES 
    ("97.776.3530001", "Mercado Bom Preço", "juca.123@meq.com.br"),
    ("11.223.3340001", "Mercado da Maria", "maria.loja@mail.com"),
    ("22.334.4450001", "Supermercado do João", "joao.supermercado@mail.com"),
    ("33.445.5560001", "Padaria da Ana", "ana.padaria@mail.com"),
    ("44.556.6670001", "Eletro Top Shop", "eletros@mail.com"),
    ("55.667.7780001", "Restaurante Saboroso", "contato@saboroso.com"),
    ("66.778.8890001", "Mercado São de Deus", "saodedeus@mail.com"),
    ("77.889.9000001", "Alimentos+", "alimentos+@mail.com"),
    ("88.990.0110001", "Max Atacado", "maxatacadoo@hohhtmail.com"),
    ("99.001.1220001", "Mercado Glamour", "contato@glamour.com");


-- -----------------------------------------------------
-- Table tb_telefone
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table tb_endereco
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table tb_pagamento
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table tb_pedido
-- -----------------------------------------------------
INSERT INTO tb_pedido VALUES (1,'2023-07-09','2023-07-10','2023-07-09',1,"000.456.789-56");
INSERT INTO tb_pedido VALUES (2,'2023-07-10','2023-07-10','2023-07-11',2,"123.456.789-56");

-- -----------------------------------------------------
-- Table tb_produto
-- -----------------------------------------------------

INSERT INTO tb_produto (id_produto, valor_produto, descricao_produto, qtd_max_venda, qtd_total, id_cnpj, data_validade)
VALUES (1, 5.0, "feijão", 20, 400, "97.776.3530001", '2023-05-31');

INSERT INTO tb_produto (id_produto, valor_produto, descricao_produto, qtd_max_venda, qtd_total, id_cnpj, data_validade)
VALUES (2, 2.0, "arroz", 20, 500, "99.001.1220001", '2023-05-29');

INSERT INTO tb_produto (id_produto, valor_produto, descricao_produto, qtd_max_venda, qtd_total, id_cnpj, data_validade)
VALUES (3, 3.5, "macarrão", 15, 300, "11.223.3340001", '2023-06-15');

INSERT INTO tb_produto (id_produto, valor_produto, descricao_produto, qtd_max_venda, qtd_total, id_cnpj, data_validade)
VALUES (4, 1.5, "sal", 10, 200, "22.334.4450001", '2023-06-10');

INSERT INTO tb_produto (id_produto, valor_produto, descricao_produto, qtd_max_venda, qtd_total, id_cnpj, data_validade)
VALUES (5, 8.99, "carne", 10, 50, "33.445.5560001", '2023-06-05');

INSERT INTO tb_produto (id_produto, valor_produto, descricao_produto, qtd_max_venda, qtd_total, id_cnpj, data_validade)
VALUES (6, 2.5, "leite", 15, 250, "44.556.6670001", '2023-06-20');

INSERT INTO tb_produto (id_produto, valor_produto, descricao_produto, qtd_max_venda, qtd_total, id_cnpj, data_validade)
VALUES (7, 3.0, "pão", 30, 600, "55.667.7780001", '2023-06-18');

INSERT INTO tb_produto (id_produto, valor_produto, descricao_produto, qtd_max_venda, qtd_total, id_cnpj, data_validade)
VALUES (8, 6.5, "refrigerante", 20, 400, "66.778.8890001", '2023-06-25');

INSERT INTO tb_produto (id_produto, valor_produto, descricao_produto, qtd_max_venda, qtd_total, id_cnpj, data_validade)
VALUES (9, 4.99, "sabonete", 25, 300, "77.889.9000001", '2023-06-30');

INSERT INTO tb_produto (id_produto, valor_produto, descricao_produto, qtd_max_venda, qtd_total, id_cnpj, data_validade)
VALUES (10, 7.0, "shampoo", 15, 150, "88.990.0110001", '2023-06-28');

-- -----------------------------------------------------
-- Table tb_itens_pedido
-- -----------------------------------------------------
INSERT INTO tb_itens_pedido values (1,1,100,20.00);
INSERT INTO tb_itens_pedido values (2,3,100,20.00);