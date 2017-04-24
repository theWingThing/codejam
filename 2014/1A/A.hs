import Control.Monad (forM_)
import Data.List as List (filter, foldr1, intersect, map, null, partition)
import Data.Map as Map
import Data.Maybe as Maybe
import Text.Printf (printf)
import Debug.Trace

main = do
    t <- readLn :: IO Int
    forM_ [1..t] $ \i -> do
        [n,l] <- List.map read <$> words <$> getLine :: IO [Int]
        flows <- words <$> getLine
        devices <- words <$> getLine
        printf "Case #%d: %s\n" i $ solve flows devices

-- ONE HOUR COMMITTED ALREADY

solve :: [String] -> [String] -> String
solve flows devices =
    let solve' :: [([String], [String])] -> Maybe Int
        solve' pairs
            | (List.null $ head $ fst $ head pairs) = Just 0
            | List.null keyIntersection || List.null rest = Nothing
            | otherwise = Just $ minimum rest
            where split = List.partition (\s -> head s == '0')
                  group :: ([String], [String]) -> Map Bool [([String], [String])]
                  group (left, right) =
                      let (leftZeroes, leftOnes) = split left
                          (rightZeroes, rightOnes) = split right
                          tails = List.map tail
                          nonempty = List.filter (not . List.null . fst)
                          zeroF m =
                              let v = nonempty
                                      [ (tails leftZeroes, tails rightZeroes)
                                      , (tails leftOnes, tails rightOnes)]
                              in if (length leftZeroes) == (length rightZeroes)
                                 then Map.insert False v m
                                 else m
                          oneF m =
                              let v = nonempty
                                      [ (tails leftZeroes, tails rightOnes)
                                      , (tails leftOnes, tails rightZeroes)]
                              in if (length leftZeroes) == (length rightOnes)
                                 then Map.insert True v m
                                 else m
                      in zeroF $ oneF Map.empty
                  groups = List.map group pairs
                  keyIntersection = List.foldr1 List.intersect $ List.map Map.keys groups
                  solveRest k
                      | k == True = (1+) <$> rest
                      | otherwise = rest
                      where rest = solve' $ concat $ List.map (Map.! k) groups
                  rest = Maybe.catMaybes $ List.map solveRest keyIntersection
    in case solve' [(flows, devices)] of Just x -> show x
                                         Nothing -> "NOT POSSIBLE"
