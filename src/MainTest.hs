{-
   Copyright (C) 2017 Costa Paraskevopoulos.
   Runs QuickCheck on the energy conservation property.
-}

module Main where

import Test.QuickCheck
import Test

-- runs 1000 random tests
main :: IO ()
main = quickCheckWith stdArgs { maxSuccess = 1000 } prop_EnergyConservation
