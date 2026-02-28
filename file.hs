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