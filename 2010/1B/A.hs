import Control.Monad (forM_)
import Data.List as List
import Data.Map as Map
import Text.Printf (printf)

main = do
    t <- readLn :: IO Int
    forM_ [1..t] $ \i -> do
        [n,m] <- List.map read <$> words <$> getLine :: IO [Int]
        start <- mapM (const getLine) [1..n]
        paths <- mapM (const getLine) [1..m]
        let startDir = List.foldr Main.insert Dir{ children=Map.empty } start
            f :: String -> (Dir, Int) -> (Dir,Int)
            f path (dir, i) =
                let (dir', c) = countInsert path dir
                in (dir', c+i)
        printf "Case #%d: %d\n" i $ snd $ List.foldr f (startDir, 0) paths

data Dir = Dir {
    children :: Map String Dir
} deriving (Show)

countInsert :: String -> Dir -> (Dir, Int)
countInsert path dir =
    let splitPath :: String -> [String]
        splitPath "" = []
        splitPath ('/':s) =
            let (dir,rest) = List.span (/= '/') s
            in dir:(splitPath rest)
        countInsert' :: Dir -> [String] -> (Dir, Int)
        countInsert' dir [] = (dir, 0)
        countInsert' dir (p:ps) =
            let m = children dir
                (childDir, inc) =
                    if Map.member p m then (m Map.! p, 0)
                    else (Dir { children = Map.empty }, 1)
                (childDir', c) = countInsert' childDir ps
            in (Dir{ children = Map.insert p childDir' m }, c+inc)
    in countInsert' dir $ splitPath path

insert :: String -> Dir -> Dir
insert path dir =
    fst $ countInsert path dir
