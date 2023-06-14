
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
INSERT INTO tb_parceiro (id_cnpj, nome, email) VALUES 
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
INSERT INTO tb_telefone (id_numero, numero, id_cpf_cliente) VALUES
    (1, "82212633406", "11122233332"),
    (2, "81353600237", "22233344455"),
    (3, "81301031817", "33344455566"),
    (4, "85612633432", "44455566677"),
    (5, "84320245678", "55566677788"),
    (6, "83212634356", "66677788899"),
    (7, "82210033560", "77788899900"),
    (8, "82216733066", "88899900011"),
    (9, "82989056457", "99900011122"),
    (10, "82212633650", "00011122233");
    
    INSERT INTO tb_telefone (id_numero, numero, id_cnpj) VALUES
    (11, "81353316237", "97.776.3530001"),
    (12, "81353318717", "11.223.3340001"),
    (13, "84324456788", "22.334.4450001"),
    (14, "83212633439", "33.445.5560001"),
    (15, "83212613560", "44.556.6670001"),
    (16, "81999889933", "55.667.7780001"),
    (17, "82999889944", "66.778.8890001"),
    (18, "81299889944", "77.889.9000001"),
    (19, "81976889933", "88.990.0110001"),
    (20, "11999449911", "99.001.1220001");
    
    
-- -----------------------------------------------------
-- Table tb_endereco
-- -----------------------------------------------------
INSERT INTO tb_endereco (logradouro, numero,bairro,uf, cep, cidade,id_cpf_cliente,id_cnpj) VALUES
    ('Rua A', 123,"Centro",'SP', '01234-567', 'São Paulo',"11122233332",null),
    ('Avenida B', 456,"Jardim das Flores", 'RJ', '98765-432', 'Rio de Janeiro',"22233344455",null),
    ('Rua C', 789, "Vila Esperança",'MG', '65432-109', 'Belo Horizonte',"33344455566",null),
    ('Avenida D', 321, "Cidade Nova",'RS', '54321-098', 'Porto Alegre',"44455566677",null),
    ('Rua E', 654, "Parque dos Sonhos",'SC', '87654-321', 'Florianópolis',"55566677788",null),
    ('Avenida F', 987,"Alto da Colina", 'BA', '21098-765', 'Salvador',"66677788899",null),
    ('Rua G', 654, "Bosque das Árvores",'CE', '54321-876', 'Fortaleza',"77788899900",null),
    ('Avenida H', 321, "Lagoa Azul",'PR', '89076-543', 'Curitiba',"88899900011",null),
    ('Rua I', 852, "Vila Harmonia",'PE', '12345-678', 'Recife',"99900011122",null),
    ('Avenida J', 963, "Nova Esperança",'GO', '87654-321', 'Goiânia',"00011122233",null);
    
    
    INSERT INTO tb_endereco (logradouro, numero,bairro, uf, cep, cidade,id_cnpj) VALUES
    ('Rua dos Exemplos', 123,"Jardim Primavera", 'SP', '01234-567', 'São Paulo',"97.776.3530001"),
    ('Avenida das Amostras', 456,"Residencial Sol Nascente", 'RJ', '98765-432', 'Rio de Janeiro',"11.223.3340001"),
    ('Travessa dos Testes', 789, "Praia Bela",'MG', '65432-109', 'Belo Horizonte',"22.334.4450001"),
    ('Avenida dos Resultados', 321, "Campo Verde",'RS', '54321-098', 'Porto Alegre',"33.445.5560001"),
    ('Rua das Variáveis', 654,"Água Limpa", 'SC', '87654-321', 'Florianópolis',"44.556.6670001"),
    ('Avenida das Funções', 987,"Vila Rica", 'BA', '21098-765', 'Salvador',"55.667.7780001"),
    ('Rua das Classes', 654,"Jardim dos Lagos", 'CE', '54321-876', 'Fortaleza',"66.778.8890001"),
    ('Avenida dos Objetos', 321,"Santa Rosa", 'PR', '89076-543', 'Curitiba',"77.889.9000001"),
    ('Rua dos Métodos', 852, "Vale Encantado",'PE', '12345-678', 'Recife',"88.990.0110001"),
    ('Avenida das Estruturas', 963,"Alto da Conquista", 'GO', '87654-321', 'Goiânia',"99.001.1220001");


