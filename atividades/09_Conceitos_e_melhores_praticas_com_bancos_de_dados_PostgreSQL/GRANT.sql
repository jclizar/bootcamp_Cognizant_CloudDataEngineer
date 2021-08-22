-------------------GRANT

CREATE TABLE teste (nome varchar);
GRANT ALL ON TABLE teste TO professores;
DROP ROLE daniel;
CREATE ROLE daniel LOGIN PASSWORD '123';

-->(terminal) \q
-->(terminal) -U daniel aula (digita senha)
-->(terminal) SELECT nome FROM teste; (denied)

DROP ROLE daniel;
CREATE ROLE daniel INHERIT LOGIN PASSWORD '123' IN ROLE professores;

-->(terminal) -U daniel aula (digita senha)
(-->terminal) SELECT nome FROM teste; (agora pode ver a tabela)

REVOKE professores FROM daniel;
-->(terminal) SELECT nome FROM teste; (denied)

--Daniel como membro de professores
DROP ROLE daniel;
CREATE ROLE daniel LOGIN PASSWORD '123' IN ROLE professores;
--Professores como membro de Daniel
DROP ROLE daniel;
CREATE ROLE daniel LOGIN PASSWORD '123' ROLE professores;