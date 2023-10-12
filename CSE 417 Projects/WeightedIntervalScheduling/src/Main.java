import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;

public class Main {
    public static void main(String[] args) {
        GreedyWeightedIntervalScheduling test0 = new GreedyWeightedIntervalScheduling(10000, 1000000, 2000, 1000);
//        GreedyWeightedIntervalScheduling test0 = new GreedyWeightedIntervalScheduling(5, 10, 5, 10);
//        System.out.println(Arrays.deepToString(test0.intervals));
        int value = 0;
        ArrayList<int[]> test1 = test0.earliestStart();
        for (int i = 0; i < test1.size(); i++) {
//            System.out.println(Arrays.toString(test1.get(i)));
            value += test1.get(i)[2];
        }
        System.out.println(Arrays.toString(new int[] {test1.size(), value}));
        value = 0;
        ArrayList<int[]> test2 = test0.maxValue();
        for (int i = 0; i < test2.size(); i++) {
//            System.out.println("test: " + Arrays.toString(test2.get(i)));
            value += test2.get(i)[2];
        }
        System.out.println(Arrays.toString(new int[] {test2.size(), value}));
        value = 0;
        ArrayList<int[]> test3 = test0.maxValueDensity();
        for (int i = 0; i < test3.size(); i++) {
//            System.out.println("test: " + Arrays.toString(test3.get(i)));
            value += test3.get(i)[2];
        }
        System.out.println(Arrays.toString(new int[] {test3.size(), value}));

        DynamicWeightedIntervalScheduling test4 = new DynamicWeightedIntervalScheduling(test0.intervals);
//        System.out.println(Arrays.deepToString(test4.intervals));
        int[] result = test4.solve();
        System.out.println(Arrays.toString(result));
//        System.out.println(Arrays.deepToString(test4.intervals));
//        System.out.println(Arrays.toString(test4.R));
    }
}