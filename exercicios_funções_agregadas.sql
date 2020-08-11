SELECT Count(codfornec)
FROM   fornecedor;

SELECT Count(DISTINCT cidadefornec)
FROM   fornecedor;

SELECT cidadefornec,
       Count(codfornec)
FROM   fornecedor
GROUP  BY cidadefornec;

SELECT Max(qtdeembarc)
FROM   embarq;

SELECT codfornec,
       Count(qtdeembarc)
FROM   embarq
GROUP  BY codfornec;

SELECT codfornec,
       SUM(qtdeembarc)
FROM   embarq
GROUP  BY codfornec
HAVING SUM(qtdeembarc) > 300;

SELECT codfornec,
       SUM(qtdeembarc)
FROM   embarq a
       inner join peca b
               ON a.codpeca = b.codpeca
WHERE  b.corpeca = 'Cinza'
GROUP  BY codfornec; 