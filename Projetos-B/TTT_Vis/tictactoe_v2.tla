---------------------------- MODULE tictactoe_v2 ----------------------------
(* taken from https://elliotswart.github.io/pragmaticformalmodeling/ *)
(* version adapted for TLA2B so that we can have B-style operations with parameters for VisB *)
(* also contains GAME state definitions for ProB so that we can use MCTS *)
EXTENDS Naturals

VARIABLES 
    board, \* board[1..3][1..3] A 3x3 tic-tac-toe board
    nextTurn \* who goes next

Pieces == {"X", "O", "_"} \* "_" represents a blank square

Init ==
        /\ nextTurn = "X" \* X always goes first
        \* Every space in the board states blank
        /\ board = [i \in 1..3 |-> [j \in 1..3 |-> "_"]]

MoveO ==
    \E i \in 1..3: \E j \in 1..3: \* There exists a position on the board
        /\ nextTurn = "O" \* Only enabled on player's turn
        /\ nextTurn' = "X" \* The future state of next turn is other player
        /\ board[i][j] = "_" \* Where the board is currently empty
        (********************************************************************)
        (* The future state of board is the same, except a piece is in that *)
        (* spot                                                             *)
        (********************************************************************)
        /\ board' = [board EXCEPT
                        ![i][j] = "O"] 

MoveX ==
    \E i \in 1..3: \E j \in 1..3: \* There exists a position on the board
        /\ nextTurn = "X" \* Only enabled on player's turn
        /\ nextTurn' = "O" \* The future state of next turn is other player
        /\ board[i][j] = "_" \* Where the board is currently empty
        (********************************************************************)
        (* The future state of board is the same, except a piece is in that *)
        (* spot                                                             *)
        (********************************************************************)
        /\ board' = [board EXCEPT
                        ![i][j] = "X"] 

\* Every state, X will move if X's turn, O will move on O's turn
Next == MoveX \/ MoveO

\* A description of every possible game of tic-tac-toe
\* will play until the board fills up, even if someone won
Spec == Init /\ [][Next]_<<board,nextTurn>>

(***************************************************************************)
(* Invariants: The things we are checking for.                             *)
(***************************************************************************)

WinningPositions == {
    \* Horizonal wins
    {<<1,1>>, <<1,2>>, <<1,3>>},
    {<<2,1>>, <<2,2>>, <<2,3>>},
    {<<3,1>>, <<3,2>>, <<3,3>>},
    \* Vertical wins
    {<<1,1>>, <<2,1>>, <<3,1>>},
    {<<1,2>>, <<2,2>>, <<3,2>>},
    {<<1,3>>, <<2,3>>, <<3,3>>},
    \* Diagonal wins
    {<<1,1>>, <<2,2>>, <<3,3>>},
    {<<3,1>>, <<2,2>>, <<1,3>>}
}

Won(player) == 
    \* A player has won if there exists a winning position
    \E winningPosition \in WinningPositions:
        \* Where all the needed spaces
        \A neededSpace \in winningPosition:
            \* are occupied by one player
            board[neededSpace[1]][neededSpace[2]] = player

XHasNotWon == ~Won("X")
OHasNotWon == ~Won("O")

BoardFilled ==
    \* There does not exist
    ~\E i \in 1..3, j \in 1..3:
        \* an empty space
        LET space == board[i][j] IN
        space = "_"

\* It's not a stalemate if one player has won or the board is not filled
NotStalemate ==
    \/ Won("X")
    \/ Won("O")
    \/ ~BoardFilled

\* additions for ProB:
VISB_JSON_FILE == "tictactoe_visb.json"
GOAL == Won("O")
\* the following Invariant is violated by this model
INVARIANT == ~Won("O") \/ ~Won("X")
\* additions for ProB so that we can apply MCTS auto play:
GAME_MCTS_RUNS == 400
GAME_PLAYER == IF nextTurn = "X" THEN "max" ELSE "min"
GAME_OVER == IF Won("X") \/ Won("O") THEN TRUE ELSE FALSE
GAME_VALUE == IF Won("X") THEN 1 ELSE 0
=============================================================================
