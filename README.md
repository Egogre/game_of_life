## Conway's Game of Life

The universe of the Game of Life is an infinite two-dimensional orthogonal grid
of square cells, each of which is in one of two possible states, alive or dead.
Every cell interacts with its eight neighbours, which are the cells that are
horizontally, vertically, or diagonally adjacent. At each step in time, the
following transitions occur:


+ Any live cell with fewer than two live neighbours dies, as if caused by
under-population.
+ Any live cell with two or three live neighbours lives on to the next generation.
+ Any live cell with more than three live neighbours dies, as if by overcrowding.
+ Any dead cell with exactly three live neighbours becomes a live cell, as if by
reproduction.

The initial pattern constitutes the seed of the system. The first generation is
created by applying the above rules simultaneously to every cell in the
seed—births and deaths occur simultaneously, and the discrete moment at which
this happens is sometimes called a tick (in other words, each generation is
a pure function of the preceding one). The rules continue to be applied
repeatedly to create further generations.

For a more in depth explaination, checkout out
[Wikipedia](http://en.wikipedia.org/wiki/Conway's_Game_of_Life)


## Running the game

Want to see it in action? No problem, just follow these steps:

```bash
git clone git@github.com:wvmitchell/game_of_life.git
cd game_of_life
ruby simulate.rb
```


## Contributing

Have an edge case that needs a test? Know a faster algorithm for simulating
a life cycle? Please, fork, hack, and submit a pull request.
