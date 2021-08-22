---------------------------- FUNÇÕES AGREGADAS

-- ver nome de todas as colunas
SELECT * FROM information_schema.columns WHERE table_name ='banco';
SELECT columns.column_name data_types FROM information_schema.columns WHERE table_name ='banco';

SELECT * FROM cliente_transacoes;
SELECT AVG(valor) FROM cliente_transacoes;

SELECT COUNT(numero) FROM cliente;

SELECT COUNT(numero),email
FROM cliente
WHERE email ILIKE '*gmail.com'
GROUP BY email;

SELECT MAX(numero)
FROM cliente;

SELECT MAX(numero)
FROM cliente;

SELECT MIN(numero)
FROM cliente;

SELECT MAX(valor)
FROM cliente_transacoes;

SELECT MIN(valor)
FROM cliente_transacoes;

SELECT MAX(valor), tipo_transacao_id
FROM cliente_transacoes
GROUP BY tipo_transacao_id;

SELECT MIN(valor), tipo_transacao_id
FROM cliente_transacoes
GROUP BY tipo_transacao_id;

SELECT COUNT(id), tipo_transacao_id
FROM cliente_transacoes
GROUP BY tipo_transacao_id
HAVING COUNT(id) > 150;

SELECT SUM(valor),tipo_transacao_id
FROM cliente_transacoes
GROUP BY tipo_transacao_id
ORDER BY tipo_transacao_id;

SELECT SUM(valor),tipo_transacao_id
FROM cliente_transacoes
GROUP BY tipo_transacao_id
ORDER BY tipo_transacao_id DESC;