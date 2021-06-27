module Main where

import Graphics.Gloss
import Life
import Logic
import Rendering

windowSize :: (Int, Int)
windowSize = (640, 640)

windowPos :: (Int, Int)
windowPos = (100, 100)

window :: Display
window = InWindow "Conway's game of life" windowPos windowSize

bgColor :: Color
bgColor = black

stepsPerSecond :: Int
stepsPerSecond = 15

main :: IO ()
-- FixMe: Initial Life should get some kind of input to decide what initial cells are on
-- TODO: Take argument for grid side length and steps per second
main =
     play window bgColor stepsPerSecond initialLife lifeToPicture eventHandler stepLife
     where initialLife = mkInitialLife $ cycle [Alive, Dead, Dead, Alive, Alive, Dead]
