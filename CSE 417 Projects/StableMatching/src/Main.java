public class Main {
    public static void main(String[] args) {
        //StableMatching problem4 = new StableMatching(new int[][] {{2, 1, 3, 0}, {0, 1, 3, 2}, {0, 1, 2, 3}, {0, 1, 2, 3}}, new int[][] {{0, 2, 1, 3}, {2, 0, 3, 1}, {3, 2, 1, 0}, {2, 3, 1, 0}});
        //problem4.solve();
        //System.out.println("Matches:\n" + problem4.solution());
        //System.out.println("Proposals:\n" + problem4.proposals());

        StableMatching test = new StableMatching(new int[][] {{1, 0, 2}, {0, 1, 2}, {0, 1, 2}}, new int[][] {{0, 2, 1}, {1, 0, 2}, {0, 1, 2}});
        test.solve();
        System.out.println("Matches:\n" + test.solution());
        System.out.println("Proposals:\n" + test.proposals());

        /*
        int size = 100;
        int[][] mPriorities = StableMatching.randomPriorities(size);
        int[][] wPriorities = StableMatching.randomPriorities(size);
        StableMatching problem5 = new StableMatching(mPriorities, wPriorities);
        problem5.solve();
        System.out.println("M Goodness: " + problem5.mGoodness());
        System.out.println("W Goodness: " + problem5.wGoodness());
         */
    }
}