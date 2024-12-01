import java.io.*;
import java.util.ArrayList;
import java.util.List;

class puzzle // lower case just so i can reuse the variable in the makefile
{
    public static void main(String []args) throws Exception // this should never be used
    {
        List<Integer> left = new ArrayList<>();
        List<Integer> right = new ArrayList<>();

        BufferedReader reader = new BufferedReader(new FileReader("puzzle.input"));
        String line;
        while ((line = reader.readLine()) != null) {
            var nr = line.trim().split("\\s+");
            Integer a = Integer.parseInt(nr[0]);
            Integer b = Integer.parseInt(nr[1]);
            left.add(a);
            right.add(b);
        }
        reader.close();

        left.sort(null);
        right.sort(null);

        // Part 1 
        Integer s1 = 0;
        for (int i = 0; i < left.size() && i < right.size(); i += 1) {
            s1 += Math.abs(left.get(i) - right.get(i));
        }

        System.err.println("Part 1: " + s1.toString());

        // Part 2
        Integer s2 = 0;
        for (int a : left) {
            int cnt = (int)right.stream().filter(b -> b == a).count();
            s2 += a * cnt;
        }

        System.err.println("Part 2: " + s2.toString());
    }
};