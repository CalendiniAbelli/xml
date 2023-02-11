import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Objects;

public class Voyage {
    private final ArrayList<Integer> voyagesId;
    private int offreId;
    private LocalDate dateDepart;
    private int nombreClients;

    public Voyage(int OffreId, LocalDate dateDepart) {
        this.offreId = OffreId;
        this.dateDepart = dateDepart;
        this.voyagesId = new ArrayList<>();
        this.nombreClients = 0;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }

        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }

        Voyage voyage = (Voyage) obj;

        return offreId == voyage.offreId && dateDepart.equals(voyage.dateDepart);
    }

    @Override
    public int hashCode() {
        return Objects.hash(offreId, dateDepart);
    }

    public ArrayList<Integer> getVoyagesId() {
        return voyagesId;
    }

    public void addIdVoyages(Integer idVoyages) {
        this.voyagesId.add(idVoyages);
    }

    public int getOffreId() {
        return offreId;
    }

    public void setOffreId(int offreId) {
        this.offreId = offreId;
    }

    public LocalDate getDateDepart() {
        return dateDepart;
    }

    public void setDateDepart(LocalDate dateDepart) {
        this.dateDepart = dateDepart;
    }

    public int getNombreClients() {
        return nombreClients;
    }

    public void addNombreClients() {
        this.nombreClients += 1;
    }
}