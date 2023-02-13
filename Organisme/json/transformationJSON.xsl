<?xml version="1.0"?>

<!--
Ce fichier xsl permet de transformer les données XML en données JSON.
Code récuperé de : https://stackoverflow.com/questions/24122921/xsl-to-convert-xml-to-json
En revanche, un changement ligne 83 a été fait pour le code fonctionne avec notre fichier xml
-->


<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>

    <xsl:template match="/">{
        <xsl:apply-templates select="*"/>}
    </xsl:template>

    <!-- Object or Element Property-->
    <xsl:template match="*">
        "<xsl:value-of select="name()"/>" : <xsl:call-template name="Properties"/>
    </xsl:template>

    <!-- Array Element -->
    <xsl:template match="*" mode="ArrayElement">
        <xsl:call-template name="Properties"/>
    </xsl:template>

    <!-- Object Properties -->
    <xsl:template name="Properties">
        <xsl:variable name="childName" select="name(*[1])"/>
        <xsl:choose>
            <xsl:when test="not(*|@*)">"<xsl:value-of select="."/>"</xsl:when>
            <xsl:when test="count(*[name()=$childName]) > 1">{ "<xsl:value-of select="$childName"/>" :[<xsl:apply-templates select="*" mode="ArrayElement"/>] }</xsl:when>
            <xsl:otherwise>{
                <xsl:apply-templates select="@*"/>
                <xsl:apply-templates select="*"/>
                }</xsl:otherwise>
        </xsl:choose>
        <xsl:if test="following-sibling::*">,</xsl:if>
    </xsl:template>

    <!-- Attribute Property -->
    <xsl:template match="@*">"<xsl:value-of select="name()"/>" : "<xsl:value-of select="."/>"
        <xsl:if test="count(../*) > 0">,</xsl:if>
    </xsl:template>
</xsl:stylesheet>