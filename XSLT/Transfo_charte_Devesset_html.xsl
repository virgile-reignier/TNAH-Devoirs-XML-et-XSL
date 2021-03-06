<?xml version="1.0" encoding="UTF-8"?>

<!-- Ce projet a été mené de front avec le projet rendu pour le devoir du cours de python et
a été pensé pour pouvoir s'y inclure, cf https://github.com/virgile-reignier/Devoir-python.git.
C'est pourquoi le présent document ne propose qu'une mise en forme minimale du rendu html,
ces problématique ayant plutôt été traités au moment de l'inclusion de ces pages dans l'application.

Nous avons aussi fait le choix de réutiliser les données du devoir de XML sans prendre en compte
les corrections proposées par Ségolène Albouy. L'objectif était de ne
modifier le code XML que lorsque cela était nécessaire pour la transformation. Une voie
d'amélioration de ce devoir serait de retravailler intégralement l'édition TEI du texte
en fonction de sa transformation pour amélioration la visualisation -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs tei"
    version="2.0">
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    
    <!-- Gestion des espaces entre les balises : -->
    
    <xsl:strip-space elements="*"/>
    <xsl:preserve-space elements="p supplied placeName persName orgName date seg"/>

    <!-- Je commence par définir les variables dont j'aurai besoin pour la suite -->

    <xsl:variable name="titre">
        <xsl:value-of select="//titleStmt/title/text()/normalize-space()"/>
    </xsl:variable>
    <xsl:variable name="auteur">
        <xsl:value-of select="//titleStmt/respStmt/persName/text()/normalize-space()"/>
    </xsl:variable>

    <!-- configuration des sorties dans les règles XSL -->

    <xsl:variable name="witfile">
        <!-- récupération du nom et du chemin du fichier courant -->
        <xsl:value-of select="replace(base-uri(.), '.xml', '')"/>
    </xsl:variable>
    <xsl:variable name="pathAllo">
        <xsl:value-of select="concat($witfile, '_allograph', '.html')"/>
    </xsl:variable>
    <xsl:variable name="pathNorm">
        <xsl:value-of select="concat($witfile, '_norm', '.html')"/>
    </xsl:variable>
    <xsl:variable name="pathIndex">
        <xsl:value-of select="concat($witfile, '_index', '.html')"/>
    </xsl:variable>
    <xsl:variable name="pathAccueil">
        <xsl:value-of select="concat($witfile, '_accueil', '.html')"/>
    </xsl:variable>
    <xsl:variable name="pathImages">
        <xsl:value-of select="concat($witfile, '_images', '.html')"/>
    </xsl:variable>

    <!-- Encodage des méta-données -->

    <xsl:template name="lang">
        <xsl:attribute name="lang">
            <xsl:text>fr lat</xsl:text>
        </xsl:attribute>
    </xsl:template>

    <xsl:template name="meta">
        <head>
            <title>
                <xsl:value-of select="$titre"/>
            </title>
            <meta>
                <xsl:attribute name="name">
                    <xsl:text>author</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="content">
                    <xsl:value-of select="$auteur"/>
                </xsl:attribute>
            </meta>
        </head>
    </xsl:template>

    <!-- Transformation du corps du texte -->

    <xsl:template match="/">

        <!-- Encodage de la description du texte -->

        <xsl:result-document method="html" indent="yes" href="{$pathAccueil}">
            <html id="accueil">
                <xsl:call-template name="lang"/>
                <xsl:call-template name="meta"/>
                <body>
                    <h1>
                        <xsl:attribute name="style">
                            <xsl:text>text-align:center;</xsl:text>
                        </xsl:attribute>
                        <xsl:value-of select="concat('Edition de la ', replace($titre, 'C', 'c'))"/>
                    </h1>
                    <p>
                        <xsl:value-of select=".//editionStmt//*/text()/normalize-space()"/>
                    </p>
                    <p>
                        <xsl:text>Elle est issue d'un travail réalisé par </xsl:text>
                        <xsl:value-of select="$auteur"/>
                        <xsl:text> dans le cadre du master TNAH à l'</xsl:text>
                        <xsl:value-of select=".//titleStmt//orgName/text()"/>
                        <xsl:text>.</xsl:text>
                    </p>
                    <p>
                        <xsl:value-of select=".//respStmt/note/text()/normalize-space()"/>
                        <xsl:text> Nous remercions également </xsl:text>
                        <xsl:value-of select=".//publicationStmt/authority/text()"/>
                        <xsl:text> et Ariane Pinche pour leur aide dans l'encodage de celle-ci.</xsl:text>
                    </p>
                    <p>
                        <xsl:text>On trouvera une édition-traduction partielle de ce texte dans </xsl:text>
                        <xsl:value-of
                            select="concat('&quot;', //bibl[@xml:id = 'Reignier_2021b']/title/text(), '&quot;', ', ', //bibl[@xml:id = 'Reignier_2021b']/series/title/text(), ', ', //bibl[@xml:id = 'Reignier_2021b']/series/idno/text(), ', ', //bibl[@xml:id = 'Reignier_2021b']/date/text(), ', ', //bibl[@xml:id = 'Reignier_2021b']/series/biblScope/text(), '.')"
                        />
                    </p>
                    <p>
                        <xsl:text>Pour plus d'informations sur le contexte historique, on se reportera aussi à </xsl:text>
                        <xsl:value-of
                            select="concat('&quot;', //bibl[@xml:id = 'Reignier_2021a']/title/text(), '&quot;', ', ', //bibl[@xml:id = 'Reignier_2021a']/series/title/text(), ', ', //bibl[@xml:id = 'Reignier_2021a']/series/idno/text(), ', ', //bibl[@xml:id = 'Reignier_2021a']/date/text(), ', ', //bibl[@xml:id = 'Reignier_2021a']/series/biblScope/text(), '.')"
                        />
                    </p>
                    <p>
                        <xsl:text>L'édition paléographique du texte est disponible </xsl:text>
                        <a href="{$pathAllo}">ici</a>
                    </p>
                    <p>
                        <xsl:text>L'édition normalisée du texte est disponible </xsl:text>
                        <a href="{$pathNorm}">ici</a>
                    </p>
                    <p>
                        <xsl:text>Un index a également été réalisé </xsl:text>
                        <a href="{$pathIndex}">ici</a>
                        <xsl:text> avec les noms propres et les toponymes mentionnés dans le texte</xsl:text>
                    </p>
                    <p>Les images d'origines sont disponibles <a href="{$pathImages}">ici</a></p>
                </body>
            </html>
        </xsl:result-document>

        <!-- Encodage des deux versions de l'édition -->

        <xsl:result-document method="html" indent="yes" href="{$pathAllo}">
            <html id="allograph">
                <xsl:call-template name="lang"/>
                <xsl:call-template name="meta"/>
                <body>
                    <xsl:call-template name="titre"/>
                    <xsl:call-template name="description"/>
                    <xsl:call-template name="sources"/>
                    <xsl:apply-templates mode="orig"/>
                    <xsl:call-template name="notes_finales"/>
                </body>
            </html>
        </xsl:result-document>
        <xsl:result-document method="html" indent="yes" href="{$pathNorm}">
            <html id="normalise">
                <xsl:call-template name="lang"/>
                <xsl:call-template name="meta"/>
                <body>
                    <xsl:call-template name="titre"/>
                    <xsl:call-template name="description"/>
                    <xsl:call-template name="sources"/>
                    <xsl:apply-templates mode="reg"/>
                    <xsl:call-template name="notes_finales"/>
                </body>
            </html>
        </xsl:result-document>

        <!-- Mise en place de l'index -->

        <xsl:result-document method="html" indent="yes" href="{$pathIndex}">
            <html id="index">
                <xsl:call-template name="lang"/>
                <xsl:call-template name="meta"/>
                <body>
                    <xsl:call-template name="titre"/>
                    <xsl:call-template name="index"/>
                </body>
            </html>
        </xsl:result-document>

        <!-- Visualisation des images -->

        <xsl:result-document method="html" indent="yes" href="{$pathImages}">
            <html id="images">
                <xsl:call-template name="lang"/>
                <xsl:call-template name="meta"/>
                <body>
                    <xsl:call-template name="titre"/>
                    <xsl:call-template name="images"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>

    <!-- Règles pour la transformation du texte -->

    <xsl:template name="titre">
        <h1>
            <xsl:attribute name="style">
                <xsl:text>text-align:center;</xsl:text>
            </xsl:attribute>
            <xsl:value-of select="$titre"/>
        </h1>
        <span>
            <a href="{$pathAccueil}">Retour présentation charte</a>
        </span>
    </xsl:template>

    <xsl:template match="teiHeader | facsimile" mode="#all"/>

    <xsl:template match="div1 | div2 | div3" mode="#all">
        <xsl:variable name="id">
            <xsl:text>#</xsl:text>
            <xsl:value-of select="./@xml:id"/>
        </xsl:variable>
        <div>
            <xsl:if test="@xml:id">
                <xsl:attribute name="id">
                    <xsl:value-of select="$id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="//item[@corresp = $id][@n]">
                <p>
                    <xsl:value-of select="//item[@corresp = $id]/@n"/>
                    <xsl:text>.</xsl:text>
                </p>
            </xsl:if>
            <xsl:apply-templates mode="#current"/>
        </div>
    </xsl:template>

    <xsl:template match="p[not(ancestor::personGrp | ancestor::rdg)]" mode="#all">
        <p>
            <xsl:apply-templates mode="#current"/>
        </p>
    </xsl:template>

    <xsl:template match="choice" mode="orig">
        <xsl:apply-templates select="./orig | ./abbr | ./sic" mode="#current"/>
    </xsl:template>

    <xsl:template match="choice" mode="reg">
        <xsl:apply-templates select="./reg | ./expan | ./ex | ./corr" mode="#current"/>
    </xsl:template>

    <!-- Visualisation des ruptures dans l'édition -->

    <xsl:template match="supplied" mode="#all">
        <xsl:choose>
            <xsl:when test="@source = '#AD69_48H_1671-3' or @source = '#AD69_48H_1671-4'">
                <b>
                    <xsl:choose>
                        <xsl:when test="@source = '#AD69_48H_1671-4'">
                            <u>
                                <xsl:apply-templates mode="#current"/>
                            </u>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates mode="#current"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </b>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>[</xsl:text>
                <xsl:apply-templates mode="#current"/>
                <xsl:text>]</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="gap" mode="#all">
        <xsl:text>[</xsl:text>
        <xsl:value-of select="./@rend"/>
        <xsl:text>]</xsl:text>
    </xsl:template>

    <xsl:template match="lb" mode="#all">
        <xsl:choose>
            <xsl:when test="@rend = 'hyphen'">
                <xsl:text>-(l. </xsl:text>
                <xsl:value-of select="./@n"/>
                <xsl:text>)-</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text> (l. </xsl:text>
                <xsl:value-of select="./@n"/>
                <xsl:text>) </xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Règles pour les notes présentes dans le texte -->

    <xsl:template match="text" name="notes_finales">
        <div>
            <xsl:attribute name="style">
                <xsl:text>margin-top: 2%;</xsl:text>
            </xsl:attribute>
            <xsl:for-each select=".//note[ancestor::text]">
                <p>
                    <xsl:attribute name="id">
                        <xsl:text>fn</xsl:text>
                        <xsl:value-of select="./@n"/>
                    </xsl:attribute>
                    <xsl:text>[</xsl:text>
                    <xsl:value-of select="./@n"/>
                    <xsl:text>] </xsl:text>
                    <xsl:value-of select="./text()/normalize-space()"/>
                </p>
            </xsl:for-each>
        </div>
    </xsl:template>

    <xsl:template match="note" mode="#all">
        <a>
            <xsl:attribute name="href">
                <xsl:text>#fn</xsl:text>
                <xsl:value-of select="./@n"/>
            </xsl:attribute>
            <xsl:text> [</xsl:text>
            <xsl:value-of select="./@n"/>
            <xsl:text>]</xsl:text>
        </a>
    </xsl:template>

    <!-- Description du contenu du texte -->

    <xsl:template match="abstract" mode="#all" name="description">
        <div>
            <h4>Contenu de la charte :</h4>
            <ul>
                <xsl:for-each select=".//item[ancestor::item]">
                    <li>
                        <xsl:value-of select="./@n"/>
                        <xsl:text>. </xsl:text>
                        <xsl:copy-of select=".//text()"/>
                    </li>
                </xsl:for-each>
            </ul>
        </div>
    </xsl:template>

    <!-- Règle pour les éléments d'édition critique -->

    <xsl:template match="listWit" mode="#all" name="sources">
        <div>
            <h4>Ce texte nous est connu par trois documents :</h4>
            <p>
                <xsl:text>A. Original, </xsl:text>
                <xsl:copy-of select=".//witness[1]//support//lower-case(text())"/>
                <xsl:text> </xsl:text>
                <xsl:copy-of select=".//witness[1]//height/text()"/>
                <xsl:text>x</xsl:text>
                <xsl:copy-of select=".//witness[1]//width/text()"/>
                <xsl:text>, AD 69, cote </xsl:text>
                <xsl:copy-of select=".//witness[1]//idno/text()"/>
                <xsl:text>.</xsl:text>
            </p>
            <p>
                <xsl:text>B. Grosse sur </xsl:text>
                <xsl:copy-of select=".//witness[2]//material/text()"/>
                <xsl:text>, contemporaine de l'original, AD 69, cote </xsl:text>
                <xsl:copy-of select=".//witness[2]//idno/text()"/>
                <xsl:text>.</xsl:text>
            </p>
            <p>
                <xsl:text>C. Copie sur feuilles de </xsl:text>
                <xsl:copy-of select=".//witness[3]//material/text()"/>
                <xsl:text>, style XVIIIème siècle, AD 69, cote </xsl:text>
                <xsl:copy-of select=".//witness[3]//idno/text()"/>
                <xsl:text>.</xsl:text>
            </p>
            <h4>Cette transcription est réalisée à partir de A et les lacunes sont complétées à
                partir de B (en gras) et de C (en gras et souligné) :</h4>
        </div>
    </xsl:template>

    <xsl:template match="rdg" mode="#all">
        <span>
            <xsl:text> (Variante </xsl:text>
            <xsl:value-of select="replace(replace(./@wit, '#', ''), '_', ' ')"/>
            <xsl:text> : "</xsl:text>
            <xsl:apply-templates mode="#current"/>
            <xsl:text>")</xsl:text>
        </span>
    </xsl:template>

    <xsl:template match="text//ref" mode="reg">
        <xsl:variable name="id">
            <xsl:value-of select="replace(./@target, '#', '')"/>
        </xsl:variable>
        <xsl:apply-templates select="//seg[@xml:id = $id]" mode="#current"/>
    </xsl:template>

    <xsl:template match="div1[@xml:id = 'renvois_internes']" mode="reg"/>

    <xsl:template match="text//ref" mode="orig">
        <xsl:text> </xsl:text>
        <xsl:number count="ref[ancestor::text]" format="[I]" level="any"/>
    </xsl:template>

    <xsl:template match="seg" mode="orig">
        <p>
            <xsl:number count="seg" format="[I]" level="any"/>
            <xsl:apply-templates mode="#current"/>
        </p>
    </xsl:template>

    <!-- Règle pour l'index -->

    <xsl:template name="index">
        <h2>Index des noms propres :</h2>
        <div>
            <ul>
                <xsl:for-each select="//particDesc//persName[parent::person]">
                    <li>
                        <xsl:value-of select="replace(./@xml:id, '_', ' ')"/>
                        <xsl:variable name="idPerson">
                            <xsl:value-of select="./@xml:id"/>
                        </xsl:variable>
                        <xsl:text> : </xsl:text>
                        <xsl:for-each
                            select="ancestor::TEI/text//persName[replace(@nymRef, '#', '') = $idPerson]">
                            <xsl:choose>
                                <xsl:when test="not(ancestor::rdg)">
                                    <xsl:text> (l. </xsl:text>
                                    <xsl:value-of select="preceding::lb[1]/@n"/>
                                    <xsl:text>)</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of
                                        select="replace(replace(preceding::rdg/@wit, '_', ' '), '#', '')"
                                    />
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:choose>
                                <xsl:when test="position() != last()">, </xsl:when>
                                <xsl:otherwise>.</xsl:otherwise>
                            </xsl:choose>
                        </xsl:for-each>
                    </li>
                </xsl:for-each>
            </ul>
        </div>
        <h2>Index des toponymes :</h2>
        <div>
            <ul>
                <xsl:for-each select="//settingDesc//placeName[parent::place]">
                    <li>
                        <xsl:value-of select="replace(./@xml:id, '_', ' ')"/>
                        <xsl:variable name="idLieu">
                            <xsl:value-of select="./@xml:id"/>
                        </xsl:variable>
                        <xsl:text> : </xsl:text>
                        <xsl:for-each
                            select="ancestor::TEI/text//placeName[replace(@nymRef, '#', '') = $idLieu]">
                            <xsl:choose>
                                <xsl:when test="not(ancestor::rdg)">
                                    <xsl:text> (l. </xsl:text>
                                    <xsl:value-of select="preceding::lb[1]/@n"/>
                                    <xsl:text>)</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of
                                        select="replace(replace(preceding::rdg/@wit, '_', ' '), '#', '')"
                                    />
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:choose>
                                <xsl:when test="position() != last()">, </xsl:when>
                                <xsl:otherwise>.</xsl:otherwise>
                            </xsl:choose>
                        </xsl:for-each>
                    </li>
                </xsl:for-each>
            </ul>
        </div>
    </xsl:template>

    <!-- Règle pour la visualisation des images -->

    <xsl:template match="facsimile" name="images">
        <div>
            <xsl:for-each select=".//surface">
                <xsl:variable name="url"
                    select="concat(substring-before($witfile, 'Devoir_charte_Devesset'), ./graphic/@url)"/>
                <xsl:variable name="titre_image"
                    select="substring-before(substring-after($url, 'Images/'), '.jpg')"/>
                <h2>
                    <xsl:value-of select="concat(replace($titre_image, '_', ' '), ' :')"/>
                </h2>
                <p data-section="{position()}">
                    <a href="{$url}">
                        <img src="{$url}" alt="{$titre_image}" height="100px"/>
                    </a>
                </p>
            </xsl:for-each>
        </div>
    </xsl:template>

</xsl:stylesheet>
