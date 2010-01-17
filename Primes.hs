import qualified Data.IntSet as IS
import Data.List 

primes :: [Int]
primes = 2: 3: sieve 0 (tail primes) 5
sieve k (p:ps) x = [x | x<-[x,x+2..p*p-2], and [x`rem`p/=0 | p<-fs]]
                   ++ sieve (k+1) ps (p*p+2) 
                       where fs = take k (tail primes)


primeFactors n = rec n primes []
    where
      rec n (p:ps) acc
          | n == 1 = acc
          | mod n p == 0 = rec (div n p) (p:ps) (p:acc)
          | otherwise = rec n ps acc

primesLessThan n = (takeWhile (n > ) primes)
primeSet pMax = IS.fromList (primesLessThan pMax)

