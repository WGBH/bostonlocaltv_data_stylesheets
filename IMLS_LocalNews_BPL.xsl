<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://www.pbcore.org/PBCore/PBCoreNamespace.html"
    xmlns:fmp="http://www.filemaker.com/fmpdsoresult"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.pbcore.org/PBCore/PBCoreNamespace.html"
    exclude-result-prefixes="fmp xsi">
    <xsl:output indent="yes" method="xml"/>
    <xsl:variable name="rowCount" select="count(/fmp:FMPDSORESULT/fmp:ROW)"/>
    
<!--     NOTE:  this was written for use with WHDH data in FileMaker database "IMLS_LocalNews_BPL" on hosted server (available through launcher) -->
    
    
    
    

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
        <xsl:element name="PBCoreDescriptionDocument"><!--<PBCoreDescriptionDocument>-->
            
            <xsl:if test="fmp:INTENDED_PURPOSE/text() != ''">
                <xsl:element name="pbcoreAssetType"><!--<pbcoreAssetType>-->
                    <xsl:value-of select="fmp:INTENDED_PURPOSE/text()"/>
                </xsl:element><!--</pbcoreAssetType>-->
            </xsl:if>
            <xsl:element name="pbcoreAssetDate">
                <!--<pbcoreAssetDate dateType="created">-->
                <xsl:attribute name="dateType">
                    <xsl:text>created</xsl:text>
                </xsl:attribute>
                <xsl:value-of select="fmp:DATE/text()"/>
            </xsl:element>
            <!--</pbcoreAssetDate>-->
            <xsl:element name="pbcoreIdentifier">
                <!--<pbcoreIdentifier source="UID">-->
                <xsl:attribute name="source">
                    <xsl:text>UID</xsl:text>
                </xsl:attribute>
                <xsl:value-of select="fmp:UID/text()"/>
            </xsl:element>
            <!--</pbcoreIdentifier>-->
            <xsl:element name="pbcoreIdentifier">
                <!--<pbcoreIdentifier source="can number">-->
                <xsl:attribute name="source">
                    <xsl:text>can number</xsl:text>
                </xsl:attribute>
                <xsl:value-of select="fmp:CAN_NUMBER/text()"/>
            </xsl:element>
            <!--</pbcoreIdentifier>-->
            <!-- 2 IDENTIFIERS? -->
            <xsl:element name="pbcoreTitle">
                <!--<pbcoreTitle>-->
                <xsl:value-of select="fmp:TITLE/text()"/>
            </xsl:element>
            <!--</pbcoreTitle>-->
            
