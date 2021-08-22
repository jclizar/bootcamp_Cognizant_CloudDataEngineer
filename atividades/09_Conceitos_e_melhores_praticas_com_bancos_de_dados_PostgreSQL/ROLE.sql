------------------- ROLE
CREATE ROLE professores NOCREATEDB NOCREATEROLE INHERIT NOLOGIN NOBYPASSRLS CONNECTION LIMIT 10;

--No terminal psql, só digita a senha (WIN)
-->> \du (Listar as ROLES)
-->> SELECT * FROM pg_roles; (Listar as ROLES)

ALTER ROLE professores PASSWORD '123';

-->>(terminal psql) \q (sair do db)
-->>(terminal psql) -U professores aula (tentar entrar, mas não é permitido)

CREATE ROLE daniel LOGIN PASSWORD '123';

-->>(terminal psql) \du

--Daniel como membro de professores
DROP ROLE daniel;
CREATE ROLE daniel LOGIN PASSWORD '123' IN ROLE professores;
--Professores como membro de Daniel
DROP ROLE daniel;
CREATE ROLE daniel LOGIN PASSWORD '123' ROLE professores;