<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="text"/>

    <xsl:template match="/">
        {
        "offres": [
        <xsl:apply-templates select="Organisme/offres/offre"/>
        ],
        "voyages" : [
        <xsl:apply-templates select="Organisme/voyages"/>
        ],
        "utilisateurs": [
        <xsl:apply-templates select="Organisme/utilisateurs"/>
        ]
        }
    </xsl:template>

    <xsl:template match="offre">
        {
        "offreId": "<xsl:value-of select="@offreId"/>",
        "type": "<xsl:value-of select="type"/>",
        "destination": "<xsl:value-of select="destination"/>",
        <xsl:if test="ageMin">"ageMin": "<xsl:value-of select="ageMin"/>",
        </xsl:if>
        <xsl:if test="ageMax">"ageMax": "<xsl:value-of select="ageMax"/>",
        </xsl:if>
        "prix": "<xsl:value-of select="prix"/>",
        "nombrePlaces": "<xsl:value-of select="nombrePlaces"/>",
        "duree": "<xsl:value-of select="duree"/>"
        <xsl:if test="langue">
            ,
            "langue": {
            "nom": "<xsl:value-of select="langue/nom"/>",
            "niveauCours": "<xsl:value-of select="langue/niveauCours"/>",
            "heuresCours": "<xsl:value-of select="langue/heuresCours"/>",
            "test": "<xsl:value-of select="langue/test"/>"
            }
        </xsl:if>
        }<xsl:if test="position() != last()">,</xsl:if>
    </xsl:template>

    <xsl:template match="voyages">
        <xsl:for-each-group select="voyage" group-by="dateDepart">
            {
            "voyageId": "<xsl:value-of select="concat(dateDepart, offre/@offreIdRef)"/>",
            "offreIdRef": "<xsl:value-of select="offre/@offreIdRef"/>",
            "dateDepart": "<xsl:value-of select="dateDepart"/>"
            }<xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each-group>
    </xsl:template>

    <xsl:template match="utilisateurs">
        {
        "clients": [
        <xsl:apply-templates select="clients/client"/>
        ],
        "moniteurs": [
        <xsl:apply-templates select="moniteurs/moniteur"/>
        ],
        "enseignants": [
        <xsl:apply-templates select="enseignants/enseignant"/>
        ]
        }
    </xsl:template>

    <xsl:template match="client">
        {
        "nom": "<xsl:value-of select="nom"/>",
        "prenom": "<xsl:value-of select="prenom"/>",
        "age": "<xsl:value-of select="age"/>",
        "voyages": [
        <xsl:for-each select="voyages/voyage">
            <xsl:variable name="voyageClientIdRef" select="@voyageClientIdRef"/>
            <xsl:for-each select="../../../../../voyages/voyage">
                <xsl:if test="@voyageId = $voyageClientIdRef">
                    <xsl:variable name="nouveauVoyageId" select="concat(dateDepart, offre/@offreIdRef)"/>
                    {
                    "voyageIdRef": "<xsl:value-of select="$nouveauVoyageId"/>"
                    }
                </xsl:if>
            </xsl:for-each>
                <xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        ],
        "contact": {
        "numeroTelephone": "<xsl:value-of select="contact/numeroTelephone"/>",
        "adresse": "<xsl:value-of select="contact/adresse"/>",
        "ville": "<xsl:value-of select="contact/ville"/>",
        "codePostale": "<xsl:value-of select="contact/codePostale"/>",
        "adresseMail": "<xsl:value-of select="contact/adresseMail"/>"
        },
        "contactUrgence": {
        "lien": "<xsl:value-of select="contactUrgence/lien"/>",
        "nom": "<xsl:value-of select="contactUrgence/nom"/>",
        "prenom": "<xsl:value-of select="contactUrgence/prenom"/>",
        "numeroTelephone": "<xsl:value-of select="contactUrgence/numeroTelephone"/>"
        },
        "langues": [
        <xsl:for-each select="langues/langue">
            {
            "nom": "<xsl:value-of select="nom"/>",
            "niveau": "<xsl:value-of select="niveau"/>"
            }
            <xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        ]
        }<xsl:if test="position() != last()">,</xsl:if>
    </xsl:template>

    <xsl:template match="moniteur">
        {
        "nom": "<xsl:value-of select="nom"/>",
        "prenom": "<xsl:value-of select="prenom"/>",
        "voyages": [
        <xsl:for-each select="voyages/voyage">
            <xsl:variable name="voyageMoniteurIdRef" select="@voyageMoniteurIdRef"/>
            <xsl:for-each select="../../../../../voyages/voyage">
                <xsl:if test="@voyageId = $voyageMoniteurIdRef">
                    <xsl:variable name="nouveauVoyageId" select="concat(dateDepart, offre/@offreIdRef)"/>
                    {
                    "voyageIdRef": "<xsl:value-of select="$nouveauVoyageId"/>"
                    }
                </xsl:if>
            </xsl:for-each>
            <xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        ],
        "contact": {
        "numeroTelephone": "<xsl:value-of select="contact/numeroTelephone"/>",
        "adresse": "<xsl:value-of select="contact/adresse"/>",
        "ville": "<xsl:value-of select="contact/ville"/>",
        "codePostale": "<xsl:value-of select="contact/codePostale"/>",
        "adresseMail": "<xsl:value-of select="contact/adresseMail"/>"
        },
        "diplomes": [
        <xsl:for-each select="diplomes/diplome">
            {
            "nom": "<xsl:value-of select="nom"/>",
            "anneeObtention": "<xsl:value-of select="anneeObtention"/>"
            }
            <xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        ],
        "langues": [
        <xsl:for-each select="langues/langue">
            {
            "nom": "<xsl:value-of select="nom"/>",
            "niveau": "<xsl:value-of select="niveau"/>"
            }
            <xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        ]
        }<xsl:if test="position() != last()">,</xsl:if>
    </xsl:template>

    <xsl:template match="enseignant">
        {
        "nom": "<xsl:value-of select="nom"/>",
        "prenom": "<xsl:value-of select="prenom"/>",
        "voyages": [
        <xsl:for-each select="voyages/voyage">
            <xsl:variable name="voyageEnseignantIdRef" select="@voyageEnseignantIdRef"/>
            <xsl:for-each select="../../../../../voyages/voyage">
                <xsl:if test="@voyageId = $voyageEnseignantIdRef">
                    <xsl:variable name="nouveauVoyageId" select="concat(dateDepart, offre/@offreIdRef)"/>
                    {
                    "voyageIdRef": "<xsl:value-of select="$nouveauVoyageId"/>"
                    }
                </xsl:if>
            </xsl:for-each>
            <xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        ],
        "contact": {
        "numeroTelephone": "<xsl:value-of select="contact/numeroTelephone"/>",
        "adresse": "<xsl:value-of select="contact/adresse"/>",
        "ville": "<xsl:value-of select="contact/ville"/>",
        "codePostale": "<xsl:value-of select="contact/codePostale"/>",
        "adresseMail": "<xsl:value-of select="contact/adresseMail"/>"
        },
        "matieres": [
        <xsl:for-each select="matieres/matiere">
            "<xsl:value-of select="."/>"
            <xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        ],
        "langues": [
        <xsl:for-each select="langues/langue">
            {
            "nom": "<xsl:value-of select="nom"/>",
            "niveau": "<xsl:value-of select="niveau"/>"
            }
            <xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
        ]
        }<xsl:if test="position() != last()">,</xsl:if>
    </xsl:template>


</xsl:stylesheet>
