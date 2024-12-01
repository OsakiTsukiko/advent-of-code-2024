left = []
right = []

file = open("puzzle.input")
for line in file.readlines():
    nr = line.strip().split("   ")
    n1 = int(nr[0])
    n2 = int(nr[1])
    left.append(n1)
    right.append(n2)

left.sort()
right.sort()

# Part 1
s1 = 0
for i in range(0, len(left)):
    a = left[i]
    b = right[i]
    s1 += abs(a-b)

print("Part 1: " + str(s1))

# Part 2
s2 = 0
for a in left:
    cnt = right.count(a)
    s2 += a * cnt 

print("Part 2: " + str(s2))