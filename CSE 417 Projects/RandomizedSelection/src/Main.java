import java.util.ArrayList;
import java.util.Random;

public class Main {
    public static void main(String[] args) {
        Random random = new Random();
        for (int i = 100000; i <= 1000000; i += 50000) {
            double avg = 0.0;
            ArrayList<Integer> array = new ArrayList<>();
            for (int j = 0; j < 7; j++) {
                for (int k = 0; k < i; k++) {
                    array.add(random.nextInt());
                }
                RandomizedSelection test = new RandomizedSelection(array);
                test.solve(i / 2);
                avg += test.comparisonCount();
            }
            System.out.println(i + ", " + (avg / 7.0));
        }
    }
}