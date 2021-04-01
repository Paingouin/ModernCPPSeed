#include <stdio.h>
#include <chrono>
 
template<typename Diff>
void log_progress(Diff d)
{
    printf("\n\n%d ms passed \n",  std::chrono::duration_cast<std::chrono::milliseconds>(d).count());
}


template<typename T>
void log_data(T d)
{
    printf("%d", d);
}
 
int main()
{
    for (int j=0; j<50; ++j)
    {
        auto t1 = std::chrono::high_resolution_clock::now();
        for (int n = 0; n < 20; ++n)
            for (int m = 0; m < 20; ++m)
                log_data(n * m);

        auto now = std::chrono::high_resolution_clock::now();
        log_progress(now - t1);
    }
}