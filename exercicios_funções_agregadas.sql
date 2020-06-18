SELECT
	Count(CodFornec)
FROM
	fornecedor;

SELECT
	Count(DISTINCT CidadeFornec)
FROM
	fornecedor;

SELECT
	cidadeFornec,
	Count(CodFornec)
FROM
	fornecedor
GROUP BY
	CidadeFornec;

SELECT
	MAX(QTDEEMBARC)
FROM
	embarq;

SELECT
	CodFornec,
	Count(QTDEEMBARC)
FROM
	embarq
GROUP BY
	CodFornec;

SELECT
	CodFornec,
	SUM(QTDEEMBARC)
FROM
	embarq
GROUP BY
	CodFornec
HAVING
	SUM(QTDEEMBARC) > 300;

SELECT
	CodFornec,
	Sum(QTDEEMBARC)
FROM
	embarq a
INNER JOIN peca b ON
	a.codpeca = b.codpeca
WHERE
	b.corpeca = 'Cinza'
GROUP BY
	CodFornec;
