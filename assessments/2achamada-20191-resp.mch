/* MAccess
 * Author: Gustavo Carvalho
 * Creation date: 27/06/19
 */
MACHINE
    achamada-20191-resp
SETS
    USER_ID ;
    ROOM_ID ;
    CATEGORY = {lecturer, student, staff, none}
VARIABLES
    users, 
    category,
    rooms,
    permission_category,
    permission_users,
    num_access,
    total_time
INVARIANT
    users <: USER_ID
    & category : users --> CATEGORY
    & rooms <: ROOM_ID
    & permission_category : rooms --> CATEGORY
    & permission_users : rooms --> POW(users)
    & num_access : users --> NATURAL
    & total_time : users --> NATURAL
INITIALISATION
    users, category := {}, {}
    || rooms, permission_category, permission_users := {}, {}, {}
    || num_access, total_time := {}, {}
OPERATIONS
    add_users(uu,cc) =
    PRE
        uu : USER_ID & uu /: users
        & cc : CATEGORY & cc /= none
    THEN
        users := users \/ {uu}
        || category := category \/ {uu |-> cc}
        || num_access := num_access \/ {uu |-> 0}
        || total_time := total_time \/ {uu |-> 0}
    END
    ;
    remove_user(uu) =
    PRE
        uu : USER_ID & uu : users
    THEN
        users := users - {uu}
        || category := {uu} <<| category
        || num_access := {uu} <<| num_access
        || total_time := {uu} <<| total_time
        || permission_users := { rr,us | rr : dom(permission_users)
                                         & us = permission_users(rr) - {uu} }
    END    
    ;
    add_room(rr) =
    PRE
        rr : ROOM_ID & rr /: rooms
    THEN
        rooms := rooms \/ {rr}
        || permission_category := permission_category \/ {rr |-> none}
        || permission_users := permission_users \/ {rr |-> {}}
    END
    ;
    remove_room(rr) =
    PRE
        rr : ROOM_ID & rr : rooms
    THEN
        rooms := rooms - {rr}
        || permission_category := {rr} <<| permission_category
        || permission_users := {rr} <<| permission_users
    END
    ;
    grant_permission_category(rr,cc) =
    PRE
        rr : ROOM_ID & rr : rooms & cc : CATEGORY
        & permission_category(rr) /= cc
    THEN
        permission_category(rr) := cc
    END
    ;
    grant_permission_user(rr,uu) =
    PRE
        rr : ROOM_ID & rr : rooms
        & uu : USER_ID & uu : users
        & uu /: permission_users(rr)
    THEN
        permission_users(rr) := permission_users(rr) \/ {uu}
    END
    ;
    revoke_permission_user(rr,uu) =
    PRE
        rr : ROOM_ID & rr : rooms
        & uu : USER_ID & uu : users
        & uu : permission_users(rr)
    THEN
        permission_users(rr) := permission_users(rr) - {uu}
    END
    ;
    register_user_access(uu,rr,dd) =    
    PRE
        uu : USER_ID & uu : users
        & rr : ROOM_ID & rr : rooms
        & dd : NATURAL & dd > 0
        & (uu : permission_users(rr) or category(uu) = permission_category(rr))    
    THEN
        num_access(uu) := num_access(uu) + 1
        || total_time(uu) := total_time(uu) + dd
    END
    ;
    avg <-- average_time =
    PRE
        num_access /= {} & max(ran(num_access)) > 0
    THEN
        LET sum_accesses, sum_time
        BE sum_accesses = (SIGMA aa . (aa : ran(num_access) | aa))
           & sum_time = (SIGMA tt . (tt : ran(total_time) | tt))
        IN avg := sum_time / sum_accesses END
    END
    ;
    us <-- most_number_accesses =
    BEGIN
        IF num_access /= {} THEN
            LET max_num BE max_num = max(ran(num_access))
            IN us := num_access~[{max_num}] END
        ELSE us := {} END
    END
END