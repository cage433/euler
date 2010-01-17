import Data.List

allpairs list1 list2 = rec list1 list2 []
    where
      rec [] _ acc = reverse acc
      rec (x:xs) [] acc = rec xs list2 acc
      rec (x:xs) (y:ys) acc = rec (x:xs) ys ((x, y):acc)

integerList base n = rec n []
    where rec n acc
                  | n < base = n : acc
                  | otherwise = rec (div n base) ((mod n base) : acc)

decimalIntegers = integerList 10

sumDecimalIntegers n = foldr (+) 0 (decimalIntegers n)

power (a, b) = a^b

main = do
  let powers = map (sumDecimalIntegers . power) (allpairs [1..100] [1..100])
  let biggest = (head . reverse .sort) powers
  putStrLn (show biggest)
  

