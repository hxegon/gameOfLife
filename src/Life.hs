module Life where

import Data.Array (Array, Ix (range), array)

gridSideLen :: Int
gridSideLen = 20

data Cell = Alive | Dead deriving (Show, Eq)

type Grid = Array (Int, Int) Cell

data Life = Life
  { --
    lifeGrid :: Grid,
    generation :: Integer
  }
  deriving (Show, Eq)

mkGrid :: Int -> [Cell] -> Grid
mkGrid sideLen cells =
  array gridBounds $ zip (range gridBounds) cells
  where
    gridBounds = ((0, 0), (sideLen -1, sideLen -1))

mkInitialLife :: [Cell] -> Life
mkInitialLife cells =
  Life
    { lifeGrid = mkGrid gridSideLen cells,
      generation = 0
    }