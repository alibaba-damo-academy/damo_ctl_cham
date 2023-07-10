#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <malloc.h>
#include <chrono>

using std::chrono::high_resolution_clock;
using std::chrono::microseconds;

int main() {
    const int n_rep = 100;
    const int n_data = 1024 * 4096;
    const int n_batch = 1024;
    const int n_data_per_batch = n_data / n_batch;
    const int size_of_batch = n_data_per_batch * sizeof(long);
    const int size_of_data = n_data * sizeof(long);

    long *a[n_batch];
    for (int i = 0; i < n_batch; ++i) {
        a[i] = (long*)aligned_alloc(4096, size_of_batch);
    }
    long *b = (long*)aligned_alloc(4096, size_of_data);

    for (int i = 0; i < n_data; ++i) {
        a[i/n_data_per_batch][i%n_data_per_batch] = i;
        b[i] = i;
    }

    auto start_time = high_resolution_clock::now();
    for (int rep = 0; rep < n_rep; ++rep) {
        auto iter_start_time = high_resolution_clock::now();
        for (int i = 0; i < n_batch; ++i) {
            memcpy(b + i * n_data_per_batch, a[i], size_of_batch);
        }
        auto iter_end_time = high_resolution_clock::now();
        auto interval = std::chrono::duration_cast<microseconds>(
                        iter_end_time - iter_start_time);
        printf("%d ", interval);
    }
    auto end_time = high_resolution_clock::now();

    auto interval = std::chrono::duration_cast<microseconds>(
                    end_time - start_time);
    printf("\navergae time: %d\n", interval / n_rep);

    return 0;
}
