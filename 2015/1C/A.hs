import Control.Monad (forM_)
import Text.Printf (printf)

main = do
    t <- readLn :: IO Int
    forM_ [1..t] $ \i -> do
        [r,c,w] <- map read <$> words <$> getLine
        printf "Case #%d: %d\n" i $ solve r c w

solve :: Int -> Int -> Int -> Int
solve r c w =
    let clearCost = c `div` w
        -- wrongRowsCost = (r-1) * clearCost
        -- rightRowClearCost = c `div` w
        finishCost = if c `mod` w == 0 then w-1 else w
    in r * clearCost + finishCost
