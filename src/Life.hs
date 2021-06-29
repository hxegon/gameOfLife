module Life where

import Data.Array (Array, Ix (range), array)

data Cell = Alive | Dead deriving (Show, Eq)

type Grid = Array (Int, Int) Cell

data Life = Life
  { lifeGrid :: Grid,
    generation :: Integer
  }
  deriving (Show, Eq)

intAsCell :: Int -> Cell
intAsCell n = if even n then Alive else Dead

mkGrid :: Int -> [Cell] -> Grid
mkGrid sideLen cells =
  array gridBounds $ zip (range gridBounds) cells
  where
    gridBounds = ((0, 0), (sideLen -1, sideLen -1))

mkInitialLife :: Int -> [Cell] -> Life
mkInitialLife gridsize cells =
  Life
    { lifeGrid = mkGrid gridsize cells,
      generation = 0
    }