import qualified Data.IntSet as IS

integers = 1 : (map (1+) integers)
pentagonals = map (\n -> (n * (3 * n - 1)) `div` 2) integers
pentagonalSet = IS.fromList (take 1000000 pentagonals)

isPentagonal n = IS.member n pentagonalSet
-- isPentagonal n = rec n pentagonals
--     where
--       rec n (p:ps) 
--           | n < p = False
--           | n == p = True
--           | otherwise = rec n ps

pairs :: [(Int, Int)]
pairs = (0, 0) : map nextPair pairs
    where 
      nextPair (i, j)
          | i == j = (i + 1, 0)
          | otherwise = (i, j + 1)

hasProperty :: (Int, Int) -> Bool
hasProperty (i, j) = isPentagonal (p1 + p2) && isPentagonal (p1 - p2)
    where
      p1 = pentagonals !! i
      p2 = pentagonals !! j

pairsWithProperty = rec pentagonals pentagonals
    where
      rec (x:xs) (y:ys) 
          | x > 37625100 = []
          | x == y = rec xs pentagonals
          | otherwise = if isPentagonal (x + y) && isPentagonal (x - y) then 
                            (x, y) : (rec (x:xs) ys)
                        else
                            (rec (x:xs) ys)