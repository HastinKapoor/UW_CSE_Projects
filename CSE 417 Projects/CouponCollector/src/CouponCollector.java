import java.util.Random;

public class CouponCollector {

    private int n;
    public int[] couponsCollected;
    private int uniqueCollected;
    private int totalCollected;

    public CouponCollector(int n) {
        this.n = n;
        couponsCollected = new int[n];
        uniqueCollected = 0;
        totalCollected = 0;
    }

    public void run() {
        Random rand = new Random();
        while (uniqueCollected != n) {
            int coupon = rand.nextInt(0, n);
            int value = rand.nextInt(0, n) + 1;
            if (couponsCollected[coupon] == 0) {
                uniqueCollected++;
                couponsCollected[coupon] = value;
            }
            if (value < couponsCollected[coupon]) {
                couponsCollected[coupon] = value;
            }
                totalCollected++;
        }
    }

    public void reset() {
        couponsCollected = new int[n];
        uniqueCollected = 0;
        totalCollected = 0;
    }

    public int totalCoupons() {
        return totalCollected;
    }

    public double mGoodness() {
        return totalCollected / (double) n;
    }

    public int totalValue() {
        int total = 0;
        for (int i = 0; i < n; i++) {
            total += couponsCollected[i];
        }
        return total;
    }

    public double wGoodness() {
        return totalValue() / (double) n;
    }
}
