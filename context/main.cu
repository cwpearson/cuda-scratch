#include <iostream>

#include <cuda.h>

#include "common.h"

int main(void)
{

    const size_t count = 1024 * 1024 * 128;

    DR_CHECK(cuInit(0));

    CUdevice dev;
    DR_CHECK(cuDeviceGet(&dev, 0));

    CUcontext c0, c1, c2;
    DR_CHECK(cuCtxCreate(&c0, 0, dev));
    DR_CHECK(cuCtxCreate(&c1, 0, dev));
    DR_CHECK(cuCtxCreate(&c2, 0, dev));

    float *p0, *p1, *p2;
    DR_CHECK(cuCtxSetCurrent(c0));
    RT_CHECK(cudaMalloc(&p0, count));

    DR_CHECK(cuCtxSetCurrent(c1));
    RT_CHECK(cudaMalloc(&p1, count));

    DR_CHECK(cuCtxSetCurrent(c2));
    RT_CHECK(cudaMalloc(&p2, count));

    RT_CHECK(cudaFree(p1));
    RT_CHECK(cudaMalloc(&p1, count/2));

    std::cout << p0 << std::endl;
    std::cout << p1 << std::endl;
    std::cout << p2 << std::endl;

    std::cout << uintptr_t(p1) << " " << uintptr_t(p0) << " " << uintptr_t(p1) - uintptr_t(p0) << std::endl;
    std::cout << uintptr_t(p2) << " " << uintptr_t(p1) << " " << uintptr_t(p2) - uintptr_t(p1) << std::endl;
}