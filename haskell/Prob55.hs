import Data.List

integerList base n = rec n []
    where rec n acc
                  | n < base = n : acc
                  | otherwise = rec (div n base) ((mod n base) : acc)

decimalIntegers = integerList 10

listToInt base list = rec list 0
    where rec [] acc = acc
          rec (x:xs) acc = rec xs (x + acc * base)

decimalListToInt = listToInt 10

isPalindrome list = list == (reverse list)

nextStep list = decimalIntegers (n + n')
    where
      n = decimalListToInt list
      n' = decimalListToInt (reverse list)

isLychrel n = rec (nextStep (decimalIntegers n)) 1
    where
      rec list 50 = True
      rec list i = if isPalindrome list then
                       False
                   else
                       rec (nextStep list) (i + 1)

main = do
  putStrLn (show (length (filter isLychrel [1..9999])))