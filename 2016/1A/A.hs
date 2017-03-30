import Control.Monad (forM_)
import Data.Foldable (toList)
import Data.List as List
import Data.Sequence as Seq
import Text.Printf (printf)

main = do
    t <- readLn :: IO Int
    forM_ [1..t] $ \i -> do
        s <- getLine
        printf "Case #%d: %s\n" i $ solve s

solve :: String -> String
solve s =
    let add :: Seq Char -> Char -> Seq Char
        add seq c
            | head Seq.:< _ <- Seq.viewl seq =
                if c >= head then c Seq.<| seq
                else seq Seq.|> c
            | otherwise = Seq.singleton c
    in toList $ List.foldl add Seq.empty s
