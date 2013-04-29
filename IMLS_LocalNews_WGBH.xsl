<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://www.pbcore.org/PBCore/PBCoreNamespace.html"
    xmlns:fmp="http://www.filemaker.com/fmpdsoresult"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.pbcore.org/PBCore/PBCoreNamespace.html"
    exclude-result-prefixes="fmp xsi">
    <xsl:output indent="yes" method="xml"/>
    <xsl:variable name="rowCount" select="count(/fmp:FMPDSORESULT/fmp:ROW)"/>


    <!--     NOTE: this was written for use with WGBH data in Filemaker database "IMLS_LocalNews_WGBH" on hosted server (available through launcher) -->


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
        <!--<PBCoreDescriptionDocument>-->
        <xsl:element name="pbcoreDescriptionDocument">

            <!--        <pbcoreAssetType source="" ref="" version="" annotation=""/>-->
            <xsl:element name="pbcoreAssetType">
                <xsl:value-of select="fmp:INTENDED_PURPOSE/text()"/>
            </xsl:element>
            <!--</pbcoreAssetType>-->

            <!--        <pbcoreAssetDate dateType=""/>-->
            <xsl:if test="fmp:DATE/text() != ''">
                <xsl:element name="pbcoreAssetDate">
                    <xsl:attribute name="dateType">
                        <xsl:text>created</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="fmp:DATE/text()"/>
                </xsl:element>
            </xsl:if>
            <!--</pbcoreAssetDate>-->

            <!--        <pbcoreIdentifier source="" ref="" version="" annotation=""/>-->
            <xsl:element name="pbcoreIdentifier">
                <xsl:attribute name="source">
                    <xsl:text>can number</xsl:text>
                </xsl:attribute>
                <xsl:value-of select="fmp:CAN_NUMBER/text()"/>
            </xsl:element>
            <xsl:element name="pbcoreIdentifier">
                <xsl:attribute name="source">
                    <xsl:text>UID</xsl:text>
                </xsl:attribute>
                <xsl:value-of select="fmp:UID/text()"/>
            </xsl:element>
            <!--</pbcoreIdentifier>-->


            <!--        <pbcoreTitle titleType="" source="" ref="" version="" annotation="" startTime="" endTime="" timeAnnotation=""/>-->
            <xsl:if test="fmp:TITLE/text() != ''">
                <xsl:element name="pbcoreTitle">
                    <!--<xsl:value-of select="fmp:LEGACY_SUBJECT/text()"/>-->
                    <xsl:value-of select="translate(fmp:TITLE,'&quot;][','')"/>
                </xsl:element>
                <!--</pbcoreTitle>-->
            </xsl:if>



            <!--        <pbcoreTitle titleType="" source="" ref="" version="" annotation="" startTime="" endTime="" timeAnnotation=""/>-->
            <xsl:if test="fmp:TITLE_SERIES/text() != ''">
                <xsl:element name="pbcoreTitle">
                    <xsl:attribute name="titleType">
                        <xsl:text>Series</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="fmp:TITLE_SERIES"/>
                </xsl:element>
            </xsl:if>

            <!--        <pbcoreSubject subjectType="" source="" ref="" version="" annotation="" startTime="" endTime="" timeAnnotation=""/>-->
            <xsl:for-each select="fmp:SUBJECT/fmp:DATA[text() != '']">
                <xsl:element name="pbcoreSubject">
                    <xsl:value-of select="text()"/>
                </xsl:element>
            </xsl:for-each>
            <!--</pbcoreSubject>-->
            <xsl:for-each select="fmp:SUBJECT_PERSONALITIES/fmp:DATA[text() != '']">
                <xsl:element name="pbcoreSubject">
                    <xsl:attribute name="subjectType">
                        <xsl:text>entity</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="text()"/>
                </xsl:element>
            </xsl:for-each>
            <!--</pbcoreSubject>-->

            <!--        <pbcoreDescription descriptionType="" descriptionTypeSource="" descriptionTypeRef="" descriptionTypeVersion="" descriptionTypeAnnotation="" segmentType="" segmentTypeSource="" segmentTypeRef="" segmentTypeVersion="" segmentTypeAnnotation="" startTime="" endTime="" timeAnnotation="" annotation=""/>-->
            <xsl:if test="fmp:DESCRIPTION/text() != ''">
                <xsl:element name="pbcoreDescription">
                    <xsl:value-of select="fmp:DESCRIPTION/text()"/>
                </xsl:element>
            </xsl:if>
            <!--</pbcoreDescription>-->

            <!--        <pbcoreDescription descriptionType="" descriptionTypeSource="" descriptionTypeRef="" descriptionTypeVersion="" descriptionTypeAnnotation="" segmentType="" segmentTypeSource="" segmentTypeRef="" segmentTypeVersion="" segmentTypeAnnotation="" startTime="" endTime="" timeAnnotation="" annotation=""/>-->
            <!--        <pbcoreGenre source="" ref="" version="" annotation="" startTime="" endTime="" timeAnnotation=""/>-->

            <!--        <pbcoreRelation>
            <pbcoreRelationType source="" ref="" version="" annotation=""/>
            <pbcoreRelationIdentifier source="" ref="" version="" annotation=""/>
            </pbcoreRelation>-->
            <xsl:element name="pbcoreRelation">
                <xsl:element name="pbcoreRelationType">
                    <xsl:text>Is Part Of</xsl:text>
                </xsl:element>
                <xsl:element name="pbcoreRelationIdentifier">
                    <xsl:value-of select="fmp:COLLECTION/text()"/>
                </xsl:element>
            </xsl:element>
            <!--</pbcoreRelation>-->


            <!--        <pbcoreCoverage>
            <coverage source="" ref="" version="" annotation="" startTime="" endTime="" timeAnnotation=""/>
            <coverageType/>
            </pbcoreCoverage>-->
            <xsl:for-each select="fmp:LOCATION/fmp:DATA[text() != '']">
                <xsl:element name="pbcoreCoverage">
                    <xsl:element name="coverage">
                        <xsl:value-of select="text()"/>
                    </xsl:element>
                    <xsl:element name="coverageType">
                        <xsl:text>spatial</xsl:text>
                    </xsl:element>
                </xsl:element>
                <!--</pbcoreCoverage>-->
            </xsl:for-each>

            <!--        <pbcoreAudienceLevel source="" ref="" version="" annotation=""/>-->
            <!--        <pbcoreAudienceRating source="" ref="" version="" annotation=""/>-->
            <!--        <pbcoreCreator>
            <creator affiliation="" ref="" annotation="" startTime="" endTime="" timeAnnotation=""/>
            <creatorRole source="" ref="" version="" annotation=""/>
            </pbcoreCreator>-->

            <!--        <pbcoreContributor>
            <contributor affiliation="" ref="" annotation="" startTime="" endTime="" timeAnnotation=""/>
            <contributorRole portrayal="" source="" ref="" version="" annotation=""/>
            </pbcoreContributor>-->
            <xsl:for-each select="fmp:CONTRIBUTOR/fmp:DATA">
                <xsl:if test="text() != ''">
                    <xsl:element name="pbcoreContributor">
                        <xsl:element name="contributor">
                            <xsl:value-of select="text()"/>
                        </xsl:element>
                        <xsl:element name="contributorRole">
                            <xsl:if
                                test="translate(../../fmp:CONTRIBUTOR_ROLE/fmp:DATA[position()]/text(),'ABCDEFGHIJKLMNOPQRSTUVWXYZ ,?.:!','abcdefghijklmnopqrstuvwxyz') != 'unknown'">
                                <xsl:value-of select="../../fmp:CONTRIBUTOR_ROLE/fmp:DATA[position()]/text()"/>
                            </xsl:if>
                        </xsl:element>
                    </xsl:element>
                </xsl:if>
                <!--</pbcoreContributor>-->
            </xsl:for-each>

            <!--       <pbcorePublisher>
            <publisher affiliation="" ref="" annotation="" startTime="" endTime="" timeAnnotation=""/>
            <publisherRole source="" ref="" version="" annotation=""/>
        </pbcorePublisher>-->
            <!--        <pbcoreRightsSummary startTime="" endTime="" timeAnnotation="">
            <rightsSummary source="" ref="" version="" annotation=""/>
