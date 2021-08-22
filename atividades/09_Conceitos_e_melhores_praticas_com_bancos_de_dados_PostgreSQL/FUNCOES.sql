-------------------  FUNÇÕES

--SQL
CREATE OR REPLACE FUNCTION func_somar(INTEGER,INTEGER)
RETURNS INTEGER
SECURITY DEFINER
RETURNS NULL ON NULL INPUT
LANGUAGE SQL
AS $$
	SELECT $1+$2;
$$;

SELECT func_somar(1,2);
SELECT func_somar(1,null);

CREATE OR REPLACE FUNCTION func_somar(INTEGER,INTEGER)
RETURNS INTEGER
SECURITY DEFINER
CALLED ON NULL INPUT
LANGUAGE SQL
AS $$
	SELECT $1+$2;
$$;

SELECT func_somar(1,null);

SELECT COALESCE(null,null,'teste','teste2'); -- retorna primeiro valor nao nulo de uma lista

CREATE OR REPLACE FUNCTION func_somar(INTEGER,INTEGER)
RETURNS INTEGER
SECURITY DEFINER
CALLED ON NULL INPUT
LANGUAGE SQL
AS $$
	SELECT COALESCE($1,0)+ COALESCE($2,0);
$$;

SELECT func_somar(1,null);

-- PLpgSQL

CREATE OR REPLACE FUNCTION bancos_add(p_numero INTEGER, p_nome VARCHAR, p_ativo BOOLEAN)
RETURNS INTEGER
SECURITY INVOKER
LANGUAGE PLPGSQL
CALLED ON NULL INPUT
AS $$
DECLARE var_id INTEGER;
BEGIN
	SELECT INTO var_id numero
	FROM banco
	WHERE numero = p_numero;
	RETURN var_id;
END;
$$; 

--1 pq não existe
SELECT bancos_add(1,'Banco Novo', FALSE);
--null pq não existe
SELECT bancos_add(5432,'Banco Novo', FALSE);

CREATE OR REPLACE FUNCTION bancos_add(p_numero INTEGER, p_nome VARCHAR, p_ativo BOOLEAN)
RETURNS INTEGER
SECURITY INVOKER
LANGUAGE PLPGSQL
CALLED ON NULL INPUT
AS $$
DECLARE var_id INTEGER;
BEGIN
	IF p_numero IS NULL or p_nome IS NULL or p_ativo IS NULL THEN
		RETURN 0;
	END IF;

	SELECT INTO var_id numero
	FROM banco
	WHERE numero = p_numero;

	IF var_id IS NULL THEN
		INSERT INTO banco(numero,nome,ativo)
		VALUES(p_numero,p_nome,p_ativo);
	ELSE
		RETURN var_id;
	END IF;

	SELECT INTO var_id numero
	FROM banco
	WHERE numero = p_numero;
	RETURN var_id;
END;
$$; 


