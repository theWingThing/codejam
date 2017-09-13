import Control.Monad (forM_)
import Control.Monad.ST as ST
import Data.Array.Unboxed as UArray
import Data.Array.ST as STArray
import Data.STRef as STRef
import Text.Printf (printf)
import Debug.Trace

main = do
    t <- readLn :: IO Int
    forM_ [1..t] $ \i -> do
        [r,c] <- map read <$> words <$> getLine :: IO [Int]
        painting <- mapM (const getLine) [1..r]
        printf "Case #%d:\n%s" i $ answer painting r c

answer :: [String] -> Int -> Int -> String
answer painting r c =
    let maybeReds = blueToRed painting r c
    in case maybeReds of
        Just reds -> serializePainting reds
        Nothing -> "Impossible\n"

blueToRed :: [String] -> Int -> Int -> Maybe (UArray.UArray (Int,Int) Char)
blueToRed rows r c
    | result UArray.! (0,0) == '?' = Nothing
    | otherwise = Just result
    where result = runSTUArray $ do
            bluePainting <- newListArray ((0,0), (r-1, c-1)) $ concat rows :: ST.ST s (STUArray s (Int,Int) Char)
            redPainting <- newArray ((0,0), (r-1,c-1)) '.'
            impossibleRef <- newSTRef False
            forM_ [0..r-1] $ \i -> do
                forM_ [0..c-1] $ \j -> do
                    impossible <- readSTRef impossibleRef
                    if not impossible then do
                        rv <- readArray redPainting (i,j)
                        b <- readArray bluePainting (i,j)
                        if b == '#' then
                            if rv == '.' then do
                                if j+1 < c && i+1 < r then do
                                    -- check range
                                    bs <- mapM (readArray bluePainting) [(i,j+1), (i+1,j), (i+1,j+1)]
                                    if all ('#'==) bs then do
                                        -- if all blue write all reds
                                        writeArray redPainting (i,j) '/'
                                        writeArray redPainting (i,j+1) '\\'
                                        writeArray redPainting (i+1,j) '\\'
                                        writeArray redPainting (i+1,j+1) '/'
                                        -- remove those blues
                                        mapM_ (\p -> writeArray bluePainting p '.') [(i,j), (i+1,j), (i,j+1), (i+1,j+1)]
                                    else writeSTRef impossibleRef True
                                else writeSTRef impossibleRef True
                            else writeSTRef impossibleRef True
                        else return ()
                    else return ()
            impossible <- readSTRef impossibleRef
            if impossible then writeArray redPainting (0,0) '?' else return ()
            return redPainting

serializePainting :: UArray.UArray (Int,Int) Char -> String
serializePainting painting =
    let f :: Int -> Int -> String
        f i j
            | i == r = ""
            | j == c = '\n':f (i+1) 0
            | otherwise = (painting UArray.! (i,j)):(f i $ j+1)
        (_,(br,bc)) = bounds painting
        (r,c) = (br+1, bc+1)
    in f 0 0
