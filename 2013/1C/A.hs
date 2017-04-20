import Control.Monad (forM_)
import Data.List (elem, null)
import Text.Printf (printf)

main = do
    t <- readLn :: IO Int
    forM_ [1..t] $ \i -> do
        [s, n] <- words <$> getLine
        printf "Case #%d: %d\n" i $ solve s (read n :: Int)

solve :: String -> Int -> Int
solve s n =
    let preprocessed = preprocess s n
        solve' :: String -> [Int] -> Int -> Int -> Int -> Int
        solve' [] _ _ _ _ = 0
        solve' _ [] _ _ _ = 0
        solve' (c:cs) (p:ps) i n len
            | i+n-1 > p = solve' (c:cs) ps i n len
            | i+n-1 <= p = solve' cs (p:ps) (i+1) n len + len - p
            | otherwise = solve' cs (p:ps) (i+1) n len
    in solve' s preprocessed 0 n $ length s

preprocess :: String -> Int -> [Int]
preprocess s n =
    let preprocess' :: String -> Int -> Int -> Int -> [Int]
        preprocess' [] _ _ _ = []
        preprocess' (c:cs) i seen n
            | c `elem` vowels = preprocess' cs (i+1) 0 n
            | seen+1 >= n = i:(preprocess' cs (i+1) (seen+1) n)
            | otherwise = preprocess' cs (i+1) (seen+1) n
    in preprocess' s 0 0 n

vowels :: String
vowels = "aeiou"
