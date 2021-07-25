#include <iostream>
#include <chrono>
 
template<typename Diff>
void log_progress(Diff d)
{
    std::cout << "\n\n" << std::chrono::duration_cast<std::chrono::milliseconds>(d).count()
        << " ms passed \n";
}

template<typename T>
void log_data(T d)
{
    std::cout << d;
}
 
int main()
{
    std::cout.sync_with_stdio(false);//comment this line and add <<std::endl instead of \n
    auto now = std::chrono::high_resolution_clock::now();
    for (int j=0; j<50; ++j)
    {
        auto t1 = std::chrono::high_resolution_clock::now();
       
        for (int n = 0; n < 20; ++n)
            for (int m = 0; m < 20; ++m)
                log_data(n*m);
                
        
        log_progress(t1 -now);
        now = std::chrono::high_resolution_clock::now();
       // tp = now - t1;
    }
}