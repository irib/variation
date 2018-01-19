-- This file is part of Variation.

-- Variation is free software: you can redistribute it and/or modify
-- it under the terms of the GNU Affero General Public License as published
-- by the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.

-- Variation is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Affero General Public License for more details.

-- You should have received a copy of the GNU Affero General Public License
-- along with Variation.  If not, see <http://www.gnu.org/licenses/>.
-- --------------------------------------------------------------------------------
-- Ce fichier fait partie de Variation.

-- Variation est un logiciel libre ; vous pouvez le redistribuer ou le modifier 
-- suivant les termes de la GNU Affero General Public License telle que publiée 
-- par la Free Software Foundation ; soit la version 3 de la licence, soit 
-- (à votre gré) toute version ultérieure.

-- Variation est distribué dans l'espoir qu'il sera utile, 
-- mais SANS AUCUNE GARANTIE ; sans même la garantie tacite de 
-- QUALITÉ MARCHANDE ou d'ADÉQUATION à UN BUT PARTICULIER. Consultez la 
-- GNU Affero General Public License pour plus de détails.

-- Vous devez avoir reçu une copie de la GNU Affero General Public License 
-- en même temps que Variation ; si ce n'est pas le cas, 
-- consultez <http://www.gnu.org/licenses>.
-- --------------------------------------------------------------------------------
-- Copyright (c) 2014 Kavarna SARL

SET search_path = document, pg_catalog;

-- 
-- Suppression anciennes fonctions sans token
--
DROP FUNCTION IF EXISTS document_document_secteur_liste_details(prm_doc_id integer);
DROP FUNCTION IF EXISTS document_documents_groupe_liste(prm_dos_id integer);
DROP FUNCTION IF EXISTS document_documents_secteur_liste_details(prm_dos_id integer);
DROP FUNCTION IF EXISTS document_documents_secteur_liste_details_etab(prm_dos_id integer, prm_eta_id integer);
DROP FUNCTION IF EXISTS document_document_get(prm_doc_id integer);
DROP FUNCTION IF EXISTS document_document_liste(prm_dos_id integer);
DROP FUNCTION IF EXISTS document_document_liste(prm_dos_id integer, prm_per_id integer);
DROP FUNCTION IF EXISTS document_document_liste(prm_dos_id integer, prm_per_id integer, prm_start date, prm_end date);
DROP FUNCTION IF EXISTS document_document_liste(prm_dos_id integer, prm_per_id integer, prm_start date, prm_end date, prm_grp_id integer, prm_per_ids integer[]);
DROP FUNCTION IF EXISTS document_document_liste(prm_token integer, prm_dos_id integer, prm_per_id integer, prm_start date, prm_end date, prm_grp_id integer, prm_per_ids integer[]);
DROP FUNCTION IF EXISTS document_document_save(prm_doc_id integer, prm_per_id_responsable integer, prm_dty_id integer, prm_titre character varying, prm_statut integer, prm_date_obtention date, prm_date_realisation date, prm_date_validite date, prm_description text);
DROP FUNCTION IF EXISTS document_document_save(prm_doc_id integer, prm_per_id_responsable integer, prm_dty_id integer, prm_titre character varying, prm_statut integer, prm_date_obtention date, prm_date_realisation date, prm_date_validite date, prm_description text, prm_uti_id integer);
DROP FUNCTION IF EXISTS document_document_secteur_save(prm_doc_id integer, prm_sec_ids integer[]);
DROP FUNCTION IF EXISTS document_document_set_fichier(prm_doc_id integer, prm_fichier character varying);
DROP FUNCTION IF EXISTS document_document_supprime(prm_doc_id integer);
DROP FUNCTION IF EXISTS document_document_type_ajoute (prm_nom varchar);
DROP FUNCTION IF EXISTS document_document_type_etablissement_get(prm_dty_id integer, prm_eta_id integer);
DROP FUNCTION IF EXISTS document_document_type_etablissement_set (prm_dty_id integer, prm_eta_id integer, prm_b boolean);
DROP FUNCTION IF EXISTS document_document_type_get(prm_dty_id integer);
DROP FUNCTION IF EXISTS document_document_type_liste(prm_doc_id integer);
DROP FUNCTION IF EXISTS document_document_type_liste(prm_doc_id integer, prm_eta_id integer);
DROP FUNCTION IF EXISTS document_document_type_liste_par_sec_ids(prm_sec_ids integer[]);
DROP FUNCTION IF EXISTS document_document_type_liste_par_sec_ids(prm_sec_ids integer[], prm_eta_id integer);
DROP FUNCTION IF EXISTS document.document_document_type_secteur_ajoute (prm_dty_id integer, prm_sec_id integer);
DROP FUNCTION IF EXISTS document.document_document_type_secteur_list (prm_dty_id integer);
DROP FUNCTION IF EXISTS document.document_document_type_secteur_supprime (prm_dty_id integer, prm_sec_id integer);
DROP FUNCTION IF EXISTS document.document_document_type_set_nom (prm_dty_id integer, prm_nom varchar);
DROP FUNCTION IF EXISTS document.document_document_type_supprime (prm_dty_id integer);
DROP FUNCTION IF EXISTS document_document_usager_liste(prm_doc_id integer);
DROP FUNCTION IF EXISTS document_document_usager_save(prm_doc_id integer, prm_per_ids integer[]);
DROP FUNCTION IF EXISTS document_documents_create(prm_titre character varying);
DROP FUNCTION IF EXISTS document_documents_create(prm_titre character varying, prm_dty_id integer);
DROP FUNCTION IF EXISTS document_documents_get(prm_dos_id integer);
DROP FUNCTION IF EXISTS document_documents_liste();
DROP FUNCTION IF EXISTS document_documents_secteur_ajoute(prm_dos_id integer, prm_sec_id integer);
DROP FUNCTION IF EXISTS document_documents_secteur_supprime(prm_dss_id integer);
DROP FUNCTION IF EXISTS document_documents_supprime(prm_dos_id integer);
DROP FUNCTION IF EXISTS document_documents_update(prm_dos_id integer, prm_titre character varying);
DROP FUNCTION IF EXISTS document_documents_update(prm_dos_id integer, prm_titre character varying, prm_dty_id integer);

