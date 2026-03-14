--Доллор иммет самый низкий преоритет
-- ($) :: (a ->b ) -> a -> b 
--f $ x = f x
-- f a b c d ->  ((((f a)b)c)d)

-- sum (map sqrt [1..1000])
-- sum $ map sqrt [1..1000]

drop' :: Int -> [a] -> [a]
drop' n xs = foldr (\x acc -> \k -> if k > 0 then acc (k-1) else x : acc 0) (const []) xs n

dropWhile' :: (a -> Bool) -> [a] -> [a]
dropWhile' p xs = snd $ foldl (\(dropping, acc) x ->
    if dropping && p x 
        then (True, [])          
        else (False, acc ++ [x]))  
    (True, []) xs

--drop' Через свёртки
--dropwhile'

--mapNfilter :: (a -> b) -> (b -> Bool) -> [a] -> [b]
--map' :: (a -> b) -> [a] -> [b]
--map' f xs = foldr (\x acc -> f x:acc) [] xs

--map'' :: (a -> b) -> [a] -> [b]
--map'' f xs = foldl (\x acc)

elem' :: (Eq a) => a -> [a] -> Bool
elem' x xs = foldl 
  (\acc a -> if a == x then True else acc)
  False xs

sum' :: (Num a) => [a] -> a
sum' xs = foldl (\acc x -> acc + x) 0 xs

sum'' :: (Num a) => [a] -> a
sum'' = foldl (+) 0

flip' :: (a -> b -> c) -> b -> a ->c
flip' f = \x y -> f y x

multiplyThree :: Int -> Int -> Int -> Int
multiplyThree x y z = x * y * z

multiplyThree' :: Int -> Int -> Int -> Int
multiplyThree' = \x -> \y -> \z -> x * y *z

numCountChains :: Int
numCountChains = length(
                 filter (\xs -> length xs > 15)
                 (map chain [1..1000]))

chain :: Integer -> [Integer]
chain 1 = [1]
chain n 
    | even n = n : chain (n `div` 2)
    | otherwise = n : chain (3 * n + 1)