<!--        <pbcoreSubject subjectType="" source="" ref="" version="" annotation="" startTime="" endTime="" timeAnnotation=""/>-->
            <xsl:for-each select="fmp:SUBJECT/fmp:DATA[text() != '']">
                <xsl:element name="pbcoreSubject">
                    <xsl:value-of select="text()"/>
                </xsl:element>
            </xsl:for-each><!--</pbcoreSubject>-->
            <xsl:for-each select="fmp:SUBJECT_PERSONALITIES/fmp:DATA[text() != '']">
                <xsl:element name="pbcoreSubject">
                    <xsl:attribute name="subjectType">
                        <xsl:text>entity</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="text()"/>
                </xsl:element>
            </xsl:for-each><!--</pbcoreSubject>-->

            <xsl:element name="pbcoreDescription">
                <!--<pbcoreDescription>-->
                <xsl:value-of select="fmp:DESCRIPTION/text()"/>
            </xsl:element>
            <!--</pbcoreDescription>-->

            <xsl:if test="normalize-space(fmp:COLLECTION/text()) != ''">
                <xsl:element name="pbcoreRelation">
                    <!--<pbcoreRelation>-->
                    <xsl:element name="pbcoreRelationType"><!--<pbcoreRelationType>-->
                        <xsl:text>Is Part Of</xsl:text>
                    </xsl:element><!--</pbcoreRelationType>-->
                    <xsl:element name="pbcoreRelationIdentifier"><!--<pbcoreRelationIdentifier>-->
                        <xsl:value-of select="fmp:COLLECTION/text()"/>
                    </xsl:element><!--</pbcoreRelationIdentifier>-->
                </xsl:element>
                <!--</pbcoreRelation>-->
            </xsl:if>
            <xsl:if test="normalize-space(fmp:CROSS_REFERENCE/text()) != ''">
                <xsl:element name="pbcoreRelation">
                    <!--<pbcoreRelation>-->
                    <xsl:element name="pbcoreRelationType"><!--<pbcoreRelationType>-->
                        <xsl:text>References</xsl:text>
                    </xsl:element><!--</pbcoreRelationType>-->
                    <xsl:element name="pbcoreRelationIdentifier"><!--<pbcoreRelationIdentifier>-->
                        <xsl:value-of select="fmp:CROSS_REFERENCE/text()"/>
                    </xsl:element><!--</pbcoreRelationIdentifier>-->
                </xsl:element>
                <!--</pbcoreRelation>-->
            </xsl:if>
            
            
            <xsl:for-each select="fmp:LOCATION/fmp:DATA[text() != '']">
                <xsl:element name="pbcoreCoverage">
                    <xsl:element name="coverage">
                        <xsl:value-of select="text()"/>
                    </xsl:element>
                    <xsl:element name="coverageType">
                        <xsl:text>spatial</xsl:text>
                    </xsl:element>
                </xsl:element>
            </xsl:for-each>
            
            
            
            <xsl:for-each select="fmp:CONTRIBUTOR/fmp:DATA[text() != '']">
                <xsl:element name="pbcoreContributor">
                    <xsl:element name="contributor">
                        <xsl:value-of select="text()"/>
                    </xsl:element>
                    <xsl:element name="contributorRole">
                        <xsl:if test="translate(../../fmp:CONTRIBUTOR_ROLE/fmp:DATA/text(),'ABCDEFGHIJKLMNOPQRSTUVWXYZ ,?.:!','abcdefghijklmnopqrstuvwxyz') != 'unknown'">
                            <xsl:value-of select="../../fmp:CONTRIBUTOR_ROLE/fmp:DATA/text()"/>
                        </xsl:if>
                    </xsl:element>
                </xsl:element><!--</pbcoreContributor>-->
            </xsl:for-each>
            
            
            
            <xsl:element name="pbcoreInstantiation">
