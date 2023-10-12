import java.util.ArrayList;

public class MinStateElectoralCollegeTie {
    private int[] set;

    public MinStateElectoralCollegeTie(int[] set) {
        this.set = set;
    }

    public ArrayList<Integer> run() throws Exception {
        int[][][] minStateSum = new int[set.length + 1][270][2];
        for (int i = 0; i < minStateSum.length; i++) {
            minStateSum[i][0] = new int[] {0, 0};
        }
        for (int i = 1; i < 270; i++) {
            minStateSum[0][i] = new int[] {minStateSum.length, 0};
        }
        for (int i = 1; i < minStateSum.length; i++) {
            for (int j = 0; j < 270; j++) {
                int v1 = minStateSum[i - 1][j][0];
                int v2 = minStateSum.length;
                if (set[i - 1] <= j) {
                    v2 = minStateSum[i - 1][j - set[i - 1]][0] + 1;
                }
                if (v1 <= v2) {
                    minStateSum[i][j] = new int[] {v1, 0};
                } else {
                    minStateSum[i][j] = new int[] {v2, 1};
                }
            }
        }
        if (minStateSum[set.length][269][0] == minStateSum.length) {
            throw new Exception("No subset sum found");
        }
        ArrayList<Integer> result = new ArrayList<>();
        int index = set.length;
        int value = 269;
        while (index > 0) {
            if (minStateSum[index][value][1] == 1) {
                result.add(index - 1);
                value -= set[index - 1];
            }
            index--;
        }
        return result;
    }
}