--
-- Suppression anciennes fonctions
--
DROP FUNCTION IF EXISTS document_documents_save(prm_token integer, prm_dos_id integer, prm_titre character varying, prm_dty_id integer);

--
--
--
DROP FUNCTION IF EXISTS document_document_secteur_liste_details(prm_token integer, prm_doc_id integer);
DROP TYPE IF EXISTS document_document_secteur_liste_details;
CREATE TYPE document_document_secteur_liste_details AS (
	dse_id integer,
	sec_id integer,
	sec_nom character varying
);

CREATE OR REPLACE FUNCTION document_document_secteur_liste_details(prm_token integer, prm_doc_id integer) RETURNS SETOF document_document_secteur_liste_details
    LANGUAGE plpgsql
    AS $$
DECLARE
	row document.document_document_secteur_liste_details;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT dse_id, sec_id, sec_nom 
		FROM document.document_secteur
		INNER JOIN meta.secteur USING(sec_id)
		WHERE doc_id = prm_doc_id
	LOOP
		RETURN NEXT row;
	END LOOP;		
END;
$$;
COMMENT ON FUNCTION document_document_secteur_liste_details(prm_token integer, prm_doc_id integer) IS
'Retourne la liste des secteurs (thèmes) auxquels un document est rattaché.
Entrées :
 - prm_token : Token d''authentification
 - prm_doc_id : Identifiant du document
Retour : 
 - dse_id : Identifiant du rattachement du document au secteur 
 - sec_id : Identifiant du secteur
 - sec_nom : nom du secteur
';

DROP FUNCTION IF EXISTS document_documents_groupe_liste(prm_token integer, prm_dos_id integer);
DROP TYPE IF EXISTS document_documents_groupe_liste;
CREATE TYPE document_documents_groupe_liste AS (
	grp_id integer,
	grp_nom character varying,
	eta_id integer,
	eta_nom character varying
);

CREATE OR REPLACE FUNCTION document_documents_groupe_liste(prm_token integer, prm_dos_id integer) RETURNS SETOF document_documents_groupe_liste
    LANGUAGE plpgsql
    AS $$
DECLARE
	row document.document_documents_groupe_liste;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		select DISTINCT groupe.grp_id, groupe.grp_nom, eta_id, eta_nom
			FROM groupe 
			INNER JOIN etablissement USING(eta_id)
			INNER JOIN groupe_secteur USING (grp_id)
			INNER JOIN document.documents_secteur USING (sec_id)
			where documents_secteur.dos_id = prm_dos_id 
			ORDER BY eta_nom, grp_nom
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION document_documents_groupe_liste(prm_token integer, prm_dos_id integer) IS
'Retourne la liste des groupes en relation avec une page de documents (en considérant les secteurs du groupe et les secteurs de la configuration de la page).
Entrées :
 - prm_token : Token d''authentification
 - prm_dos_id : Identifiant de la configuration de page de documents.
';

DROP FUNCTION IF EXISTS document_documents_secteur_liste_details_etab(prm_token integer, prm_dos_id integer, prm_eta_id integer);
DROP TYPE IF EXISTS document_documents_secteur_liste_details;
CREATE TYPE document_documents_secteur_liste_details AS (
	dss_id integer,
	sec_id integer,
	sec_nom character varying,
	sec_icone character varying
);

