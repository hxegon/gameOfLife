# Conway's Game of Life

An implementation in Haskell :)  

Uses gloss to show an NxN sized window

I'm mostly doing this to have something to test out profiling, quickcheck, and build something more meaty in Haskell.

The Naive implementation uses 110 - 130% CPU on my 2015 Macbook Pro (2.9 Ghz 2 core i5), and I want to see how far I can optimize this.

## Setup
`stack build && stack run`

## TODO
- [x] Naive implementation
- [x] Random initial grid state
- [ ] Profile for Naive implementation
- [ ] Testing
- [ ] CLI option: Steps per second
- [ ] CLI option: Side length for grid
- [ ] CLI option: Initial grid as CSV file
- [ ] Performance Pass 1

### Git workflow
Feature branches off master
