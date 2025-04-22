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

        System.out.println("Converting is over");
    }
}