<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://www.pbcore.org/PBCore/PBCoreNamespace.html"
    xmlns:fmp="http://www.filemaker.com/fmpdsoresult"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.pbcore.org/PBCore/PBCoreNamespace.html"
    exclude-result-prefixes="fmp xsi">
    <xsl:output indent="yes" method="xml"/>
    <xsl:variable name="rowCount" select="count(/fmp:FMPDSORESULT/fmp:ROW)"/>
    
    
<!--     NOTE:  this was written for use with WCVB Assignment Sheets data in Filemaker database "IMLS_LocalNews_NHF" on hosted server (available through launcher) -->

    <xsl:template match="/fmp:FMPDSORESULT">
        <xsl:choose>
            <xsl:when test="$rowCount > 1">
                <xsl:element name="pbcoreCollection">
                    <xsl:apply-templates select="fmp:ROW"/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="fmp:ROW"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>




    <xsl:template match="fmp:ROW">
        <xsl:element name="pbcoreDescriptionDocument">
            <!--<PBCoreDescriptionDocument>-->

            <!--<pbcoreAssetType source="source1" ref="ref1" version="version1" annotation="annotation1">pbcoreAssetType0-->
            <xsl:if test="fmp:INTENDED_PURPOSE/text() != ''">
                <xsl:element name="pbcoreAssetType">
                    <xsl:value-of select="fmp:INTENDED_PURPOSE/text()"/>
                </xsl:element>
            </xsl:if>
            <!--</pbcoreAssetType>-->

            <xsl:if test="fmp:DATE/text() != ''">
                <xsl:element name="pbcoreAssetDate">
                    <!--<pbcoreAssetDate dateType="created">-->
                    <xsl:attribute name="dateType">
                        <xsl:text>created</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="fmp:DATE/text()"/>
                </xsl:element>
                <!--</pbcoreAssetDate>-->
            </xsl:if>

            <!--<pbcoreIdentifier source="UID">-->
            <xsl:if test="fmp:UID/text() != ''">
                <xsl:element name="pbcoreIdentifier">
                    <xsl:attribute name="source">
                        <xsl:text>UID</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="fmp:UID/text()"/>
                </xsl:element>
            </xsl:if>

            <xsl:if test="fmp:TITLE/text() != ''">
                <xsl:element name="pbcoreIdentifier">
                    <xsl:attribute name="source">
                        <xsl:text>TITLE</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="fmp:TITLE/text()"/>
                </xsl:element>
            </xsl:if>
            <!--</pbcoreIdentifier>-->


            <!--<pbcoreTitle>-->
            <!--<xsl:element name="pbcoreTitle">
                <xsl:attribute name="titleType">
                    <xsl:text>Description</xsl:text>
                </xsl:attribute>
                <xsl:value-of select="fmp:Description/text()"/>
            </xsl:element>-->
            <xsl:element name="pbcoreTitle">
                <!--<pbcoreTitle>-->
                <xsl:value-of select="fmp:ITEM/text()"/>
            </xsl:element>
            <!--</pbcoreTitle>-->

            <!--<pbcoreSubject subjectType="subjectType3" source="source127" ref="ref143"
                version="version127" annotation="annotation227" startTime="startTime43"
                endTime="endTime43" timeAnnotation="timeAnnotation43">pbcoreSubject1-->
            <xsl:if test="fmp:SUBJECT/text() != ''">
                <xsl:element name="pbcoreSubject">
                    <xsl:value-of select="fmp:SUBJECT/text()"/>
                </xsl:element>
            </xsl:if>
            <xsl:if test="fmp:SUBJECT_PERSONALITIES/text() != ''">
                <xsl:element name="pbcoreSubject">
                    <xsl:attribute name="subjectType">
                        <xsl:text>entity</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="fmp:SUBJECT_PERSONALITIES/text()"/>
                </xsl:element>
            </xsl:if>

            <!--</pbcoreSubject>-->


            <xsl:if test="fmp:DESCRIPTION/text() != ''">
                <xsl:element name="pbcoreDescription">
                    <xsl:value-of select="fmp:DESCRIPTION/text()"/>
                </xsl:element>
            </xsl:if>



            <xsl:element name="pbcoreRelation">
                <!--<pbcoreRelation>-->
                <xsl:element name="pbcoreRelationType">
                    <!--<pbcoreRelationType>-->
                    <xsl:text>Is Part Of</xsl:text>
                </xsl:element>
                <!--</pbcoreRelationType>-->
                <xsl:element name="pbcoreRelationIdentifier">
                    <!--<pbcoreRelationIdentifier>-->
                    <!--<xsl:text>WCVB</xsl:text>-->
                    <xsl:value-of select="fmp:COLLECTION/text()"/>
                </xsl:element>
                <!--</pbcoreRelationIdentifier>-->
            </xsl:element>
            <!--</pbcoreRelation>-->

            <!--<pbcoreCoverage>
                <coverage source="source23" ref="ref23" version="version23"
                    annotation="annotation29" startTime="startTime17" endTime="endTime17"
                    timeAnnotation="timeAnnotation17">coverage0</coverage>
                <coverageType>Spatial</coverageType>
                -->
            <xsl:if test="fmp:LOCATION/text() != ''">
                <xsl:element name="pbcoreCoverage">
                    <xsl:element name="coverage">
                        <xsl:value-of select="fmp:LOCATION/text()"/>
                    </xsl:element>
                    <xsl:element name="coverageType">
                        <xsl:text>spatial</xsl:text>
                    </xsl:element>
                </xsl:element>
            </xsl:if>
            <!--</pbcoreCoverage>-->

            <!--<pbcoreContributor>-->
            <xsl:if test="concat(fmp:CONTRIBUTOR/text(),fmp:CONTRIBUTOR_ROLE/text()) != ''">
                <xsl:element name="pbcoreContributor">
                    <!--<contributor affiliation="affiliation9" ref="ref161" annotation="annotation251" startTime="startTime57" endTime="endTime57"
                timeAnnotation="timeAnnotation57">contributor1</contributor>-->
                    <xsl:element name="contributor">
                        <xsl:value-of select="fmp:CONTRIBUTOR/text()"/>
                    </xsl:element>
                    <!--<contributorRole portrayal="portrayal3" source="source143" ref="ref163" version="version143" annotation="annotation253">contributorRole1</contributorRole>-->
                    <xsl:element name="contributorRole">
                        <xsl:value-of select="fmp:CONTRIBUTOR_ROLE/text()"/>
                    </xsl:element>
                </xsl:element>
            </xsl:if>
            
            <xsl:if test="concat(fmp:NHF_CONTRIBUTOR/text(),fmp:NHF_CONTRIBUTOR_ROLE/text()) != ''">
                <xsl:element name="pbcoreContributor">
                    <!--<contributor affiliation="affiliation9" ref="ref161" annotation="annotation251" startTime="startTime57" endTime="endTime57"
                timeAnnotation="timeAnnotation57">contributor1</contributor>-->
                    <xsl:element name="contributor">
                        <xsl:value-of select="fmp:NHF_CONTRIBUTOR/text()"/>
                    </xsl:element>
                    <!--<contributorRole portrayal="portrayal3" source="source143" ref="ref163" version="version143" annotation="annotation253">contributorRole1</contributorRole>-->
                    <xsl:element name="contributorRole">
                        <xsl:value-of select="fmp:NHF_CONTRIBUTOR_ROLE/text()"/>
                    </xsl:element>
                </xsl:element>
            </xsl:if>
            
            <xsl:if test="fmp:NEWS_CAMERA_VAN/text() != ''">
                <xsl:element name="pbcoreContributor">
                    <!--<contributor affiliation="affiliation9" ref="ref161" annotation="annotation251" startTime="startTime57" endTime="endTime57"
                timeAnnotation="timeAnnotation57">contributor1</contributor>-->
                    <xsl:element name="contributor">
                        <xsl:value-of select="fmp:NEWS_CAMERA_VAN/text()"/>
                    </xsl:element>
                    <!--<contributorRole portrayal="portrayal3" source="source143" ref="ref163" version="version143" annotation="annotation253">contributorRole1</contributorRole>-->
                    <xsl:element name="contributorRole">
                        <xsl:text>Camera Operator</xsl:text>
                    </xsl:element>
                </xsl:element>
            </xsl:if>
            <!-- </pbcoreContributor>-->


            <xsl:element name="pbcoreInstantiation">
                <!--                <instantiationIdentifier source="L2dlyAuS" ref="FV-2" version="_9eSaepM1.kUEK" annotation="h_72.xkRKa">-->
                <xsl:element name="instantiationIdentifier">
                    <xsl:attribute name="source">
                        <xsl:text>UID -AS</xsl:text>
                    </xsl:attribute>
                    <xsl:attribute name="annotation">
                        <xsl:text>not in DB, but added to records during conversion to PBCore</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="concat(fmp:UID/text(),'-AS')"/>
                </xsl:element>
                <!--</instantiationIdentifier>-->

                <!--<instantiationDimensions unitsOfMeasure="xF4cJeX0No2VodcAL" annotation="J8GYMlEuYWWu">fX.</instantiationDimensions>-->
                <xsl:if test="fmp:FOOTAGE_LENGTH/text() != ''">
                    <xsl:element name="instantiationDimensions">
                        <xsl:attribute name="unitsOfMeasure">
                            <xsl:text>feet</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="fmp:FOOTAGE_LENGTH"/>
                    </xsl:element>
                </xsl:if>
                <!--</instantiationDimensions>-->

                <!--<instantiationPhysical>-->
                <xsl:if test="fmp:FORMAT_ITEM/text() != ''">
                    <xsl:element name="instantiationPhysical">
                        <xsl:value-of select="fmp:FORMAT_ITEM/text()"/>
                    </xsl:element>
                </xsl:if>
                <!--</instantiationPhysical>-->


                <!--<instantiationLocation>-->
                
                <!--</instantiationLocation>-->


                <!--<instantiationMediaType source="cgJsuv" ref="ri-8coaqhn1K_R7pHGLO8KB" version="OvBY1WRpQi9foZpCvf" annotation="FxuJMXBz4ygyv3N8MqkUIcTjG535QH">a</instantiationMediaType>-->
                <!--</instantiationMediaType>-->

                <!--<instantiationDuration>instantiationDuration0-->
                <xsl:if test="fmp:FORMAT_DURATION/text() != ''">
                    <xsl:element name="instantiationDuration">
                        <xsl:value-of select="fmp:FORMAT_DURATION/text()"/>
                    </xsl:element>
                </xsl:if>
                <!--</instantiationDuration>-->


                <!--<instantiationColors source="Y1J" ref="cRZAENTL" version="iDNU6RY6mk0wERVFZW1" annotation="fAptW2">MfKdnIGJB3JCtM_SEjU</instantiationColors>-->
                <xsl:if test="fmp:FORMAT_COLOR/text() != ''">
                    <xsl:element name="instantiationColors">
                        <xsl:value-of select="fmp:FORMAT_COLOR/text()"/>
                    </xsl:element>
                </xsl:if>
                <!--</instantiationColors>-->

                <!--<instantiationTracks>instantiationTracks0-->
                <xsl:if test="fmp:AUDIO_TYPE/text() != ''">
                    <xsl:element name="instantiationTracks">
                        <xsl:value-of select="fmp:AUDIO_TYPE/text()"/>
                    </xsl:element>
                </xsl:if>
                <!--</instantiationTracks>-->




                <!--<instantiationLanguage source="MRqS9KQaSklZe8TojSJ6Z3uN" ref="dzt14R-TLd8k1" version="PhUnau" annotation="sb7BN8bTPKh"></instantiationLanguage>-->
                <!--</instantiationLanguage>-->



            </xsl:element>
            <!--</pbcoreInstantiation>-->


            <!--<pbcoreAnnotation annotationType="X3yG7.NG1HftpWD7XfZF_asUVOLf" ref="L4F">V_I</pbcoreAnnotation>-->
            <xsl:if test="translate(fmp:COVERAGE_ANNOTATION/text(),'YES ','yes') = 'yes' ">
                <xsl:element name="pbcoreAnnotation">
                    <xsl:attribute name="ref">
                        <xsl:text>pbcoreAssetDate</xsl:text>
                    </xsl:attribute>
                    <xsl:text>Date Estimated</xsl:text>
                </xsl:element>
            </xsl:if>

            <!--</pbcoreAnnotation>-->



            <!--
            <pbcoreExtension>
                <extensionWrap annotation="az3PGJ">
                    <extensionElement>vPgDmPfiSafONc598kMQYq_6xbGkZ</extensionElement>
                    <extensionValue>Jwn3LUDcuq</extensionValue>
                    <extensionAuthorityUsed>http://PgTjZMrF/</extensionAuthorityUsed>
                    </extensionWrap>-->
            <xsl:element name="pbcoreExtension">
                <xsl:element name="extensionWrap">
                    <xsl:attribute name="annotation">
                        <xsl:text>original database metadata</xsl:text>
                    </xsl:attribute>
                    <xsl:element name="extensionElement">
                        <xsl:text>DATE_CREATED</xsl:text>
                    </xsl:element>
                    <xsl:element name="extensionValue">
                        <xsl:value-of select="fmp:DATE_CREATED/text()"/>
                    </xsl:element>
                </xsl:element>
                <xsl:element name="extensionWrap">
                    <xsl:attribute name="annotation">
                        <xsl:text>original database metadata</xsl:text>
                    </xsl:attribute>
                    <xsl:element name="extensionElement">
                        <xsl:text>DATE_MODIFIED</xsl:text>
                    </xsl:element>
                    <xsl:element name="extensionValue">
                        <xsl:value-of select="fmp:DATE_MODIFIED/text()"/>
                    </xsl:element>
                </xsl:element>
            </xsl:element>


        </xsl:element>
        <!--</PBCoreDescriptionDocument>-->

    </xsl:template>
    <xsl:template name="asset"/>

</xsl:stylesheet>
