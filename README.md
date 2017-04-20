# ParticleSimulation
Computes the motion of particles over time under the influence of the gravitational force acting between the particles

This simulator was built and tested on Ubuntu 16.04 LTS using GHC version 7.10.3. The simulator uses the Gloss graphics library, which can be installed using `cabal install gloss`.

* The simulator can be built by running `make`.
* To launch a simulation, run
```
./particles <world description>
```
where `world description` is a file containing the canonical pretty printing of the World data type
```
data World = World Float Float Float [Particle]
```
as defined in `World.hs`.
* Two World configurations `SunEarth.world` and `FourParticles.world` are provided.
* The simulator can be tested by running `make test`.

Copyright (C) 2017 Costa Paraskevopoulos

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