-- CREATE OR REPLACE FUNCTION document_documents_secteur_liste_details(prm_dos_id integer) RETURNS SETOF document_documents_secteur_liste_details
--     LANGUAGE plpgsql
--     AS $$
-- DECLARE
-- 	row document.document_documents_secteur_liste_details;
-- BEGIN
-- 	FOR row IN
-- 		SELECT DISTINCT dss_id, sec_id, sec_nom, sec_icone 
-- 		FROM document.documents_secteur
-- 		INNER JOIN meta.secteur USING(sec_id)
-- 		WHERE dos_id = prm_dos_id
-- 	LOOP
-- 		RETURN NEXT row;
-- 	END LOOP;		
-- END;
-- $$;

CREATE OR REPLACE FUNCTION document_documents_secteur_liste_details_etab(prm_token integer, prm_dos_id integer, prm_eta_id integer) RETURNS SETOF document_documents_secteur_liste_details
    LANGUAGE plpgsql
    AS $$
DECLARE
	row document.document_documents_secteur_liste_details;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT DISTINCT dss_id, sec_id, sec_nom, sec_icone 
		FROM document.documents_secteur
		INNER JOIN meta.secteur USING(sec_id)
		LEFT JOIN etablissement_secteur USING(sec_id)
		WHERE dos_id = prm_dos_id AND (prm_eta_id ISNULL OR eta_id = prm_eta_id)
	LOOP
		RETURN NEXT row;
	END LOOP;		
END;
$$;
COMMENT ON FUNCTION document_documents_secteur_liste_details_etab(prm_token integer, prm_dos_id integer, prm_eta_id integer) IS
'Retourne la liste des secteurs sur lesquels est spécialisée une page de documents.
Entrées : 
 - prm_token : Token d''authentification
 - prm_dos_id : Identifiant de la configuration de page de documents
 - prm_eta_id : Identifiant de l''établissement sur lequel filtrer les secteurs';

CREATE OR REPLACE FUNCTION document_document_get(prm_token integer, prm_doc_id integer) RETURNS document
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret document.document;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT * INTO ret FROM document.document WHERE doc_id = prm_doc_id;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION document_document_get(prm_token integer, prm_doc_id integer) IS
'Retourne les informations concernant un document.
Entrées :
 - prm_token : Token d''authentification
 - prm_doc_id : Identifiant du document';




CREATE OR REPLACE FUNCTION document_document_liste(prm_token integer, prm_dos_id integer, prm_per_id integer, prm_start date, prm_end date, prm_grp_id integer, prm_per_ids integer[], prm_eta_id integer) RETURNS SETOF document
    LANGUAGE plpgsql
    AS $$
DECLARE
	row document.document;
	p_start timestamp;
	p_end timestamp;

BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	if prm_start NOTNULL THEN
		p_start = prm_start;
	ELSE
		p_start = timestamp '-INFINITY';
	END IF;
	if prm_end NOTNULL THEN
		p_end = prm_end;
	ELSE
		p_end = timestamp 'INFINITY';
	END IF;
	
	FOR row IN
		SELECT DISTINCT document.* 
			FROM document.document
			INNER JOIN document.document_secteur USING(doc_id)
			INNER JOIN document.documents_secteur USING(sec_id)
			INNER JOIN document.documents USING(dos_id)
			INNER JOIN document.document_usager USING(doc_id)
			LEFT JOIN personne_groupe on personne_groupe.per_id = document_usager.per_id_usager
			LEFT JOIN public.personne_etablissement ON document.document_usager.per_id_usager = public.personne_etablissement.per_id
			WHERE dos_id = prm_dos_id 
			AND (documents.dty_id ISNULL OR documents.dty_id = document.dty_id)
			AND (prm_per_id ISNULL OR prm_per_id = per_id_usager)
			AND ((prm_start ISNULL AND prm_end ISNULL) OR doc_date_obtention BETWEEN p_start AND p_end OR doc_date_realisation BETWEEN p_start AND p_end OR doc_date_validite BETWEEN p_start AND p_end)
 			AND (prm_grp_id ISNULL OR prm_grp_id = personne_groupe.grp_id)
			AND (prm_per_ids ISNULL OR document_usager.per_id_usager = ANY (prm_per_ids))
			AND (prm_eta_id ISNULL OR personne_etablissement.eta_id = prm_eta_id)
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION document_document_liste(prm_token integer, prm_dos_id integer, prm_per_id integer, prm_start date, prm_end date, prm_grp_id integer, prm_per_ids integer[], prm_eta_id integer) IS
'Retourne une liste de documents, filtrée selon plusieurs paramètres.
Entrées : 
 - prm_token : Token d''authentification
 - prm_dos_id : Identifaint de la configuration d''une page de documents, pour utiliser les filtres de cette page
 - prm_per_id : Retourne uniquement les documents rattachés à cet usager
 - prm_start : Date de début de recherche
 - prm_end : Date de fin de recherche
 - prm_grp_id : Retourne uniquement les documents rattachés aux usagers de ce groupe
 - prm_per_ids : Retourne uniquement les documents rattachés à ces usagers
 - prm_eta_id : Retourne uniquement les documents des usagers de cet etablissement';


