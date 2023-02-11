<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="Main">
    <html>
      <head>
        <title>Liste des offres disponibles</title>
        <link rel="stylesheet" type="text/css" href="offres.css"/>
      </head>
      <body>
        <h1>Liste des voyages disponibles</h1>
        <table border="1">
          <tr>
            <th>Type</th>
            <th>Destination</th>
            <th>Age minimum</th>
            <th>Age maximum</th>
            <th>Prix</th>
            <th>Nombre de places</th>
            <th>Durée</th>
            <th>Langue</th>
            <th>Niveau de cours</th>
            <th>Heures de cours</th>
            <th>Test</th>
          </tr>
          <xsl:for-each select="offres/offre">
            <xsl:sort select="type"/>
                <tr>
                    <td style="background-color: {
                        if (type = 'Immersion en famille') then 'lightblue'
                        else if (type = 'Colonies de vacances') then 'lightgreen'
                        else if (type = 'Groupe scolaire') then 'lightyellow'
                        else 'lightgrey'
                        }"> 
                    <xsl:value-of select="type"/> 
                    </td>

                    <td> <xsl:value-of select="destination"/> </td>
                    <td> <xsl:value-of select="ageMin"/> </td>
                    <td> <xsl:value-of select="ageMax"/> </td>
                    <td> <xsl:value-of select="prix"/> </td>
                    <td> <xsl:value-of select="nombrePlaces"/> </td>
                    <td> <xsl:value-of select="duree"/> </td>
                    
                    <xsl:for-each select="langue">
                        <td> <xsl:value-of select="@nom"/> </td>
                        <td> <xsl:value-of select="niveauCours"/> </td>
                        <td> <xsl:value-of select="heuresCours"/> </td>
                        <td> <xsl:value-of select="test"/> </td>
                    </xsl:for-each>
                    
                </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>