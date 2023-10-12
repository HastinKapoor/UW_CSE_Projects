import java.util.ArrayList;

public class RandomizedSelection {
    private ArrayList<Integer> array;
    private int comparisonCount;

    public RandomizedSelection(ArrayList<Integer> array) {
        this.array = array;
        comparisonCount = 0;
    }

    public int solve(int k) {
        return select(array, k);
    }

    private int select(ArrayList<Integer> search, int k) {
        int pivot = search.get(0);
        ArrayList<Integer> less = new ArrayList<>();
        ArrayList<Integer> eq = new ArrayList<>();
        ArrayList<Integer> more = new ArrayList<>();
        for (int i = 0; i < search.size(); i++) {
            int current = search.get(i);
            if (current < pivot) {
                comparisonCount += 1;
                less.add(current);
            } else if (current == pivot) {
                comparisonCount += 2;
                eq.add(current);
            } else {
                comparisonCount += 2;
                more.add(current);
            }
        }
        if (more.size() >= k) {
            return select(more, k);
        } else if (more.size() + eq.size() >= k) {
            return pivot;
        } else {
            return select(less, k - more.size() - eq.size());
        }
    }

    public int comparisonCount() {
        return comparisonCount;
    }
}