-- -----------------------------------------------------
-- Table tb_pagamento
-- -----------------------------------------------------
INSERT INTO tb_pagamento (id_pagamento,id_pedido,data_hr_pagamento,tipo_pagamento,valor_total_pago) VALUES
	(1,1, '2023-07-09 09:25:00', "pix",0),
    (2,2, '2023-07-10 11:25:00', "credito",0),
    (3,3, '2023-07-11 09:00:00', "pix",0),
    (4,4, '2023-07-12 08:30:00', "debito",0),
    (5,5, '2023-07-13 12:10:00',"debito",0 ),
    (6,6, '2023-07-14 10:15:00', "credito",0),
    (7,7, '2023-07-15 14:20:00', "pix",0),
    (8,8, '2023-07-16 11:50:00', "pix",0),
    (9,9, '2023-07-17 09:40:00', "pix",0),
    (10,10,'2023-07-18 13:20:00', "credito",0);

-- -----------------------------------------------------
-- Table tb_pedido
-- -----------------------------------------------------

INSERT INTO tb_pedido (id_pedido, data_hr_pedido, data_hr_retirada, data_hr_disp_retirada,id_cpf_cliente, valor_total_pedido)
VALUES
    ( 1,'2023-07-09 09:25:00', '2023-07-10 11:40:00', '2023-07-09 10:08:00',"99900011122", 0),
    ( 2,'2023-07-10 11:25:00', null, null,"11122233332", 0),
    ( 3,'2023-07-11 09:00:00', '2023-07-11 13:00:00', '2023-07-11 10:30:00',"11122233332", 0),
    ( 4,'2023-07-12 08:30:00', '2023-07-12 10:45:00', '2023-07-12 09:15:00',"22233344455", 0),
    ( 5,'2023-07-13 12:10:00', null, '2023-07-13 13:00:00',"33344455566", 0),
    ( 6,'2023-07-14 10:15:00', '2023-07-14 12:30:00', '2023-07-14 11:00:00',"44455566677", 0),
    ( 7,'2023-07-15 14:20:00', '2023-07-15 16:45:00', '2023-07-15 15:30:00',"55566677788", 0),
    ( 8,'2023-07-16 11:50:00', null, null,"66677788899", 0),
    ( 9,'2023-07-17 09:40:00', '2023-07-17 11:55:00', '2023-07-17 10:25:00',"77788899900", 0),
    (10,'2023-07-18 13:20:00', null, '2023-07-18 14:00:00',"88899900011",0);


-- -----------------------------------------------------
-- Table tb_produto
-- -----------------------------------------------------

INSERT INTO tb_produto (id_produto, valor_produto, descricao_produto, qtd_max_venda, qtd_total, id_cnpj, data_validade)
VALUES (1, 5.0, "Feijão Turquesa 1kg", 20, 400, "97.776.3530001", '2023-05-31'),(11, 3.50, "Biscoito Bono 150g", 20, 10, "97.776.3530001", '2023-07-15'),
(12, 4.0, "Macarrão Fitarela 1kg", 20, 5, "97.776.3530001", '2023-07-09'),(13, 3.80, "Açuca Cristal 1kg", 20, 15, "97.776.3530001", '2023-07-20'),
(14, 2.0, "Arroz Emoções 1kg", 20, 30, "97.776.3530001", '2023-07-08'),(15, 3.20, "Leite Itambé 120g", 20, 50, "97.776.3530001", '2023-07-10');

INSERT INTO tb_produto (id_produto, valor_produto, descricao_produto, qtd_max_venda, qtd_total, id_cnpj, data_validade)
VALUES (2, 2.0, "Arroz Tropero 1kg", null, 500, "99.001.1220001", '2023-06-29'),(16, 3.50, "Milho Pipoca Dona Clara 500g", null, 30, "99.001.1220001", '2023-07-25'),
(17, 1.0, "Creme de Leita Italac 120g", 30, 50, "99.001.1220001", '2023-08-01'),(18,2.80, "Mistura Lacta Condensada Moça 396g", null, 26, "99.001.1220001", '2023-07-14'),
(19, 2.15, "Sardinha Coqueiro 125g", null, 30, "99.001.1220001", '2023-07-05'),(20, 3.20, "Leite Itambé 120g", null, 50, "99.001.1220001", '2023-07-10');

