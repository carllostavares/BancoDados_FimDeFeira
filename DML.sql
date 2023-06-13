
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
INSERT INTO tb_pedido VALUES (1,'2023-07-09','2023-07-10','2023-07-09',1,"000.456.789-56",0);
INSERT INTO tb_pedido VALUES (2,'2023-07-10','2023-07-10','2023-07-11',2,"123.456.789-56",0);

-- -----------------------------------------------------
-- Table tb_produto
-- -----------------------------------------------------

INSERT INTO tb_produto (id_produto, valor_produto, descricao_produto, qtd_max_venda, qtd_total, id_cnpj, data_validade)
VALUES (1, 5.0, "Feijão Turquesa 1kg", 20, 400, "97.776.3530001", '2023-05-31'),(11, 3.50, "Biscoito Bono 150g", 20, 10, "97.776.3530001", '2023-07-15'),
(12, 4.0, "Macarrão Fitarela 1kg", 20, 5, "97.776.3530001", '2023-07-09'),(13, 3.80, "Açuca Cristal 1kg", 20, 15, "97.776.3530001", '2023-07-20'),
(14, 2.0, "Arroz Emoções 1kg", 20, 30, "97.776.3530001", '2023-07-08'),(15, 3.20, "Leite Itambé 120g", 20, 50, "97.776.3530001", '2023-07-10');

INSERT INTO tb_produto (id_produto, valor_produto, descricao_produto, qtd_max_venda, qtd_total, id_cnpj, data_validade)
VALUES (2, 2.0, "Arroz Tropero 1kg", 30, 500, "99.001.1220001", '2023-06-29'),(16, 3.50, "Milho Pipoca Dona Clara 500g", 30, 30, "99.001.1220001", '2023-07-25'),
(17, 1.0, "Creme de Leita Italac 120g", 30, 50, "99.001.1220001", '2023-08-01'),(18,2.80, "Mistura Lacta Condensada Moça 396g", 30, 26, "99.001.1220001", '2023-07-14'),
(19, 2.15, "Sardinha Coqueiro 125g", 20, 30, "99.001.1220001", '2023-07-05'),(20, 3.20, "Leite Itambé 120g", 20, 50, "99.001.1220001", '2023-07-10');

INSERT INTO tb_produto (id_produto, valor_produto, descricao_produto, qtd_max_venda, qtd_total, id_cnpj, data_validade)
VALUES (3, 3.5, "Macarrão Vitarela 1kg", 30, 300, "11.223.3340001", '2023-06-15'),(21, 1.30, "Leite de Coco 200ml", 30, 60, "11.223.3340001", '2023-08-25'),
(22, 12, "Azeite Andorinha 500ml", 30, 100, "11.223.3340001", '2023-08-17'),(23,2.80, "Margarina Delline 1kg", 30, 80, "11.223.3340001", '2023-08-22'),
(24, 12, "Achocolatado Nescal 1.2gk", 30, 70, "11.223.3340001", '2023-06-28'),(25, 3.20, "Óleo de Soja 900ml", 30, 90, "11.223.3340001", '2023-08-30');


INSERT INTO tb_produto (id_produto, valor_produto, descricao_produto, qtd_max_venda, qtd_total, id_cnpj, data_validade)
VALUES (4, 1.5, "Sal Terra", 10, 200, "22.334.4450001", '2023-06-10'),(21, 1.30, "Leite de Coco 200ml", 30, 60, "22.334.4450001", '2023-08-25'),
(22, 12, "Azeite Andorinha 500ml", 30, 100, "22.334.4450001", '2023-08-17'),(23,2.80, "Margarina Delline 1kg", 30, 80, "22.334.4450001", '2023-08-22'),
(24, 12, "Achocolatado Nescal 1.2gk", 30, 70, "22.334.4450001", '2023-06-28'),(25, 3.20, "Óleo de Soja 900ml", 30, 90, "22.334.4450001", '2023-08-30');

