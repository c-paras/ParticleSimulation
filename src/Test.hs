{-
   Copyright (C) 2017 Costa Paraskevopoulos.
   Implements a QuickCheck property for energy conservation.
-}

module Test where

import Test.QuickCheck
import TestSupport
import World
import Simulation
import Physics

-- check that the energy ratio after one step < epsilon
prop_EnergyConservation =
  (\w -> getRatio w < (realToFrac epsilon)) :: World -> Bool
  where
    getRatio w = if oldEnergy == 0
                 then 0
                 else abs (oldEnergy - newEnergy) / oldEnergy
      where
        oldEnergy = worldEnergy w -- current energy
        newEnergy = worldEnergy $ advanceWorld foo 0.001 w -- energy after one step of time 0.001
        foo = 42 -- unused by advanceWorld
