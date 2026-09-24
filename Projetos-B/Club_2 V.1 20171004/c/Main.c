#include "stdio.h"
#include "Club_2_i.c"

int main (int argc, char** argv)
{
    printf("STARTING...!\n");
    
    Club_2__INITIALISATION();
    printf("INITIALISED...!\n");

    int i;
    for(i = 0; i <= Club_2_ctx__MAX_NAME;i++)
    {
        printf("%d is member: %d | %d is waiting: %d\n", i, Club_2__member_i[i], i, Club_2__waiting_i[i]);
    }

    Club_2__join_queue(10);
    Club_2__join_queue(9);
    Club_2__join_queue(8);
    Club_2__join(8);
    Club_2__join(9);
    printf("JOINED...!\n");
    for(i = 0; i <= Club_2_ctx__MAX_NAME;i++)
    {
        printf("%d is member: %d | %d is waiting: %d\n", i, Club_2__member_i[i], i, Club_2__waiting_i[i]);
    }

    Club_2__remove(9);
    printf("REMOVED...!\n");
    for(i = 0; i <= Club_2_ctx__MAX_NAME;i++)
    {
        printf("%d is member: %d | %d is waiting: %d\n", i, Club_2__member_i[i], i, Club_2__waiting_i[i]);
    }

    return (0);
}
