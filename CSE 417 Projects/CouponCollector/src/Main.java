public class Main {
    public static void main(String[] args) {
        System.out.println("M:");
        for (int i = 200; i < 4200; i += 200) {
            CouponCollector test = new CouponCollector(i);
//            double avg = 0.0;
//            for (int j = 0; j < 7; j++) {
//                test.run();
//                avg += test.mGoodness() / 7;
//                test.reset();
//            }
//            System.out.println(avg);
            test.run();
            System.out.print(test.totalCoupons() + ", ");
            System.out.printf("%.3f%n", test.mGoodness());
        }

        System.out.println("\nW:");
        for (int i = 200; i < 4200; i += 200) {
            CouponCollector test = new CouponCollector(i);
//            double avg = 0.0;
//            for (int j = 0; j < 7; j++) {
//                test.run();
//                avg += test.wGoodness() / 7;
//                test.reset();
//            }
//            System.out.println(avg);
            test.run();
            System.out.print(test.totalValue() + ", ");
            System.out.printf("%.3f%n", test.wGoodness());
        }

        CouponCollector test = new CouponCollector(50000);
        double avgM = 0.0;
        double avgW = 0.0;
        for (int i = 0; i < 10000; i++) {
            test.run();
            avgM += test.mGoodness();
            avgW += test.wGoodness();
            test.reset();
        }
        avgM = avgM / 10000;
        avgW = avgW / 10000;
        System.out.printf("%.3f%n", avgM);
        System.out.printf("%.3f%n", avgW);
    }
}