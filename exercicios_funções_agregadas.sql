SELECT Count(CodFornec) from fornecedor;

SELECT Count(distinct CidadeFornec) from fornecedor;

SELECT cidadeFornec, Count(CodFornec) from fornecedor group by CidadeFornec;

SELECT MAX(QTDEEMBARC) from embarq;

SELECT CodFornec, Count(QTDEEMBARC) from embarq group by CodFornec;

SELECT CodFornec, SUM(QTDEEMBARC) FROM embarq GROUP BY CodFornec HAVING SUM(QTDEEMBARC) > 300;

SELECT CodFornec, Sum(QTDEEMBARC) from embarq a inner join peca b on a.codpeca = b.codpeca where b.corpeca = 'Cinza' group by CodFornec;


