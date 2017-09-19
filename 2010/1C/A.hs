import Control.Monad (forM_)
import Data.List as List
import Text.Printf (printf)

main = do
    t <- readLn :: IO Int
    forM_ [1..t] $ \i -> do
        n <- readLn :: IO Int
        wires <- (map ((map read) . words)) <$> mapM (const getLine) [1..n] :: IO [[Int]]
        printf "Case #%d: %d\n" i $ answer wires

answer :: [[Int]] -> Int
answer wires =
    let sortedWires = List.sort wires
    in count sortedWires

-- assume input is sorted so we only need to check right
count :: [[Int]] -> Int
count [] = 0
count (wire:wires) =
    let r = wire List.!! 1
        c = length $ filter (\w -> r > w List.!! 1) wires
    in c+(count wires)
