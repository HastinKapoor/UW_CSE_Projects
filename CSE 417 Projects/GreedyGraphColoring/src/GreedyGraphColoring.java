import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.Random;

public class GreedyGraphColoring {

    private int size;
    private ArrayList<Node> graph;
    private int totalColors;

    public GreedyGraphColoring(int n, double p) {
        size = n;
        graph = generateRandomGraph(n, p);
        totalColors = 0;
    }

    public int run() {
        for (int i = 0; i < size; i++) {
            Node current = graph.get(i);
            for (int j = 0; j < totalColors; j++) {
                if (!current.getEdgeColors().contains(j)) {
                    current.setColor(j);
                }
            }
            if (current.getColor() == -1) {
                current.setColor(totalColors);
                totalColors++;
            }
        }
        return totalColors;
    }

    public void sortIncr() {
        Collections.sort(graph);
    }

    public void sortDecr() {
        Collections.sort(graph, Collections.reverseOrder());
    }

    private ArrayList<Node> generateRandomGraph(int n, double p) {
        Random random = new Random();
        ArrayList<Node> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new Node(-1));
        }
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                if (random.nextDouble() < p) {
                    graph.get(i).addEdge(graph.get(j));
                }
            }
        }
        return graph;
    }

    private static class Node implements Comparable<Node> {
        private int color;
        private int edgeCount;
        private HashSet<Node> edges;
        private HashSet<Integer> edgeColors;

        private Node(int i) {
            color = i;
            edgeCount = 0;
            edges = new HashSet<>();
            edgeColors = new HashSet<>();
        }

        private void addEdge(Node n) {
            edges.add(n);
            n.edges.add(this);
            edgeCount++;
            n.edgeCount++;
        }

        private void setColor(int i) {
            color = i;
            for (Node node : edges) {
                node.edgeColors.add(i);
            }
        }
        private int getColor() {
            return color;
        }

        private int getEdgeCount() {
            return edgeCount;
        }

        private HashSet<Node> getEdges() {
            return edges;
        }

        private HashSet<Integer> getEdgeColors() {
            return edgeColors;
        }

        public int compareTo(Node node) {
            return edgeCount - node.edgeCount;
        }
    }
}