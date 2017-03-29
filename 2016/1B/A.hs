import Control.Monad (forM_)
import Data.List as List
import Data.Map.Strict as Map
import Text.Printf (printf)
import Debug.Trace

main = do
    t <- readLn :: IO Int
    forM_ [1..t] $ \i -> do
        s <- getLine
        printf "Case #%d: %s\n" i $ solve s

solve :: String -> String
solve s =
    let charCount = List.foldr increment Map.empty s
    in List.sort $ getNumbers charCount

getNumbers :: Map.Map Char Int -> String
getNumbers charCount =
    let stepMap = Map.fromList [(0, letterMap), (1, letterMap'), (2, letterMap'')]
        getNumbers' :: Map.Map Char Int -> Int -> String -> String
        getNumbers' charCount step acc
            | Just lm <- step `Map.lookup` stepMap =
                let removeLetters :: [(Char, [String])] -> Map.Map Char Int -> String -> (String, Map.Map Char Int)
                    removeLetters [] charCount ret = (ret, charCount)
                    removeLetters ((c, [word]):rest) charCount acc =
                        let count = Map.findWithDefault 0 c charCount
                            newCharCount = List.foldr (\k -> Map.insertWith (flip (-)) k count) charCount word
                        in removeLetters rest newCharCount $ replicate count (numberMap Map.! word) ++ acc
                    (newAcc, newCharCount) = removeLetters lm charCount acc
                in getNumbers' newCharCount (step+1) newAcc
            | otherwise = acc
    in getNumbers' charCount 0 ""

increment :: Char -> Map.Map Char Int -> Map.Map Char Int
increment c m =
    let current = Map.findWithDefault 0 c m
    in Map.insert c (current+1) m

numbers = [ "ZERO", "ONE", "TWO", "THREE", "FOUR", "FIVE", "SIX" , "SEVEN" , "EIGHT", "NINE"]
numberMap = Map.fromList $ zip numbers ['0'..'9']

-- for finding the unique letters to look for
uniques :: [(Char, [String])] -> [(Char, [String])]
uniques = List.filter (\(_,b) -> length b == 1)

getLetterMap :: [String] -> [(Char, [String])]
getLetterMap numbers = uniques $  List.map (\letter -> (letter, List.filter (elem letter) numbers)) ['A'..'Z']

letterMap = getLetterMap numbers
letterMap' = getLetterMap ["ONE", "THREE", "FIVE", "SEVEN", "NINE"]
letterMap'' = getLetterMap ["NINE"]
