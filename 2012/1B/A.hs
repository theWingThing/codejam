import Control.Monad (forM_)
import Data.List (intersperse, sort)
import Data.Map as Map ((!), fromList)
import Text.Printf
import Debug.Trace

main = do
    t <- readLn :: IO Int
    forM_ [1..t] $ \i -> do
        n:cs <- map read <$> words <$> getLine :: IO [Int]
        printf "Case #%d: %s\n" i $ solve n cs

solve :: Int -> [Int] -> String
solve n cs =
    let x = fromIntegral $ sum cs
        getMapping' :: [Int] -> [(Int, Double)] -> Double -> Int -> Int
                    -> [(Int, Double)]
        getMapping' (c:cs) [] 0 0 0 = getMapping' cs [(c,0)] 0 1 c
        getMapping' allCs seen yacc count curr
            | null allCs = done
            | (fromIntegral count) * y >= (1-yacc) =
                done ++ (map (\n -> (n,0)) allCs)
            | otherwise =
                let 
                    newSeen = (c,0.0):(map (\(a,b) -> (a, b+y)) seen)
                    newYacc = yacc + (fromIntegral count) * y
                    newCount = count+1
                    newCurr = c
                in getMapping' cs newSeen newYacc newCount newCurr
            where diff = fromIntegral $ c-curr
                  y = diff / x
                  t = (1 - yacc) / (fromIntegral count)
                  done = map (\(a,b) -> (a, b+t)) seen
                  c:cs = allCs
        solve' :: [Int] -> [Double]
        solve' cs =
            let mapping = getMapping' (sort cs) [] 0 0 0
                _map = Map.fromList mapping
            in map (\c -> _map ! c) cs
    in concat $ intersperse " " $ map show $ map (*100) $ solve' cs
