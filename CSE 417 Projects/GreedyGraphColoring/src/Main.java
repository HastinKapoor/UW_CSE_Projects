import java.util.HashSet;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        for (int i = 0; i < 200; i++) {
            double avg = 0.0;
            for (int j = 0; j < 10; j++) {
                GreedyGraphColoring test = new GreedyGraphColoring(1000, i / 1000.0 + 0.002);
                test.sortDecr();
                avg += test.run() / 10.0;
            }
            System.out.printf("%.3f", (i / 1000.0 + 0.002));
            System.out.print(", ");
            System.out.printf("%.2f", avg);
            System.out.println();
        }
    }
}