{-
   Copyright (C) 2017 Costa Paraskevopoulos.
   Implements functions that progress particle simulation.
-}

module Simulation (moveParticle, accelerate, advanceWorld) where

import World
import Physics

-- moves a particle according to its velocity for the given number of (simulated) seconds
moveParticle :: Float -> Particle -> Particle
moveParticle t (Particle m p@(px, py) v@(vx, vy))
  = Particle m (px + deltaX, py + deltaY) v -- only change the position
  where
    deltaX = vx * t -- change the position component-wise
    deltaY = vy * t

-- accelerates a particle in dependence on the gravitational force excerted by all other particles for the given number of (simulated) seconds
accelerate :: Float -> [Particle] -> [Particle]
accelerate t []         = []
accelerate t all@(p:ps) = accelerate' t p all ps
  where

    -- accelerates all particles by maintaining a list of particles left to accelerate
    accelerate' :: Float -> Particle -> [Particle] -> [Particle] -> [Particle]
    accelerate' t toAccelerate all []               = [accelerateOne t toAccelerate all]
    accelerate' t toAccelerate all remaining@(r:rs) = accelerateOne t toAccelerate all : (accelerate' t r all rs)

    -- updates the velocity of one particle based on the force between it and all the other particles
    accelerateOne :: Float -> Particle -> [Particle] -> Particle
    accelerateOne t p1 []     = p1
    accelerateOne t p1 (p:ps) = accelerateOne t (updateVelocity t p1 p) ps

    -- changes velocity of one particle based on force between that particle and another particle
    updateVelocity :: Float -> Particle -> Particle -> Particle
    updateVelocity t p1@(Particle m p v@(vx, vy)) p2 = Particle m p (vx + deltaVx, vy + deltaVy)
      where
        (ax, ay) = force p1 p2
        deltaVx  = ax * t
        deltaVy  = ay * t

-- progress the World state by updating the velocity and position of all particles
advanceWorld :: unused -> Float -> World -> World
advanceWorld u f w@(World f1 f2 f3 p) = World f1 f2 f3 p''
  where
    p'  = accelerate    (f * f3) p
    p'' = moveParticles (f * f3) p'

    -- updates position of all particles
    moveParticles :: Float -> [Particle] -> [Particle]
    moveParticles t []     = []
    moveParticles t (p:ps) = moveParticle t p : moveParticles t ps
