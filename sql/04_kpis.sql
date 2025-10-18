-- KPIs de exemplo

-- Ticket médio
SELECT ROUND(SUM(valor_total)::numeric / NULLIF(COUNT(DISTINCT pedido_id),0), 2) AS ticket_medio
FROM analytics.f_pedidos;

-- Top 10 clientes por receita
SELECT c.nome AS cliente, SUM(f.valor_total) AS receita
FROM analytics.f_pedidos f
JOIN analytics.d_clientes c ON c.cliente_sk = f.cliente_sk
GROUP BY c.nome
ORDER BY receita DESC
LIMIT 10;

-- Top 10 produtos por quantidade
SELECT p.nome AS produto, SUM(f.quantidade) AS qtd
FROM analytics.f_pedidos f
JOIN analytics.d_produtos p ON p.produto_sk = f.produto_sk
GROUP BY p.nome
ORDER BY qtd DESC
LIMIT 10;

-- Receita mensal
SELECT to_char(f.data_pedido, 'YYYY-MM') AS ano_mes, SUM(f.valor_total) AS receita
FROM analytics.f_pedidos f
GROUP BY 1
ORDER BY 1;