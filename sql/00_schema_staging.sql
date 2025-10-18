DROP SCHEMA IF EXISTS staging CASCADE;
CREATE SCHEMA staging;

-- COPY exemplos (ajuste caminho absoluto):
-- COPY staging.clientes_raw (cliente_id, nome, documento, email, cidade, estado) FROM '/abs/path/data/clientes.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8';
-- COPY staging.produtos_raw (produto_id, nome, categoria, preco) FROM '/abs/path/data/produtos.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8';
-- COPY staging.pedidos_raw (pedido_id, cliente_id, data_pedido, produto_id, quantidade, valor_total) FROM '/abs/path/data/pedidos.csv' DELIMITER ',' CSV HEADER ENCODING 'UTF8';

CREATE TABLE staging.clientes_raw (
  cliente_id   INTEGER,
  nome         TEXT,
  documento    TEXT,
  email        TEXT,
  cidade       TEXT,
  estado       TEXT
);

CREATE TABLE staging.produtos_raw (
  produto_id   INTEGER,
  nome         TEXT,
  categoria    TEXT,
  preco        NUMERIC(12,2)
);

CREATE TABLE staging.pedidos_raw (
  pedido_id    INTEGER,
  cliente_id   INTEGER,
  data_pedido  DATE,
  produto_id   INTEGER,
  quantidade   INTEGER,
  valor_total  NUMERIC(12,2)
);