<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://www.pbcore.org/PBCore/PBCoreNamespace.html"
    xmlns:fmp="http://www.filemaker.com/fmpdsoresult"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.pbcore.org/PBCore/PBCoreNamespace.html"
    exclude-result-prefixes="fmp xsi">
    <xsl:output indent="yes" method="xml"/>
    <xsl:variable name="rowCount" select="count(/fmp:FMPDSORESULT/fmp:ROW)"/>
    
    
<!--     NOTE:  this was written for use with CCTV data in Filemaker database "Programs.fp7" in CCTV folder on dept server in IMLS_News -->
    
    

    <xsl:template match="/fmp:FMPDSORESULT">
        <xsl:choose>
            <xsl:when test="$rowCount > 1">
                <xsl:element name="PBCoreCollection">
                    <xsl:apply-templates select="fmp:ROW"/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="fmp:ROW"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>




    <xsl:template match="fmp:ROW">
        <xsl:element name="PBCoreDescriptionDocument">
            <!--<PBCoreDescriptionDocument>-->

            <xsl:if test="fmp:program_type/text() != ''">
                <xsl:element name="pbcoreAssetType">
                    <!--<pbcoreAssetType>-->
                    <xsl:value-of select="fmp:program_type/text()"/>
                </xsl:element>
                <!--</pbcoreAssetType>-->
            </xsl:if>

            <xsl:if test="fmp:date_first_play_calc/text() != ''">
                <xsl:element name="pbcoreAssetDate">
                    <!--<pbcoreAssetDate dateType="created">-->
                    <xsl:attribute name="dateType">
                        <xsl:text>broadcast</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="fmp:date_first_play_calc/text()"/>
                </xsl:element>
                <!--</pbcoreAssetDate>-->
            </xsl:if>

            <xsl:if test="fmp:d_FirstPlay/text() != ''">
                <xsl:element name="pbcoreAssetDate">
                    <!--<pbcoreAssetDate dateType="created">-->
                    <xsl:attribute name="dateType">
                        <xsl:text>broadcast</xsl:text>
                    </xsl:attribute>
                    <!--<xsl:value-of select="fmp:date_creation/text()"/>-->
                    <xsl:value-of select="fmp:d_FirstPlay/text()"/>
                </xsl:element>
                <!--</pbcoreAssetDate>-->
            </xsl:if>
            
            <xsl:if test="fmp:d_CreationDate/text() != ''">
                <xsl:element name="pbcoreAssetDate">
                    <!--<pbcoreAssetDate dateType="created">-->
                    <xsl:attribute name="dateType">
                        <xsl:text>created</xsl:text>
                    </xsl:attribute>
                    <!--<xsl:value-of select="fmp:date_creation/text()"/>-->
                    <xsl:value-of select="fmp:d_CreationDate/text()"/>
                </xsl:element>
                <!--</pbcoreAssetDate>-->
            </xsl:if>
            
            <xsl:if test="fmp:d_ExportedtoTiltrac/text() != ''">
                <xsl:element name="pbcoreAssetDate">
                    <!--<pbcoreAssetDate dateType="created">-->
                    <xsl:attribute name="dateType">
                        <xsl:text>exported</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="fmp:d_ExportedtoTiltrac/text()"/>
                </xsl:element>
                <!--</pbcoreAssetDate>-->
            </xsl:if>

            <xsl:element name="pbcoreIdentifier">
                <!--<pbcoreIdentifier source="UID">-->
                <xsl:attribute name="source">
                    <xsl:text>id_archive</xsl:text>
                </xsl:attribute>
                <xsl:value-of select="fmp:id_archive/text()"/>
            </xsl:element>
            <!--</pbcoreIdentifier>-->
            <xsl:element name="pbcoreIdentifier">
                <!--<pbcoreIdentifier source="can number">-->
                <xsl:attribute name="source">
                    <xsl:text>id_program_prime</xsl:text>
                </xsl:attribute>
                <xsl:value-of select="fmp:id_program_prime/text()"/>
            </xsl:element>
            <!--</pbcoreIdentifier>-->
            <!-- 2 IDENTIFIERS? -->
            <xsl:element name="pbcoreTitle">
                <xsl:attribute name="titleType">
                    <xsl:text>Program</xsl:text>
                </xsl:attribute>
                <!--<pbcoreTitle>-->
                <!--<xsl:value-of select="fmp:program_title/text()"/>-->
                <xsl:value-of select="translate(fmp:tx_ProgramTitle/text(),'&quot;][','')"/>
            </xsl:element>
            <!--</pbcoreTitle>-->

            <!-- MULTIPLES -->
            <xsl:if test="fmp:SUBJECT_PERSONALITIES/text() != ''">
                <xsl:element name="pbcoreSubject">
                    <!--<pbcoreSubject>-->
                    <xsl:attribute name="subjectType">
                        <xsl:text>entity</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="fmp:SUBJECT_PERSONALITIES/text()"/>
                </xsl:element>
                <!--</pbcoreSubject>-->
            </xsl:if>
            <xsl:if test="fmp:SUBJECT/text() != ''">
                <xsl:element name="pbcoreSubject">
                    <!--<pbcoreSubject subjectType="entity">-->
                    <xsl:attribute name="subjectType">
                        <xsl:text>entity</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="fmp:SUBJECT/text()"/>
                </xsl:element>
                <!--</pbcoreSubject>-->
            </xsl:if>

            <xsl:element name="pbcoreDescription">
                <!--<pbcoreDescription>-->
                <xsl:attribute name="descriptionType">
                    <xsl:text>Program</xsl:text>
                </xsl:attribute>
                <!--<xsl:value-of select="fmp:program_description/text()"/>-->
                <xsl:value-of select="fmp:tx_SeriesDescription/text()"/>
            </xsl:element>
            <xsl:element name="pbcoreDescription">
                <!--<pbcoreDescription>-->
                <xsl:attribute name="descriptionType">
                    <xsl:text>Program</xsl:text>
                </xsl:attribute>
                <!--<xsl:value-of select="fmp:program_description/text()"/>-->
                <xsl:value-of select="fmp:tx_Locations/text()"/>
            </xsl:element>
            <xsl:if test="fmp:tx_Talent/text() != ''">
                <xsl:element name="pbcoreDescription">
                    <!--<pbcoreDescription>-->
                    <xsl:attribute name="descriptionType">
                        <xsl:text>Program</xsl:text>
                    </xsl:attribute>
                    <!--<xsl:value-of select="fmp:program_description/text()"/>-->
                    <xsl:value-of select="concat('Talent:',fmp:tx_Talent/text())"/>
                </xsl:element>
            </xsl:if>
            <!--</pbcoreDescription>-->


            <xsl:element name="pbcoreRelation">
                <!--<pbcoreRelation>-->
                <xsl:element name="pbcoreRelationType">
                    <!--<pbcoreRelationType>-->
                    <xsl:text>Is Part Of</xsl:text>
                </xsl:element>
                <!--</pbcoreRelationType>-->
                <xsl:element name="pbcoreRelationIdentifier">
                    <!--<pbcoreRelationIdentifier>-->
                    <xsl:text>CCTV</xsl:text>
                </xsl:element>
                <!--</pbcoreRelationIdentifier>-->
            </xsl:element>
            <!--</pbcoreRelation>-->



            <xsl:if test="fmp:LOCATION/text() != ''">
                <!--fmp:program_locations/text() != ''">-->
                <xsl:element name="pbcoreCoverage">
                    <xsl:element name="coverage">
                        <!--<xsl:value-of select="fmp:program_locations/text()"/>-->
                        <xsl:value-of select="fmp:LOCATION/text()"/>
                    </xsl:element>
                    <xsl:element name="coverageType">
                        <xsl:text>spatial</xsl:text>
                    </xsl:element>
                </xsl:element>
            </xsl:if>

            <xsl:if test="fmp:tx_Organizations/text() != ''">
                <xsl:element name="pbcoreCreator">
                    <xsl:element name="creator">
                        <xsl:value-of select="fmp:tx_Organizations/text()"/>
                    </xsl:element>
                    <xsl:element name="creatorRole">
                        <xsl:text>Producer</xsl:text>
                    </xsl:element>
                </xsl:element>
            </xsl:if>



            <xsl:if
                test="fmp:CONTRIBUTOR/text() != '' and translate(fmp:CONTRIBUTOR_ROLE/text(),'ABCDEFGHIJKLMNOPQRSTUVWXYZ ,.:!?','abcdefghijklmnopqrstuvwxyz') != 'unknown'">
                <!--translate(fmp:program_talent/text(),' ','') != ''">-->
                <!--removes all whitespace for test-->
                <xsl:element name="pbcoreContributor">
                    <!--<pbcoreContributor>-->
                    <xsl:value-of select="fmp:CONTRIBUTOR/text()"/>
                </xsl:element>
                <!--</pbcoreContributor>-->
                <xsl:element name="contributorRole">
                    <xsl:if
                        test="translate(fmp:CONTRIBUTOR_ROLE/text(),'ABCDEFGHIJKLMNOPQRSTUVWXYZ ,.:!?','abcdefghijklmnopqrstuvwxyz') != 'unknown'">
                        <xsl:value-of select="fmp:CONTRIBUTOR_ROLE/text()"/>
                    </xsl:if>

                </xsl:element>
            </xsl:if>




            <xsl:element name="pbcoreInstantiation">
                <!--                <instantiationIdentifier source="L2dlyAuS" ref="FV-2" version="_9eSaepM1.kUEK" annotation="h_72.xkRKa">-->
                <xsl:element name="instantiationIdentifier">
                    <xsl:attribute name="source">
                        <xsl:value-of select="'id_archive &amp; id_program_prime'"/>
                    </xsl:attribute>
                    <xsl:attribute name="annotation">
                        <xsl:text>not in DB, but added to records during conversion to PBCore</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of
                        select="concat(fmp:id_archive/text(),'-',fmp:id_program_prime/text())"/>
                </xsl:element>
                <!--</instantiationIdentifier>-->

                <!--<instantiationDimensions unitsOfMeasure="xF4cJeX0No2VodcAL" annotation="J8GYMlEuYWWu">fX.</instantiationDimensions>-->
                <!--</instantiationDimensions>-->

                <xsl:if test="fmp:tx_FormatType/text() != ''">
                    <xsl:element name="instantiationPhysical">
                        <!--<instantiationPhysical>-->
                        <xsl:value-of select="fmp:tx_FormatType/text()"/>
                    </xsl:element>
                    <!--</instantiationPhysical>-->
                </xsl:if>

                <!--<instantiationMediaType source="cgJsuv" ref="ri-8coaqhn1K_R7pHGLO8KB" version="OvBY1WRpQi9foZpCvf" annotation="FxuJMXBz4ygyv3N8MqkUIcTjG535QH">a</instantiationMediaType>-->
                <!--</instantiationMediaType>-->

                <xsl:if test="fmp:time_total_running/text() !=''">
                    <xsl:element name="instantiationDuration">
                        <!--<instantiationDuration>-->
                        <xsl:value-of select="fmp:time_total_running/text()"/>
                    </xsl:element>
                    <!--</instantiationDuration>-->
                </xsl:if>


                <!--<instantiationColors source="Y1J" ref="cRZAENTL" version="iDNU6RY6mk0wERVFZW1" annotation="fAptW2">MfKdnIGJB3JCtM_SEjU</instantiationColors>-->
                <xsl:element name="instantiationColors">
                    <xsl:attribute name="annotation">
                        <xsl:text>value not present in db; added during conversion to PBCore</xsl:text>
                    </xsl:attribute>
                    <xsl:text>Color</xsl:text>
                </xsl:element>
                <!--</instantiationColors>-->




                <!--<instantiationLanguage source="MRqS9KQaSklZe8TojSJ6Z3uN" ref="dzt14R-TLd8k1" version="PhUnau" annotation="sb7BN8bTPKh"></instantiationLanguage>-->
                <xsl:if test="fmp:tx_Language/fmp:DATA[1]/text() != ''">
                    <xsl:element name="instantiationLanguage">
                        <!--<instantiationLanguage>-->
                        <xsl:value-of select="fmp:tx_Language/fmp:DATA[1]/text()"/>
                    </xsl:element>
                    <!--</instantiationLanguage>-->
                </xsl:if>

                <!--<instantiationAlternativeModes>-->
                <xsl:if
                    test="concat(fmp:program_language/fmp:DATA[2]/text(),fmp:program_language/fmp:DATA[3]/text()) != ''">
                    <xsl:element name="instantiationAlternativeModes">
                        <xsl:value-of select="fmp:program_language/fmp:DATA[2]/text()"/>
                        <xsl:if test="fmp:program_language/fmp:DATA[3]/text() != ''">
                            <xsl:value-of
                                select="concat(', ',fmp:program_language/fmp:DATA[3]/text())"/>
                        </xsl:if>
                    </xsl:element>

                </xsl:if>
                <!--</instantiationAlternativeModes>-->


            </xsl:element>
            <!--</pbcoreInstantiation>-->

            <xsl:if test="fmp:episodes/text() != ''">
                <xsl:element name="pbcoreAnnotation">
                    <!--<pbcoreAnnotation annotationType="X3yG7.NG1HftpWD7XfZF_asUVOLf" ref="L4F">V_I</pbcoreAnnotation>-->
                    <xsl:attribute name="ref">
                        <xsl:text>Episodes</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="fmp:episodes/text()"/>
                </xsl:element>
                <!--</pbcoreAnnotation>-->
            </xsl:if>

            <xsl:if test="fmp:notes/text() != ''">
                <xsl:element name="pbcoreAnnotation">
                    <!--<pbcoreAnnotation annotationType="X3yG7.NG1HftpWD7XfZF_asUVOLf" ref="L4F">V_I</pbcoreAnnotation>-->
                    <xsl:attribute name="ref">
                        <xsl:text>Notes</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="fmp:notes/text()"/>
                </xsl:element>
                <!--</pbcoreAnnotation>-->
            </xsl:if>

            <!--
            <pbcoreExtension>
                <extensionWrap annotation="az3PGJ">
                    <extensionElement>vPgDmPfiSafONc598kMQYq_6xbGkZ</extensionElement>
                    <extensionValue>Jwn3LUDcuq</extensionValue>
                    <extensionAuthorityUsed>http://PgTjZMrF/</extensionAuthorityUsed>
                    </extensionWrap>-->


        </xsl:element>
        <!--</PBCoreDescriptionDocument>-->

    </xsl:template>
    <xsl:template name="asset"/>

</xsl:stylesheet>