INSERT INTO tb_produto (id_produto, valor_produto, descricao_produto, qtd_max_venda, qtd_total, id_cnpj, data_validade)
VALUES (5, 8.99, "carne picanha", 10, 50, "33.445.5560001", '2023-06-05'),(26, 5.50, "Sabonete Lux", 10, 150, "33.445.5560001", '2023-09-10'),
(27, 2.80, "Pasta de Dente Colgate", 10, 100, "33.445.5560001", '2023-10-15'),(28, 7.90, "Shampoo Pantene", 10, 80, "33.445.5560001", '2023-09-20'),
(29, 3.50, "Condicionador Seda", 10, 90, "33.445.5560001", '2023-09-25'),(30, 4.20, "Desodorante Rexona", 10, 120, "33.445.5560001", '2023-10-05');

INSERT INTO tb_produto (id_produto, valor_produto, descricao_produto, qtd_max_venda, qtd_total, id_cnpj, data_validade)
VALUES (6, 2.5, "leite", 15, 250, "44.556.6670001", '2023-06-20'),(36, 2.99, "Café em Pó 250g", 15, 100, "44.556.6670001", '2023-09-10'),
(37, 1.50, "Macarrão Instantâneo", 15, 150, "44.556.6670001", '2023-09-15'),(38, 3.99, "Biscoito Cream Cracker", 15, 80, "44.556.6670001", '2023-09-20'),
(39, 5.99, "Leite Integral 1L", 15, 120, "44.556.6670001", '2023-09-25'),(40, 4.50, "Suco em Pó", 15, 90, "44.556.6670001", '2023-09-30');

INSERT INTO tb_produto (id_produto, valor_produto, descricao_produto, qtd_max_venda, qtd_total, id_cnpj, data_validade)
VALUES (40, 3.0, "Creme de Leite Nestle 200ml", 30, 600, "55.667.7780001", '2023-06-18'),(41, 1.99, "Biscoito de Chocolate 200g", 20, 150, "55.667.7780001", '2023-09-10'),
(42, 2.50, "Refrigerante de Cola 500ml", 15, 100, "55.667.7780001", '2023-09-15'),(43, 0.99, "Sabonete em Barra 90g", 30, 200, "55.667.7780001", '2023-09-20'),
(44, 4.99, "Café em Pó 500g", 30, 120, "55.667.7780001", '2023-09-25'),(45, 2.20, "Leite em Pó 400g", 25, 180, "55.667.7780001", '2023-09-30');

INSERT INTO tb_produto (id_produto, valor_produto, descricao_produto, qtd_max_venda, qtd_total, id_cnpj, data_validade)
VALUES (8, 6.5, "refrigerante fanta uva 2L", 20, 40, "66.778.8890001", '2023-06-25'),(46, 1.99, "Bolacha de Água e Sal 200g", 25, 150, "66.778.8890001", '2023-09-10'),
(47, 2.50, "Refrigerante de Guaraná 500ml", 15, 100, "66.778.8890001", '2023-09-15'),(48, 1.50, "Sabonete Líquido 250ml", 30, 200, "66.778.8890001", '2023-09-20'),
(49, 4.99, "Café Solúvel 200g", 30, 120, "66.778.8890001", '2023-09-25'),(50, 3.20, "Leite Condensado 395g", 20, 180, "66.778.8890001", '2023-09-30');

INSERT INTO tb_produto (id_produto, valor_produto, descricao_produto, qtd_max_venda, qtd_total, id_cnpj, data_validade)
VALUES (50, 4.99, "Sabonete Dove 90g ", 25, 30, "77.889.9000001", '2023-06-30'),(71, 1.99, "Biscoito Cream Cracker 200g", 20, 150, "11.223.3340001", '2023-09-10'),
(72, 2.50, "Refrigerante de Limão 500ml", 15, 100, "22.334.4450001", '2023-09-15'),(73, 0.99, "Sabonete em Barra 75g", 30, 200, "33.445.5560001", '2023-09-20'),
(74, 4.99, "Café em Cápsulas 10 unidades", 30, 120, "44.556.6670001", '2023-09-25'),(75, 2.20, "Leite em Pó Desnatado 400g", 25, 180, "55.667.7780001", '2023-09-30');

INSERT INTO tb_produto (id_produto, valor_produto, descricao_produto, qtd_max_venda, qtd_total, id_cnpj, data_validade)
VALUES (10, 7.0, "shampoo", 15, 150, "88.990.0110001", '2023-06-28');

-- -----------------------------------------------------
-- Table tb_itens_pedido
-- -----------------------------------------------------
INSERT INTO tb_itens_pedido values (1,1,100,20.00);
INSERT INTO tb_itens_pedido values (2,3,100,20.00);