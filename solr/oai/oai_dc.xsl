<?xml version="1.0" encoding="UTF-8"?>
<!--
  ~ OAI4Solr exposes your Solr indexes by adding a OAI2 protocol handler.
  ~
  ~     Copyright (C) 2011  International Institute of Social History
  ~
  ~     This program is free software: you can redistribute it and/or modify
  ~     it under the terms of the GNU General Public License as published by
  ~     the Free Software Foundation, either version 3 of the License, or
  ~     (at your option) any later version.
  ~
  ~     This program is distributed in the hope that it will be useful,
  ~     but WITHOUT ANY WARRANTY; without even the implied warranty of
  ~     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  ~     GNU General Public License for more details.
  ~
  ~     You should have received a copy of the GNU General Public License
  ~     along with this program.  If not, see <http://www.gnu.org/licenses/>.
  -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="2.0"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:marc="http://www.loc.gov/MARC21/slim">

    <xsl:import href="oai.xsl"/>

    <xsl:template name="header">
        <header>
            <identifier>
                <xsl:value-of select="$doc//str[@name='iisg_oai']"/>
            </identifier>
            <datestamp>
                <xsl:value-of select="$doc//date[@name='iisg_datestamp']"/>
            </datestamp>
            <xsl:for-each select="$doc//arr[@name='iisg_collectionName']/str">
                <setSpec>
                    <xsl:value-of select="."/>
                </setSpec>
            </xsl:for-each>
        </header>
    </xsl:template>

    <xsl:template name="metadata">
        <xsl:variable name="record" select="saxon:parse($doc//str[@name='resource']/text())/node()"/>
        <xsl:variable name="metadata" select="$record//recordData/*"/>
        <metadata>
            <oai_dc:dc xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
                       xmlns:dc="http://purl.org/dc/elements/1.1/">
                <xsl:for-each select="$metadata//marc:datafield">
                    <xsl:choose>
                        <xsl:when
                                test="@tag='100' or @tag='110' or @tag='111' or @tag='700' or @tag='710' or tag='711' or @tag='720'">
                            <dc:contributor>
                                <xsl:value-of select="marc:subfield/text()"/>
                            </dc:contributor>
                        </xsl:when>

                        <xsl:when test="@tag='651' or @tag='662' or @tag='751' or @tag='752'">
                            <dc:coverage>
                                <xsl:value-of select="marc:subfield/text()"/>
                            </dc:coverage>
                        </xsl:when>

                        <xsl:when test="@tag='260' and marc:subfield[@code='c' or @code='g']">
                            <dc:date>
                                <xsl:value-of select="marc:subfield/text()"/>
                            </dc:date>
                        </xsl:when>

                        <xsl:when
                                test="@tag&gt;499 and @tag&lt;600 and not(@tag=506 or @tag=530 or @tag=540 or @tag=546)">
                            <dc:description>
                                <xsl:value-of select="marc:subfield/text()"/>
                            </dc:description>
                        </xsl:when>

                        <xsl:when test="@tag='340'">
                            <dc:format>
                                <xsl:value-of select="marc:subfield/text()"/>
                            </dc:format>
                        </xsl:when>
                        <xsl:when test="@tag='856' and marc:subfield[@code='q']">
                            <dc:format>
                                <xsl:value-of select="marc:subfield/text()"/>
                            </dc:format>
                        </xsl:when>

                        <xsl:when test="@tag='020' or @tag='022' or @tag='024'">
                            <dc:identifier>
                                <xsl:value-of select="marc:subfield/text()"/>
                            </dc:identifier>
                        </xsl:when>

                        <xsl:when
                                test="@tag='041' and marc:subfield[@code='a' or @code='b' or @code='d' or @code='e' or @code='f' or @code='g' or @code='h' or @code='j']">
                            <dc:language>
                                <xsl:value-of select="marc:subfield/text()"/>
                            </dc:language>
                        </xsl:when>
                        <xsl:when test="@tag='546'">
                            <dc:language>
                                <xsl:value-of select="marc:subfield/text()"/>
                            </dc:language>
                        </xsl:when>

                        <xsl:when test="@tag='260' and marc:subfield[@code='a' or @code='b']">
                            <dc:publisher>
                                <xsl:value-of select="marc:subfield/text()"/>
                            </dc:publisher>
                        </xsl:when>

                        <xsl:when test="@tag='530'">
                            <dc:relation>
                                <xsl:value-of select="marc:subfield/text()"/>
                            </dc:relation>
                        </xsl:when>
                        <xsl:when test="@tag&gt;759 and @tag&lt;788 and marc:subfield[@code='o' or @code='t']">
                            <dc:relation>
                                <xsl:value-of select="marc:subfield/text()"/>
                            </dc:relation>
                        </xsl:when>

                        <xsl:when test="@tag='506' or @tag='540'">
                            <dc:rights>
                                <xsl:value-of select="marc:subfield/text()"/>
                            </dc:rights>
                        </xsl:when>

                        <xsl:when test="@tag='534' and marc:subfield[@code='t']">
                            <dc:source>
                                <xsl:value-of select="marc:subfield/text()"/>
                            </dc:source>
                        </xsl:when>
                        <xsl:when test="@tag='786' and marc:subfield[@code='o' or @code='t']">
                            <dc:source>
                                <xsl:value-of select="marc:subfield/text()"/>
                            </dc:source>
                        </xsl:when>

                        <xsl:when
                                test="@tag='050' or @tag='060' or @tag='080' or @tag='082' or @tag='600' or @tag='610' or @tag='611' or @tag='630' or @tag='650' or @tag='653'">
                            <dc:subject>
                                <xsl:value-of select="marc:subfield/text()"/>
                            </dc:subject>
                        </xsl:when>

                        <xsl:when test="@tag='245' or @tag='246'">
                            <dc:title>
                                <xsl:value-of select="marc:subfield/text()"/>
                            </dc:title>
                        </xsl:when>

                        <xsl:when test="@tag='655'">
                            <dc:type>
                                <xsl:value-of select="marc:subfield/text()"/>
                            </dc:type>
                        </xsl:when>

                        <xsl:otherwise/>

                    </xsl:choose>
                </xsl:for-each>
            </oai_dc:dc>
        </metadata>
    </xsl:template>

    <xsl:template name="about"/>

</xsl:stylesheet>