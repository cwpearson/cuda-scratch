NVCC = nvcc
NVCCFLAGS = -std=c++11 -lineinfo -g

all: main

main: main.cu common.h
	$(NVCC) $(NVCCFLAGS) -lcuda $< -o $@

.PHONY: clean
clean:
	rm -f main