flip' :: (a -> b -> c) -> (b -> a -> c)
flip' f = g 
  where g y x = f x y


zipWith' :: (a->b->c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f(x:xs) (y:ys) = f x y : zipWith' f xs ys


--isMoreThanTen :: (Ord a, Num a) => a -> a ->String


--Функции высшего порядка принимают в качестве аргумента другую функцию или возвращают функцию 
--каждая функция принимает ровно 1 параметр, каждая функция коррирована
--max 4 5 = (max 4) 5
multiplyThreeNumbers :: Num a => a -> a -> a -> a
multiplyThreeNumbers x y z = x * y * z


multiplyTwoNumbersOnTen :: Num a => a -> a -> a
multiplyTwoNumbersOnTen = multiplyThreeNumbers 10

--Целое чисто x возвести в целую степень y
power :: Int -> Int -> Int
power _ 0 = 1
power x y 
  | y < 0 = error "error"
  | otherwise = x * power x (y-1)


--Числа фиббоначи
fib :: (Num a, Eq a) => a -> [a]
fib 0 = [0]
fib 1 = [0, 1]
fib n = 
  let prev = fib (n-1)
      lastTwo = last prev + last (init prev)
  in prev ++ [lastTwo]


quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (p:xs) =
  let smallerSorted = quicksort [x | x <- xs, x <= p]
      biggerSorted = quicksort [x | x <- xs, x>p]
  in smallerSorted ++ [p] ++ biggerSorted

elem' :: (Eq a) => a -> [a] -> Bool
elem' _[] = False
elem' y (x:xs)
  | y == x = True
  | otherwise = elem' y xs

zip' :: [a] -> [b] -> [(a,b)]
zip' [] _      = []
zip' _ []      = []
zip' (x:xs) (y:ys) = (x, y) : zip' xs ys


cylinder :: Double -> Double -> Double
cylinder r h =
  let sideArea = 2 * pi * r * h
      topArea = pi * r * 2
  in sideArea + 2 * topArea


maximum' :: (Ord a) => [a] -> a
maximum' [] = error "No maximum"
maximum' [x] = x
maximum' (x:xs) = max x (maximum' xs)

replicate' :: Int -> a -> [a]
replicate' n x
  | n <= 0    = []
  | otherwise = x : replicate' (n-1) x

take' :: Int -> [a] -> [a]
take' n _
  | n <= 0 = []
take' _ [] = []
take' n (x:xs) = x : take' (n-1) xs

reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x]

repeat' :: a->[a]
repeat' x = x : repeat' x