INSERT INTO tb_produto (id_produto, valor_produto, descricao_produto, qtd_max_venda, qtd_total, id_cnpj, data_validade)
VALUES (3, 3.5, "Macarrão Vitarela 1kg", 30, 300, "11.223.3340001", '2023-06-15'),(21, 1.30, "Leite de Coco 200ml", 30, 60, "11.223.3340001", '2023-08-25'),
(22, 12, "Azeite Andorinha 500ml", 30, 100, "11.223.3340001", '2023-08-17'),(23,2.80, "Margarina Delline 1kg", 30, 80, "11.223.3340001", '2023-08-22'),
(24, 12, "Achocolatado Nescal 1.2gk", 30, 70, "11.223.3340001", '2023-06-28'),(25, 3.20, "Óleo de Soja 900ml", 30, 90, "11.223.3340001", '2023-08-30');

INSERT INTO tb_produto (id_produto, valor_produto, descricao_produto, qtd_max_venda, qtd_total, id_cnpj, data_validade)
VALUES (4, 1.5, "Sal Terra", 10, 200, "22.334.4450001", '2023-06-10'),(61, 1.30, "Leite de Coco 200ml", 10, 60, "22.334.4450001", '2023-08-25'),
(62, 12, "Azeite Andorinha 500ml", 10, 100, "22.334.4450001", '2023-08-17'),(63,2.80, "Margarina Delline 1kg", 10, 80, "22.334.4450001", '2023-08-22'),
(64, 12, "Achocolatado Nescal 1.2gk", 10, 70, "22.334.4450001", '2023-06-28'),(65, 3.20, "Óleo de Soja 900ml", 10, 90, "22.334.4450001", '2023-08-30');

INSERT INTO tb_produto (id_produto, valor_produto, descricao_produto, qtd_max_venda, qtd_total, id_cnpj, data_validade)
VALUES (5, 8.99, "carne picanha", null, 50, "33.445.5560001", '2023-06-05'),(26, 5.50, "Sabonete Lux", null, 150, "33.445.5560001", '2023-09-10'),
(27, 2.80, "Pasta de Dente Colgate", null, 100, "33.445.5560001", '2023-10-15'),(28, 7.90, "Shampoo Pantene", null, 80, "33.445.5560001", '2023-09-20'),
(29, 3.50, "Condicionador Seda", null, 90, "33.445.5560001", '2023-09-25'),(30, 4.20, "Desodorante Rexona", null, 120, "33.445.5560001", '2023-10-05');

INSERT INTO tb_produto (id_produto, valor_produto, descricao_produto, qtd_max_venda, qtd_total, id_cnpj, data_validade)
VALUES (6, 2.5, "leite", 15, 250, "44.556.6670001", '2023-06-20'),(36, 2.99, "Café em Pó 250g", 15, 100, "44.556.6670001", '2023-09-10'),
(37, 1.50, "Macarrão Instantâneo", 15, 150, "44.556.6670001", '2023-09-15'),(38, 3.99, "Biscoito Cream Cracker", 15, 80, "44.556.6670001", '2023-09-20'),
(39, 5.99, "Leite Integral 1L", 15, 120, "44.556.6670001", '2023-09-25'),(40, 4.50, "Suco em Pó", 15, 90, "44.556.6670001", '2023-09-30');

