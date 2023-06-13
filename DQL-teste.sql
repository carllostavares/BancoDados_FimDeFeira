

INSERT INTO tb_itens_pedido values (1,1,100);
INSERT INTO tb_itens_pedido values (2,2,200);
insert into tb_pagamento values (1,"pix",0,'2023-06-12');

SELECT * FROM tb_pedido;
select * from tb_cliente;
select * from tb_parceiro;
select * from tb_produto;
select * from tb_telefone;
select * from tb_pagamento;
SELECT * from  tb_itens_pedido;
select * from tb_endereco;


    
DELETE from  tb_itens_pedido where id_pedido = 1;
DELETE from  tb_itens_pedido;
delete from tb_pagamento;
delete  from tb_telefone;
delete  from tb_produto;
delete  from tb_cliente;
delete  from tb_pedido;
delete  from tb_cliente where nome = "Joao Carlos" ;
 -- now()

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


UPDATE tb_itens_pedido
JOIN tb_produto ON tb_itens_pedido.id_produto = tb_produto.id_produto
SET valor_total_itens = tb_itens_pedido.qtd_itens * tb_produto.valor_produto;


DELIMITER $$
DECLARE valor_inserido DECIMAL;
UPDATE tb_pagamento
JOIN tb_pagamento ON tb_pagamento.id_pagamento = tb_pedido.id_pedido
	JOIN tb_pedido ON tb_pedido.id_pedido = tb_itens_pedido.id_pedido
		SET valor_total_pedido = valor_total_pedido + valor_inserido
			JOIN tb_produto ON tb_itens_pedido.id_produto = tb_produto.id_produto
				SET valor_inserido = tb_itens_pedido.qtd_itens * tb_produto.valor_produto

END
DELIMITER;


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

