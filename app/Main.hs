module Main where

import Control.Monad (replicateM)
import Graphics.Gloss
import Life
import Logic
import Rendering
import System.Random (randomRIO)

windowSize :: (Int, Int)
windowSize = (640, 640)

windowPos :: (Int, Int)
windowPos = (100, 100)

window :: Display
window = InWindow "Conway's game of life" windowSize windowPos

bgColor :: Color
bgColor = black

stepsPerSecond :: Int
stepsPerSecond = 15

main :: IO ()
-- TODO: Take argument for grid side length and steps per second
main = do
  rInts <- replicateM (gridSideLen * gridSideLen) (randomRIO (0, 1))
  let initLife = mkInitialLife $ map intAsCell rInts
  simulate window bgColor stepsPerSecond initLife lifeAsPicture stepLife
