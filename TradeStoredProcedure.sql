SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Yusuf
-- Create date: 30/11/2023
-- Description:	GetTradeData Stored Procedure
-- =============================================
CREATE PROCEDURE GetTradeData
    @FromDate DATE,
    @ToDate DATE
AS
BEGIN
    SELECT
        T.TradeDate,
        T.AcctNo,
        A.AcctName,
        T.StockCode,
        T.Country,
        CASE 
            WHEN T.BuySell = 1 THEN 'Buy'
            WHEN T.BuySell = 2 THEN 'Sell'
        END AS Side,
        T.Price,
        T.Unit,
        T.Unit * T.Price AS GrossAmount

    FROM
        dbo.Trade T

    LEFT JOIN
        dbo.Account A ON A.AcctNo = T.AcctNo
    WHERE
        T.TradeDate BETWEEN @FromDate AND @ToDate

    GROUP BY
        T.TradeDate,
        T.AcctNo,
        A.AcctName,
        T.StockCode,
        T.Country,
        T.BuySell,
        T.Price,
        T.Unit
	ORDER BY T.TradeDate, T.AcctNo, T.StockCode
END;
