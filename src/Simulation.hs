{-
   Copyright (C) 2017 Costa Paraskevopoulos.
   Implements functions that progress particle simulation.
-}

module Simulation (moveParticle, accelerate, advanceWorld) where
  
import World
import Physics

-- move a particle according to its velocity for the given number of (simulated) seconds
moveParticle :: Float -> Particle -> Particle
moveParticle t (Particle m p@(px, py) v@(vx, vy)) =
  Particle m (px + deltaX, py + deltaY) v -- only change the position
  where
    deltaX = vx * t -- change position component-wise
    deltaY = vy * t

-- accelerate a particle in dependence on the gravitational force excerted by all other particles for the given number of (simulated) seconds
accelerate :: Float -> [Particle] -> [Particle]
accelerate f p = p -- TODO

-- progress the World state
advanceWorld :: unused -> Float -> World -> World
advanceWorld u f w = w -- TODO
