MACHINE
    Club_2_ctx
SETS
    REPORT = {yes, no}; 
    NAME

CONSTANTS         
    total, capacity, MAX_NAME 

PROPERTIES        
    capacity:NAT1 
    & capacity <= 100
    & NAME:FIN(NAME)
    & card(NAME) > capacity
    & total : NAT1 & total > capacity 
    & MAX_NAME:NAT1
    & card(NAME) = MAX_NAME + 1 

END
