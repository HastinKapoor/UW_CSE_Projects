import java.util.*;

public class RandomGraphGenerator {
    private int size;
    private int edgeCount;
    private ArrayList<HashSet<Integer>> adjacencyList;


    public RandomGraphGenerator(int n, double p) {
        size = n;
        edgeCount = 0;
        adjacencyList = new ArrayList<HashSet<Integer>>();
        for (int i = 0; i < n; i++) {
            adjacencyList.add(new HashSet<>());
        }
        generate(p);
    }


    private void generate(double p) {
        Random random = new Random();
        for (int i = 0; i < size; i++) {
            for (int j = i + 1; j < size; j++) {
                if(random.nextDouble() < p) {
                    adjacencyList.get(i).add(j);
                    adjacencyList.get(j).add(i);
                    edgeCount++;
                }
            }
        }
    }

    public int[][] getEdges() {
        int[][] result = new int[edgeCount][2];
        int edge = 0;
        for (int i = 0; i < size; i++) {
            Iterator<Integer> from = adjacencyList.get(i).iterator();
            while (from.hasNext()) {
                int j = from.next();
                if (j <= i) {
                    result[edge] = new int[]{i, j};
                    edge++;
                }
            }
        }
        return result;
    }

    public static int finiteDiameter(RandomGraphGenerator g) {
        int maxDist = 0;
        for (int i = 0; i < g.size; i++) {
            Queue<Integer> queue = new LinkedList<>();
            queue.add(i);
            HashMap<Integer, Integer> dist = new HashMap<>();
            dist.put(i, 0);
            while (!queue.isEmpty()) {
                int current = queue.poll();
                int currentDist = dist.get(current);
                HashSet<Integer> edges = g.adjacencyList.get(current);
                for (int to : edges) {
                    if (!dist.containsKey(to)) {
                        dist.put(to, currentDist + 1);
                        if (currentDist + 1 > maxDist) {
                            maxDist = currentDist + 1;
                        }
                        queue.add(to);
                    }
                }
            }
        }
        return maxDist;
    }

    public boolean isConnected() {
        int componentSize = 1;
        Queue<Integer> queue = new LinkedList<>();
        boolean[] visited = new boolean[size];
        queue.add(0);
        visited[0] = true;
        while (!queue.isEmpty()) {
            int current = queue.poll();
            HashSet<Integer> edges = adjacencyList.get(current);
            for (int to : edges) {
                if (!visited[to]) {
                    visited[to] = true;
                    componentSize++;
                    queue.add(to);
                }
            }
        }
        return componentSize == size;
    }

    public static double diameter(RandomGraphGenerator g) {
        if(!g.isConnected()) {
            return Double.POSITIVE_INFINITY;
        } else {
            return finiteDiameter(g);
        }
    }

    public Integer[] components() {
        HashSet<Integer> notInComponent = new HashSet<>();
        for (int i = 0; i < size; i++) {
            notInComponent.add(i);
        }
        int componentCount = 0;
        int maxComponentSize = 0;
        while (!notInComponent.isEmpty()) {
            componentCount++;
            int componentSize = componentSize(notInComponent, notInComponent.iterator().next());
            if (componentSize > maxComponentSize) {
                maxComponentSize = componentSize;
            }
        }
        return new Integer[] {componentCount, maxComponentSize};
    }

    private int componentSize(Set<Integer> set, int n) {
        int componentSize = 1;
        Queue<Integer> queue = new LinkedList<>();
        boolean[] visited = new boolean[size];
        queue.add(n);
        visited[n] = true;
        set.remove(n);
        while (!queue.isEmpty()) {
            int current = queue.poll();
            HashSet<Integer> edges = adjacencyList.get(current);
            for (int to : edges) {
                if (!visited[to]) {
                    visited[to] = true;
                    componentSize++;
                    queue.add(to);
                    set.remove(to);
                }
            }
        }
        return componentSize;
    }
}