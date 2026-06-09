<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:key name="City" match="/orgs/item" use="@city" />
    <xsl:key name="cityOrg" match="/orgs/item" use="concat(@city, ':', @org)" />
    <xsl:template match="/">
        <html>
            <head>
                <h1>Города и компании</h1>
            </head>
            <body>
                <ul>
                    <xsl:for-each select="/orgs/item[generate-id(.) = generate-id(key('City', @city))]">
                        <li>
                            <h3><xsl:value-of select="@city"/></h3>
                            <p>Всего товаров: <xsl:value-of select="count(key('City', @city))" /></p>
                            <xsl:for-each select="key('City', @city)[generate-id(.) = generate-id(key('cityOrg', concat(@city, ':', @org))[1])]">
                            <ul>
                                <li>
                                    <h4><xsl:value-of select="@org" /></h4>
                                    <p>Всего товаров: <xsl:value-of select="count(key('cityOrg', concat(@city, ':', @org)))" /></p>
                                    <ul>
                                        <xsl:for-each select="key('cityOrg', concat(@city, ':', @org))/@title">
                                            <xsl:sort select="." />
                                            <li>
                                                <xsl:value-of select="." />
                                            </li>
                                        </xsl:for-each>
                                    </ul>
                                </li>
                            </ul>    
                            </xsl:for-each>
                        </li>
                    </xsl:for-each>
                </ul>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>