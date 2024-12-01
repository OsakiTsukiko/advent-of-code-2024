output = main
input = puzzle
CC = gcc
CXX = g++
RC = rustc
ZIG = zig
JAVAC = javac
JAVA = java

all: rust cpp c zig java

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

java:
	$(JAVAC) $(input).java
	$(JAVA) $(input)
	rm $(input).class