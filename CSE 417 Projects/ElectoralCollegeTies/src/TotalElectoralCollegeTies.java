public class TotalElectoralCollegeTies {
    int[] set;

    public TotalElectoralCollegeTies(int[] set) {
        this.set = set;
    }

    public long run() {
        long[][] sum = new long[set.length + 1][270];
        for (int i = 0; i < sum.length; i++) {
            sum[i][0] = 1;
        }
        for (int i = 1; i < sum.length; i++) {
            for (int j = 1; j < 270; j++) {
                sum[i][j] = sum[i - 1][j];
                if (set[i - 1] <= j) {
                    sum[i][j] += sum[i - 1][j - set[i - 1]];
                }
            }
        }
        return sum[sum.length - 1][269];
    }
}
