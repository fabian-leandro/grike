package cr.ac.ucr.ci1322.kaguro;

import java.io.FileNotFoundException;
import java.io.FileReader;

public class Main {
    private static final String outputFile = "target/sample.out";

    public static void main(String[] args) {

        if(args.length != 1) {
            System.out.println("Por favor incluya un solo argumento que" +
                    "contiene una ruta a un archivo de código fuente .grk");
        } else {
            FileReader sourceCode = null;
            try {
                sourceCode = new FileReader(args[0]);
            } catch(FileNotFoundException e) {
                System.out.println("No se encontró "+args[0]);
            }
            GramaticaGrike gram = new GramaticaGrike(sourceCode);
            Grike g = new Grike(gram);
            try {
                g.parse();
            } catch (Exception e) {
                System.out.println("Error");
            }
        }
    }
}
