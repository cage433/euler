-- The number, 1406357289, is a 0 to 9 pandigital number because it is made up of each of the digits 0 to 9 in some order, but it also has a rather interesting sub-string divisibility property.

-- Let d_(1) be the 1^(st) digit, d_(2) be the 2^(nd) digit, and so on. In this way, we note the following:

--     * d_(2)d_(3)d_(4)=406 is divisible by 2
--     * d_(3)d_(4)d_(5)=063 is divisible by 3
--     * d_(4)d_(5)d_(6)=635 is divisible by 5
--     * d_(5)d_(6)d_(7)=357 is divisible by 7
--     * d_(6)d_(7)d_(8)=572 is divisible by 11
--     * d_(7)d_(8)d_(9)=728 is divisible by 13
--     * d_(8)d_(9)d_(10)=289 is divisible by 17

-- Find the sum of all 0 to 9 pandigital numbers with this property.
import Data.List

integerList :: Int -> Int -> [Int]
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

primes :: [Int]
primes = 2: 3: sieve 0 (tail primes) 5
sieve k (p:ps) x = [x | x<-[x,x+2..p*p-2], and [x`rem`p/=0 | p<-fs]]
                   ++ sieve (k+1) ps (p*p+2) 
                       where fs = take k (tail primes)

hasProperty list = rec 0 (tail list)
    where
      rec 7 _ = True
      rec i list = (decimalListToInt (take 3 list)) `mod` (primes !! i) == 0 && rec (i + 1) (tail list)


pandigitalsWithProprety = map decimalListToInt (filter hasProperty (permutations [0..9]))

sumOfPandigitalsWithProperty = foldl (+) 0 pandigitalsWithProprety

main = do
  putStrLn (show sumOfPandigitalsWithProperty)