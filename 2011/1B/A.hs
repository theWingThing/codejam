import Control.Monad (forM_)
import Data.List as List
import Data.Map as Map
import Text.Printf (printf)
import Debug.Trace

type Games = Int
type Wins = Int

main = do
    t <- readLn :: IO Int
    forM_ [1..t] $ \i -> do
        n <- readLn :: IO Int
        schedule <- mapM (const getLine) [1..n]
        let rpiStrings = (concat $ List.intersperse "\n" $ answer schedule)
        printf ("Case #%d:\n" ++ rpiStrings ++ "\n") i

answer :: [String] -> [String]
answer schedule =
    let teams = [0..teamMax]
        teamMax = length schedule - 1
        stringSchedMap = Map.fromList $ zip [0..] schedule :: Map.Map Int String
        countMap = countGamesAndWins stringSchedMap
        schedMap = convertFromStrings stringSchedMap
        toMap :: (Int -> b) -> Map.Map Int b
        toMap f = Map.fromList $ zip teams $ List.map f teams
        oowpMap = toMap $ oowp owpMap schedMap teamMax
        owpMap = toMap $ owp countMap schedMap teamMax
        wpMap = toMap $ wp countMap
    in List.map (\k -> show $ rpi (wpMap Map.! k) (owpMap Map.! k) (oowpMap Map.! k)) teams

-- converts to map so we can access by tuple
convertFromStrings :: Map.Map Int String -> Map.Map (Int, Int) Char
convertFromStrings schedMap =
    let acc :: Int
            -> String
            -> Map.Map (Int, Int) Char
            -> Map.Map (Int, Int) Char
        acc k s prev = List.foldr (\(a,v) p -> Map.insert (k,a) v p) prev $ zip [0..] s
    in Map.foldrWithKey acc Map.empty schedMap

countGamesAndWins :: Map.Map Int String
                  -> Map.Map Int (Games, Wins)
countGamesAndWins schedMap =
    let count :: (Games, Wins) -> String -> (Games, Wins)
        count (a,b) [] = (a,b)
        count (a,b) (c:cs) =
            let a' = a + if c /= '.' then 1 else 0
                b' = b + if c == '1' then 1 else 0
            in count (a', b') cs
    in Map.map (count (0,0)) schedMap

opponents :: Map.Map (Int,Int) Char -> Int -> Int -> [Int]
opponents schedMap teamMax team =
    let possibleOpponents = zip (repeat team) $
            List.filter (team /=) [0..teamMax]
    in List.map snd $
            List.filter (\k -> schedMap Map.! k /= '.') possibleOpponents

oowp :: Map.Map Int Double -> Map.Map (Int,Int) Char -> Int -> Int -> Double
oowp owpMap schedMap teamMax team =
    let owps = List.map (owpMap Map.!) $ opponents schedMap teamMax team
        games = length owps
    in sum owps / (fromIntegral games)

owp :: Map.Map Int (Games, Wins)
    -> Map.Map (Int,Int) Char
    -> Int
    -> Int
    -> Double
owp countMap schedMap teamMax team =
    let (games, _) = countMap Map.! team
        owp' :: Int -> Double
        owp' otherTeam =
            let (otherGames, otherWins) = countMap Map.! otherTeam
                c = if schedMap Map.! (team, otherTeam) == '0' then (-1) else 0
            in (fromIntegral $ otherWins + c) / (fromIntegral $ otherGames - 1)
    in sum (List.map owp' $ opponents schedMap teamMax team) / (fromIntegral games)

rpi :: Double -> Double -> Double -> Double
rpi wp owp oowp =
    0.25*wp + 0.5*owp + 0.25*oowp

wp :: Map.Map Int (Games, Wins) -> Int -> Double
wp countMap team =
    let (games, wins) = countMap Map.! team
    in (fromIntegral wins) / (fromIntegral games)
