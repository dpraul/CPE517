#include <xmmintrin.h>
#include <iostream>

int main(int argc, char** argv) {
    float data[] = { -5, 2, 30, -55, 23, 0, 13 };
    int length = 7;
    bool debug = false; // prints list while sorting
    
    float resource1[4], resource2[4], compareResult[4];
    float temp, cur, next;
    bool did_swap = false;

    __m128 result;
    __m128 register1;
    __m128 register2;
    do {
        did_swap = false;
        for (int i = 0; i < length - 1; i++) {
            cur = data[i];
            next = data[i + 1];
            
            register1 = _mm_set_ss(cur);
            register2 = _mm_set_ss(next);
        
            _mm_storeu_ps(resource1, register1);
            _mm_storeu_ps(resource2, register2);
            
            result = _mm_cmpge_ss(register1, register2);
            _mm_storeu_ps(compareResult, result); 
            
            // actual result is stored in first index of compareResult
            if (compareResult[0]) {
                temp = data[i + 1];
                data[i + 1] = data[i];
                data[i] = temp;
                did_swap = true;
            }
        }
        if (debug) { 
            for (int i = 0; i <= length - 1; i++) {
                printf("%.2f ", data[i]);
            }
            printf("\n");
        }
    } while (did_swap);

    printf("Result:\n");
    for (int i = 0; i < length; i++) {
        printf("%.2f ", data[i]);
    }
    std::cin.get();
    return 0;
}
