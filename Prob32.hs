import Data.List

perms = permutations [1..9]

integerList base n = rec n []
    where rec n acc
                  | n < base = n : acc
                  | otherwise = rec (div n base) ((mod n base) : acc)

decimalIntegers = integerList 10

listToInt base list = rec list 0
    where rec [] acc = acc
          rec (x:xs) acc = rec xs (x + acc * base)

decimalListToInt = listToInt 10


terms (a : b : c : d : e : rest) = (decimalListToInt [a, b], decimalListToInt [c, d, e], decimalListToInt rest)
terms2 (a : b : c : d : e : rest) = (a, decimalListToInt [b, c, d, e], decimalListToInt rest)

isProduct (a, b, c) = a * b == c

panterms = (filter isProduct (map terms perms)) ++ (filter isProduct (map terms2 perms))

third (a, b, c) = c
main = do
  putStrLn (show (foldl (+) 0 (nub (map third panterms))))