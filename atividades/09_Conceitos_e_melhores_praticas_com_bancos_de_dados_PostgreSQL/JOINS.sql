---------------------------- JOINs

SELECT banco_numero, numero FROM agencia;
SELECT numero, nome FROM cliente;
SELECT banco_numero, agencia_numero, numero, digito, cliente_numero FORM conta_corrente;.
SELECT id, nome FROM tipo_transacao;

-- 296 registros
SELECT COUNT(1) FROM banco;
SELECT banco.numero, banco.numero,agencia.numero,agencia.nome
FROM banco
JOIN agencia ON agencia.banco_numero = banco.numero;

SELECT COUNT(banco.numero)
FROM banco
JOIN agencia ON agencia.banco_numero = banco.numero;

SELECT banco.numero
FROM banco
JOIN agencia ON agencia.banco_numero = banco.numero
GROUP BY banco.numero;

SELECT count(distinct) banco.numero
FROM banco
JOIN agencia ON agencia.banco_numero = banco.numero;

---retorna 438 (296 que tem agencia + null)
SELECT banco.numero, banco.nome, agencia.numero, agencia.nome
FROM banco
LEFT JOIN agencia ON agencia.banco_numero = banco.numero;

SELECT agencia.numero, agencia.nome,  banco.numero, banco.nome
FROM agencia
RIGHT JOIN banco ON banco.numero = agencia.banco_numero;

SELECT banco.numero, banco.nome, agencia.numero, agencia.nome
FROM banco
FULL JOIN agencia ON agencia.banco_numero = banco.numero;

--- teste
CREATE TABLE IF NOT EXISTS teste_a (id.serial primary key, valor varchar(20));
CREATE TABLE IF NOT EXISTS teste_a (id serial primary key, valor varchar(20));
CREATE TABLE IF NOT EXISTS teste_b (id serial primary key, valor varchar(20));

INSERT INTO teste_a (valor) VALUES ('teste1');
INSERT INTO teste_a (valor) VALUES ('teste2');
INSERT INTO teste_a (valor) VALUES ('teste3');
INSERT INTO teste_a (valor) VALUES ('teste4');

INSERT INTO teste_b (valor) VALUES ('testeA');
INSERT INTO teste_b (valor) VALUES ('testeB');
INSERT INTO teste_b (valor) VALUES ('testeC');
INSERT INTO teste_b (valor) VALUES ('testeD');

SELECT tbla.valor, tblb.valor
FROM teste_a tbla ---alias
CROSS JOIN teste_b tblb;---alias

DROP TABLE IF EXISTS teste_a;
DROP TABLE IF EXISTS teste_b;

SELECT banco.nome,
	agencia.nome,
	conta_corrente.numero,
	conta_corrente.digito,
	cliente.nome
FROM banco
JOIN agencia ON agencia.banco_numero - banco.numero
JOIN conta_corrente
	ON conta_corrente.banco_numero = banco.numero
	AND conta_corrente.agencia_numero = agencia.numero
JOIN cliente
	ON clienye.numero = conta_corrente.cliente_numero;