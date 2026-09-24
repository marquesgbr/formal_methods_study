#ifndef _Club_2_h
#define _Club_2_h

#include <stdint.h>
#include <stdbool.h>
/* Clause SEES */
#include "Club_2_ctx.h"

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */


/* Clause SETS */

/* Clause CONCRETE_VARIABLES */


/* Clause CONCRETE_CONSTANTS */
/* Basic constants */
/* Array and record constants */
extern void Club_2__INITIALISATION(void);

/* Clause OPERATIONS */

extern void Club_2__join(Club_2_ctx__NAME nn);
extern void Club_2__join_queue(Club_2_ctx__NAME nn);
extern void Club_2__remove(Club_2_ctx__NAME nn);
extern void Club_2__query_membership(Club_2_ctx__NAME nn, Club_2_ctx__REPORT *ans);

#ifdef __cplusplus
}
#endif /* __cplusplus */


#endif /* _Club_2_h */
