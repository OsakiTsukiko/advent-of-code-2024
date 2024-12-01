output = main
input = puzzle
CC = gcc
CXX = g++
RC = rustc
ZIG = zig

all: rust cpp c zig

rust:
	$(RC) $(input).rs -o $(output)
	./$(output)
	rm $(output)

cpp:
	$(CXX) $(input).cpp -o $(output)
	./$(output)
	rm $(output)

c:
	$(CC) $(input).c -o $(output)
	./$(output)
	rm $(output)

zig: 
	$(ZIG) run $(input).zig