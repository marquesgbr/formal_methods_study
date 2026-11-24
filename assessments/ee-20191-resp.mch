/* MStreaming
 * Author: Gustavo Carvalho
 * Creation date: 17/06/19
 */
MACHINE
    MStreaming
SETS
    USER_ID ;
    FILM_ID
VARIABLES
    users,
    subscription,
    films,
    views,
    history,
    wish_list
INVARIANT
    users <: USER_ID
    & subscription : users --> BOOL
    & films <: FILM_ID
    & views : films --> NATURAL
    & history : users --> seq(FILM_ID)
    & wish_list : users --> POW(FILM_ID)
    & ran(union(ran(history))) <: films    
    & union(ran(wish_list)) <: films
    & ! uu . (uu : users => ran(history(uu)) /\ wish_list(uu) = {})
INITIALISATION
    users, subscription, history, wish_list := {}, {}, {}, {}
    || films, views := {}, {}
OPERATIONS
    add_user(uu) =
    PRE
        uu : USER_ID & uu /: users
    THEN
        users := users \/ {uu}
        || subscription := subscription \/ {uu |-> TRUE}
        || history := history \/ {uu |-> {}}
        || wish_list := wish_list \/ {uu |-> {}}
    END
    ;
    remove_user(uu) =
    PRE
        uu : users
    THEN
        users := users - {uu}
        || subscription := {uu} <<| subscription
        || history := {uu} <<| history
        || wish_list := {uu} <<| wish_list
    END
    ;
    expire_subscription(uu) =
    PRE
        uu : users & subscription(uu) = TRUE
    THEN
        subscription(uu) := FALSE
    END
    ;
    renew_subscription(uu) =
    PRE
        uu : users & subscription(uu) = FALSE
    THEN
        subscription(uu) := TRUE
    END
    ;
    add_film(ff) =
    PRE
        ff : FILM_ID & ff /: films
    THEN
        films := films \/ {ff}
        || views := views \/ {ff |-> 0}
    END
    ;
    remove_film(ff) =
    PRE
        ff : films
        & ! uu . (uu : users => ff /: ran(history(uu)))
    THEN
        films := films - {ff}
        || views := {ff} <<| views
        || wish_list := { uu,ww | uu : users & ww = wish_list(uu) - {ff} }
    END
    ;
    add_wish_list(uu,ff) =
    PRE
        uu : users
        & ff : films
        & ff /: wish_list(uu)
        & ff /: ran(history(uu))        
    THEN
        wish_list(uu) := wish_list(uu) \/ {ff}
    END
    ;
    remove_wish_list(uu,ff) =
    PRE
        uu : users
        & ff : films
        & ff : wish_list(uu)
    THEN
        wish_list(uu) := wish_list(uu) - {ff}
    END
    ;
    view_film(uu,ff) =
    PRE
        uu : users
        & subscription(uu) = TRUE
        & ff : films
    THEN
        views(ff) := views(ff)+1
        || history(uu) := history(uu) <- ff
        || IF ff : wish_list(uu) THEN
            wish_list(uu) := wish_list(uu) - {ff}
           END        
    END
    ;
    view_random_film(uu) =
    PRE
        uu : users
        & subscription(uu) = TRUE
    THEN
        ANY ff WHERE ff : films THEN
            views(ff) := views(ff)+1
            || history(uu) := history(uu) <- ff
            || IF ff : wish_list(uu) THEN
                wish_list(uu) := wish_list(uu) - {ff}
               END
        END
    END
    ;
    mm <-- most_viewed =
    BEGIN
        mm := {ff | ff : films & views(ff) = max(ran(views))}
    END
    ;
    uu <-- greatest_viewer =
    BEGIN
        uu := {uu | uu : users & size(history(uu)) > 0 &
                ! uu2 . (uu2 : users & uu /= uu2 => size(history(uu))
                                                    > size (history(uu2)))}
    END
    ;
    ff <-- last_three_filmes(uu) =
    PRE
        uu : users
        & size(history(uu)) >= 3
    THEN
        ff := history(uu) \|/ size(history(uu))-3
    END
END