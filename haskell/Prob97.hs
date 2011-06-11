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
--last10Digits n = decimalListToInt (reverse (take 10 (reverse (decimalIntegers n))))
last10Digits  = decimalListToInt . reverse  . take 10 . reverse . decimalIntegers

last10Mult m n = last10Digits ((last10Digits m) * (last10Digits n))
last10Square m = last10Mult m m
last10Plus m n = last10Digits ((last10Digits m) + (last10Digits n))
last10Power m n 
    | n == 1 = m
    | otherwise = last10Mult (last10Square (last10Power m (n `div` 2))) (m ^ (n `mod` 2))

main = do
  (putStrLn . show) (last10Plus (last10Mult 28433 (last10Power 2 7830457)) 1)