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

integerList base n = rec n []
    where rec n acc
                  | n < base = n : acc
                  | otherwise = rec (div n base) ((mod n base) : acc)

decimalIntegers = integerList 10
binaryIntegers = integerList 2

listToInt base list = rec list 0
    where rec [] acc = acc
          rec (x:xs) acc = rec xs (x + acc * base)

decimalListToInt = listToInt 10
binaryListToInt = listToInt 2

evens = 2 : (map (2+) evens)

isPerm n1 n2 = u1 == u2
    where
      u1 = sort (decimalIntegers n1)
      u2 = sort (decimalIntegers n2)

primesLessThan10000 = primeSet 10000

isPrime p = IS.member p primesLessThan10000
withProp p = (p, filter (\n -> let p' = p + n
                                   p'' = p + 2*n
                               in
                                 isPrime p' && isPrime p'' && isPerm p p' && isPerm p p'') 
              (takeWhile ((10000 - p) `div` 2 >=) evens))
      