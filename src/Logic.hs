module Logic where

import Data.Array
import Data.Ix (inRange)
import Data.Maybe (mapMaybe)
import Life

-- Like ! but returns Nothing when i is out of bounds Just e when it isn't
-- Why isn't this in Data.Array?
readArray :: Ix i => Array i e -> i -> Maybe e
readArray arr i =
  if inRange (bounds arr) i
    then Just (arr ! i)
    else Nothing

rules :: Cell -> Int -> Cell
rules Alive 2 = Alive
rules Alive 3 = Alive
rules Dead 3 = Alive
rules _ _ = Dead

adjacentIndexes :: (Int, Int) -> [(Int, Int)]
-- Simple implementation, but obvious as hell what it's doing.
adjacentIndexes (x, y) = 
    [ (x-1, y-1), (x, y-1), (x+1, y-1),
      (x-1, y),             (x+1, y),
      (x-1, y+1), (x, y+1), (x+1, y+1) ]

livingNeighbors :: Grid -> (Int, Int) -> Int
livingNeighbors g coord =
  length . filter (== Alive) . mapMaybe (readArray g) $ adjacentIndexes coord

stepCell :: Grid -> ((Int, Int), Cell) -> ((Int, Int), Cell)
stepCell grid (coord, cell) = (coord, rules cell $ livingNeighbors grid coord)

stepGrid :: Grid -> Grid
stepGrid g = g // map (stepCell g) (assocs g)

stepLife :: a -> b -> Life -> Life
stepLife _ _ l = Life nextGrid $ generation l + 1
  where
    nextGrid = stepGrid $ lifeGrid l