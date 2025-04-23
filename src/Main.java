import javax.xml.transform.*;
import javax.xml.transform.stream.*;
import java.io.File;

public class Main {
    public static void main(String[] args) throws TransformerException {
        Source xslt = new StreamSource(new File("resources/Task1.xslt"));
        Source xml = new StreamSource(new File("resources/Task1.xml"));

        TransformerFactory factory = TransformerFactory.newInstance();
        Transformer transformer = factory.newTransformer(xslt);


        Result output = new StreamResult(new File("resources/output.xml"));
        transformer.transform(xml, output);

        Source xslt2 = new StreamSource(new File("resources/Task2.xslt"));
        Source xml2 = new StreamSource(new File("resources/Task2.xml"));

        TransformerFactory factory2 = TransformerFactory.newInstance();
        Transformer transformer2 = factory2.newTransformer(xslt2);


        Result output2 = new StreamResult(new File("resources/output2.xml"));
        transformer2.transform(xml2, output2);

        System.out.println("Converting is over");
    }
}