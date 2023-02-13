<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="Organisme">
    <html>
      <head>
        <title> Liste des clients participant aux voyages</title>
        <link rel="stylesheet" type="text/css" href="xsl/clients.css"/>
      </head>
      <body>
        <h1>Liste des clients participant aux voyages </h1>
        <table border="1">

            <tr>
                <th>Code voyage</th>
                <th>Date de départ</th>
                <th>Nombre de clients participant au voyage </th>
                <th> Nom </th>
                <th> Prénom </th>
                <th> Age </th>
            </tr>
          
            <xsl:for-each select="voyages/voyage">
                <tr>
                 
                    <td> <xsl:value-of select="@voyageId"/> </td>
                    <td> <xsl:value-of select="dateDepart"/> </td>
                    <xsl:variable name="voyageId"> <xsl:value-of select="@voyageId"/> </xsl:variable>

                    <xsl:variable name="compteur" select="count(../../utilisateurs/clients/client/voyages/voyage[@voyageClientIdRef=$voyageId])"/>
                    <td> <xsl:value-of select="$compteur"/> </td>
                  
                    <xsl:for-each select="../../utilisateurs/clients/client/voyages/voyage">
                      <xsl:if test="@voyageClientIdRef=$voyageId">
        
                        <xsl:if test="$compteur = 1"> 
                          <td><xsl:value-of select="../../nom"/></td>
                          <td><xsl:value-of select="../../prenom"/></td>
                          <td><xsl:value-of select="../../age"/></td>
                          <tr></tr>
                        </xsl:if>
        
                        <xsl:if test="$compteur != 1"> 
                            <td><xsl:value-of select="../../nom"/></td>
                            <td><xsl:value-of select="../../prenom"/></td>
                            <td><xsl:value-of select="../../age"/></td>
                            <tr></tr>
                            <td></td>
                            <td></td>
                            <td></td>
                        </xsl:if>
                        
                      </xsl:if>
                    </xsl:for-each>
                </tr>
            </xsl:for-each> 
          
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>

          