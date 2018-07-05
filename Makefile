.PHONY: run-lld
run-lld: main-lld
	./main-lld 1 2 3

.PHONY: run-gold
run-gold: main-gold
	./main-gold 4 5 6

main-lld: main.cpp
	clang++ -fuse-ld=lld  -g -o main-lld  -v -static -pthread main.cpp -Wl,--reproduce=main-lld-repro

main-gold: main.cpp
	clang++ -fuse-ld=gold -g -o main-gold -v -static -pthread main.cpp

.PHONY: clean
clean:
	rm -rf main-*
