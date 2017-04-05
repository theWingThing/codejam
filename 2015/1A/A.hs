import Control.Monad (forM_)
import Data.List (filter, maximum, zipWith)
import Text.Printf (printf)

main = do
    t <- readLn :: IO Int
    forM_ [1..t] $ \i -> do
        getLine
        mushrooms <- map read <$> words <$> getLine
        printf "Case #%d: %d %d\n" i (solve0 mushrooms) (solve1 mushrooms)

differences :: [Int] -> [Int]
differences ns = map (max 0) $ zipWith (-) ns $ tail ns

solve0 :: [Int] -> Int
solve0 mushrooms = sum $ differences mushrooms

solve1 :: [Int] -> Int
solve1 mushrooms =
    let ds = differences mushrooms
        rate = maximum ds
    in sum $ map (min rate) $ tail $ reverse mushrooms
