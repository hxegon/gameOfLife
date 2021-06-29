module Rendering where

import Data.Array
import Graphics.Gloss
import Life

-- FixMe: Copy of windowSize in app/Main.hs
size :: (Int, Int)
size = (640, 640)

cellAsPicture :: (Float, Float) -> Cell -> Picture
cellAsPicture cellSize cell = color (cellColor cell) $ rectangleSolid height width
  where
    (height, width) = cellSize
    cellColor Dead = greyN 0.15
    cellColor Alive = greyN 0.85

-- FixMe: Rotates everything by -90.0°
snapPictureToCoord :: (Float, Float) -> Picture -> (Int, Int) -> Picture
snapPictureToCoord (width, height) p (row, col) = translate x y p
  where
    x = (fromIntegral row * width) + (width * 0.5)
    y = (fromIntegral col * height) + (height * 0.5)

gridAsPicture :: Grid -> Picture
gridAsPicture grid =
  pictures $
    map
      (\(coord, cell) ->
          snapPictureToCoord cellSize (cellAsPicture cellSize cell) coord)
      $ assocs grid
  where
    gridSideLen = snd . snd $ bounds grid
    cellSize =
      ( (fromIntegral . fst $ size) / fromIntegral gridSideLen,
        (fromIntegral . snd $ size) / fromIntegral gridSideLen
      )

-- TODO: Render generation
lifeAsPicture :: Life -> Picture
-- rotate 90.0 because snapPictureToCoord outputs picture with everything rotated -90.0
lifeAsPicture life =
  rotate 90.0 $ translate x y $ gridAsPicture $ lifeGrid life
  where
    x = fromIntegral (fst size) * (- 0.5)
    y = fromIntegral (snd size) * (- 0.5)