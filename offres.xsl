<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="Organisme">
    <html>
      <head>
        <title>Liste des voyages disponibles</title>
        <link rel="stylesheet" type="text/css" href="offres.css"/>
      </head>
      <body>
        <h1>Liste des voyages disponibles</h1>
        <table border="1">
          <tr>
            <th>Code voyage</th>
            <th>DateDepart</th>
            <th>Type d'offre</th>
            <th>Destination</th>
          </tr>

          
            <xsl:for-each select="voyages/voyage">
            <tr>
              <td> <xsl:value-of select="@voyageId"/> </td>
              <td> <xsl:value-of select="dateDepart"/> </td>
              <xsl:variable name="offreIdRef"> <xsl:value-of select="offre/@offreIdRef"/> </xsl:variable>

              <xsl:for-each select="../../offres/offre">
                <xsl:if test="@offreId=$offreIdRef">  
                    <td><xsl:value-of select="type"/></td>
                    <td><xsl:value-of select="destination"/></td>
                </xsl:if>
              </xsl:for-each>
            </tr>
            </xsl:for-each> 
          
        
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>

          