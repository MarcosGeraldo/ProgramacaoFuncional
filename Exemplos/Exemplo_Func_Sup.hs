doubleList :: [Int] -> [Int]
doubleList [] = []
doubleList (x : xs) = 2 * x : doubleList xs

notList :: [Bool] -> [Bool]
notList [] = []
notList (x : xs) = not x : notList xs

aplicaOperacao :: (Int -> Int) -> [Int] -> [Int]
aplicaOperacao _ [] = []
aplicaOperacao f (x:xs) = f x : aplicaOperacao f xs

\x -> x + 1
--Equivalentes
incrementa x = x + 1

incrementa2 x = x + 2
incrementa3 x = x + 3
somaUmRefatorada xs = aplicaOperacao incrementa xs

aplicaOperacao _ [] = []
aplicaOperacao f (x:xs) = f x : aplicaOperacao f xs

listaIncrementada = map (\x -> x + 1) [1, 2, 3]
