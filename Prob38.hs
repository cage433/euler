-- Take the number 192 and multiply it by each of 1, 2, and 3:

--     192 × 1 = 192
--     192 × 2 = 384
--     192 × 3 = 576

-- By concatenating each product we get the 1 to 9 pandigital, 192384576. We will call 192384576 the concatenated product of 192 and (1,2,3)

-- The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4, and 5, giving the pandigital, 918273645, which is the concatenated product of 9 and (1,2,3,4,5).

-- What is the largest 1 to 9 pandigital 9-digit number that can be formed as the concatenated product of an integer with (1,2, ... , n) where n > 1?

import Data.List

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


isPandigital n = (sort . decimalIntegers) n == [1..9]
isTooLong n = n > 987654321
isPandigitalList list = (isPandigital  . decimalListToInt) list
makePandigital i = rec 2 i
    where
      rec n acc 
         | isPandigital acc = acc
         | isTooLong acc = -1
         | otherwise = rec (n + 1) (decimalListToInt ((decimalIntegers acc) ++  (decimalIntegers (n * i))))

pandigitals = sort (filter (0<=) (map makePandigital [1..9999]))