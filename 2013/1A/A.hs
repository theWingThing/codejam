import Control.Monad (forM_)
import Data.Bits (shiftL, shiftR)
import Text.Printf (printf)

main = do
    t <- readLn :: IO Int
    forM_ [1..t] $ \i -> do
        [r,t] <- map read <$> words <$> getLine :: IO [Integer]
        printf "Case #%d: %d\n" i $ solve r t

-- 27min for small
-- spent 37 min on large already

solve :: Integer -> Integer -> Integer
solve r t =
    let inSqrt = 4*(r^2) - 4*r + 1 + 8*t
        twoRMinusOne = 2*r-1
    in (1 - 2*r + (squareRoot inSqrt)) `div` 4

squareRoot :: Integer -> Integer
squareRoot n
    | n < 2 && n >= 0 = n
    | otherwise = let small = squareRoot (n `shiftR` 2) `shiftL` 1
                      large = small+1
                  in if large^2 <= n then large
                     else small
