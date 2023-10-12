import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;

public class GreedyWeightedIntervalScheduling {
    public int[][] intervals;
    private int n;

    public GreedyWeightedIntervalScheduling(int n, int L, int r, int v) {
        RandomIntervalGenerator generator = new RandomIntervalGenerator(n, L, r, v);
        intervals = generator.generate();
        this.n = n;
    }

    public ArrayList<int[]> earliestStart() {
        ArrayList<int[]> result = new ArrayList<>();
        Arrays.sort(intervals, Comparator.comparingInt(a -> a[0]));
        int currentEnd = intervals[0][0] + intervals[0][1];
        result.add(intervals[0]);
        for (int i = 0; i < n; i++) {
            if (intervals[i][0] >= currentEnd) {
                currentEnd = intervals[i][0] + intervals[i][1];
                result.add(intervals[i]);
            }
        }
        return result;
    }

    public ArrayList<int[]> maxValue() {
        ArrayList<int[]> result = new ArrayList<>();
        Arrays.sort(intervals, Comparator.comparingInt(a -> a[2]));
        result.add(intervals[n - 1]);
        for (int i = n - 1; i >= 0; i--) {
            if(!overlaps(result, intervals[i])) {
                result.add(intervals[i]);
            }
        }
        return result;
    }

    public ArrayList<int[]> maxValueDensity() {
        ArrayList<int[]> result = new ArrayList<>();
        Arrays.sort(intervals, Comparator.comparingDouble(a -> (a[2] / ((double) a[1]))));
        result.add(intervals[n - 1]);
        for (int i = n - 1; i >= 0; i--) {
            if(!overlaps(result, intervals[i])) {
                result.add(intervals[i]);
            }
        }
        return result;
    }

    private boolean overlaps(ArrayList<int[]> intervals, int[] newInterval) {
        for (int i = 0; i < intervals.size(); i++) {
            if (overlapsSingle(intervals.get(i), newInterval)) {
                return true;
            }
        }
        return false;
    }

    public boolean overlapsSingle(int[] interval0, int[] interval1) {
        return (interval0[0] >= interval1[0] && interval0[0] < interval1[0] + interval1[1])
                || (interval0[0] + interval0[1] > interval1[0] && interval0[0] + interval0[1] <= interval1[0] + interval1[1]
                || (interval0[0] < interval1[0] && interval0[0] + interval0[1] > interval1[0] + interval1[1])
                || (interval1[0] < interval0[0] && interval1[0] + interval1[1] > interval0[0] + interval0[1]));
    }
}