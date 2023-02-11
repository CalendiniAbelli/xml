import org.dom4j.Document;
import org.dom4j.DocumentException;
import java.io.File;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.dom4j.Element;
import org.dom4j.io.SAXReader;

/**
 * Liste l'ensemble des voyages qui ne sont pas encore déroulés mais ou la capacité de client inscrit est deja maximale.
 * Pour ceci, il faut verifier que la somme du nombre de client inscrit pour tous les voyages ayant la même offre à la même date
 * soit égale à la capacité de l'offre.
 */

public class Main {


    public static void main(String[] args) throws DocumentException
    {
        File file =  new File("Organisme.xml") ;
        SAXReader reader =  new SAXReader() ;
        Document organisme = reader.read(file) ;

        Element root = organisme.getRootElement();

        Map<Integer, Integer> offres = new HashMap<>();
        Element offresElement = root.element("offres");
        Element voyagesElement = root.element("voyages");
        Element utilisateursElement = root.element("utilisateurs");
        Element clientsElement = utilisateursElement.element("clients");

        // Dictionnaire idOffre | nombrePlaces de l'offre
        for (Element offre : offresElement.elements("offre")) {
            int offreId = Integer.parseInt(offre.attributeValue("offreId"));
            int nombrePlaces = Integer.parseInt(offre.elementText("nombrePlaces"));

            offres.put(offreId, nombrePlaces);
        }

        List<Voyage> voyages = new ArrayList<>();
        LocalDate aujourdhui = LocalDate.now();

        // Liste de voyage ayant la même offre et la même date de départ avec la liste des idVoyage du xml qui correspond à cette spécification
        for (Element voyageElement : voyagesElement.elements("voyage")) {
            int voyageId = Integer.parseInt(voyageElement.attributeValue("voyageId"));
            int offreId = Integer.parseInt(voyageElement.element("offre").attributeValue("offreIdRef"));

            String dateString = voyageElement.elementText("dateDepart");
            LocalDate date = LocalDate.parse(dateString);

            Voyage voyage = new Voyage(offreId, date);

            if (date.isAfter(aujourdhui)) {
                if (!voyages.contains(voyage)) {
                    voyages.add(voyage);
                    voyage.addIdVoyages(voyageId);
                }
                else {
                    int index = voyages.indexOf(voyage);
                    Voyage voyageExistant = voyages.get(index);
                    voyageExistant.addIdVoyages(voyageId);
                }
            }

        }

        // Met à jour le nombreClient des voyages
        for (Element client : clientsElement.elements("client")) {
            Element voyagesClientElement = client.element("voyages");

            for (Element voyageClient : voyagesClientElement.elements("voyage")) {
                int voyageClientId = Integer.parseInt(voyageClient.attributeValue("voyageClientIdRef"));

                Voyage voyageTrouve = null;
                for (Voyage voyage : voyages) {
                    if (voyage.getVoyagesId().contains(voyageClientId)) {
                        voyageTrouve = voyage;
                        break;
                    }
                }
                if (voyageTrouve !=null) {
                    voyageTrouve.addNombreClients();
                }
            }

        }

        for (Voyage voyage : voyages) {
            int offreId = voyage.getOffreId();
            int nombreClientOffre = offres.get(offreId);

            if (nombreClientOffre <= voyage.getNombreClients()) {
                System.out.println("Le(s) voyage(s) ayant pour id : " + voyage.getVoyagesId() + " étant relié(s) à l'offre " + voyage.getOffreId() + " et commençant le " + voyage.getDateDepart() + " sont plein(s)");

            }
        }

    }

}
