import Control.Monad (forM_)
import Data.Bits (shiftR)
import Data.Maybe as Maybe
import Text.Printf (printf)

ancestors = 2^40

main = do
    t <- readLn :: IO Int
    forM_ [1..t] $ \i -> do
        s <- getLine
        let notSlash c = c /= '/'
            num = read $ takeWhile notSlash s :: Int
            denom = read $ tail $ dropWhile notSlash s
        printf "Case #%d: %s\n" i $ solve num denom

factor :: (Int,Int) -> (Int,Int)
factor (a,b) = let f = gcd a b
               in (a `div` f, b `div` f)

log2 :: Int -> Int
log2 1 = 0
log2 n = log2 (shiftR n 1) + 1

solve :: Int -> Int -> String
solve num denom =
    let (num',denom') = factor (num,denom)
        solve' :: Int -> Int -> Maybe Int
        solve' num denom
            | ancestors `mod` denom /= 0 = Nothing
            | otherwise = Just $ 40 - (log2 $ ancestors `div` denom * num)
    in case solve' num' denom' of
           Nothing -> "impossible"
           Just n -> show n
