# Tic Tac Toe

## User Stories
```
As a user,
So I can play Tic Tac Toe,
I need a board with a default, empty, square grid of 3x3 fields.

As a user,
So I can begin playing Tic Tac Toe,
I need to identify myself with a name and a play sign (X, O etc.)

As a user,
So I can play Tic Tac Toe,
I need to be able to move on a field if it is empty.

As a user,
So I can play Tic Tac Toe,
I need to play it with another player.

As a user,
So I can play Tic Tac Toe,
I need my turn to end after I moved on a field, so my opponent can play, too.

As a user,
So I can finish playing Tic Tac Toe,
I need the game to be over by it being a win, a loss (opponent wins) or a draw.

```

## How to Deploy, Test and Use
```
$ git clone https://github.com/sliute/tic_tac_toe.git
$ cd tic_tac_toe
$ bundle
$ rspec
$ pry
$ game.play
```

`.pryrc` sets up a game like this:
```
require './lib/game'
require './lib/player'
require './lib/board'
player_01 = Player.new({sign: 'X', name: 'Batman'})
player_02 = Player.new({sign: 'O', name: 'Superman'})
board = Board.new
game = Game.new({board: board, player_01: player_01, player_02: player_02})
```

## Progress and Issues

### Progress
1. The game uses three classes:
  * `Board`
    - starts with a default, empty, square grid of 3x3 fields. Grid size can only increase, if desired. Fields are, by default, empty string objects.
    - has field getter and setter methods. Through the setter method:
      - it can set any value to a field
      - it understands its own physical boundaries and forbids any field from being played twice.
  * `Player`
    - starts with a name and a sign. If an empty string is provided, the name defaults to 'Anon'
  * `Game`
    - starts with two players (must be Player objects) and a board (must be a Board object)
    - the #play method presently:
      - takes all the necessary steps for a result-free game. A result is not (yet) calculated, but players can take turns and their move observe the game rules
      - each such step uses a dedicated method

### Issues
  * Since they have been TDD-driven, all methods are presently public. Many of them could (and should) be eventually made private.
  * I developed the #play method after its sub-components. Although all unit tests passed, feature tests in PRY indicated the need to re-engineer the #get_coord method into a new, #process_move method and adapt the associated unit tests.
  * At this point, game rules are spread between `Board` and `Game`. I think they could be factored out into a single new class, `RuleBook`. Game would then pass the board and the player's move to the rulebook and display the output.
