import java.util.Iterator;
import java.util.LinkedList;
import java.util.Random;

public class StableMatching {

    private int size;
    private int[] mMatches;
    private int[] wMatches;
    private int[][] mPriorities;
    private int[][] wPriorities;
    private int[][] mPrioritiesLookup;
    private int[][] wPrioritiesLookup;
    private LinkedList<Integer> freeM;
    private int[] mProposed;
    private LinkedList<int[]> proposals;

    public StableMatching(int[][] m, int[][]w) {
        size = m.length;
        mPriorities = m;
        wPriorities = w;
        mPrioritiesLookup = new int[size][size];
        wPrioritiesLookup = new int[size][size];
        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {
                mPrioritiesLookup[i][m[i][j]] = j;
                wPrioritiesLookup[i][w[i][j]] = j;
            }
        }
        mMatches = new int[size];
        wMatches = new int[size];
        freeM = new LinkedList<>();
        for (int i = 0; i < size; i++) {
            mMatches[i] = -1;
            wMatches[i] = -1;
            freeM.add(i);
        }
        mProposed = new int[size];
        proposals = new LinkedList<int[]>();
    }

    public void solve() {
        while (!freeM.isEmpty()) {
            int m = freeM.poll();
            int w = mPrioritiesLookup[m][mProposed[m]];
            propose(m, w);
        }
    }

    private void propose(int m, int w) {
        int oldMatch = wMatches[w];
        if (oldMatch == -1) {
            wMatches[w] = m;
            mMatches[m] = w;
        } else if (wPrioritiesLookup[w][m] < wPrioritiesLookup[w][oldMatch]) {
            wMatches[w] = m;
            mMatches[m] = w;
            mMatches[oldMatch] = -1;
            freeM.add(oldMatch);
        } else {
            freeM.add(m);
        }
        mProposed[m]++;
        proposals.add(new int[] {m, w});
        return;
    }

    public String solution() {
        StringBuilder result = new StringBuilder();
        result.append("[0, " + mMatches[0] + "]");
        for (int i = 1; i < mMatches.length; i++) {
            result.append(", [" + i + ", " + mMatches[i] + "] ");
        }
        return result.toString();
    }

    public String proposals() {
        StringBuilder result = new StringBuilder();
        Iterator<int[]> iterator = proposals.listIterator(0);
        int[] temp = iterator.next();
        result.append("[[" + temp[0] + ", " + temp[1] + "]");
        while (iterator.hasNext()) {
            temp = iterator.next();
            result.append(", [" + temp[0] + ", " + temp[1] + "]");
        }
        result.append("]");
        return result.toString();
    }

    private static int[] Permutation(int n) {
        Random rand = new Random();
        int[] arr = new int[n];
        for (int i = 1; i < n; i++) {
            int j = rand.nextInt(0, i + 1);
            arr[i] = arr[j];
            arr[j] = i;
        }
        return arr;
    }

    public static int[][] randomPriorities(int n) {
        int[][] arr = new int[n][n];
        for (int i = 0; i < n; i++) {
            arr[i] = Permutation(n);
        }
        return arr;
    }

    public double mGoodness() {
        double total = 0;
        for (int i = 0; i < size; i++) {
            total += mPriorities[i][mMatches[i]];
        }
        return total / size;
    }

    public double wGoodness() {
        double total = 0;
        for (int i = 0; i < size; i++) {
            total += wPriorities[i][wMatches[i]];
        }
        return (total / size) + 1;
    }
}
