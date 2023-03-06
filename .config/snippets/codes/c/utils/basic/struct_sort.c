/*
 * FileName:     struct_sort
 * Author: 8ucchiman
 * CreatedDate:  2023-03-01 22:18:30 +0900
 * LastModified: 2023-03-02 00:05:28 +0900
 * Reference: 8ucchiman.jp
 */

#include <stdio.h>
#include <stdlib.h>
#include "../mylib.h"
#define MACRO

typedef struct _playersData {
    char* name;
    int age;
}_playersData;

_playersData* SortStruct(_playersData* d, const int n) {
    for (int i=0; i<n; i++) {
        for (int j=n-1; j>i; j--) {
            if ((d+j)->age < (d+j-1)->age) {
                _playersData tmp;
                tmp = d[j];
                d[j] = d[j-1];
                d[j-1] = tmp;
            }
        }
    }
    return d;
}

#ifdef MACRO
int main(int argc, char* argv[]){
    char name[10];
    int age;
    _playersData* pd = (_playersData*) malloc(20*sizeof(_playersData));
    int id_count = 0;
    while(scanf("%s %d", name, &age) != EOF) {
        (pd+id_count)->name = (char*) malloc(mystrlen((const char*)name)*sizeof(const char));
        mystrcpy((pd+id_count)->name, (const char*)name);
        (pd+id_count)->age = age;
        id_count++;
    }
    pd = SortStruct(pd, id_count);
    for (int i=0; i<id_count; i++) {
        printf("%s, %d\n", (pd+i)->name, (pd+i)->age);
    }
    return 0;
}
#endif
