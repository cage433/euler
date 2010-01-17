import Data.List
import qualified Data.IntSet as IS


integerList base n = rec n []
    where rec n acc
                  | n < base = n : acc
                  | otherwise = rec (div n base) ((mod n base) : acc)

decimalIntegers = integerList 10
binaryIntegers = integerList 2
listToInt :: Int -> [Int] -> Int
listToInt base list = rec list 0
    where rec [] acc = acc
          rec (x:xs) acc = rec xs (x + acc * base)

decimalListToInt = listToInt 10
binaryListToInt = listToInt 2


primes :: [Int]
primes = 2: 3: sieve 0 (tail primes) 5
sieve k (p:ps) x = [x | x<-[x,x+2..p*p-2], and [x`rem`p/=0 | p<-fs]]
                   ++ sieve (k+1) ps (p*p+2) 
                       where fs = take k (tail primes)


isInSet set n =  IS.member n set  
isPrimeFn maxPrime n = IS.member n primeSet 
    where
      primeSet = rec primes IS.empty
      rec (p:ps) set = 
         if p > maxPrime then
             set
         else
             rec ps (IS.insert p set)



p3000 = takeWhile (3000 >) primes
isPrime n = all (\p -> n `mod` p /= 0) p3000
pandigitals = map decimalListToInt (permutations [1..7])

main = do
  putStrLn ((show . head . reverse . sort) (filter isPrime  pandigitals))
