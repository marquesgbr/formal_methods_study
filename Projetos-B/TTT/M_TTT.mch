/* M_TTT
 * Author: Gustavo Carvalho (ghpc@cin.ufpe.br)
 * Creation date: 20/08/2026
 */
MACHINE
    M_TTT
DEFINITIONS
    ANIMATION_FUNCTION == ( {r,c,i|r:1..3 & c:1..3 & i=0} <+ board);
    ANIMATION_IMG0 == "C:\Projects\26.2\MF\formal_methods_study\Projetos-B\TTT\images\empty_square.png"; 
    ANIMATION_IMG1 == "C:\Projects\26.2\MF\formal_methods_study\Projetos-B\TTT\images\X.png"; 
    ANIMATION_IMG2 == "C:\Projects\26.2\MF\formal_methods_study\Projetos-B\TTT\images\O.png";
CONSTANTS
    SIZE,
    VALUE
PROPERTIES
    SIZE = {1,2,3}
    & VALUE = {0,1,2}
VARIABLES
    board,
    turn
INVARIANT
    board : (SIZE * SIZE) --> VALUE
    & turn : BOOL
INITIALISATION
    board := (SIZE * SIZE) * {0}
    || turn :: BOOL
OPERATIONS
    play(x_pos, y_pos, value) =
    PRE
        x_pos : SIZE
        & y_pos : SIZE
        & value : VALUE - {0}
        & board(x_pos,y_pos) = 0
        & (turn = TRUE => value = 1)
        & (turn = FALSE => value = 2)
        & not(
            # cc .
              (cc : {board[{xx,yy|xx : SIZE & yy = 1}],
                    board[{xx,yy|xx : SIZE & yy = 2}], 
                    board[{xx,yy|xx : SIZE & yy = 3}],
                    board[{xx,yy|xx = 1 & yy : SIZE}],
                    board[{xx,yy|xx = 2 & yy : SIZE}],
                    board[{xx,yy|xx = 3 & yy : SIZE}],
                    board[{xx,yy|xx : SIZE & yy = xx}],
                    board[{xx,yy|yy : SIZE & xx = card(SIZE)+1-yy}]}
               & card(cc) = 1 & 0 /: cc))
    THEN
        board(x_pos,y_pos) := value
        || IF turn = TRUE
           THEN turn := FALSE
           ELSE turn := TRUE END
    END
END
