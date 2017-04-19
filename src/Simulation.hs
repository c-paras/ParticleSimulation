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
accelerate t [] = []
--accelerate t all@(p:ps) = (accelerateOne t p all) : (accelerate t ps)
accelerate t all@(p:ps) = accelerate' t p all ps
  where

    -- accelerates all particles by maintaining a list of particles left to accelerate
    accelerate' :: Float -> Particle -> [Particle] -> [Particle] -> [Particle]
    accelerate' t toAccelerate all [] = [accelerateOne t toAccelerate all]
    accelerate' t toAccelerate all remaining@(r:rs) = accelerateOne t toAccelerate all : (accelerate' t r all rs)

    -- updates the velocity of one particle based on the force between it and all the other particles
    accelerateOne :: Float -> Particle -> [Particle] -> Particle
    accelerateOne t p1 [] = p1
    accelerateOne t p1 (p:ps) = accelerateOne t (updateVelocity t p1 p) ps

    -- changes velocity of one particle based on force between that particle and another particle
    updateVelocity :: Float -> Particle -> Particle -> Particle
    updateVelocity t p1@(Particle m p v@(vx, vy)) p2 = Particle m p (vx + deltaVx, vy + deltaVy)
      where
        (ax, ay) = force p1 p2
        deltaVx = ax * t
        deltaVy = ay * t

-- progress the World state
advanceWorld :: unused -> Float -> World -> World
advanceWorld u f w = w -- TODO
