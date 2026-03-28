hotCup (ml, temp) = \msg -> msg (ml, temp)
getHotCupMl sCup = sCup(\(m,_)->m)
getTemp sCup = sCup (\(_,t)->t)


cup ml = \msg -> msg ml
--human.getHeigth()
--getHeigth human
--Получение обьема
getMl sCup = sCup (\ml -> ml)

--Выпить глаток
makeSipFromCup sCup mlDrank = if mlDiff > 0
                              then cup mlDiff
                              else cup 0
  where ml = getMl sCup 
        mlDiff = ml - mlDrank

