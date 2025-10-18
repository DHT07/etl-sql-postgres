DROP SCHEMA IF EXISTS analytics CASCADE;
CREATE SCHEMA analytics;

CREATE TABLE analytics.d_clientes (
  cliente_sk   INTEGER PRIMARY KEY,
  cliente_id   INTEGER,
  nome         TEXT,
  documento    TEXT,
  cidade       TEXT,
  estado       TEXT
);

CREATE TABLE analytics.d_produtos (
  produto_sk   INTEGER PRIMARY KEY,
  produto_id   INTEGER,
  nome         TEXT,
  categoria    TEXT,
  preco        NUMERIC(12,2)
);

CREATE OR REPLACE VIEW analytics.d_tempo AS
WITH datas AS (
  SELECT DISTINCT data_pedido AS d FROM cleansed.pedidos WHERE data_pedido IS NOT NULL
)
SELECT
  d::date AS data,
  EXTRACT(DAY FROM d)::int  AS dia,
  EXTRACT(MONTH FROM d)::int AS mes,
  EXTRACT(YEAR FROM d)::int AS ano,
  to_char(d, 'YYYY-MM') AS ano_mes
FROM datas;

CREATE TABLE analytics.f_pedidos (
  pedido_id     INTEGER PRIMARY KEY,
  cliente_sk    INTEGER REFERENCES analytics.d_clientes(cliente_sk),
  produto_sk    INTEGER REFERENCES analytics.d_produtos(produto_sk),
  data_pedido   DATE NOT NULL,
  quantidade    INTEGER NOT NULL,
  valor_total   NUMERIC(12,2) NOT NULL
);