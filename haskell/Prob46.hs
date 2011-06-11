import qualified Data.IntSet as IS
import Data.List 

--primes :: [Int]
primes = 2: 3: sieve 0 (tail primes) 5
sieve k (p:ps) x = [x | x<-[x,x+2..p*p-2], and [x`rem`p/=0 | p<-fs]]
                   ++ sieve (k+1) ps (p*p+2) 
                       where fs = take k (tail primes)

--odds :: [Int]
odds = 3:(map (2+) odds)

--oddComposites :: [Int]
oddComposites = rec odds (IS.fromList (take 1000 primes)) (drop 1000 primes)
    where
      rec (o:os) primeSet (p:ps) 
          | o > p = let n = IS.size primeSet 
                    in
                      rec (o:os) (IS.union primeSet (IS.fromList (take n (p:ps)))) (drop n (p:ps))
          | IS.member o primeSet = rec os primeSet (p:ps)
          | otherwise = o : (rec os primeSet (p:ps))




isSquareInt n = s * s == n
    where s = round (sqrt (fromIntegral n))


firstGoldbach = rec oddComposites primes
    where
      rec (o:os) (p:ps)
          | o < p = o
          | otherwise = if isSquareInt ((o - p) `div` 2) then
                            rec os primes
                        else
                            rec (o:os) ps
                  
main = do
  putStrLn (show firstGoldbach)