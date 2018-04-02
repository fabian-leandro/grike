package cr.ac.ucr.ci1322.kaguro;

import java.io.FileNotFoundException;
import java.io.FileReader;

public class Main {
    private static final String outputFile = "target/sample.out";

    public static void main(String[] args) {
        String[] argv = new String[1];
        argv[0] = "src/main/resources/input.txt";

        try {
            GramaticaKaguro gram = new GramaticaKaguro(new FileReader(argv[0]));
            GramaticaKaguro.main(argv);
        } catch(FileNotFoundException e ) {
            e.printStackTrace();
        }
    }

}
