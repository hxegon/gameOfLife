module Rendering where

import Data.Array
import Graphics.Gloss
import Life

-- FixMe: Copy of windowSize in app/Main.hs
size :: (Int, Int)
size = (640, 640)

cellSize :: (Float, Float)
cellSize =
  ( (fromIntegral . fst $ size) / fromIntegral gridSideLen,
    (fromIntegral . snd $ size) / fromIntegral gridSideLen
  )

cellAsPicture :: Cell -> Picture
cellAsPicture cell = color (cellColor cell) $ rectangleSolid height width
  where
    (height, width) = cellSize
    cellColor Dead = greyN 0.15
    cellColor Alive = greyN 0.85

-- FixMe: Rotates everything by -90.0°
snapPictureToCoord :: Picture -> (Int, Int) -> Picture
snapPictureToCoord p (row, col) = translate x y p
  where
    (width, height) = cellSize
    x = (fromIntegral row * width) + (width * 0.5)
    y = (fromIntegral col * height) + (height * 0.5)

gridAsPicture :: Grid -> Picture
gridAsPicture grid =
  pictures $
    map (\(coord, cell) -> snapPictureToCoord (cellAsPicture cell) coord) $
      assocs grid

-- TODO: Render generation
lifeAsPicture :: Life -> Picture
-- rotate 90.0 because snapPictureToCoord outputs picture with everything rotated -90.0
lifeAsPicture life =
  rotate 90.0 $ translate x y $ gridAsPicture $ lifeGrid life
  where
    x = fromIntegral (fst size) * (- 0.5)
    y = fromIntegral (snd size) * (- 0.5)