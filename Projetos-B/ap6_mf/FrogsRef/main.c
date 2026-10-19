#include <stdio.h>
#include "MFrog.h"

const char* get_name(MFrog__FROG *ff) {
    switch (*ff) {
        case MFrog__ee: return "ee"; break;
        case MFrog__b1: return "b1"; break;
        case MFrog__b2: return "b2"; break;
        case MFrog__b3: return "b3"; break;
        case MFrog__r1: return "r1"; break;
        case MFrog__r2: return "r2"; break;
        case MFrog__r3: return "r3"; break;
        default: return "??";
    }
}

void print_state() {
    for (int i=1; i<=7; i++) {
        if (i != 1) {
            printf(" ");
        }
        MFrog__FROG ff;
        MFrog__frog_pos(i, &ff);
        printf("%s", get_name(&ff));
    }
    printf("\n");
}

void main() {
    MFrog__INITIALISATION();
    print_state();

    MFrog__move(MFrog__b3);
    MFrog__move(MFrog__r1);
    MFrog__move(MFrog__r2);
    MFrog__move(MFrog__b3);
    MFrog__move(MFrog__b2);
    MFrog__move(MFrog__b1);
    MFrog__move(MFrog__r1);
    MFrog__move(MFrog__r2);
    MFrog__move(MFrog__r3);
    MFrog__move(MFrog__b3);
    MFrog__move(MFrog__b2);
    MFrog__move(MFrog__b1);
    MFrog__move(MFrog__r2);
    MFrog__move(MFrog__r3);
    MFrog__move(MFrog__b1);
    print_state();
}