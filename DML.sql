
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
INSERT INTO tb_telefone (id_numero, numero, id_cpf_cliente) VALUES
    (1, "1111111111", "11122233332"),
    (2, "2222222222", "22233344455"),
    (3, "3333333333", "33344455566"),
    (4, "4444444444", "44455566677"),
    (5, "5555555555", "55566677788"),
    (6, "6666666666", "66677788899"),
    (7, "7777777777", "77788899900"),
    (8, "8888888888", "88899900011"),
    (9, "9999999999", "99900011122"),
    (10, "0000000000", "00011122233");
    
    INSERT INTO tb_telefone (id_numero, numero, id_cnpj) VALUES
    (11, "4411111177", "97.776.3530001"),
    (12, "4422222279", "11.223.3340001"),
    (13, "4433333336", "22.334.4450001"),
    (14, "5544444443", "33.445.5560001"),
    (15, "44555555552", "44.556.6670001"),
    (16, "44666666669", "55.667.7780001"),
    (17, "44777777770", "66.778.8890001"),
    (18, "4488888887", "77.889.9000001"),
    (19, "4499999934", "88.990.0110001"),
    (20, "4400000023", "99.001.1220001");
    
    
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

-- -----------------------------------------------------
-- Table tb_pedido
-- -----------------------------------------------------

INSERT INTO tb_pedido (id_pedido, data_hr_pedido, data_hr_retirada, data_hr_disp_retirada, id_pagamento, id_cpf_cliente, valor_total_pedido)
VALUES
    (1, '2023-07-09 09:25:00', '2023-07-10 11:40:00', '2023-07-09 10:08:00', 1,"99900011122", 0),
    (2, '2023-07-10 11:25:00', '2023-07-10 13:40:00', '2023-07-11 12:00:00', 2,"11122233332", 0),
    (3, '2023-07-11 09:00:00', '2023-07-11 13:00:00', '2023-07-11 10:30:00', 3,"11122233332", 0),
    (4, '2023-07-12 08:30:00', '2023-07-12 10:45:00', '2023-07-12 09:15:00', 4,"22233344455", 0),
    (5, '2023-07-13 12:10:00', '2023-07-13 14:30:00', '2023-07-13 13:00:00', 5,"33344455566", 0),
    (6, '2023-07-14 10:15:00', '2023-07-14 12:30:00', '2023-07-14 11:00:00', 6,"44455566677", 0),
    (7, '2023-07-15 14:20:00', '2023-07-15 16:45:00', '2023-07-15 15:30:00', 7,"55566677788", 0),
    (8, '2023-07-16 11:50:00', '2023-07-16 13:15:00', '2023-07-16 12:30:00', 8,"66677788899", 0),
    (9, '2023-07-17 09:40:00', '2023-07-17 11:55:00', '2023-07-17 10:25:00', 9,"77788899900", 0),
    (10,'2023-07-18 13:20:00', '2023-07-18 15:45:00', '2023-07-18 14:00:00', 10,"88899900011",0);


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
VALUES (9, 4.99, "Sabonete Dove 90g ", 25, 30, "77.889.9000001", '2023-06-30'),(51, 1.99, "Biscoito Cream Cracker 200g", 20, 150, "11.223.3340001", '2023-09-10'),
(52, 2.50, "Refrigerante de Limão 500ml", 15, 100, "22.334.4450001", '2023-09-15'),(53, 0.99, "Sabonete em Barra 75g", 30, 200, "33.445.5560001", '2023-09-20'),
(54, 4.99, "Café em Cápsulas 10 unidades", 30, 120, "44.556.6670001", '2023-09-25'),(55, 2.20, "Leite em Pó Desnatado 400g", 25, 180, "55.667.7780001", '2023-09-30');

INSERT INTO tb_produto (id_produto, valor_produto, descricao_produto, qtd_max_venda, qtd_total, id_cnpj, data_validade)
VALUES (10, 7.0, "Shampoo Dex 300ml", 15, 150, "88.990.0110001", '2023-06-28'),(56, 7.0, "Shampoo Dex 300ml", 15, 150, "88.990.0110001", '2023-06-28'),
    (57, 12.5, "Condicionador Suave 200ml", 10, 80, "88.990.0110001", '2023-07-15'),(58, 2.99, "Sabonete em Barra 90g", 20, 200, "88.990.011000", '2023-08-10'),
    (59, 3.75, "Creme Dental Fresh 50g", 30, 250, "88.990.0110001", '2023-09-05'),(60, 5.25, "Desodorante Roll-on 50ml", 25, 180, "88.990.0110001", '2023-10-20');

-- -----------------------------------------------------
-- Table tb_itens_pedido
-- -----------------------------------------------------
INSERT INTO tb_itens_pedido (id_produto,id_pedido,qtd_itens) values (1,1,8), (2,3,10);


INSERT INTO tb_itens_pedido (id_produto, id_pedido, qtd_itens)
VALUES
    (1, 1, 8),
    (1, 2, 10),
    (1, 3, 5),
    (1, 4, 12),
    (1, 5, 6),
    
    (2, 6, 15),
    (2, 7, 9),
    (2, 8, 11),
    (2, 9, 7),
    (2, 10, 14),
    
    (3, 11, 8),
    (3, 12, 10),
    (3, 13, 5),
    (3, 14, 12),
    (3, 15, 6),
    
    (4, 16, 15),
    (4, 17, 9),
    (4, 18, 11),
    (4, 19, 7),
    (4, 20, 14);

