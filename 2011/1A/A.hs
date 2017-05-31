import Control.Monad (forM_)
import Text.Printf (printf)
import Debug.Trace

main = do
    t <- readLn :: IO Int
    forM_ [1..t] $ \i -> do
        [n,pd,pg] <- map read <$> words <$> getLine :: IO [Int]
        printf "Case #%d: %s\n" i $ solve n pd pg

solve :: Int -> Int -> Int -> String
solve n pd pg | solve' = "Possible"
              | otherwise = "Broken"
    where solve' :: Bool
          solve' | pg == 100 = pd == 100
                 | pg == 0 = pd == 0
                 | otherwise = factorsLeft [2,2,5,5] pd <= n

factorsLeft :: [Int] -> Int -> Int
factorsLeft [] b = 1
factorsLeft (a:as) b
    | b `mod` a == 0 = factorsLeft as $ b `div` a
    | otherwise = a * (factorsLeft as b)
