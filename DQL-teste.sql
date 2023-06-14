

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

