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
