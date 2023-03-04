/*
 * FileName:     struct
 * Author: 8ucchiman
 * CreatedDate:  2023-03-01 22:12:20 +0900
 * LastModified: 2023-03-01 22:17:22 +0900
 * Reference: 8ucchiman.jp
 */

#include <stdio.h>
#define MACRO
#define STRUCT



#ifdef MACRO
int main(int argc, char* argv[]){
/*#ifdef STRUCT
    struct _IData {
        int age;
        double height;
    };
#endif*/
    typedef struct _IData {
        int age;
        double height;
    }_IData;
    _IData id;
    id.age = 23;
    id.height = 172.3;
    return 0;
}
#endif
