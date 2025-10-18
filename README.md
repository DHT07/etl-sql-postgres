# ETL em SQL (PostgreSQL) — Staging ▸ Cleansed ▸ Analytics

Projeto 100% em **SQL puro** demonstrando um pipeline ETL realista em PostgreSQL:
- **Staging**: recebe CSVs brutos (clientes, pedidos, produtos)
- **Cleansed**: normaliza dados (tipos, deduplicação, formatação, chaves)
- **Analytics**: monta fato e dimensões para análises (ticket médio, top clientes/produtos, receita mensal)

> 💡 Eu quis mostrar **processo e raciocínio** mais do que um CRUD. Aqui está minha forma de organizar camadas, escrever SQL limpo e pensar em KPIs.

## 🧱 Estrutura
sql/00_schema_staging.sql
sql/01_schema_cleansed.sql
sql/02_schema_analytics.sql
sql/03_transformations.sql
sql/04_kpis.sql
data/*.csv

## ⚙️ Como rodar (PostgreSQL)
1. Crie um banco local: `CREATE DATABASE etl_sql;`
2. Rode os scripts na ordem (00 → 04). Se preferir, importe os CSVs com `COPY` conforme instrução no `00_schema_staging.sql`.
3. `03_transformations.sql` já contém um SEED mínimo (caso não use `COPY`).

> Criado por **Tiago Dotto** — 2025-10-18