CREATE OR REPLACE FUNCTION document_document_save(prm_token integer, prm_doc_id integer, prm_per_id_responsable integer, prm_dty_id integer, prm_titre character varying, prm_statut integer, prm_date_obtention date, prm_date_realisation date, prm_date_validite date, prm_description text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	uti integer;
	ret integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT uti_id INTO uti FROM login.token WHERE tok_token = prm_token;
	IF prm_doc_id NOTNULL THEN
	   	-- TODO modif uti_id_modif ...
		UPDATE document.document SET
			per_id_responsable = prm_per_id_responsable,
			dty_id = prm_dty_id,
			doc_titre = prm_titre,
			doc_statut = prm_statut,
			doc_date_obtention = prm_date_obtention,
			doc_date_realisation = prm_date_realisation,
			doc_date_validite = prm_date_validite,
			doc_description = prm_description
			WHERE doc_id = prm_doc_id;
		RETURN prm_doc_id;
	ELSE
		INSERT INTO document.document (per_id_responsable, dty_id, doc_titre, doc_statut, doc_date_obtention, doc_date_realisation, doc_date_validite, doc_description, doc_date_creation, uti_id_creation) 
			VALUES (prm_per_id_responsable, prm_dty_id, prm_titre, prm_statut, prm_date_obtention, prm_date_realisation, prm_date_validite, prm_description, CURRENT_TIMESTAMP, uti)
			RETURNING doc_id INTO ret;
		RETURN ret;
	END IF;
END;
$$;
COMMENT ON FUNCTION document_document_save(prm_token integer, prm_doc_id integer, prm_per_id_responsable integer, prm_dty_id integer, prm_titre character varying, prm_statut integer, prm_date_obtention date, prm_date_realisation date, prm_date_validite date, prm_description text) IS
'Crée un nouveau document ou modifie les informations d''un document existant.
Entrées : 
 - prm_token : Token d''authentification, le créateur du document sera l''utilisateur authentifié par ce token lors de la création d''un document
 - prm_doc_id : Identifiant du document à modifier, ou NULL pour créer un document
 - prm_per_id_responsable : Identifiant du personnel responsable
 - prm_dty_id : Identifiant du type de document
 - prm_titre : Intitulé du document
 - prm_statut : Statut du document : 1=À faire, 2=Demandé, 3=Existant
 - prm_date_obtention : Date d''obtention du document
 - prm_date_realisation : Date de réalisation du document
 - prm_date_validite : Date de validité du document
 - prm_description : Description du document';

CREATE OR REPLACE FUNCTION document_document_secteur_save(prm_token integer, prm_doc_id integer, prm_sec_ids integer[]) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	row document.document_secteur;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT * FROM document.document_secteur WHERE doc_id = prm_doc_id 
	LOOP
		IF NOT row.sec_id = ANY (prm_sec_ids) THEN
			DELETE FROM document.document_secteur WHERE dse_id = row.dse_id;
		END IF;
	END LOOP;
	FOR i IN 1 .. array_upper (prm_sec_ids, 1) LOOP
		IF NOT EXISTS (SELECT 1 FROM document.document_secteur WHERE doc_id = prm_doc_id AND sec_id = prm_sec_ids[i]) THEN
			INSERT INTO document.document_secteur (doc_id, sec_id) VALUES (prm_doc_id, prm_sec_ids[i]);
		END IF;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION document_document_secteur_save(prm_token integer, prm_doc_id integer, prm_sec_ids integer[]) IS
'Rattache un document à une liste de secteurs (thèmes).
Entrées : 
 - prm_token : Token d''authentification
 - prm_doc_id : Identifiant du document
 - prm_sec_ids : Tableau d''identifants de secteurs';

CREATE OR REPLACE FUNCTION document_document_set_fichier(prm_token integer, prm_doc_id integer, prm_fichier character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	UPDATE document.document SET doc_fichier = prm_fichier WHERE doc_id = prm_doc_id;
END;
$$;
COMMENT ON FUNCTION document_document_set_fichier(prm_token integer, prm_doc_id integer, prm_fichier character varying) IS
'Rattache un fichier à un document.
Entrées :
 - prm_token : Token d''authentification
 - prm_doc_id : Identifiant du document
 - prm_fichier : Nom du fichier à rattacher au document
';

CREATE OR REPLACE FUNCTION document_document_supprime(prm_token integer, prm_doc_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	DELETE FROM document.document_secteur WHERE doc_id = prm_doc_id;
	DELETE FROM document.document_usager WHERE doc_id = prm_doc_id;
	DELETE FROM document.document WHERE doc_id = prm_doc_id;
END;
$$;
COMMENT ON FUNCTION document_document_supprime(prm_token integer, prm_doc_id integer) IS
'Supprime un document.
Entrées : 
 - prm_token : Token d''authentification
 - prm_doc_id : Identifiant du document à supprimer';

CREATE OR REPLACE FUNCTION document_document_type_ajoute (prm_token integer, prm_nom varchar) RETURNS integer
       LANGUAGE plpgsql
       AS $$
DECLARE
	ret integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, TRUE);
	INSERT INTO document.document_type (dty_nom) VALUES (prm_nom) RETURNING dty_id INTO ret;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION document_document_type_ajoute (prm_token integer, prm_nom varchar) IS
'Ajoute un nouveau type de document.
Entrées : 
 - prm_token : Token d''authentification
 - prm_nom : Nom du nouveau type de document
Retour : 
 - Identifiant du type de document créé
Remarques : 
Nécessite les droits à la configuration "Réseau"
';


CREATE OR REPLACE FUNCTION document_document_type_etablissement_get(prm_token integer, prm_dty_id integer, prm_eta_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, TRUE, FALSE);
	RETURN EXISTS (SELECT 1 FROM document.document_type_etablissement WHERE dty_id = prm_dty_id AND eta_id = prm_eta_id);
END;
$$;
COMMENT ON FUNCTION document_document_type_etablissement_get(prm_token integer, prm_dty_id integer, prm_eta_id integer) IS
'Retourne TRUE si un type de document est affecté à un établissement, FALSE sinon.
Entrées : 
 - prm_token : Token d''authentification
 - prm_dty_id : Identifiant du type de document
 - prm_eta_id : Identifiant de l''établissement
Remarques : 
Nécessite les droits à la configuration "Établissement".
';

CREATE OR REPLACE FUNCTION document_document_type_etablissement_set (prm_token integer, prm_dty_id integer, prm_eta_id integer, prm_b boolean) RETURNS void
       LANGUAGE plpgsql
       AS $$
BEGIN
	PERFORM login._token_assert (prm_token, TRUE, FALSE);
	IF EXISTS (SELECT 1 FROM document.document_type_etablissement WHERE dty_id = prm_dty_id AND eta_id = prm_eta_id) AND NOT prm_b THEN
		DELETE FROM document.document_type_etablissement WHERE dty_id = prm_dty_id AND eta_id = prm_eta_id;
	ELSIF NOT EXISTS (SELECT 1 FROM document.document_type_etablissement WHERE dty_id = prm_dty_id AND eta_id = prm_eta_id) AND prm_b THEN
		INSERT INTO document.document_type_etablissement (dty_id, eta_id) VALUES (prm_dty_id, prm_eta_id);
	END IF;
END;
$$;
COMMENT ON FUNCTION document_document_type_etablissement_set (prm_token integer, prm_dty_id integer, prm_eta_id integer, prm_b boolean) IS
'Indique si un type de document est affecté à un établissement.
Entrées : 
 - prm_token : Token d''authentification
 - prm_dty_id : Identifiant du type de document
 - prm_eta_id : Identifiant de l''établissement
 - prm_b : TRUE si le type de document est affecté à l''établissement, FALSE sinon
Remarques : 
Nécessite les droits à la configuration "Établissement".';

CREATE OR REPLACE FUNCTION document_document_type_get(prm_token integer, prm_dty_id integer) RETURNS document_type
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret document.document_type;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT * INTO ret FROM document.document_type WHERE dty_id = prm_dty_id;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION document_document_type_get(prm_token integer, prm_dty_id integer) IS
'Retourne les informations d''un type de document.
Entrées :
 - prm_token : Token d''authentification
 - prm_dty_id : Identifiant du type de document';


CREATE OR REPLACE FUNCTION document_document_type_liste(prm_token integer, prm_doc_id integer, prm_eta_id integer) RETURNS SETOF document_type
    LANGUAGE plpgsql
    AS $$
DECLARE
	row document.document_type;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT DISTINCT document_type.* 
			FROM document.document_type
			INNER JOIN document.document_type_secteur USING(dty_id)
			INNER JOIN document.document_secteur USING(sec_id)
			INNER JOIN document.document_type_etablissement USING(dty_id)
			WHERE doc_id = prm_doc_id AND (prm_eta_id ISNULL OR eta_id = prm_eta_id)
			group by document_type.dty_id
			having array_agg(sec_id) = (select array_agg(DISTINCT sec_id) FROM document.document_secteur where doc_id = prm_doc_id)
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION document_document_type_liste(prm_token integer, prm_doc_id integer, prm_eta_id integer) IS
'Retourne la liste des types de documents applicables à un document, étant donné les secteurs auxquels est rattaché le document et un établissement.
Entrées :
 - prm_token : Token d''authentification
 - prm_doc_id : Identifiant du document
 - prm_eta_id : Identifiant de l''établissement (les types de documents étant affectés ou non à un établissement)';


CREATE OR REPLACE FUNCTION document_document_type_liste_par_sec_ids(prm_token integer, prm_sec_ids integer[], prm_eta_id integer) RETURNS SETOF document_type
    LANGUAGE plpgsql
    AS $$
DECLARE
	row document.document_type;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	IF prm_sec_ids ISNULL THEN
		FOR row IN
			SELECT DISTINCT document_type.* 
				FROM document.document_type
				LEFT JOIN document.document_type_etablissement USING(dty_id)
				WHERE (prm_eta_id ISNULL OR eta_id = prm_eta_id)
				ORDER BY dty_nom
		LOOP
			RETURN NEXT row;
		END LOOP;
	ELSE
		FOR row IN
			SELECT DISTINCT document_type.* 
				FROM document.document_type
				INNER JOIN document.document_type_secteur USING(dty_id)
				LEFT JOIN document.document_type_etablissement USING(dty_id)
				WHERE (prm_eta_id ISNULL OR eta_id = prm_eta_id)
				GROUP BY document_type.dty_id
				HAVING array_agg(sec_id) @> prm_sec_ids
				ORDER BY dty_nom
		LOOP
			RETURN NEXT row;
		END LOOP;
	END IF;
END;
$$;
COMMENT ON FUNCTION document_document_type_liste_par_sec_ids(prm_token integer, prm_sec_ids integer[], prm_eta_id integer) IS
'Retourne la liste des types de documents rattachés à certains secteurs, et affectés à un établissement.
Entrées : 
 - prm_token : Token d''authentification
 - prm_sec_ids : Tableau d''identifiant de secteurs (les types de documents listés seront ceux affectés à TOUS ces secteurs) OU NULL pour retourner tous les types de documents
 - prm_eta_id : Identifiant de l''établissement auquel sont rattachés les types de documents, ou NULL pour retourner tous les types de documents
';

CREATE OR REPLACE FUNCTION document.document_document_type_secteur_ajoute (prm_token integer, prm_dty_id integer, prm_sec_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, TRUE);
	INSERT INTO document.document_type_secteur (dty_id, sec_id) VALUES (prm_dty_id, prm_sec_id) RETURNING dts_id INTO ret;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION document.document_document_type_secteur_ajoute (prm_token integer, prm_dty_id integer, prm_sec_id integer) IS
'Affecte un type de document à un secteur.
Entrées :
 - prm_token : Token d''authentification
 - prm_dty_id : Identifiant du type de document 
 - prm_sec_id : Identifiant du secteur
Remarques : 
Nécessite les droits à la configuration "Réseau".';

CREATE OR REPLACE FUNCTION document.document_document_type_secteur_list (prm_token integer, prm_dty_id integer) RETURNS SETOF meta.secteur
       LANGUAGE plpgsql
       AS $$
DECLARE
	row meta.secteur;
BEGIN
	PERFORM login._token_assert (prm_token, TRUE, TRUE);
	FOR row IN
		SELECT secteur.* FROM meta.secteur
			INNER JOIN document.document_type_secteur USING(sec_id)
			WHERE dty_id = prm_dty_id
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION document.document_document_type_secteur_list (prm_token integer, prm_dty_id integer) IS
'Retourne la liste des secteurs auxquels est affecté un type de document.
Entrées :
 - prm_token : Token d''authentification
 - prm_dty_id : Identifiant du type de document 
Remarques : 
Nécessite les droits à la configuration "Établissement" ou "Réseau".';

CREATE OR REPLACE FUNCTION document.document_document_type_secteur_supprime (prm_token integer, prm_dty_id integer, prm_sec_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, TRUE);
	DELETE FROM document.document_type_secteur WHERE dty_id = prm_dty_id AND sec_id = prm_sec_id;
END;
$$;
COMMENT ON FUNCTION document.document_document_type_secteur_supprime (prm_token integer, prm_dty_id integer, prm_sec_id integer) IS
'Supprime l''affectation un type de document à un secteur.
Entrées :
 - prm_token : Token d''authentification
 - prm_dty_id : Identifiant du type de document 
 - prm_sec_id : Identifiant du secteur
Remarques : 
Nécessite les droits à la configuration "Réseau".';

CREATE OR REPLACE FUNCTION document.document_document_type_set_nom (prm_token integer, prm_dty_id integer, prm_nom varchar) RETURNS VOID 
       LANGUAGE plpgsql
       AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, TRUE);
	UPDATE document.document_type SET dty_nom = prm_nom WHERE dty_id = prm_dty_id;
END;
$$;
COMMENT ON FUNCTION document.document_document_type_set_nom (prm_token integer, prm_dty_id integer, prm_nom varchar) IS
'Modifie le nom d''un type de document.
Entrées :
 - prm_token : Token d''authentification
 - prm_dty_id : Identifiant du type de document 
 - prm_nom : Nouveau nom du type de document
Remarques : 
Nécessite les droits à la configuration "Réseau".';

CREATE OR REPLACE FUNCTION document.document_document_type_set_nom_individuel(prm_token integer, prm_dty_id integer, prm_nom_individuel boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, TRUE);
	UPDATE document.document_type SET dty_nom_individuel = prm_nom_individuel WHERE dty_id = prm_dty_id;
END;
$$;
COMMENT ON FUNCTION document.document_document_type_set_nom_individuel(prm_token integer, prm_dty_id integer, prm_nom_individuel boolean) IS
'Indique si l''intitulé d''un document de ce type peut être personnalisé.
Entrées :
 - prm_token : Token d''authentification
 - prm_ety_id : Identifiant du type de document
 - prm_nom_individuel : TRUE si l''intitulé peut être personnalisé 
Remarques :
Nécessite les droits à la configuration "Réseau"';

CREATE OR REPLACE FUNCTION document.document_document_type_supprime (prm_token integer, prm_dty_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, TRUE);
	DELETE FROM document.document_type_secteur WHERE dty_id = prm_dty_id;
	DELETE FROM document.document_type WHERE dty_id = prm_dty_id;
END;
$$;
COMMENT ON FUNCTION document.document_document_type_supprime (prm_token integer, prm_dty_id integer) IS
'Supprime un type de document.
Entrées : 
 - prm_token : Token d''authentification
 - prm_dty_id : Identifiant du type de document à supprimer.
Remarques : 
Nécessite les droits à la configuration "Réseau"
';

CREATE OR REPLACE FUNCTION document_document_usager_liste(prm_token integer, prm_doc_id integer) RETURNS SETOF document_usager
    LANGUAGE plpgsql
    AS $$
DECLARE
	row document.document_usager;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT * FROM document.document_usager WHERE doc_id = prm_doc_id
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION document_document_usager_liste(prm_token integer, prm_doc_id integer) IS
'Retourne la liste des usagers auxquels est rattaché un document.
Entrées : 
 - prm_token : Token d''authentification
 - prm_doc_id : Identifiant du document';

CREATE OR REPLACE FUNCTION document_document_usager_save(prm_token integer, prm_doc_id integer, prm_per_ids integer[]) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	row document.document_usager;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT * FROM document.document_usager WHERE doc_id = prm_doc_id 
	LOOP
		IF NOT row.per_id_usager = ANY (prm_per_ids) THEN
			DELETE FROM document.document_usager WHERE dus_id = row.dus_id;
		END IF;
	END LOOP;
	FOR i IN 1 .. array_upper (prm_per_ids, 1) LOOP
		IF NOT EXISTS (SELECT 1 FROM document.document_usager WHERE doc_id = prm_doc_id AND per_id_usager = prm_per_ids[i]) THEN
			INSERT INTO document.document_usager (doc_id, per_id_usager) VALUES (prm_doc_id, prm_per_ids[i]);
		END IF;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION document_document_usager_save(prm_token integer, prm_doc_id integer, prm_per_ids integer[]) IS 
'Modifie la liste des usagers auxquels est rattaché un document.
Entrées : 
 - prm_token : Token d''authentification
 - prm_doc_id : Identifiant du document
 - prm_per_ids : Tableau d''identifiants d''usagers';


CREATE OR REPLACE FUNCTION document_documents_get(prm_token integer, prm_dos_id integer) RETURNS documents
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret document.documents;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT * INTO ret FROM document.documents WHERE dos_id = prm_dos_id;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION document_documents_get(prm_token integer, prm_dos_id integer) IS
'Retourne les informations de configuration d''une page de documents.
Entrées :
 - prm_token : Token d''authentification
 - prm_dos_id : Identifiant de la configuration de page de documents';

CREATE OR REPLACE FUNCTION document_documents_get_par_code(prm_token integer, prm_dos_code varchar) RETURNS documents
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret document.documents;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT * INTO ret FROM document.documents WHERE dos_code = prm_dos_code;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION document_documents_get_par_code(prm_token integer, prm_dos_code varchar) IS
'Retourne les informations de configuration d''une page de documents.
Entrées :
 - prm_token : Token d''authentification
 - prm_dos_code : Code de la configuration de page de documents';


CREATE OR REPLACE FUNCTION document_documents_liste(prm_token integer) RETURNS SETOF documents
    LANGUAGE plpgsql
    AS $$
DECLARE
	row document.documents;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	FOR row IN
		SELECT * FROM document.documents ORDER BY dos_titre 
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION document_documents_liste(prm_token integer) IS
'Retourne la liste des configurations de pages de documents.
Entrées : 
 - prm_token : Token d''authentification
Remarques : 
Nécessite les droits de configuration de l''interface.
';

DROP FUNCTION IF EXISTS document.document_documents_liste_details (prm_token integer);
DROP TYPE IF EXISTS document.document_documents_liste_details;
CREATE TYPE document.document_documents_liste_details AS (
       dos_id integer,
       dos_titre varchar,
       themes varchar,
       typ varchar
);

CREATE FUNCTION document.document_documents_liste_details (prm_token integer)
  RETURNS SETOF document.document_documents_liste_details
  LANGUAGE plpgsql
  AS $$
DECLARE
	row document.document_documents_liste_details;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
	    SELECT 
	    	   dos_id,
		   dos_titre,
		   concatenate (DISTINCT secteur.sec_nom),
		   dty_nom
	    FROM document.documents
	    LEFT JOIN document.documents_secteur USING(dos_id)
	    LEFT JOIN meta.secteur USING(sec_id)
	    LEFT JOIN document.document_type USING(dty_id)
	    GROUP BY dos_id, dos_titre, dty_nom
	LOOP
	    RETURN NEXT row;
	END LOOP;
END;
$$;

CREATE OR REPLACE FUNCTION document_documents_secteur_ajoute(prm_token integer, prm_dos_id integer, prm_sec_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE 
	ret integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	INSERT INTO document.documents_secteur (dos_id, sec_id) VALUES (prm_dos_id, prm_sec_id) 
		RETURNING dss_id INTO ret;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION document_documents_secteur_ajoute(prm_token integer, prm_dos_id integer, prm_sec_id integer) IS
'Ajoute un secteur à la spécialisation de la page de documents par secteur.
Entrées : 
 - prm_token : Token d''authentification
 - prm_dos_id : Identifiant de la configuration de page de documents
 - prm_sec_id : Identifiant du secteur
Remarques : 
Nécessite les droits de configuration de l''interface.
';

CREATE OR REPLACE FUNCTION document_documents_secteur_supprime(prm_token integer, prm_dss_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	DELETE FROM document.documents_secteur WHERE dss_id = prm_dss_id;
END;
$$;
COMMENT ON FUNCTION document_documents_secteur_supprime(prm_token integer, prm_dss_id integer) IS 
'Enlève un secteur à la spécialisation de la page de documents par secteur.
Entrées : 
 - prm_token : Token d''authentification
 - prm_dss_id : Identifiant de la spécialisation de la page de documents par un secteur
Remarques : 
Nécessite les droits de configuration de l''interface.
';

CREATE OR REPLACE FUNCTION document_documents_supprime(prm_token integer, prm_dos_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	DELETE FROM document.documents_secteur WHERE dos_id = prm_dos_id;
	DELETE FROM document.documents WHERE dos_id = prm_dos_id;
END;
$$;
COMMENT ON FUNCTION document_documents_supprime(prm_token integer, prm_dos_id integer) IS
'Supprime une configuration de page de documents.
Entrées :
 - prm_token : Token d''authentification
 - prm_dos_id : Identifiant de la configuration de page de documents
Remarque :
Nécessite le droit de configuration de l''interface';


CREATE OR REPLACE FUNCTION document_documents_save(prm_token integer, prm_dos_id integer, prm_code varchar, prm_titre character varying, prm_dty_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	IF prm_dos_id ISNULL THEN
		INSERT INTO document.documents (dos_titre, dos_code, dty_id) VALUES (prm_titre, prm_code, prm_dty_id) 
		       RETURNING dos_id INTO ret;
		RETURN ret;
	ELSE
		UPDATE document.documents SET dos_titre = prm_titre, dos_code = prm_code, dty_id = prm_dty_id WHERE dos_id = prm_dos_id;
		RETURN prm_dos_id;
	END IF;
END;
$$;
COMMENT ON FUNCTION document_documents_save(prm_token integer, prm_dos_id integer, prm_code varchar, prm_titre character varying, prm_dty_id integer) IS
'Modifie les informations de configuration d''une page de documents ou crée une nouvelle configuration.
Entrées :
 - prm_token : Token d''authentification
 - prm_dos_id : Identifiant de la configuration de page à modifier ou NULL pour créer une nouvelle configuration
 - prm_code : Code de la page
 - prm_titre : Nouveau nom de page
 - prm_dty_id : Identifiant du type de document permettant de filtrer les documents sur cette page
Remarque :
Nécessite le droit de configuration de l''interface';

CREATE OR REPLACE FUNCTION document.document_documents_secteurs_set (prm_token integer, prm_dos_id integer, prm_sec_codes varchar[]) RETURNS void LANGUAGE plpgsql AS 
$$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, TRUE);
	DELETE FROM document.documents_secteur WHERE dos_id = prm_dos_id;
	IF prm_sec_codes NOTNULL THEN
	   FOR i IN 1 .. array_upper(prm_sec_codes, 1) LOOP
	       	 INSERT INTO document.documents_secteur (dos_id, sec_id) VALUES (prm_dos_id, (SELECT sec_id FROM meta.secteur WHERE sec_code = prm_sec_codes[i]));
	   END LOOP;
	END IF;
END;
$$;
COMMENT ON FUNCTION document.document_documents_secteurs_set (prm_token integer, prm_dos_id integer, prm_sec_codes varchar[]) IS 
'Indique les secteurs sur lesquels est spécialisée une vue de documents.

Entrées : 
 - prm_token : Token d''authentification
 - prm_dos_id : Identifiant de la vue de documents
 - prm_sec_codes : tableau de codes de secteurs
Remarques :
 - Nécessite les droits à la configuration "Réseau"
';
