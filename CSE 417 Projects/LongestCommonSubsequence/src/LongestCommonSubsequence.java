import java.util.Random;

public class LongestCommonSubsequence {
    private int[] a;
    private int[] b;
    private int k;

    public LongestCommonSubsequence(int k) {
        this.k = k;
    }

    public void randomSequences(int n) {
        a = new int[n];
        b = new int[n];
        Random random = new Random();
        for (int i = 0; i < n; i++) {
            a[i] = random.nextInt(k);
            b[i] = random.nextInt(k);
        }
    }

    public int run() {
        int[][] result = new int[a.length + 1][b.length + 1];
        for (int i = 0; i < a.length; i++) {
            for (int j = 0; j < b.length; j++) {
                if(a[i] == b[j]) {
                    result[i + 1][j + 1] = result[i][j] + 1;
                } else {
                    result[i + 1][j + 1] = Math.max(result[i][j + 1], result[i + 1][j]);
                }
            }
        }
        return result[a.length][b.length];
    }
}
