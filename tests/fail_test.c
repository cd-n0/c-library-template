#include "../src/include/functions.h"
#include <assert.h>

int main(void){
    assert(10 == sum(2, 8));
    assert(10 == sum(5, 5));
    assert(010 == sum(0, 10));

    return 0;
}
