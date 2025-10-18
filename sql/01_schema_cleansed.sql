DROP SCHEMA IF EXISTS cleansed CASCADE;
CREATE SCHEMA cleansed;

CREATE TABLE cleansed.clientes (
  cliente_sk   SERIAL PRIMARY KEY,
  cliente_id   INTEGER UNIQUE,
  nome         TEXT NOT NULL,
  documento    TEXT,
  email        TEXT,
  cidade       TEXT,
  estado       TEXT,
  dt_carga     TIMESTAMP DEFAULT NOW()
);

CREATE TABLE cleansed.produtos (
  produto_sk   SERIAL PRIMARY KEY,
  produto_id   INTEGER UNIQUE,
  nome         TEXT NOT NULL,
  categoria    TEXT,
  preco        NUMERIC(12,2) NOT NULL CHECK (preco >= 0),
  dt_carga     TIMESTAMP DEFAULT NOW()
);

CREATE TABLE cleansed.pedidos (
  pedido_sk    SERIAL PRIMARY KEY,
  pedido_id    INTEGER UNIQUE,
  cliente_id   INTEGER,
  data_pedido  DATE,
  produto_id   INTEGER,
  quantidade   INTEGER CHECK (quantidade > 0),
  valor_total  NUMERIC(12,2) CHECK (valor_total >= 0),
  dt_carga     TIMESTAMP DEFAULT NOW()
);