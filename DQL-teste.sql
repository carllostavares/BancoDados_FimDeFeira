insert into tb_cliente values ("11122233332","carlos","carlos@.com.br","M");

INSERT INTO tb_pedido VALUES (1,'2023-07-09','2023-07-10','2023-07-09',1,"000.456.789-56");
INSERT INTO tb_pedido VALUES (2,'2023-07-10','2023-07-10','2023-07-11',2,"123.456.789-56");

INSERT INTO tb_produto values (1,5.0,"feijão",20,250,"97.776.3530001");
INSERT INTO tb_produto values (2,2.0,"arroz",20,150,"97.776.3530001");

INSERT INTO tb_parceiro values ("97.776.3530001","Mercado de Juca","juca.123@meq.com.br");

INSERT INTO tb_itens_pedido values (1,1,10,20.00);
INSERT INTO tb_itens_pedido values (2,2,10,20.00);

SELECT * FROM tb_pedido;
select * from tb_cliente;
select * from tb_parceiro;
select * from tb_produto;
select * from tb_telefone;
SELECT * from  tb_itens_pedido;

DELETE from  tb_itens_pedido;
delete  from tb_telefone;
delete  from tb_produto;
delete  from tb_cliente where nome = "Carlos" ;
 -- now()
	
select * FROM tb_cliente where nome = "Pedro";
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
SET valor_total_itens = tb_itens_pedido.qtd_itens * tb_produto.valor_produto
WHERE tb_itens_pedido.id_produto = 1;