<!--                <instantiationIdentifier source="L2dlyAuS" ref="FV-2" version="_9eSaepM1.kUEK" annotation="h_72.xkRKa">-->
                <xsl:element name="instantiationIdentifier">
                    <xsl:attribute name="source">
                        <xsl:value-of select="'UID - CAN_NUMBER'"/>
                    </xsl:attribute>
                    <xsl:attribute name="annotation">
                        <xsl:text>not in DB, but added to records during conversion to PBCore</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="fmp:UID"/>
                    <xsl:if test="fmp:UID/text() != '' and fmp:CAN_NUMBER/text() != ''">
                        <xsl:text>-</xsl:text>
                    </xsl:if>
                    <xsl:value-of select="fmp:CAN_NUMBER/text()"/>
                </xsl:element><!--</instantiationIdentifier>-->
                
                <!--<instantiationDimensions unitsOfMeasure="xF4cJeX0No2VodcAL" annotation="J8GYMlEuYWWu">fX.</instantiationDimensions>-->
                <xsl:element name="instantiationDimensions"><!--<instantiationDimensions/>-->
                    <xsl:attribute name="unitsOfMeasure">
                        <xsl:text>feet</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="fmp:FOOTAGE_LENGTH/text()"/>
                </xsl:element><!--</instantiationDimensions>-->
                <xsl:element name="instantiationPhysical"><!--<instantiationPhysical>-->
                    <!--<xsl:attribute name="annotation">
                        <xsl:text>not in DB, but added to records during conversion to PBCore</xsl:text>
                    </xsl:attribute>
                    <xsl:text>Film: 16mm</xsl:text>-->
                    <xsl:value-of select="fmp:FORMAT_ITEM/text()"/>
                </xsl:element><!--</instantiationPhysical>-->
                <!--<instantiationMediaType source="cgJsuv" ref="ri-8coaqhn1K_R7pHGLO8KB" version="OvBY1WRpQi9foZpCvf" annotation="FxuJMXBz4ygyv3N8MqkUIcTjG535QH">a</instantiationMediaType>-->
                <!--<xsl:if test="fmp:AUDIO_TYPE/text() != ''">
                    <xsl:element name="instantiationMediaType">
                        <xsl:value-of select="fmp:AUDIO_TYPE/text()"/>
                    </xsl:element>
                </xsl:if>-->
                
                <xsl:if test="fmp:FORMAT_DURATION/text() !=''">
                    <xsl:element name="instantiationDuration"><!--<instantiationDuration>-->
                        <xsl:value-of select="fmp:FORMAT_DURATION/text()"/>
                    </xsl:element><!--</instantiationDuration>-->
                </xsl:if>
                
                
                <xsl:if test="fmp:FORMAT_COLOR/text() != ''">
                    <xsl:element name="instantiationColors"><!--<instantiationColors source="Y1J" ref="cRZAENTL" version="iDNU6RY6mk0wERVFZW1" annotation="fAptW2">MfKdnIGJB3JCtM_SEjU</instantiationColors>-->
                        <xsl:value-of select="fmp:FORMAT_COLOR/text()"/>
                    </xsl:element><!--</instantiationColors>-->
                </xsl:if>
                
                <xsl:if test="concat(fmp:AUDIO_TYPE/text(),fmp:AUDIO_FORMAT/text()) != ''">
                    <xsl:element name="instantiationTracks">
                        <xsl:value-of select="fmp:AUDIO_FORMAT/text()"/>
                        <xsl:if test="fmp:AUDIO_FORMAT/text() != '' and fmp:AUDIO_TYPE/text() != ''">
                            <xsl:text>&#32;</xsl:text>
                        </xsl:if>
                        <xsl:value-of select="fmp:AUDIO_TYPE/text()"/>
                    </xsl:element>
                </xsl:if>
                
                
                
            </xsl:element><!--</pbcoreInstantiation>-->
            
            <xsl:if test="fmp:COVERAGE_ANNOTATION/text()='yes'">
                <xsl:element name="pbcoreAnnotation"><!--<pbcoreAnnotation annotationType="X3yG7.NG1HftpWD7XfZF_asUVOLf" ref="L4F">V_I</pbcoreAnnotation>-->
                    <xsl:attribute name="ref">
                        <xsl:text>pbcoreAssetDate</xsl:text>
                    </xsl:attribute>
                    <xsl:text>Date Estimated</xsl:text>
                </xsl:element><!--</pbcoreAnnotation>-->
            </xsl:if>
            <!--
            <pbcoreExtension>
                <extensionWrap annotation="az3PGJ">
                    <extensionElement>vPgDmPfiSafONc598kMQYq_6xbGkZ</extensionElement>
                    <extensionValue>Jwn3LUDcuq</extensionValue>
                    <extensionAuthorityUsed>http://PgTjZMrF/</extensionAuthorityUsed>
                    </extensionWrap>-->
            <xsl:if test="translate(concat(fmp:DATE_CREATED/text(),fmp:DATE_MODIFIED/text()),' ','') != ''">
                <xsl:element name="pbcoreExtension"><!--<pbcoreExtension>-->
                    <xsl:if test="translate(fmp:DATE_CREATED/text(),' ','') != ''">
                        <xsl:element name="extensionWrap">
                            <xsl:element name="extensionElement">
                                <xsl:text>DATE_CREATED</xsl:text>
                            </xsl:element>
                            <xsl:element name="extensionValue">
                                <xsl:value-of select="fmp:DATE_CREATED/text()"/>
                            </xsl:element>
                        </xsl:element>
                    </xsl:if>
                </xsl:element><!--</pbcoreExtension>-->
                <xsl:element name="pbcoreExtension"><!--<pbcoreExtension>-->
                    <xsl:if test="translate(fmp:DATE_MODIFIED/text(),' ','') != ''">
                        <xsl:element name="extensionWrap">
                            <xsl:element name="extensionElement">
                                <xsl:text>DATE_MODIFIED</xsl:text>
                            </xsl:element>
                            <xsl:element name="extensionValue">
                                <xsl:value-of select="fmp:DATE_MODIFIED/text()"/>
                            </xsl:element>
                        </xsl:element>
                    </xsl:if>
                </xsl:element><!--</pbcoreExtension>-->
            </xsl:if>
            
        </xsl:element><!--</PBCoreDescriptionDocument>-->
        
    </xsl:template>
    <xsl:template name="asset"/>

</xsl:stylesheet>
