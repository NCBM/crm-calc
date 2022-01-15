#include "data.h"

double getrmass(char* name) {
    element el;
    for (int i = 0; i < 118; i++) {
        if (strcmp(elements[i].name, name) == 0) {
            el = elements[i];
            return el.rmass;
        }
    }
    printf("警告：未知的元素“%s”，已忽略。\n", name);
    return 0.0;
}
