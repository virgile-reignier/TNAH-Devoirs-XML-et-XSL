<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs tei"
    version="2.0">
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>

    <xsl:template match="/">
        <html>
            <xsl:apply-templates/>
        </html>
    </xsl:template>

    <xsl:template match="titleStmt">
        <head>
            <title>
                <xsl:copy-of select="./title/text()"/>
            </title>
            <author>
                <xsl:copy-of select="./respStmt/persName/text()"></xsl:copy-of>
            </author>
        </head>
    </xsl:template>

<xsl:template match="div1|div2|div3">
    <div>
        <xsl:apply-templates/>
    </div>
</xsl:template>
    
<xsl:template match="p">
    <p>
        <xsl:apply-templates/>
    </p>
</xsl:template>

</xsl:stylesheet>
