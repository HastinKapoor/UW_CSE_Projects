public class Main {
    public static void main(String[] args) {
        int k = 18;
        LongestCommonSubsequence test = new LongestCommonSubsequence(k);
        System.out.println("k = " + k);
        for (int n = 1000; n < 11000; n += 1000) {
            test.randomSequences(n);
            double avg = 0.0;
            for (int i = 0; i < 7; i++) {
                avg += test.run();
            }
            avg /= 7;
            System.out.printf("%.4f%n", (avg / n));
        }
    }
}