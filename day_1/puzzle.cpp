#include <bits/stdc++.h>
using namespace std;

bool comp(int a, int b) {
    return a < b;
}

int main() {
    ifstream in("puzzle.input");

    vector<int> left;
    vector<int> right;

    int a, b;
    while (in >> a >> b)
    {
        left.push_back(a);
        right.push_back(b);
    }

    sort(left.begin(), left.end(), comp);
    sort(right.begin(), right.end(), comp);

    // Part 1
    int s1 = 0;
    for (int i = 0; i < left.size() && i < right.size(); i++) {
        s1 += abs(left[i] - right[i]);
    }
    
    cout << "Part 1: " << s1 << endl;

    // Part 2
    int s2 = 0;
    for (auto a : left) {
        int cnt = 0;
        for (auto b : right) if (a == b) cnt += 1;
        s2 += a * cnt;
    }

    cout << "Part 2: " << s2 << endl;
    
    return 0;
}