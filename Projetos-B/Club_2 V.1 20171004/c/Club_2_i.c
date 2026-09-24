/* WARNING if type checker is not performed, translation could contain errors ! */

#include "Club_2.h"

/* Clause SEES */
#include "Club_2_ctx.h"

/* Clause CONCRETE_CONSTANTS */
/* Basic constants */

/* Array and record constants */
/* Clause CONCRETE_VARIABLES */

static bool Club_2__member_i[Club_2_ctx__NAME__max+1];
static bool Club_2__waiting_i[Club_2_ctx__NAME__max+1];
/* Clause INITIALISATION */
void Club_2__INITIALISATION(void)
{
    
    unsigned int i = 0;
    for(i = 0; i <= Club_2_ctx__NAME__max-1;i++)
    {
        Club_2__member_i[i] = false;
    }
    for(i = 0; i <= Club_2_ctx__NAME__max-1;i++)
    {
        Club_2__waiting_i[i] = false;
    }
}

/* Clause OPERATIONS */

void Club_2__join(Club_2_ctx__NAME nn)
{
    Club_2__member_i[nn] = true;
    Club_2__waiting_i[nn] = false;
}

void Club_2__join_queue(Club_2_ctx__NAME nn)
{
    Club_2__waiting_i[nn] = true;
}

void Club_2__remove(Club_2_ctx__NAME nn)
{
    Club_2__member_i[nn] = false;
}

void Club_2__query_membership(Club_2_ctx__NAME nn, Club_2_ctx__REPORT *ans)
{
    {
        bool is_member;
        
        is_member = Club_2__member_i[nn];
        if(is_member == true)
        {
            (*ans) = Club_2_ctx__yes;
        }
        else
        {
            (*ans) = Club_2_ctx__no;
        }
    }
}

