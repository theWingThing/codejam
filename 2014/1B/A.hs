import Control.Monad (forM_, mapM)
import Data.List ((!!), foldr, head, map, sort, sum)
import Text.Printf (printf)

main = do
    t <- readLn :: IO Int
    forM_ [1..t] $ \i -> do
        n <- readLn :: IO Int
        strings <- mapM (const getLine) [1..n]
        printf "Case #%d: %s\n" i $ solve strings

solve :: [String] -> String
solve strings
    | any (\s -> head stringsNoRepeats /= s) stringsNoRepeats = "Fegla Won"
    | otherwise = show distances
    where stringsNoRepeats = map removeRepeats strings
          transformedStrings = map transform strings
          groups = group transformedStrings
          medians = map median groups
          distance :: (Int, [Int]) -> Int
          distance (m, ns) = sum $ map (\n -> abs $ n-m) ns
          distances = sum $ map distance $ zip medians groups

group :: [[Int]] -> [[Int]]
group [] = []
group counts =
    let g :: [Int] -> [[Int]] -> [[Int]]
        g [] [] = []
        g (a:as) (b:bs) = (a:b):(g as bs)
    in foldr g (replicate (length $ head counts) []) counts

median :: [Int] -> Int
median ns
    | length ns `mod` 2 == 1 = sortedNs !! ((length ns - 1) `div` 2)
    | otherwise = midSum `div` 2 + (if midSum `mod` 2 == 1 then 1 else 0)
    where sortedNs = sort ns
          half = length ns `div` 2
          midSum = (sortedNs !! half) + (sortedNs !! (half-1))

removeRepeats :: String -> String
removeRepeats [] = []
removeRepeats (c:cs) =
    let removeRepeats' :: String -> Char -> String
        removeRepeats' [] _ = []
        removeRepeats' (c:cs) prev
            | c == prev = removeRepeats' cs prev
            | otherwise = c:(removeRepeats' cs c)
    in c:(removeRepeats' cs c)

transform :: String -> [Int]
transform [] = []
transform (c:cs) =
    let transform' :: String -> Char -> Int -> [Int]
        transform' [] _ acc = [acc]
        transform' (c:cs) prev acc
            | c == prev = transform' cs prev $ acc+1
            | otherwise = acc:(transform' cs c 1)
    in transform' cs c 1
