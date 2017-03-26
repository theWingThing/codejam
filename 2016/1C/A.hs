import Control.Monad (forM_)
import Data.List as List
import Text.Printf (printf)
import Debug.Trace

main = do
    t <- readLn :: IO Int
    forM_ [1..t] $ \i -> do
        n <- readLn :: IO Int
        ps <- map read <$> words <$> getLine :: IO [Int]
        printf "Case #%d: %s\n" i $ solve ps

solve :: [Int] -> String
solve ps =
    let senators = reverse $ List.sort $ zip ps ['A'..'Z']
        total = sum $ map fst senators
        format :: [String] -> String
        format s = concat $ List.intersperse " " s
        solve' :: [(Int, Char)] -> Int -> [String]
        solve' senators sum'
            | finished senators = []
            | otherwise =
                let (firstChar, firstSenators) = nextChar senators
                    firstSum = sum'-1
                    (secondChar, secondSenators) = nextChar firstSenators
                    secondSum = sum'-2
                in if (not $ finished firstSenators) &&
                          (hasMajority firstSenators firstSum) then
                       [firstChar, secondChar]:(solve' secondSenators secondSum)
                   else
                       [firstChar]:(solve' firstSenators firstSum)
            where finished :: [(Int,Char)] -> Bool
                  finished l = (fst $ head l) == 0
    in format $ solve' senators total

nextChar :: [(Int,Char)] -> (Char, [(Int,Char)])
nextChar ((count,char):rest) = (char, insertSorted (count-1,char) rest)

hasMajority :: [(Int, Char)] -> Int -> Bool
hasMajority ((count,_):_) sum' = count > sum' `div` 2

insertSorted :: (Int, a) -> [(Int, a)] -> [(Int, a)]
insertSorted a [] = [a]
insertSorted a@(a0,_) ((b@(b0,_)):bs) =
    if a0 >= b0 then a:b:bs
    else b:(insertSorted a bs)
