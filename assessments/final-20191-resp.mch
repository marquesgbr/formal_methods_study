/* MParking
 * Author: Gustavo Carvalho
 * Creation date: 07/07/19
 */
MACHINE
    MParking
SETS
    CAR_PLATE ;
    PLACE
CONSTANTS
    STARTING_PRICE,
    PRICE_PER_HOUR,
    PLACES
PROPERTIES
    STARTING_PRICE : NATURAL
    & STARTING_PRICE = 5
    & PRICE_PER_HOUR : NATURAL
    & PRICE_PER_HOUR = 3
    & PLACES <: PLACE
VARIABLES
    reg_cars,
    cars,
    time,
    max_time,
    parking,
    available,
    pay_history
INVARIANT
    reg_cars <: CAR_PLATE
    & cars <: CAR_PLATE
    & time : cars --> NATURAL
    & max_time : NATURAL
    & parking : cars >+> PLACES
    & available : PLACES --> BOOL
    & pay_history : seq(NATURAL)
INITIALISATION
    reg_cars, cars, time := {}, {}, {}
    || parking, available := {}, PLACES * {TRUE}
    || pay_history := []
    || max_time := 0
OPERATIONS
    add_reg_car(cc) =
    PRE
        cc : CAR_PLATE
        & cc /: reg_cars
        & cc /: cars
    THEN
        reg_cars := reg_cars \/ {cc}
    END
    ;
    remove_reg_car(cc) =
    PRE
        cc : CAR_PLATE
        & cc : reg_cars
        & cc /: cars
    THEN
        reg_cars := reg_cars - {cc}
    END
    ;
    enter(cc,tt) =
    PRE
        cc : CAR_PLATE & cc /: cars
        & tt : NATURAL & tt : 0..24 & tt >= max_time
        & card(cars) < card(PLACES)
    THEN
        IF tt > max_time THEN
            max_time := tt
        END 
        || cars := cars \/ {cc}
        || time := time \/ {cc |-> tt}
    END
    ;
    leave(cc,tt) =
    PRE
        cc : cars
        & tt : NATURAL & tt : 0..24 & tt >= max_time
        & cc /: dom(parking)
    THEN
        IF tt > max_time THEN
            max_time := tt
        END
        ||
        IF cc : reg_cars THEN
            pay_history := pay_history <- 0
        ELSE
            IF tt - time(cc) <= 2 THEN
                pay_history := pay_history <- STARTING_PRICE
            ELSE
                pay_history := pay_history <- (STARTING_PRICE + (tt - time(cc) - 2)*PRICE_PER_HOUR)
            END
        END
        || cars := cars - {cc}
        || time := {cc} <<| time
    END
    ;
    park(cc) =
    PRE
        cc : CAR_PLATE & cc : cars
        & cc /: dom(parking)
    THEN
        ANY pp WHERE pp : PLACES & available(pp) = TRUE
        THEN
            parking := parking \/ {cc |-> pp}
            || available(pp) := FALSE
        END
    END
    ;
    free(cc) =
    PRE
        cc : CAR_PLATE & cc : cars
        & cc : dom(parking)
    THEN
        parking := {cc} <<| parking
        || available(parking(cc)) := TRUE
    END
    ;
    vv <-- get_vacancies =
    BEGIN
        vv := card(PLACES) - card(parking)
    END
    ;
    pp <-- get_total_paid =
    BEGIN
        pp := (SIGMA ii . (ii : dom(pay_history) | pay_history(ii)))
    END    
END