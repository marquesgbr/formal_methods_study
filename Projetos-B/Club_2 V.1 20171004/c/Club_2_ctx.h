#ifndef _Club_2_ctx_h
#define _Club_2_ctx_h

#include <stdint.h>
#include <stdbool.h>
#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */


#define Club_2_ctx__NAME__max Club_2_ctx__MAX_NAME
/* Clause SETS */
typedef enum
{
    Club_2_ctx__yes,
    Club_2_ctx__no
    
} Club_2_ctx__REPORT;
#define Club_2_ctx__REPORT__max 2
typedef int Club_2_ctx__NAME;

/* Clause CONCRETE_VARIABLES */


/* Clause CONCRETE_CONSTANTS */
/* Basic constants */
#define Club_2_ctx__total 10
#define Club_2_ctx__capacity 5
#define Club_2_ctx__MAX_NAME 10
/* Array and record constants */



extern void Club_2_ctx__INITIALISATION(void);


#ifdef __cplusplus
}
#endif /* __cplusplus */


#endif /* _Club_2_ctx_h */
