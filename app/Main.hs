module Main where

import Control.Monad (replicateM, when)
import Data.Maybe (mapMaybe)
import Graphics.Gloss
import Life
import Logic
import Rendering
import System.Environment (getArgs)
import System.Random (randomRIO)
import Text.Read (readMaybe)

windowSize :: (Int, Int)
windowSize = (640, 640)

windowPos :: (Int, Int)
windowPos = (100, 100)

window :: Display
window = InWindow "Conway's game of life" windowSize windowPos

bgColor :: Color
bgColor = black

main :: IO ()
-- TODO: Take argument for grid side length and steps per second
main = do
  args <- getArgs
  when (length args /= 2) $ error "Usage: stack run <side length> <steps per second>"

  let intArgs = mapMaybe readMaybe args
  when (length intArgs /= 2) $ error "Arguments weren't valid numbers"

  -- Seems like a gross way to do this, but intArgs is guaranteed to have 2
  -- elements at this point so, works for now
  let stepsPerSecond = intArgs !! 0
  let gridsize = intArgs !! 1

  rInts <- replicateM (gridsize ^ 2) (randomRIO (0, 1))
  let initLife = mkInitialLife gridsize $ map intAsCell rInts
  simulate window bgColor stepsPerSecond initLife lifeAsPicture stepLife
