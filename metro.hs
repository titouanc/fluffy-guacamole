assignID :: Integer -> [Bool] -> (Integer, [Maybe Integer])
assignID x [] = (x, [])
assignID x (True:xs)  = (y, Just x:rest) where
    (y, rest) = assignID (x+1) xs
assignID x (False:xs) = (y, Nothing:rest) where
    (y, rest) = assignID x xs



transition :: (Integer, [Maybe Integer]) -> [Bool] -> (Integer, [Maybe Integer])
-- Cas de base
transition (x, []) [] = (x, [])

-- Un metro avance
transition (x, (Nothing:Just m:ms)) (True:False:ss) = (nextId, Just m:Nothing:rest) where
    (nextId, rest) = transition (x, ms) ss

-- Deux metros avancent
transition (x, (Nothing:Just m:Just n:ms)) (True:True:False:ss) = (nextId, Just m:Just n:Nothing:rest) where
    (nextId, rest) = transition (x, ms) ss

-- Un metro avance de 2 stations
transition (x, (Nothing:Nothing:Just m:ms)) (True:False:False:ss) = (nextId, Just m:Nothing:Nothing:rest) where
    (nextId, rest) = transition (x, ms) ss

-- Un metro apparaît
transition (x, (Nothing:ms)) (True:ss) = (nextId, Just x:rest) where
    (nextId, rest) = transition (x+1, ms) ss

-- Un metro stagne
transition (x, (Just m:ms)) (True:ss) = (nextId, Just m:rest) where
    (nextId, rest) = transition (x, ms) ss

-- Un metro disparaît
transition (x, (Just m:ms)) (False:ss) = (nextId, Nothing:rest) where
    (nextId, rest) = transition (x, ms) ss

-- Aucun metro
transition (x, (Nothing:ms)) (False:ss) = (nextId, Nothing:rest) where
    (nextId, rest) = transition (x, ms) ss

-- Cas inconnu
transition (x, ms) ss = error ("Unknow case ! newId:"++(show x)++" metros:"++(show ms)++" / stations:"++(show ss))



metros :: (Integer, [Maybe Integer]) -> IO ()
metros x = do
    line <- getLine
    let state = read line :: [Bool] in
        let (newId, metroIds) = transition x state in
            print metroIds >>
            metros (newId, metroIds)


main :: IO ()
main = do
    line <- getLine
    let initial = assignID 1 (read line :: [Bool]) in
        metros initial
