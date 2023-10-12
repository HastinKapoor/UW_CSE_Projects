import java.util.Random;

public class RandomIntervalGenerator {
    //number of intervals
    private int n;
    //maximum interval start position
    private int L;
    //maximum interval length
    private int r;
    //maximum interval value
    private int v;

    public RandomIntervalGenerator(int n, int L, int r, int v) {
        this.n = n;
        this.L = L;
        this.r = r;
        this.v = v;
    }

    public int[][] generate() {
        int[][] result = new int[n][3];
        Random random = new Random();
        for (int i = 0; i < n; i++) {
            result[i][0] = random.nextInt(1, L + 1);
            result[i][1] = random.nextInt(1, r + 1);
            result[i][2] = random.nextInt(1, v + 1);
        }
        return result;
    }
}