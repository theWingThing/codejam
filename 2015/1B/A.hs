import Control.Monad (forM_)
import Data.List as List
import Data.Sequence as Seq
import Data.Set as Set
import Text.Printf (printf)
import Debug.Trace

main = do
    t <- readLn :: IO Int
    forM_ [1..t] $ \i -> do
        n <- readLn :: IO Int
        printf "Case #%d: %d\n" i $ solve n

solve :: Int -> Int
solve n =
    let solve' :: Int -> Int -> Int
        solve' current target
            -- if it ends in 0, we try solving for the thing before
            -- | target `mod` 10 == 0 = 1 + (solve' current $ target-1)
            -- if too short, get to the right length
            | target `mod` 10 == 0 = solve' current (target - 1) + 1
            | currentLen < targetLen =
                let nines = read $ List.replicate currentLen '9'
                    next_len_cost = (solve' current nines) + 1
                in next_len_cost + (solve' (nines+1) target)
            | targetLen == 1 = target
            | leftHalfTarget == 1 = rightHalfTarget - rightHalfCurr
            | otherwise =
                -- inc left till target
                -- rev
                -- inc right half starting from 1
                (leftHalfTarget - rightHalfCurr) + 1 + (rightHalfTarget - 1)
            where targetLen = List.length targetS
                  currentLen = List.length currentS
                  currentS = show current
                  targetS = show target
                  leftHalfTarget = read $ '0':(List.reverse
                                             $ List.take leftLen targetS)
                  leftLen =  currentLen `div` 2
                  rightHalf = read . (List.drop leftLen)
                  rightHalfTarget = rightHalf targetS
                  rightHalfCurr = rightHalf currentS
    in solve' 0 n