INSERT INTO tb_produto (id_produto, valor_produto, descricao_produto, qtd_max_venda, qtd_total, id_cnpj, data_validade)
VALUES (7, 3.0, "Creme de Leite Nestle 200ml", 30, 600, "55.667.7780001", '2023-06-18'),(41, 1.99, "Biscoito de Chocolate 200g", 30, 150, "55.667.7780001", '2023-09-10'),
(42, 2.50, "Refrigerante de Cola 500ml", 30, 100, "55.667.7780001", '2023-09-15'),(43, 0.99, "Sabonete em Barra 90g", 30, 200, "55.667.7780001", '2023-09-20'),
(44, 4.99, "Café em Pó 500g", 30, 120, "55.667.7780001", '2023-09-25'),(45, 2.20, "Leite em Pó 400g", 30, 180, "55.667.7780001", '2023-09-30');

INSERT INTO tb_produto (id_produto, valor_produto, descricao_produto, qtd_max_venda, qtd_total, id_cnpj, data_validade)
VALUES (8, 6.5, "refrigerante fanta uva 2L", 20, 40, "66.778.8890001", '2023-06-25'),(46, 1.99, "Bolacha de Água e Sal 200g", 20, 150, "66.778.8890001", '2023-09-10'),
(47, 2.50, "Refrigerante de Guaraná 500ml", 20, 100, "66.778.8890001", '2023-09-15'),(48, 1.50, "Sabonete Líquido 250ml", 20, 200, "66.778.8890001", '2023-09-20'),
(49, 4.99, "Café Solúvel 200g", 20, 120, "66.778.8890001", '2023-09-25'),(50, 3.20, "Leite Condensado 395g", 20, 180, "66.778.8890001", '2023-09-30');

INSERT INTO tb_produto (id_produto, valor_produto, descricao_produto, qtd_max_venda, qtd_total, id_cnpj, data_validade)
VALUES (9, 4.99, "Sabonete Dove 90g ", null, 30, "77.889.9000001", '2023-06-30'),(51, 1.99, "Biscoito Cream Cracker 200g", null, 150, "11.223.3340001", '2023-09-10'),
(52, 2.50, "Refrigerante de Limão 500ml", null, 100, "22.334.4450001", '2023-09-15'),(53, 0.99, "Sabonete em Barra 75g", null, 200, "33.445.5560001", '2023-09-20'),
(54, 4.99, "Café em Cápsulas 10 unidades",null , 120, "44.556.6670001", '2023-09-25'),(55, 2.20, "Leite em Pó Desnatado 400g", null, 180, "55.667.7780001", '2023-09-30');

INSERT INTO tb_produto (id_produto, valor_produto, descricao_produto, qtd_max_venda, qtd_total, id_cnpj, data_validade)
VALUES (10, 7.0, "Shampoo Dex 300ml", null, 150, "88.990.0110001", '2023-06-28'),(56, 7.0, "Shampoo Dex 300ml", null, 150, "88.990.0110001", '2023-06-28'),
    (57, 12.5, "Condicionador Suave 200ml", null, 80, "88.990.0110001", '2023-07-15'),(58, 2.99, "Sabonete em Barra 90g", null, 200, "88.990.011000", '2023-08-10'),
    (59, 3.75, "Creme Dental Fresh 50g", null, 250, "88.990.0110001", '2023-09-05'),(60, 5.25, "Desodorante Roll-on 50ml", null, 180, "88.990.0110001", '2023-10-20');

-- -----------------------------------------------------
-- Table tb_itens_pedido
-- -----------------------------------------------------

INSERT INTO tb_itens_pedido (id_pedido, id_produto, qtd_itens)
VALUES
    (1, 1, 8),
    (1, 11, 5),
    (2, 17, 5),
    (3, 3, 12),
    (3, 22, 6),
    (4, 63, 10),
    (5, 28, 9),
    (6, 6, 11),
    (6, 37, 7),
    (7, 10, 14),
    (7, 41, 8),
    (7, 44, 10),
    (7, 7, 5),
    (8, 8, 12),
    (8, 47, 6),
    (8, 50, 15),
    (8, 49, 9),
    (9, 53, 3),
    (9, 55, 7),
    (10, 58, 14);

INSERT INTO tb_itens_pedido (id_pedido, id_produto, qtd_itens) VALUES (1, 1, 8);
INSERT INTO tb_itens_pedido (id_pedido, id_produto, qtd_itens) VALUES (1, 11, 10);
