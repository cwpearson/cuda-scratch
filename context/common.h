#ifndef COMMON_H
#define COMMON_H

#include <iostream>
#include <cuda_runtime.h>
#include <cuda.h>

#define RT_CHECK(ans)                                                   \
  { rtAssert((ans), __FILE__, __LINE__); }
inline void rtAssert(cudaError_t code, const char *file, int line,bool abort = true) {
  if (code != cudaSuccess) {
    std::cerr << "RT_CHECK: " << cudaGetErrorString(code) << " " << file << " "
        << line << std::endl;
    if (abort)
      exit(code);
  }
}

#define DR_CHECK(ans)                                                   \
  { drAssert((ans), __FILE__, __LINE__); }
inline void drAssert(CUresult res, const char *file, int line,bool abort = true) {
  if (res != CUDA_SUCCESS) {
    const char *errStr, *errName;
    cuGetErrorString(res, &errStr);
    cuGetErrorName(res, &errName);
    std::cerr << "DR_CHECK: " << errName << ": " << errStr << " " << file << " "
        << line << std::endl;
    if (abort)
      exit(res);
  }
}

#endif