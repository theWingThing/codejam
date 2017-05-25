import Control.Monad (forM_)
import Control.Monad.ST (runST)
import Data.Array ((!), listArray)
import Data.List (any, foldr, map)
import Data.Set as Set (Set, delete, empty, fromList, insert, member, toList)
import Data.STRef (readSTRef, modifySTRef, newSTRef)
import Text.Printf (printf)

main = do
    t <- readLn :: IO Int
    forM_ [1..t] $ \i -> do
        m <- readLn :: IO Int
        nodes <- mapM (const (map read <$> tail <$> words <$> getLine))
                 [1..m] :: IO [[Int]]
        printf "Case #%d: %s\n" i $ solve nodes

solve :: [[Int]] -> String
solve nodes | solve' = "Yes"
            | otherwise = "No"
    where solve' :: Bool
          solve' =
              let sourceNodes = Set.toList $ source nodes
                              $ Set.fromList [1..len]
              in any hasDiamond sourceNodes
          len = length nodes
          source :: [[Int]] -> Set.Set Int -> Set.Set Int
          source [] left = left
          source (node:nodes) left =
              let left' = foldr delete left node
              in source nodes left'
          hasDiamond :: Int -> Bool
          hasDiamond node =
              let nodeArray = listArray (1, len) nodes
                  dfs :: [Int] -> Set Int -> Bool
                  dfs [] visited = False
                  dfs (n:ns) visited
                      | member n visited = True
                      | otherwise =
                          let neighbors = nodeArray ! n
                          in dfs (neighbors ++ ns) $ insert n visited
              in dfs [node] $ Set.empty
