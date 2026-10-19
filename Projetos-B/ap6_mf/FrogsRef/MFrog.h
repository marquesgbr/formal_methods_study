#ifndef _MFrog_h
#define _MFrog_h

#include <stdint.h>
#include <stdbool.h>
#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */


/* Clause SETS */
typedef enum
{
    MFrog__ee,
    MFrog__b1,
    MFrog__b2,
    MFrog__b3,
    MFrog__r1,
    MFrog__r2,
    MFrog__r3
    
} MFrog__FROG;
#define MFrog__FROG__max 7

/* Clause CONCRETE_CONSTANTS */
/* Basic constants */
typedef int MFrog__STONE;
/* Array and record constants */


/* Clause CONCRETE_VARIABLES */

extern void MFrog__INITIALISATION(void);

/* Clause OPERATIONS */

extern void MFrog__move(MFrog__FROG frog);
extern void MFrog__frog_pos(int32_t pos, MFrog__FROG *ff);

#ifdef __cplusplus
}
#endif /* __cplusplus */


#endif /* _MFrog_h */
