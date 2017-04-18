import Control.Monad (forM_)
import Data.List (sort)
import Text.Printf (printf)

main = do
    t <- readLn :: IO Int
    forM_ [1..t] $ \i -> do
        [a,_] <- map read <$> words <$> getLine :: IO [Int]
        motes <- map read <$> words <$> getLine :: IO [Int]
        printf "Case #%d: %d\n" i $ solve a motes

solve :: Int -> [Int] -> Int
solve a motes =
    let solve' :: Int -> [Int] -> Int
        solve' a [] = 0
        solve' a motes@(m:ms)
            | m < a = solve' (a+m) ms
            | a == 1 = length motes
            | otherwise = min (solve' (2*a-1) motes + 1) $ length motes
    in solve' a $ sort motes
