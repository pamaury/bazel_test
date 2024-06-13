#include <stdio.h>

extern int get_value(void);

int main(int argc, char **arg) {
    printf("VALUE = %d\n", get_value());
    return 0;
}