< ! - -            <rightsLink annotation=""></rightsLink> - - >
< ! - -            <rightsEmbedded annotation=""/> - - >
            
            </pbcoreRightsSummary>-->

            <!--        <pbcoreInstantiation startTime="" endTime="" timeAnnotation="">-->
            <xsl:for-each select="fmp:FORMAT_ITEM/fmp:DATA[text() != '']">
                <xsl:element name="pbcoreInstantiation">

                    <!--            <instantiationIdentifier source="" ref="" version="" annotation=""/>-->
                    <xsl:if test="concat(../../fmp:UID/text(),../../fmp:CAN_NUMBER/text()) != ''">
                        <xsl:element name="instantiationIdentifier">
                            <xsl:attribute name="source">
                                <xsl:text>UID - CAN_NUMBER</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="annotation">
                                <xsl:text>not in DB, but added to records during conversion to PBCore</xsl:text>
                            </xsl:attribute>
                            <xsl:variable name="multiIDString">
                                <xsl:choose>
                                    <xsl:when
                                        test="../../fmp:UID/text() = '' or ../../fmp:CAN_NUMBER/text() = ''">
                                        <xsl:text/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:text>-</xsl:text>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:variable>
                            <xsl:value-of
                                select="concat('(',text(),') ',../../fmp:UID/text(),$multiIDString,../../fmp:CAN_NUMBER/text())"
                            />
                        </xsl:element>
                        <!--</instantiationIdentifier>-->
                    </xsl:if>

                    <!--            <instantiationIdentifier source="" ref="" version="" annotation=""/>-->
                    <!--            <instantiationDate dateType=""/>-->
                    <!--            <instantiationDimensions unitsOfMeasure="" annotation=""/>-->

                    <!--            <instantiationPhysical source="" ref="" version="" annotation=""/>-->
                    <!--<xsl:for-each select="fmp:FORMAT_ITEM/fmp:DATA[text() != '']">-->
                    <xsl:element name="instantiationPhysical">
                        <xsl:value-of select="text()"/>
                    </xsl:element>
                    <!--</instantiationPhysical>-->
                    <!--</xsl:for-each>-->

                    <!--            <instantiationDigital source="" ref="" version="" annotation=""/>-->
                    <!--            <instantiationStandard profile="" source="" ref="" version="" annotation=""/>-->
                    <!--            <instantiationLocation/>-->
                    <!--            <instantiationMediaType source="" ref="" version="" annotation=""/>-->
                    <!--            <instantiationGenerations source="" ref="" version="" annotation=""/>-->
                    <!--            <instantiationFileSize unitsOfMeasure="" annotation=""/>-->
                    <!--            <instantiationTimeStart/>-->

                    <!--            <instantiationDuration/>-->
                    <xsl:element name="instantiationDuration">
                        <xsl:value-of select="../../fmp:FORMAT_DURATION/text()"/>
                    </xsl:element>
                    <!--</instantiationDuration-->

                    <!--            <instantiationDataRate unitsOfMeasure="" annotation=""/>-->

                    <!--            <instantiationColors source="" ref="" version="" annotation=""/>-->
                    <xsl:element name="instantiationColors">
                        <xsl:value-of select="../../fmp:FORMAT_COLOR/text()"/>
                    </xsl:element>
                    <!--</instantiationColors-->

                    <!--            <instantiationTracks/>-->
                    <!--            <instantiationChannelConfiguration/>-->
                    <!--            <instantiationLanguage source="" ref="" version="" annotation=""/>-->
                    <!--            <instantiationAlternativeModes/>-->
                    <!--            <instantiationEssenceTrack>-->
                    <!--                <essenceTrackType/>-->
                    <!--                <essenceTrackIdentifier source="" ref="" version="" annotation=""/>-->
                    <!--                <essenceTrackStandard source="" ref="" version="" annotation=""/>-->
                    <!--                <essenceTrackEncoding source="" ref="" version="" annotation=""/>-->
                    <!--                <essenceTrackDataRate unitsOfMeasure="" annotation=""/>-->
                    <!--                <essenceTrackFrameRate unitsOfMeasure="" annotation=""/>-->
                    <!--                <essenceTrackPlaybackSpeed unitsOfMeasure="" annotation=""/>-->
                    <!--                <essenceTrackSamplingRate unitsOfMeasure="" annotation=""/>-->
                    <!--                <essenceTrackBitDepth/>-->
                    <!--                <essenceTrackFrameSize source="" ref="" version="" annotation=""/>-->
                    <!--                <essenceTrackAspectRatio source="" ref="" version="" annotation=""/>-->
                    <!--                <essenceTrackTimeStart/>-->
                    <!--                <essenceTrackDuration/>-->
                    <!--                <essenceTrackLanguage source="" ref="" version="" annotation=""/>-->
                    <!--                <essenceTrackAnnotation annotationType="" ref=""/>-->
                    <!--                <essenceTrackExtension>-->
                    <!--                    <extensionWrap annotation="">-->
                    <!--                        <extensionElement/>-->
                    <!--                        <extensionValue/>-->
                    <!--                        <extensionAuthorityUsed/>-->
                    <!--                    </extensionWrap>-->
                    <!--                    <extensionWrap annotation="">-->
                    <!--                        <extensionElement/>-->
                    <!--                        <extensionValue/>-->
                    <!--                        <extensionAuthorityUsed/>-->
                    <!--                    </extensionWrap>-->
                    <!--                    <extensionEmbedded annotation="">
                    </extensionEmbedded>-->
                    <!--                    <extensionEmbedded annotation="">
                    </extensionEmbedded>-->
                    <!--                </essenceTrackExtension>-->
                    <!--            </instantiationEssenceTrack>-->
                    <!--            <instantiationRelation>-->
                    <!--                <instantiationRelationType source="" ref="" version="" annotation=""/>-->
                    <!--                <instantiationRelationIdentifier source="" ref="" version="" annotation=""/>-->
                    <!--            </instantiationRelation>-->
                    <!--            <instantiationRights startTime="" endTime="" timeAnnotation="">-->
                    <!--                <rightsSummary source="" ref="" version="" annotation=""/>-->
                    <!--                <rightsLink annotation=""></rightsLink>-->
                    <!--                <rightsEmbedded annotation="">
                </rightsEmbedded>-->
                    <!--            </instantiationRights>-->
                    <!--            <instantiationAnnotation annotationType="" ref=""/>-->
                    <!--            <instantiationPart startTime="" endTime="" timeAnnotation="">-->
                    <!--                <instantiationIdentifier source="" ref="" version="" annotation=""/>-->
                    <!--                <instantiationIdentifier source="" ref="" version="" annotation=""/>-->
                    <!--                <instantiationDate dateType=""/>-->
                    <!--                <instantiationDimensions unitsOfMeasure="" annotation=""/>-->
                    <!--                <instantiationPhysical source="" ref="" version="" annotation=""/>-->
                    <!--                <instantiationDigital source="" ref="" version="" annotation=""/>-->
                    <!--                <instantiationStandard profile="" source="" ref="" version="" annotation=""/>-->
                    <!--                <instantiationLocation/>-->
                    <!--                <instantiationMediaType source="" ref="" version="" annotation=""/>-->
                    <!--                <instantiationGenerations source="" ref="" version="" annotation=""/>-->
                    <!--                <instantiationFileSize unitsOfMeasure="" annotation=""/>-->
                    <!--                <instantiationTimeStart/>-->
                    <!--                <instantiationDuration/>-->
                    <!--                <instantiationDataRate unitsOfMeasure="" annotation=""/>-->
                    <!--                <instantiationColors source="" ref="" version="" annotation=""/>-->
                    <!--                <instantiationTracks/>-->
                    <!--                <instantiationChannelConfiguration/>-->
                    <!--                <instantiationLanguage source="" ref="" version="" annotation=""/>-->
                    <!--                <instantiationAlternativeModes/>-->
                    <!--                <instantiationEssenceTrack>-->
                    <!--                    <essenceTrackType/>-->
                    <!--                    <essenceTrackIdentifier source="" ref="" version="" annotation=""/>-->
                    <!--                    <essenceTrackStandard source="" ref="" version="" annotation=""/>-->
                    <!--                    <essenceTrackEncoding source="" ref="" version="" annotation=""/>-->
                    <!--                    <essenceTrackDataRate unitsOfMeasure="" annotation=""/>-->
                    <!--                    <essenceTrackFrameRate unitsOfMeasure="" annotation=""/>-->
                    <!--                    <essenceTrackPlaybackSpeed unitsOfMeasure="" annotation=""/>-->
                    <!--                    <essenceTrackSamplingRate unitsOfMeasure="" annotation=""/>-->
                    <!--                    <essenceTrackBitDepth/>-->
                    <!--                    <essenceTrackFrameSize source="" ref="" version="" annotation=""/>-->
                    <!--                    <essenceTrackAspectRatio source="" ref="" version="" annotation=""/>-->
                    <!--                    <essenceTrackTimeStart/>-->
                    <!--                    <essenceTrackDuration/>-->
                    <!--                    <essenceTrackLanguage source="" ref="" version="" annotation=""/>-->
                    <!--                    <essenceTrackAnnotation annotationType="" ref=""/>-->
                    <!--                    <essenceTrackExtension>-->
                    <!--                        <extensionWrap annotation="">-->
                    <!--                            <extensionElement/>-->
                    <!--                            <extensionValue/>-->
                    <!--                            <extensionAuthorityUsed/>-->
                    <!--                        </extensionWrap>-->
                    <!--                        <extensionWrap annotation="">-->
                    <!--                            <extensionElement/>-->
                    <!--                            <extensionValue/>-->
                    <!--                            <extensionAuthorityUsed/>-->
                    <!--                        </extensionWrap>-->
                    <!--                        <extensionEmbedded annotation="">
                        </extensionEmbedded>-->
                    <!--                        <extensionEmbedded annotation="">
                        </extensionEmbedded>-->
                    <!--                    </essenceTrackExtension>-->
                    <!--                </instantiationEssenceTrack>-->
                    <!--                <instantiationRelation>-->
                    <!--                    <instantiationRelationType source="" ref="" version="" annotation=""/>-->
                    <!--                    <instantiationRelationIdentifier source="" ref="" version="" annotation=""/>-->
                    <!--                </instantiationRelation>-->
                    <!--                <instantiationRights startTime="" endTime="" timeAnnotation="">-->
                    <!--                    <rightsSummary source="" ref="" version="" annotation=""/>-->
                    <!--                    <rightsLink annotation=""></rightsLink>-->
                    <!--                    <rightsEmbedded annotation="">
                    </rightsEmbedded>-->
                    <!--                </instantiationRights>-->
                    <!--                <instantiationAnnotation annotationType="" ref=""/>-->
                    <!--                <instantiationExtension>-->
                    <!--                    <extensionWrap annotation="">-->
                    <!--                        <extensionElement/>-->
                    <!--                        <extensionValue/>-->
                    <!--                        <extensionAuthorityUsed/>-->
                    <!--                    </extensionWrap>-->
                    <!--                    <extensionWrap annotation="">-->
                    <!--                        <extensionElement/>-->
                    <!--                        <extensionValue/>-->
                    <!--                        <extensionAuthorityUsed/>-->
                    <!--                    </extensionWrap>-->
                    <!--                    <extensionEmbedded annotation="">
                    </extensionEmbedded>-->
                    <!--                    <extensionEmbedded annotation="">
                    </extensionEmbedded>-->
                    <!--                </instantiationExtension>-->
                    <!--            </instantiationPart>-->
                    <!--            <instantiationExtension>-->
                    <!--                <extensionWrap annotation="">-->
                    <!--                    <extensionElement/>-->
                    <!--                    <extensionValue/>-->
                    <!--                    <extensionAuthorityUsed/>-->
                    <!--                </extensionWrap>-->
                    <!--                <extensionWrap annotation="">-->
                    <!--                    <extensionElement/>-->
                    <!--                    <extensionValue/>-->
                    <!--                    <extensionAuthorityUsed/>-->
                    <!--                </extensionWrap>-->
                    <!--                <extensionEmbedded annotation="">
                </extensionEmbedded>-->
                    <!--                <extensionEmbedded annotation="">
                </extensionEmbedded>-->
                    <!--            </instantiationExtension>-->

                </xsl:element>
                <!--</pbcoreInstantiation>-->
            </xsl:for-each>


            <!--        <pbcoreAnnotation annotationType="" ref=""/>-->
            <!--        <pbcorePart startTime="" endTime="" timeAnnotation="">-->
            <!--            <pbcoreAssetType source="" ref="" version="" annotation=""/>-->
            <!--            <pbcoreAssetDate dateType=""/>-->
            <!--            <pbcoreIdentifier source="" ref="" version="" annotation=""/>-->
            <!--            <pbcoreIdentifier source="" ref="" version="" annotation=""/>-->
            <!--            <pbcoreTitle titleType="" source="" ref="" version="" annotation="" startTime="" endTime="" timeAnnotation=""/>-->
            <!--            <pbcoreTitle titleType="" source="" ref="" version="" annotation="" startTime="" endTime="" timeAnnotation=""/>-->
            <!--            <pbcoreSubject subjectType="" source="" ref="" version="" annotation="" startTime="" endTime="" timeAnnotation=""/>-->
            <!--            <pbcoreDescription descriptionType="" descriptionTypeSource="" descriptionTypeRef="" descriptionTypeVersion="" descriptionTypeAnnotation="" segmentType="" segmentTypeSource="" segmentTypeRef="" segmentTypeVersion="" segmentTypeAnnotation="" startTime="" endTime="" timeAnnotation="" annotation=""/>-->
            <!--            <pbcoreDescription descriptionType="" descriptionTypeSource="" descriptionTypeRef="" descriptionTypeVersion="" descriptionTypeAnnotation="" segmentType="" segmentTypeSource="" segmentTypeRef="" segmentTypeVersion="" segmentTypeAnnotation="" startTime="" endTime="" timeAnnotation="" annotation=""/>-->
            <!--            <pbcoreGenre source="" ref="" version="" annotation="" startTime="" endTime="" timeAnnotation=""/>-->
            <!--            <pbcoreRelation>-->
            <!--                <pbcoreRelationType source="" ref="" version="" annotation=""/>-->
            <!--                <pbcoreRelationIdentifier source="" ref="" version="" annotation=""/>-->
            <!--            </pbcoreRelation>-->
            <!--            <pbcoreCoverage>-->
            <!--                <coverage source="" ref="" version="" annotation="" startTime="" endTime="" timeAnnotation=""/>-->
            <!--                <coverageType/>-->
            <!--            </pbcoreCoverage>-->
            <!--            <pbcoreAudienceLevel source="" ref="" version="" annotation=""/>-->
            <!--            <pbcoreAudienceRating source="" ref="" version="" annotation=""/>-->
            <!--            <pbcoreCreator>-->
            <!--                <creator affiliation="" ref="" annotation="" startTime="" endTime="" timeAnnotation=""/>-->
            <!--                <creatorRole source="" ref="" version="" annotation=""/>-->
            <!--            </pbcoreCreator>-->
            <!--            <pbcoreContributor>-->
            <!--                <contributor affiliation="" ref="" annotation="" startTime="" endTime="" timeAnnotation=""/>-->
            <!--                <contributorRole portrayal="" source="" ref="" version="" annotation=""/>-->
            <!--            </pbcoreContributor>-->
            <!--            <pbcorePublisher>-->
            <!--                <publisher affiliation="" ref="" annotation="" startTime="" endTime="" timeAnnotation=""/>-->
            <!--                <publisherRole source="" ref="" version="" annotation=""/>-->
            <!--            </pbcorePublisher>-->
            <!--            <pbcoreRightsSummary startTime="" endTime="" timeAnnotation="">-->
            <!--                <rightsSummary source="" ref="" version="" annotation=""/>-->
            <!--                <rightsLink annotation=""></rightsLink>-->
            <!--                <rightsEmbedded annotation="">
                </rightsEmbedded>-->
            <!--            </pbcoreRightsSummary>-->

            <!--            <pbcoreAnnotation annotationType="" ref=""/>-->
            <xsl:if test="fmp:COVERAGE_ANNOTATION/text()='yes'">
                <xsl:element name="pbcoreAnnotation">
                    <!--<pbcoreAnnotation annotationType="X3yG7.NG1HftpWD7XfZF_asUVOLf" ref="L4F">V_I</pbcoreAnnotation>-->
                    <xsl:attribute name="ref">
                        <xsl:text>pbcoreAssetDate</xsl:text>
                    </xsl:attribute>
                    <xsl:text>Date Estimated</xsl:text>
                </xsl:element>
                <!--</pbcoreAnnotation>-->
            </xsl:if>
            <!--            <pbcoreExtension>-->
            <!--                <extensionWrap annotation="">-->
            <!--                    <extensionElement/>-->
            <!--                    <extensionValue/>-->
            <!--                    <extensionAuthorityUsed/>-->
            <!--                </extensionWrap>-->
            <!--                <extensionWrap annotation="">-->
            <!--                    <extensionElement/>-->
            <!--                    <extensionValue/>-->
            <!--                    <extensionAuthorityUsed/>-->
            <!--                </extensionWrap>-->
            <!--                <extensionEmbedded annotation="">
                </extensionEmbedded>-->
            <!--                <extensionEmbedded annotation="">
                </extensionEmbedded>-->
            <!--            </pbcoreExtension>-->
            <!--        </pbcorePart>-->

            <!--            <pbcoreExtension>-->
            <!--                <extensionWrap annotation="">-->
            <!--                    <extensionElement></extensionElement>-->
            <!--                    <extensionValue></extensionValue>-->
            <!--                    <extensionAuthorityUsed></extensionAuthorityUsed>-->
            <!--                </extensionWrap>-->
            <!--            <extensionEmbedded annotation="">
                    </extensionEmbedded>-->
            <!--            <extensionEmbedded annotation="">
                    </extensionEmbedded>-->
            <!--            </pbcoreExtension>-->
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
                    <xsl:element name="extensionAuthorityUsed">
                        <xsl:text>WGBH</xsl:text>
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
                    <xsl:element name="extensionAuthorityUsed">
                        <xsl:text>WGBH</xsl:text>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
            <!--</pbcoreExtension>-->


        </xsl:element>
        <!--</PBCoreDescriptionDocument>-->

    </xsl:template>


</xsl:stylesheet>
