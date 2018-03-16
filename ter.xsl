<?xml version="1.0" encoding="iso-8859-1" ?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="text" encoding="UTF-8" omit-xml-declaration="yes" indent="yes" use-character-maps="mApos"/>

<xsl:character-map name = "mApos">
	<xsl:output-character character="'" string="''"/>
	<xsl:output-character character="&#245;" string="&apos;"/>
</xsl:character-map>

	<xsl:template match="diplomes">


TRUNCATE TABLE se_referer;
TRUNCATE TABLE avoir_code_rome;
TRUNCATE TABLE avoir_code_nsf;
TRUNCATE TABLE avoir_code_erasmus;
TRUNCATE TABLE est_contributeur;
TRUNCATE TABLE est_intervenant;
TRUNCATE TABLE est_responsable;
TRUNCATE TABLE est_responsable_rof;
TRUNCATE TABLE faire_reference;
TRUNCATE TABLE personne;
TRUNCATE TABLE comprendre;
TRUNCATE TABLE MENTION;
TRUNCATE TABLE MENTION_A;
TRUNCATE TABLE SPECIALITE;
TRUNCATE TABLE SPECIALITE_A;
TRUNCATE TABLE PROGRAMME;
TRUNCATE TABLE ENSEIGNEMENT;
TRUNCATE TABLE COMPOSENT;
TRUNCATE TABLE CODE;
TRUNCATE TABLE DOMAINE;
TRUNCATE TABLE TYPE_DIPLOME;
TRUNCATE TABLE ELEMENT;
TRUNCATE TABLE COMPOSANTE;

		<xsl:apply-templates select="personne|extra" />
		<xsl:apply-templates select="mention|specialite|programme|enseignement|annee|groupe|option|semestre|compr" />
		<xsl:apply-templates select="fiche_erasmus|fiche_nsf|fiche_rome" />
		<xsl:apply-templates select="mention/structure" />
		<xsl:apply-templates select="specialite/structure" />
		<xsl:apply-templates select="programme/structure" />
		<xsl:apply-templates select="enseignement/structure" />
		<xsl:apply-templates select="annee/structure|groupe/structure|option/structure|
									 semestre/structure|compr/structure" />


	</xsl:template>

	<xsl:template match="mention">

		<xsl:text>&#10;insert into ELEMENT(code,type) values (&#245;</xsl:text>
		<xsl:value-of select="@code" />
		<xsl:text>&#245;,&#245;MENTION&#245;);&#10;</xsl:text>

		<xsl:text>&#10;insert into MENTION(code,type_diplome) values (&#245;</xsl:text>
		<xsl:value-of select="@code" />
		<xsl:text>&#245;,&#245;</xsl:text>
		<xsl:value-of select="./type_diplome[.]"/>
		<xsl:text>&#245;);&#10;</xsl:text>

		<xsl:text>&#10;insert into MENTION_A(code,type_diplome) values (&#245;</xsl:text>
		<xsl:value-of select="@code" />
		<xsl:text>&#245;,&#245;</xsl:text>
		<xsl:value-of select="./type_diplome[.]"/>
		<xsl:text>&#245;);&#10;</xsl:text>

		<xsl:apply-templates
			select='nom|nom_complet|identificateur|etat-rof|version|date_modification|plubliable|
			nom_nature|anne_offre|code_dossier|debut_habilitation|denomination_nationale|
			fin_habilitation|finalite|web|nb_credits|competences|
			mots-clefs|responsables|responsable-rof|contributeurs|ref-domaine'>
			<xsl:with-param name="type">
				<xsl:text>MENTION</xsl:text>
			</xsl:with-param>
		</xsl:apply-templates>

		<xsl:apply-templates select='refs-composante'>
			<xsl:with-param name="code">
				<xsl:value-of select="@code"/>
			</xsl:with-param>
		</xsl:apply-templates>

		<xsl:apply-templates
			select='ados_pro|ados_recherche|articu_autres_format|auto_evaluation|
		 	aide_ins_pro|aide_orientation|aide_reussite|conditions_admission|connaissances|
		 	contexte|secteur_pro'>
			<xsl:with-param name="type">
				<xsl:text>MENTION</xsl:text>
			</xsl:with-param>
		</xsl:apply-templates>

		<xsl:apply-templates select='mcc|modifications'>
			<xsl:with-param name="type">
				<xsl:text>MENTION_A</xsl:text>
			</xsl:with-param>
		</xsl:apply-templates>


		<xsl:apply-templates
			select='debouches|international|org_pedago|politique_stages|pos_offre_etablis|
		 			pos_offre_region|poursuite_etudes|public|valide_competences'>
			<xsl:with-param name="type">
				<xsl:text>MENTION_A</xsl:text>
			</xsl:with-param>
		</xsl:apply-templates>


	</xsl:template>
	
	<xsl:template match="extra">
		<xsl:apply-templates select="composantes" />
		<xsl:apply-templates select='xx-type-diplome'/>
		<xsl:apply-templates select='domaines'/>
	</xsl:template>
	
	<xsl:template match="domaines">
		<xsl:apply-templates select="domaine" />
	</xsl:template>
	
	<xsl:template match="domaine">
		<xsl:text>&#10;insert into DOMAINE(code) values (&#245;</xsl:text>
		<xsl:value-of select="@code" />
		<xsl:text>&#245;);&#10;</xsl:text>
		<xsl:apply-templates select='nom'>
			<xsl:with-param name="type">
				<xsl:text>DOMAINE</xsl:text>
			</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>	
	
	<xsl:template match="composantes">
		<xsl:apply-templates select="composante" />
	</xsl:template>

	<xsl:template match="specialite">
		<xsl:text>&#10;insert into ELEMENT(code,type) values (&#245;</xsl:text>
		<xsl:value-of select="@code" />
		<xsl:text>&#245;,&#245;SPECIALITE&#245;);&#10;</xsl:text>

		<xsl:text>&#10;insert into SPECIALITE(code) values (&#245;</xsl:text>
		<xsl:value-of select="@code" />
		<xsl:text>&#245;);&#10;</xsl:text>

		<xsl:text>&#10;insert into SPECIALITE_A(code) values (&#245;</xsl:text>
		<xsl:value-of select="@code" />
		<xsl:text>&#245;);&#10;</xsl:text>

		<xsl:apply-templates
			select='nom|identificateur|etat-rof|version|date_modification|plubliable|
					nom_complet|aide_ins_pro|aide_orientation|aide_reussite|aspects_format_continue|
					aspects_formats_pro|aspects_format_recherche|conditions_admission|connaissances|
					finalite|ens_delocalises|
					mots-clefs|responsables|contributeurs'>
			<xsl:with-param name="type">
				<xsl:text>SPECIALITE</xsl:text>
			</xsl:with-param>
		</xsl:apply-templates>

		<xsl:apply-templates
			select='mcc|debouches|international|org_pedago|politique_stages|poursuite_etudes|public'>
			<xsl:with-param name="type">
				<xsl:text>SPECIALITE_A</xsl:text>
			</xsl:with-param>
		</xsl:apply-templates>		

	</xsl:template>

	<xsl:template match="programme">
		<xsl:text>&#10;insert into ELEMENT(code,type) values (&#245;</xsl:text>
		<xsl:value-of select="@code" />
		<xsl:text>&#245;,&#245;PROGRAMME&#245;);&#10;</xsl:text>

		<xsl:text>&#10;insert into PROGRAMME(code) values (&#245;</xsl:text>
		<xsl:value-of select="@code" />
		<xsl:text>&#245;);&#10;</xsl:text>
		<xsl:apply-templates
			select='nom|identificateur|etat-rof|version|date_modification|mcc|plubliable|
					nom_parcours|apogee|aspects_format_recherche|capacite|code_erasmus|
					competences|duree_stage|ens_delocalisation|infos_diverses|langue|
					modalites_inscription|modalites_pedago|nb_credits|objectifs|
					politiques_stages|pre_requis|code_nsf|code_rome|
					pre_requis_oblig|tronc_commun|vol_cm|vol_td|vol_tp|
					mots-clefs|responsables|responsable-rof|contributeurs'>
			<xsl:with-param name="type">
				<xsl:text>PROGRAMME</xsl:text>
			</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="enseignement">
		<xsl:text>&#10;insert into ELEMENT(code,type) values (&#245;</xsl:text>
		<xsl:value-of select="@code" />
		<xsl:text>&#245;,&#245;ENSEIGNEMENT&#245;);&#10;</xsl:text>

		<xsl:text>&#10;insert into ENSEIGNEMENT(code) values(&#245;</xsl:text>
		<xsl:value-of select="@code" />
		<xsl:text>&#245;);&#10;</xsl:text>
		<xsl:apply-templates
			select='nom|identificateur|etat-rof|version|date_modification|mcc|plubliable|
					apogee|bibliographie|capacite|capitalisation|coefficient|competences|
					contenu|discipline|duree_stage|langue|modalites_organisation|mutualisable|
					nb_credits|pre_requis|pre_requis_oblig|type_ens|
					von_autres|vol_cm|vol_global|vol_td|vol_tp|vol_travail|
					responsables|contributeurs|intervenants'>
			<xsl:with-param name="type">
				<xsl:text>ENSEIGNEMENT</xsl:text>
			</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template
		match="objectifs|pre_requis|pre_requis_oblig|bibliographie|coefficient|contenu|
			   discipline|modalites_organisation|politique_stages|
	           aspects_format_pro|aspects_format_recherche|ens_delocalises|infos_diverses|
	           modalites_pedago|modalites_inscription|aspects_format_continue|valide_competences|
	           temoin_specialites|temoin_habilitation|secteur_pro|
	           public|poursuite_etudes|pos_offre_region|pos_offre_etablis|politiques_stages|org_pedago|
	           international|debouches|contexte|connaissances|conditions_admission|competences|auto_evaluation|
	           articu_autres_format|aide_reussite|aide_orientation|
	           aide_ins_pro|ados_recherche|ados_pro|adaptation">
		<xsl:param name="type" />
		<xsl:choose>
			<xsl:when test='body[.!=""]'>
				<xsl:text>&#10;update </xsl:text>
				<xsl:value-of select="$type" />
				<xsl:text> set </xsl:text>
				<xsl:value-of select='name()' />
				<xsl:text> = &#245;</xsl:text>
				<xsl:apply-templates select='body' />
				<xsl:text>&#245; where code = &#245;</xsl:text>
				<xsl:value-of select="../@code" />
				<xsl:text>&#245;;&#10;</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="annee|groupe|option|semestre|compr">
		<xsl:text>&#10;insert into ELEMENT(code,type) values (&#245;</xsl:text>
		<xsl:value-of select="@code" />
		<xsl:text>&#245;,&#245;COMPOSENT&#245;);&#10;</xsl:text>

		<xsl:text>&#10;insert into COMPOSENT(code, type) values (&#245;</xsl:text>
		<xsl:value-of select="@code" />
		<xsl:text>&#245;, &#245;</xsl:text>
		<xsl:value-of select='name()' />
		<xsl:text>&#245;);&#10;</xsl:text>
		<xsl:apply-templates select='nom|nb_credits|mutualisable|numero'>
			<xsl:with-param name="type">
				<xsl:text>COMPOSENT</xsl:text>
			</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="personne">
		<xsl:text>&#10;insert into personne(code) values (&#245;</xsl:text>
		<xsl:value-of select="@code" />
		<xsl:text>&#245;);&#10;</xsl:text>
		<xsl:apply-templates select='idext|nom|prenom|telephone|version|mail'>
			<xsl:with-param name="type">
				<xsl:text>personne</xsl:text>
			</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>
	
	<xsl:template match="fiche_erasmus|fiche_nsf|fiche_rome">
		<xsl:text>&#10;update CODE set libelle = &#245;</xsl:text>
		<xsl:value-of select="libelle" />
		<xsl:text>&#245;, libelle_travail = &#245;</xsl:text>
		<xsl:value-of select="libelle_travail" />
		<xsl:text>&#245; where code = &#245;</xsl:text>
		<xsl:value-of select="code_metier" />
		<xsl:text>&#245;;&#10;</xsl:text>
	</xsl:template>
	
	<xsl:template match='xx-type-diplome'>
		<xsl:text>&#10;insert into TYPE_DIPLOME(code) values (&#245;</xsl:text>
		<xsl:value-of select="@code" />
		<xsl:text>&#245;);&#10;</xsl:text>
		<xsl:apply-templates select='type_diplome_rof|nom|nom-court|acronyme|identificateur|droits|rang'>
			<xsl:with-param name="type">
				<xsl:text>TYPE_DIPLOME</xsl:text>
			</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>
		
	<xsl:template match='ref-domaine'>
		
		<xsl:text>&#10;insert into se_referer(code_m, code_dom) values (&#245;</xsl:text>
		<xsl:value-of select="../@code" />
		<xsl:text>&#245;,&#245;</xsl:text>
		<xsl:value-of select="@ref" />
		<xsl:text>&#245;);&#10;</xsl:text>
		
	</xsl:template>
		
	<xsl:template match="refs-composante">
		<xsl:param name="code" />
		
		<xsl:apply-templates>
			<xsl:with-param name="code">
				<xsl:value-of select="$code" />
			</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>
	
	<xsl:template match="ref-composante">
		<xsl:param name="code" />
		
		<xsl:text>&#10;insert into faire_reference(code_m, code_comp) values (&#245;</xsl:text>
		<xsl:value-of select="$code" />
		<xsl:text>&#245;,&#245;</xsl:text>
		<xsl:value-of select="@ref" />
		<xsl:text>&#245;);&#10;</xsl:text>
		
	</xsl:template>
	
	<xsl:template match="composante">
		<xsl:text>&#10;insert into COMPOSANTE(code) values (&#245;</xsl:text>
		<xsl:value-of select="@code" />
		<xsl:text>&#245;);&#10;</xsl:text>
		
		<xsl:apply-templates
			select='nom|web|acronyme'>
			<xsl:with-param name="type">
				<xsl:text>COMPOSANTE</xsl:text>
			</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="mots-clefs">
		<xsl:param name="type" />
		<xsl:choose>
			<xsl:when test='count(item) > 0'>
				<xsl:text>&#10;update </xsl:text>
				<xsl:value-of select="$type" />
				<xsl:text> set MOT_CLEFS = &#245;</xsl:text>
				<xsl:apply-templates select='item' />
				<xsl:text>&#245; where code = &#245;</xsl:text>
				<xsl:value-of select="../@code" />
				<xsl:text>&#245;;&#10;</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="responsables">
		<xsl:apply-templates select='ref-personne'>
			<xsl:with-param name="table">est_responsable</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>
	
	<xsl:template match="intervenants">
		<xsl:apply-templates select='ref-personne'>
			<xsl:with-param name="table">est_intervenant</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>
	
	<xsl:template match="responsable-rof">
		<xsl:apply-templates select='ref-personne'>
			<xsl:with-param name="table">est_responsable_rof</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>
	
	<xsl:template match="contributeurs">
		<xsl:apply-templates select='ref-personne'>
			<xsl:with-param name="table">est_contributeur</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>
	
	<xsl:template match="ref-personne">
		<xsl:param name="table" />
			<xsl:text>&#10;INSERT INTO </xsl:text>
			<xsl:value-of select = '$table'/>
			<xsl:text>(code_p,code_e) VALUES (&#245;</xsl:text>
			<xsl:value-of select = '@ref'/>
			<xsl:text>&#245;,&#245;</xsl:text>
			<xsl:value-of select="../../@code"/>
			<xsl:text>&#245;);&#10;</xsl:text>
	</xsl:template>

	<xsl:template
		match="nom_complet|nom_nature|type_ens|mutualisable|capitalisation|anne_offre|
	           code_dossier|debut_habilitation|denomination_nationale|fin_habilitation|
	           finalit|modifications|web|nom|identificateur|version|date_modification|mcc|apogee|finalite|
	           tronc_commun|duree_stage|nom|prenom|telephone|mail|idext|acronyme|type_diplome_rof">
		<xsl:param name="type" />
		<xsl:choose>
			<xsl:when test='.!=""'>
				<xsl:text>&#10;update </xsl:text>
				<xsl:value-of select="$type" />
				<xsl:text> set </xsl:text>
				<xsl:value-of select='name()' />
				<xsl:text> = &#245;</xsl:text>
				<xsl:value-of select="." />
				<xsl:text>&#245; where code = &#245;</xsl:text>
				<xsl:value-of select="../@code" />
				<xsl:text>&#245;;&#10;</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="etat-rof">
		<xsl:param name="type" />
		<xsl:choose>
			<xsl:when test='.!=""'>
				<xsl:text>&#10;update </xsl:text>
				<xsl:value-of select="$type" />
				<xsl:text> set etat_rof = &#245;</xsl:text>
				<xsl:value-of select="." />
				<xsl:text>&#245; where code = &#245;</xsl:text>
				<xsl:value-of select="../@code" />
				<xsl:text>&#245;;&#10;</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="nom-court">
		<xsl:param name="type" />
		<xsl:choose>
			<xsl:when test='.!=""'>
				<xsl:text>&#10;update TYPE_DIPLOME set nom_court = &#245;</xsl:text>
				<xsl:value-of select="." />
				<xsl:text>&#245; where code = &#245;</xsl:text>
				<xsl:value-of select="../@code" />
				<xsl:text>&#245;;&#10;</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="nb_credits|publiable|capacite|langue|vol_cm|vol_td|vol_tp|
						 vol_autres|vol_global|vol_travail|numero|droits|rang">
		<xsl:param name="type" />
		<xsl:choose>
			<xsl:when test='.!=""'>
				<xsl:text>&#10;update </xsl:text>
				<xsl:value-of select="$type"/> set <xsl:value-of select='name()'/>
				<xsl:text> = </xsl:text><xsl:value-of select="."/>
				<xsl:text> where code = &#245;</xsl:text><xsl:value-of select="../@code"/>&#245;;
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="item">
		<xsl:text/><xsl:value-of select = '.'/><xsl:text>    </xsl:text>
	</xsl:template>
	
	<xsl:template match="code_rome|code_nsf|code_erasmus">
		<xsl:text>&#10;INSERT IGNORE INTO CODE(code, type) VALUES (&#245;</xsl:text>
		<xsl:value-of select='.'/>
		<xsl:text>&#245;, &#245;</xsl:text>
		<xsl:value-of select='name()'/>
		<xsl:text>&#245;);&#10;</xsl:text>
		
		<xsl:text>&#10;INSERT INTO avoir_</xsl:text>
		<xsl:value-of select='name()'/>
		<xsl:text>(code_pr,</xsl:text>
		<xsl:value-of select='name()'/>
		<xsl:text>) VALUES (&#245;</xsl:text>
		<xsl:value-of select = '../@code'/>&#245;,&#245;<xsl:value-of select="."/>&#245;);
	</xsl:template>
	
	<xsl:template match="structure">	
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="ref-specialite|ref-programme|ref-annee|ref-semestre|ref-groupe|ref-compr|ref-option|ref-enseignement">	
		<xsl:text>&#10;INSERT INTO comprendre(code_pere,code_fils,rang) VALUES (&#245;</xsl:text>
		<xsl:value-of select = '../../@code'/>
		<xsl:text>&#245;,&#245;</xsl:text>
		<xsl:value-of select="@ref"/>
		<xsl:text>&#245;,&#245;</xsl:text>
		<xsl:value-of select="position()"/>
		<xsl:text>&#245;);&#10;</xsl:text>
	</xsl:template>
	
	<xsl:template match="body">
		<xsl:text>&#10;</xsl:text>
		<xsl:apply-templates select='p|ol'/>
		<xsl:apply-templates select='ul|b|u'/>
		<xsl:apply-templates select='li|t'/>
		<xsl:text>&#10;</xsl:text>
	</xsl:template>
	
	<xsl:template match="p|ol">
		<xsl:text>	&lt;</xsl:text>
		<xsl:value-of select='name()'/>
		<xsl:text>&gt;&#10;</xsl:text>
		<xsl:apply-templates />
		<xsl:text>&#10;	&lt;/</xsl:text>
		<xsl:value-of select='name()'/><xsl:text>&gt;&#10;</xsl:text>
	</xsl:template>
	
	<xsl:template match="ul|b|u">
		<xsl:text>		&lt;</xsl:text>
		<xsl:value-of select='name()'/>
		<xsl:text>&gt;&#10;</xsl:text>
		<xsl:apply-templates />
		<xsl:text>&#10;		&lt;/</xsl:text>
		<xsl:value-of select='name()'/><xsl:text>&gt;&#10;</xsl:text>
	</xsl:template>
	
	<xsl:template match="li|t">
		<xsl:text>			&lt;</xsl:text>
		<xsl:value-of select='name()'/>
		<xsl:text>&gt;&#10;</xsl:text>
		<xsl:apply-templates />
		<xsl:text>&#10;			&lt;/</xsl:text>
		<xsl:value-of select='name()'/><xsl:text>&gt;&#10;</xsl:text>
	</xsl:template>
	
	<xsl:template match="a">
	    <xsl:text>	&lt;</xsl:text>
	    <xsl:value-of select='name()'/>
	    <xsl:text> href= </xsl:text>
	    <xsl:value-of select='@href'/>
	    <xsl:text>&gt;&#10;</xsl:text>
		<xsl:apply-templates />
		<xsl:text>&#10;	&lt;\</xsl:text>
	    <xsl:value-of select='name()'/>
	    <xsl:text>&gt; </xsl:text>
	</xsl:template>
	
</xsl:stylesheet>
