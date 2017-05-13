import Control.Monad (forM_)
import Text.Printf (printf)
import Debug.Trace

main = do
    t <- readLn :: IO Int
    forM_ [1..t] $ \i -> do
        [a,b] <- map read <$> words <$> getLine :: IO [Int]
        ps <- map read <$> words <$> getLine :: IO [Double]
        printf "Case #%d: %f\n" i $ solve a b ps

solve :: Int -> Int -> [Double] -> Double
solve a b ps =
    let pis = calculatePis ps
        calculateExpected :: [Double] -> Int -> [Double]
        calculateExpected [] _ = []
        calculateExpected (pi:pis) i =
            let c = b-a+1
                next = (fromIntegral $ c+2*(a-i)) + (1-pi)*(fromIntegral $ b+1)
            in next:(calculateExpected pis $ i+1)
        expected = calculateExpected pis 0
        giveUp = fromIntegral $ 1 + b + 1
    in minimum $ giveUp:(expected)

calculatePis :: [Double] -> [Double]
calculatePis ps =
    let calculatePis' :: [Double] -> Double -> [Double]
        calculatePis' [] acc = [acc]
        calculatePis' (p:ps) acc =
            let next = p*acc
            in acc:(calculatePis' ps next)
    in calculatePis' ps 1
