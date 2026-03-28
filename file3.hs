tank (model, attack, hp) = \msg -> msg(model, attack, hp)
-- let myTank = tank ("T34", 20, 100)
model (m, _, _) = m

attack (_, a, _) = a

health (_, _, h) = h

setTankHealth sTank nHp = sTank(\(m, a , nHp) ->
  tank (m, a, nHp))

setTankAttack sTank nAttack = sTank (\(m, _, h) ->
  tank (m, nAttack, h))

setTankModel sTank nModel = sTank (\(_, a, h) ->
  tank (nModel, a, h))

printTankInfo sTank = sTank (\(m, a, h) ->
  "Model: " ++ m ++ ", Attack: " ++ (show a) ++
    ", Health:" ++ (show h))

damage sTank dmg = sTank (\(m, a, h) ->
  tank (m, a, h - dmg))

-- sTank.fight(anotherTank)
fight aTank dTank = damage dTank attack
  where attack = if getTankHealth aTank > 0
                 then getTankAttack aTank
                 else 0

repair sTank repairAmount maxHp = sTank (\(m, a, h) ->
  tank (m, a, min maxHp (h + repairAmount)))

getTankModel sTank = sTank model

getTankAttack sTank = sTank attack

getTankHealth sTank = sTank health

--COFFEE
-----------------------------------------
hotCup (ml, temp) = \msg -> msg (ml, temp)
getHotCupMl sCup = sCup(\(m,_)->m)
getTemp sCup = sCup (\(_,t)->t)

coolDown sCup deg = sCup (\(m, t) -> 
  hotCup (m, max 20 (t-deg)))


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

