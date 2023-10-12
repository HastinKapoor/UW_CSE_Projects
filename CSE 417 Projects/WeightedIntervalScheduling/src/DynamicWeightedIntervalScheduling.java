import java.util.Arrays;
import java.util.Comparator;

public class DynamicWeightedIntervalScheduling {
    public int[][] intervals;
    private int[] M;
    public int[] R;
    private int n;

    public DynamicWeightedIntervalScheduling(int n, int L, int r, int v) {
        RandomIntervalGenerator generator = new RandomIntervalGenerator(n, L, r, v);
        intervals = generator.generate();
        Arrays.sort(intervals, Comparator.comparingInt(a -> a[0] + a[1]));
        M = new int[n + 1];
        R = new int[n + 1];
        this.n = n;
    }

    public DynamicWeightedIntervalScheduling(int[][] intervals) {
        this.intervals = intervals;
        Arrays.sort(intervals, Comparator.comparingInt(a -> a[0] + a[1]));
        n = intervals.length;
        M = new int[n + 1];
        R = new int[n + 1];
    }

    public int[] solve() {
        for (int i = 0; i < n; i++) {
            int previous = optimalBefore(intervals[i][0]);
            int v1 = M[i];
            int v2 = intervals[i][2] + M[previous];
            if (v1 > v2) {
                M[i + 1] = v1;
                R[i + 1] = R[i];
            } else {
                M[i + 1] = v2;
                R[i + 1] = R[previous] + 1;
            }
        }
        return new int[] {R[n], M[n]};
    }

    /* Binary search is preferred, but this solution is still functional and attempting to
     * implement binary search would only add more points of failure.
     *
     * The purpose of this function is to solve the issue of having multiple intervals that
     * end at the same time by choosing the largest index which ends at the given time, since
     * its solution would account for the solutions of the others as well.
     */
    private int optimalBefore(int i) {
        int max = 0;
        while (max < n && intervals[max][0] + intervals[max][1] <= i) {
            max++;
        }
        return max;
    }
}