#include <stdio.h>

#define MAXNUM 30
#define MAXSIZE 30

extern void compare(int a, int b);

struct string_sort
{
    int num;
    int len;
    char s[MAXNUM][MAXSIZE];
};

extern void sort(struct string_sort *arg1);

int main(void)
{
    int i;
    struct string_sort my_strings;

    my_strings.len = 30;

    printf("How many string you want to input:");

    scanf("%d", &my_strings.num);
    for (i = 0; i < my_strings.num; i++)
    {
        scanf("%s", my_strings.s[i]);
    }

    sort(&my_strings);

    printf("The string after sort is below:\n");
    for (i = 0; i < my_strings.num; i++)
        printf("%s\n", my_strings.s[i]);
}