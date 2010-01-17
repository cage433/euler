--import qualified Data.IntSet as IS
import Data.List 

primes :: [Int]
primes = 2: 3: sieve 0 (tail primes) 5
sieve k (p:ps) x = [x | x<-[x,x+2..p*p-2], and [x`rem`p/=0 | p<-fs]]
                   ++ sieve (k+1) ps (p*p+2) 
                       where fs = take k (tail primes)


uniquePrimeFactors n = rec n primes []
    where
      rec n (p:ps) acc
          | n == 1 = acc
          | mod n p == 0 = if length acc > 0 && p == head acc then
                               rec (div n p) (p:ps) acc
                           else
                               rec (div n p) (p:ps) (p:acc)
          | otherwise = rec n ps acc






integers = 1: (map (1+) integers)

numDistinctPrimeFactors n = (length . uniquePrimeFactors) n

withPrimeFactors m = filter (\n -> numDistinctPrimeFactors n == m) integers

firstWithProperty m = rec (withPrimeFactors m) 
    where
      rec ns 
          | (head ns ) > 1000000 = -1
          | otherwise = let a = head ns 
                            b = ns !! (m - 1)
                        in
                          if (b - a) == m - 1 then
                              a
                          else
                              rec (tail ns)

main = do
   putStrLn (show (firstWithProperty 4))