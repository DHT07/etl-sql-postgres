-- SEED mínimo (se não usar COPY)
TRUNCATE staging.clientes_raw, staging.produtos_raw, staging.pedidos_raw;
INSERT INTO staging.clientes_raw VALUES
  (1,'Ana Souza','111.111.111-11','ana@email.com','Guaíba','rs'),
  (2,'Carlos Lima','222.222.222-22','carlos@email.com','Porto Alegre','RS'),
  (3,'Marina Alves','333.333.333-33','marina@email.com','Canoas','RS');

INSERT INTO staging.produtos_raw VALUES
  (10,'Notebook 14"','Eletrônicos',3500.00),
  (11,'Mouse Sem Fio','Acessórios',120.00),
  (12,'Teclado Mecânico','Acessórios',420.00);

INSERT INTO staging.pedidos_raw VALUES
  (1001,1,'2025-08-01',10,1,3500.00),
  (1002,2,'2025-08-03',11,2,240.00),
  (1003,1,'2025-08-15',12,1,420.00),
  (1004,3,'2025-09-02',10,1,3500.00),
  (1005,2,'2025-09-10',11,1,120.00);

-- Limpeza -> cleansed
TRUNCATE cleansed.clientes, cleansed.produtos, cleansed.pedidos RESTART IDENTITY;

INSERT INTO cleansed.clientes (cliente_id, nome, documento, email, cidade, estado)
SELECT DISTINCT ON (cliente_id)
  cliente_id,
  INITCAP(TRIM(nome)) AS nome,
  REPLACE(documento,'  ',' ') AS documento,
  LOWER(email) AS email,
  INITCAP(TRIM(cidade)) AS cidade,
  UPPER(TRIM(estado)) AS estado
FROM staging.clientes_raw
WHERE cliente_id IS NOT NULL;

INSERT INTO cleansed.produtos (produto_id, nome, categoria, preco)
SELECT DISTINCT ON (produto_id)
  produto_id,
  INITCAP(TRIM(nome)) AS nome,
  INITCAP(TRIM(categoria)) AS categoria,
  COALESCE(NULLIF(preco,0),0)
FROM staging.produtos_raw
WHERE produto_id IS NOT NULL;

INSERT INTO cleansed.pedidos (pedido_id, cliente_id, data_pedido, produto_id, quantidade, valor_total)
SELECT DISTINCT ON (pedido_id)
  pedido_id, cliente_id, data_pedido, produto_id,
  GREATEST(1, quantidade) AS quantidade,
  COALESCE(valor_total, 0)
FROM staging.pedidos_raw
WHERE pedido_id IS NOT NULL;

-- Carrega analytics
TRUNCATE analytics.d_clientes, analytics.d_produtos, analytics.f_pedidos;

INSERT INTO analytics.d_clientes (cliente_sk, cliente_id, nome, documento, cidade, estado)
SELECT cliente_sk, cliente_id, nome, documento, cidade, estado
FROM cleansed.clientes;

INSERT INTO analytics.d_produtos (produto_sk, produto_id, nome, categoria, preco)
SELECT produto_sk, produto_id, nome, categoria, preco
FROM cleansed.produtos;

INSERT INTO analytics.f_pedidos (pedido_id, cliente_sk, produto_sk, data_pedido, quantidade, valor_total)
SELECT
  p.pedido_id,
  c.cliente_sk,
  pr.produto_sk,
  p.data_pedido,
  p.quantidade,
  p.valor_total
FROM cleansed.pedidos p
LEFT JOIN cleansed.clientes c  ON c.cliente_id = p.cliente_id
LEFT JOIN cleansed.produtos pr ON pr.produto_id = p.produto_id;