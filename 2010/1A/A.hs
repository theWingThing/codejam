import Control.Monad (forM_)
import Data.Array.Unboxed as UArray
import Text.Printf (printf)
import Debug.Trace

type BlueWin = Bool
type RedWin = Bool

main = do
    t <- readLn :: IO Int
    forM_ [1..t] $ \i -> do
        [n,k] <- map read <$> words <$> getLine :: IO [Int]
        board <- mapM (const getLine) $ [1..n]
        printf "Case #%d: %s\n" i $ answer board n k

answer :: [String] -> Int -> Int -> String
answer start n k =
    let board = boardToArray (rotateBoard start n) n
        (bRight, rRight) = checkRight board n k
        (bDown, rDown) = checkDown board n k
        (bDownRight, rDownRight) = checkDownRight board n k
        (bUpRight, rUpRight) = checkUpRight board n k
        blueWin = or [bRight, bDown, bDownRight, bUpRight]
        redWin = or [rRight, rDown, rDownRight, rUpRight]
    in case (blueWin, redWin) of
        (True,True) -> "Both"
        (True, False) -> "Blue"
        (False, True) -> "Red"
        (False, False) -> "Neither"

boardToArray :: [String] -> Int -> UArray.UArray (Int,Int) Char
boardToArray board n =
    UArray.listArray ((0,0), (n-1,n-1)) $ concat board

checkDown :: UArray.UArray (Int,Int) Char -> Int -> Int -> (BlueWin, RedWin)
checkDown board n k =
    let f :: Int -> Int -> Int -> Int -> (Bool, Bool)
        f r c bCount rCount 
            | c == n = (False,False)
            | r == n = f 0 (c+1) 0 0
            | otherwise = rest board f k r c bCount rCount (+1) id
    in f 0 0 0 0

checkDownRight :: UArray.UArray (Int,Int) Char -> Int -> Int -> (BlueWin, RedWin)
checkDownRight board n k =
    let f :: Int -> Int -> Int -> Int -> (Bool, Bool)
        f r c bCount rCount
            | (r == n) || (c == n) = (False, False)
            | otherwise = rest board f k r c bCount rCount (+1) (+1)
        leftStarts = zip [0..n] $ repeat 0
        topStarts = zip (repeat 0) [0..n]
        starts = leftStarts ++ topStarts
    in foldr tupleOr (False,False) $ map (\(r,c) -> f r c 0 0) starts

checkUpRight :: UArray.UArray (Int,Int) Char -> Int -> Int -> (BlueWin,RedWin)
checkUpRight board n k =
    let f :: Int -> Int -> Int -> Int -> (Bool, Bool)
        f r c bCount rCount
            | (r < 0) || (c == n) = (False,False)
            | otherwise = rest board f k r c bCount rCount (+ (-1)) (+1)
        leftStarts = zip [0..n-1] $ repeat 0
        bottomStarts = zip (repeat $ n-1) [0..n-k]
        starts = leftStarts ++ bottomStarts
    in foldr tupleOr (False,False) $ map (\(r,c) -> f r c 0 0) starts

checkRight :: UArray.UArray (Int,Int) Char -> Int -> Int -> (BlueWin, RedWin)
checkRight board n k =
    let f :: Int -> Int -> Int -> Int -> (Bool, Bool)
        f r c bCount rCount
            | r == n = (False,False)
            | c == n = f (r+1) 0 0 0
            | otherwise = rest board f k r c bCount rCount id (+1)
    in f 0 0 0 0

rest :: UArray.UArray (Int,Int) Char
     -> (Int -> Int -> Int -> Int -> (Bool,Bool))
     -> Int
     -> Int
     -> Int
     -> Int
     -> Int
     -> (Int -> Int)
     -> (Int -> Int)
     -> (Bool,Bool)
rest board f k r c bCount rCount fr fc =
    let bWin = bCount' >= k
        rWin = rCount' >= k
        v = board UArray.! (r,c)
        bCount' = if v == 'B' then bCount+1 else 0
        rCount' = if v == 'R' then rCount+1 else 0
        (bRest, rRest) = f (fr r) (fc c) bCount' rCount'
    in (bWin || bRest, rWin || rRest)

-- takes initial board and then returns what you'd see if looking from bottom
rotateBoard :: [String] -> Int -> [String]
rotateBoard start n =
    map (\s -> take n $ s ++ (repeat '.')) $
        map (reverse . (filter ('.' /=))) start

tupleOr :: (Bool,Bool) -> (Bool,Bool) -> (Bool,Bool)
tupleOr (a0,a1) (b0,b1) = (a0 || b0, a1 || b1)
