------------------- VIEWS

SELECT numero, nome, ativo
FROM banco;


CREATE OR REPLACE VIEW vw_bancos AS (
	SELECT numero, nome, ativo
	FROM banco
);

SELECT numero, nome, ativo
FROM vw_bancos;

CREATE OR REPLACE VIEW vw_bancos2(banco_numero, banco_nome,banco_ativo) AS (
	SELECT numero, nome, ativo
	FROM banco
);

SELECT banco_numero, banco_nome, banco_ativo
FROM vw_bancos2;

INSERT INTO vw_bancos2 (banco_numero, banco_nome, banco_ativo)
VALUES (51,'BANCO BOA IDEIA', TRUE);

SELECT banco_numero, banco_nome, banco_ativo
FROM vw_bancos2
WHERE banco_numero = 51;

UPDATE vw_bancos2
SET banco_ativo = FALSE
WHERE banco_numero = 51;

DELETE FROM vw_bancos2
WHERE banco_numero = 51;

-- temporary view, em outra query tool não funciona
CREATE OR REPLACE TEMPORARY VIEW vw_agencia AS (
	SELECT nome FROM agencia
);

SELECT nome FROM vw_agencia;

-- with options

CREATE OR REPLACE VIEW vw_banco_ativos AS (
	SELECT numero, nome, ativo
	FROM banco
	WHERE ativo IS TRUE
) WITH LOCAL CHECK OPTION;

--error
INSERT INTO vw_banco_ativos (numero, nome, ativo)
VALUES (51,'BANCO BOA IDEIA', FALSE);


CREATE OR REPLACE VIEW vw_bancos_com_a AS (
	SELECT numero, nome, ativo
	FROM vw_banco_ativos 
	WHERE nome ILIKE 'a%'
) WITH LOCAL CHECK OPTION;


SELECT * FROM vw_bancos_com_a;

--  error: new row violates check option for view, bando com B
INSERT INTO vw_bancos_com_a(numero, nome, ativo)
VALUES (333,'BETA', TRUE);

INSERT INTO vw_bancos_com_a(numero, nome, ativo)
VALUES (333,'ALPHA', TRUE);

-- error: FALSE
INSERT INTO vw_bancos_com_a(numero, nome, ativo)
VALUES (331,'ALPHA GAMMA ', FALSE);


CREATE OR REPLACE VIEW vw_banco_ativos AS (
	SELECT numero, nome, ativo
	FROM banco
	WHERE ativo IS TRUE
);

INSERT INTO vw_bancos_com_a(numero, nome, ativo)
VALUES (331,'ALPHA GAMMA ', FALSE);


-- validar as views que ela estiver vinculada

CREATE OR REPLACE VIEW vw_banco_ativos AS (
	SELECT numero, nome, ativo
	FROM banco
	WHERE ativo IS TRUE
) WITH CASCADED CHECK OPTION;

INSERT INTO vw_bancos_com_a(numero, nome, ativo)
VALUES (332,'ALPHA GAMMA BETA', FALSE);

-- Recursive
CREATE TABLE IF NOT EXISTIS funcionarios (
	id SERIAL.
	nome VARCHAR(50),
	gerente INTEGER,
	PRIMARY KEY (id),
	FOREIGN KEY (gerente) REFERENCES funcionarios (id)	
);

INSERT INTO funcionarios (nome, gerente)
VALUES ('Ancelmo', null);

INSERT INTO funcionarios (nome, gerente)
VALUES ('Beatriz', 1);

INSERT INTO funcionarios (nome, gerente)
VALUES ('Magno', 1);


INSERT INTO funcionarios (nome, gerente)
VALUES ('Cremilda', 2);


INSERT INTO funcionarios (nome, gerente)
VALUES ('Wagner', 4);

SELECT id, nome, gerente FROM funcionarios
WHERE gerente IS NULL
UNION ALL
SELECT id, nome, gerente FROM funcionarios
WHERE id = 999; --- apenas para exemplo


CREATE OR REPLACE RECURSIVE VIEW vw_func (id, gerente, funcionario) AS (
	SELECT id, gerente, nome
	FROM funcionarios
	WHERE gerente IS NULL

	UNION ALL

	SELECT funcionarios.id, funcionarios.gerente, funcionarios.nome
	FROM funcionarios
	JOIN vw_func ON vw_func.id = funcionarios.gerente
);

SELECT id, gerente, funcionario FROM vw_func;