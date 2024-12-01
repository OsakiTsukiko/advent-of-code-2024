#include <stdlib.h>
#include <stdio.h>

void sort_asc(int* arr, int len) {
    // first sort that came to mind
    for (int i = 0; i < len; i += 1) {
        for (int j = i + 1; j < len; j += 1 ) {
            if (arr[j] < arr[i]) {
                int tmp = arr[i];
                arr[i] = arr[j];
                arr[j] = tmp;
            }
        }
    }
}

int main() {
    int left[10000];
    int left_len = 0;
    int right[10000];
    int right_len = 0;

    FILE* fd;
    fd = fopen("puzzle.input", "r");

    int a, b;
    while (fscanf(fd, "%d %d", &a, &b) == 2)
    {
        left[left_len] = a;
        left_len += 1;
        right[right_len] = b;
        right_len += 1;
    }
    
    fclose(fd);

    sort_asc(left, left_len);
    sort_asc(right, right_len);

    // Part 1
    int s1 = 0;
    for (int i = 0; i < left_len && i < right_len; i += 1) {
        s1 += abs(left[i] - right[i]);
    }

    printf("Part 1: %d\n", s1);

    // Part 2
    int s2 = 0;
    for (int i = 0; i < left_len; i += 1) {
        int cnt = 0;
        for (int j = 0; j < right_len; j += 1) if (left[i] == right[j]) cnt += 1;
        s2 += left[i] * cnt;
    }

    printf("Part 2: %d\n", s2);

    return 0;
}