# Neopixel-controller
# Problem
- Individual LEDs can only be accessed linearly - user needs to perform calculations based on position for a grid of NeoPixels
- Calculating this position is time consuming, tedious, and error prone

# Goal
- Create a SCOMP peripheral that performs XY coordinate translation to an address for the NeoPixel on a LED grid display
- This will help the existing NeoPixel peripheral to remain focused on just controlling the pixels
- The created peripheral will be demonstrated with a game

# Tech stack
- The code is written in assembly (the game source code is not included here)
- This repo also contains VHDL code for the SCOMP (simple computer, like the LC3) which runs the neopixel controller

# Peripheral Overview
- A peripheral that can calculate neopixel address after any input change in a state machine format
- Multiple inputs for additional matrix manipulation
- All matrix data values (i.e. x, y, # rows, and # columns) can be read into SCOMP individually for easy access

# Overview of Plan
- Find primary “formulas” for translating XY coordinates into a NeoPixel address.
- Revolve peripheral around these formulas
- Remain as user-friendly as possible

# Technical Approach
- “Formula” for finding linear LED number given (X, Y)
  - If Row # is odd: LED = (# of columns) * (Y - 1) + X
  - If Row # is even: LED = (# of columns) * (Y - 1) + (# of columns + 1) - X

# Testing
- Start with basic coordinates, locate corners of grid and test single points randomly within the grid
- Test neopixel peripheral with game demonstration: generate several “objects” moving towards a controllable LED representing the player
- Player must successfully dodge objects, or lose the game
