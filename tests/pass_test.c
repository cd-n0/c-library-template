#include "include/functions.h"
#include <assert.h>

int main(void){
    /* Invalid C++ */
    int class = 0;
    assert(10 == sum(2, 8));
    assert(10 == sum(5, 5));
    assert(010 != sum(class, 10));

    return 0;
}
