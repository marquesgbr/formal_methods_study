/* WARNING if type checker is not performed, translation could contain errors ! */

#include "MFrog.h"

/* Clause CONCRETE_CONSTANTS */
/* Basic constants */

/* Array and record constants */
/* Clause CONCRETE_VARIABLES */

static MFrog__FROG MFrog__state_i[8];
/* Clause LOCAL_OPERATIONS */

static void MFrog__find_frog(MFrog__FROG frog, int32_t *pos);
static void MFrog__update_state(MFrog__FROG frog, int32_t delta, bool *success);
/* Clause INITIALISATION */
void MFrog__INITIALISATION(void)
{
    
    MFrog__state_i[0] = MFrog__ee;
    MFrog__state_i[1] = MFrog__b1;
    MFrog__state_i[2] = MFrog__b2;
    MFrog__state_i[3] = MFrog__b3;
    MFrog__state_i[4] = MFrog__ee;
    MFrog__state_i[5] = MFrog__r1;
    MFrog__state_i[6] = MFrog__r2;
    MFrog__state_i[7] = MFrog__r3;
}

/* Clause OPERATIONS */

void MFrog__find_frog(MFrog__FROG frog, int32_t *pos)
{
    {
        int32_t ii;
        bool found;
        
        ii = 0;
        found = false;
        while(((ii) <= (7)) &&
        (found == false))
        {
            {
                MFrog__FROG current_frog;
                
                current_frog = MFrog__state_i[ii];
                if(current_frog == frog)
                {
                    (*pos) = ii;
                    found = true;
                }
            }
            ii = ii+1;
        }
    }
}

void MFrog__update_state(MFrog__FROG frog, int32_t delta, bool *success)
{
    {
        int32_t frog_pos;
        int32_t new_pos;
        MFrog__FROG target_frog;
        
        MFrog__find_frog(frog, &frog_pos);
        new_pos = frog_pos+delta;
        if(((new_pos) >= (0)) &&
        ((new_pos) <= (7)))
        {
            target_frog = MFrog__state_i[new_pos];
            if(target_frog == MFrog__ee)
            {
                MFrog__state_i[frog_pos] = MFrog__ee;
                MFrog__state_i[new_pos] = frog;
                (*success) = true;
            }
            else
            {
                (*success) = false;
            }
        }
        else
        {
            (*success) = false;
        }
    }
}

void MFrog__move(MFrog__FROG frog)
{
    {
        bool status;
        
        if(((frog == MFrog__b1) ||
            (frog == MFrog__b2)) ||
        (frog == MFrog__b3))
        {
            MFrog__update_state(frog, 1, &status);
            if(status == false)
            {
                MFrog__update_state(frog, 2, &status);
            }
        }
        else if(((frog == MFrog__r1) ||
            (frog == MFrog__r2)) ||
        (frog == MFrog__r3))
        {
            MFrog__update_state(frog, -1, &status);
            if(status == false)
            {
                MFrog__update_state(frog, -2, &status);
            }
        }
    }
}

void MFrog__frog_pos(int32_t pos, MFrog__FROG *ff)
{
    (*ff) = MFrog__state_i[pos];
}

