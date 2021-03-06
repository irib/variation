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

SET search_path = liste, pg_catalog;

--
-- Suppression anciennes fonctions sans token
--
DROP FUNCTION IF EXISTS liste_champ_liste_details(prm_lis_id integer);
DROP FUNCTION IF EXISTS jours_avant_anniversaire(prm_date date);
DROP FUNCTION IF EXISTS liste_champ_add(prm_lis_id integer, prm_inf_id integer, prm_ordre integer);
DROP FUNCTION IF EXISTS liste_champ_get(prm_cha_id integer);
DROP FUNCTION IF EXISTS liste_champ_liste(prm_lis_id integer);
DROP FUNCTION IF EXISTS liste_champ_set_contact(prm_cha_id integer, prm_contact boolean);
DROP FUNCTION IF EXISTS liste_champ_set_cycle(prm_cha_id integer, prm_cycle boolean);
DROP FUNCTION IF EXISTS liste_champ_set_dernier(prm_cha_id integer, prm_dernier boolean);
DROP FUNCTION IF EXISTS liste_champ_set_details(prm_cha_id integer, prm_details boolean);
DROP FUNCTION IF EXISTS liste_champ_set_filtrer(prm_cha_id integer, prm_filtrer boolean);
DROP FUNCTION IF EXISTS liste_champ_set_libelle(prm_cha_id integer, prm_libelle character varying);
DROP FUNCTION IF EXISTS liste_champ_set_ordre(prm_cha_id integer, prm_ordre integer);
DROP FUNCTION IF EXISTS liste_champ_set_verrouiller(prm_cha_id integer, prm_verrouiller boolean);
DROP FUNCTION IF EXISTS liste_champ_set_contact_filtre_utilisateur(prm_cha_id integer, prm_filtre_utilisateur boolean);
DROP FUNCTION IF EXISTS liste_champ_supprime(prm_cha_id integer);
DROP FUNCTION IF EXISTS liste_defaut_ajoute_groupe(prm_cha_id integer, prm_val integer, prm_val2 integer);
DROP FUNCTION IF EXISTS liste_defaut_ajoute_selection(prm_cha_id integer, prm_val integer);
DROP FUNCTION IF EXISTS liste_defaut_ajoute_texte(prm_cha_id integer, prm_val character varying);
DROP FUNCTION IF EXISTS liste_defaut_liste(prm_cha_id integer);
DROP FUNCTION IF EXISTS liste_defaut_supprime(prm_def_id integer);
DROP FUNCTION IF EXISTS liste_liste_all();
DROP FUNCTION IF EXISTS liste_liste_create(prm_nom character varying, prm_ent_id integer, prm_inverse boolean);
DROP FUNCTION IF EXISTS liste_liste_create(prm_nom character varying, prm_ent_id integer, prm_inverse boolean, prm_pagination_tout boolean);
DROP FUNCTION IF EXISTS liste_liste_get(prm_lis_id integer);
DROP FUNCTION IF EXISTS liste_liste_supprime(prm_lis_id integer);
DROP FUNCTION IF EXISTS liste_liste_supprime_rec(prm_lis_id integer);
DROP FUNCTION IF EXISTS liste_liste_update(prm_lis_id integer, prm_nom character varying, prm_ent_id integer, prm_inverse boolean);
DROP FUNCTION IF EXISTS liste_liste_update(prm_lis_id integer, prm_nom character varying, prm_ent_id integer, prm_inverse boolean, prm_pagination_tout boolean);

--
-- Suppression anciennes fonctions
--
DROP FUNCTION IF EXISTS liste_liste_update(prm_token integer, prm_lis_id integer, prm_nom character varying, prm_ent_id integer, prm_inverse boolean, prm_pagination_tout boolean);
DROP FUNCTION IF EXISTS liste_resultat(prm_lis_id integer);

--
--
--
DROP FUNCTION IF EXISTS liste_champ_liste_details(prm_token integer, prm_lis_id integer);
DROP TYPE IF EXISTS liste_champ_liste_details;
CREATE TYPE liste_champ_liste_details AS (
	cha_id integer,
	cha__groupe_contact boolean,
	cha__groupe_cycle boolean,
	cha__groupe_dernier boolean,
	cha_libelle character varying,
	cha_ordre integer,
	cha_filtrer boolean,
	cha_verrouiller boolean,
	cha__famille_details boolean,
	cha_champs_supp boolean,
	inf_libelle character varying,
	int_code character varying,
	int_libelle character varying,
	inf_multiple boolean,
	cha__contact_filtre_utilisateur boolean
);

CREATE OR REPLACE FUNCTION liste_champ_liste_details(prm_token integer, prm_lis_id integer) RETURNS SETOF liste_champ_liste_details
    LANGUAGE plpgsql
    AS $$
DECLARE
	row liste.liste_champ_liste_details;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT 
			champ.cha_id, 
			champ.cha__groupe_contact,
			champ.cha__groupe_cycle ,
			champ.cha__groupe_dernier ,
			cha_libelle ,
			cha_ordre ,
			cha_filtrer,
			cha_verrouiller,
			cha__famille_details,
			cha_champs_supp,
			info.inf_libelle,
			infos_type.int_code,
			infos_type.int_libelle,
			info.inf_multiple,
			cha__contact_filtre_utilisateur
		FROM liste.champ 
		INNER JOIN meta.info USING(inf_id)
		INNER JOIN meta.infos_type USING (int_id)
		WHERE lis_id = prm_lis_id
		ORDER BY cha_ordre
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION liste_champ_liste_details(prm_token integer, prm_lis_id integer) IS
'Retourne la liste détaillée des configurations de page liste.';

CREATE OR REPLACE FUNCTION jours_avant_anniversaire(prm_token integer, prm_date date) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT extract (doy FROM prm_date) - extract (doy FROM CURRENT_TIMESTAMP) INTO ret;
	IF ret < 0 THEN
		ret = ret + 365;
	END IF;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION jours_avant_anniversaire(prm_token integer, prm_date date) IS
'Retourne le nombre de jours avant le prochain anniversaire de la date donnée.';

CREATE OR REPLACE FUNCTION liste_champ_add(prm_token integer, prm_lis_id integer, prm_inf_id integer, prm_ordre integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	INSERT INTO liste.champ (lis_id, inf_id, cha_ordre) VALUES (prm_lis_id, prm_inf_id, prm_ordre) RETURNING cha_id INTO ret;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION liste_champ_add(prm_token integer, prm_lis_id integer, prm_inf_id integer, prm_ordre integer) IS
'Ajoute un champ à une configuration de page liste.';

CREATE OR REPLACE FUNCTION liste_champ_get(prm_token integer, prm_cha_id integer) RETURNS champ
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret liste.champ;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT * INTO ret FROM liste.champ WHERE cha_id = prm_cha_id;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION liste_champ_get(prm_token integer, prm_cha_id integer) IS
'Retourne la configuration d''un champ dans une page liste';

CREATE OR REPLACE FUNCTION liste_champ_liste(prm_token integer, prm_lis_id integer) RETURNS SETOF champ
    LANGUAGE plpgsql
    AS $$
DECLARE
	row liste.champ;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT * FROM liste.champ WHERE lis_id = prm_lis_id ORDER BY cha_ordre
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION liste_champ_liste(prm_token integer, prm_lis_id integer) IS
'Retourne la liste des configurations de page liste';

CREATE OR REPLACE FUNCTION liste_champ_set_contact(prm_token integer, prm_cha_id integer, prm_contact boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE liste.champ SET cha__groupe_contact = prm_contact WHERE cha_id = prm_cha_id;
END;
$$;
COMMENT ON FUNCTION liste_champ_set_contact(prm_token integer, prm_cha_id integer, prm_contact boolean) IS
'Pour un champ groupe, indique si le contact doit être affiché.';

CREATE OR REPLACE FUNCTION liste_champ_set_cycle(prm_token integer, prm_cha_id integer, prm_cycle boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE liste.champ SET cha__groupe_cycle = prm_cycle WHERE cha_id = prm_cha_id;
END;
$$;
COMMENT ON FUNCTION liste_champ_set_cycle(prm_token integer, prm_cha_id integer, prm_cycle boolean) IS
'Pour un champ groupe, indique si les informations de cycle doivent être  affichées.';

CREATE OR REPLACE FUNCTION liste_champ_set_dernier(prm_token integer, prm_cha_id integer, prm_dernier boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE liste.champ SET cha__groupe_dernier = prm_dernier WHERE cha_id = prm_cha_id;
END;
$$;
COMMENT ON FUNCTION liste_champ_set_dernier(prm_token integer, prm_cha_id integer, prm_dernier boolean) IS
'Pour un champ groupe, indique si uniquement la dernière appartenance doit être affichée.';

CREATE OR REPLACE FUNCTION liste_champ_set_details(prm_token integer, prm_cha_id integer, prm_details boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE liste.champ SET cha__famille_details = prm_details WHERE cha_id = prm_cha_id;
END;
$$;
COMMENT ON FUNCTION liste_champ_set_details(prm_token integer, prm_cha_id integer, prm_details boolean) IS
'Pour un champ famille, indique si les détails du lien familial doivent être affichés.';

CREATE OR REPLACE FUNCTION liste_champ_set_filtrer(prm_token integer, prm_cha_id integer, prm_filtrer boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE liste.champ SET cha_filtrer = prm_filtrer WHERE cha_id = prm_cha_id;
	IF NOT prm_filtrer THEN
		UPDATE liste.champ SET cha_verrouiller = FALSE WHERE cha_id = prm_cha_id;
	END IF;
	DELETE FROM liste.defaut WHERE cha_id = prm_cha_id;
END;
$$;
COMMENT ON FUNCTION liste_champ_set_filtrer(prm_token integer, prm_cha_id integer, prm_filtrer boolean) IS
'Indique s''il est possible de filtrer sur ce champ.';

CREATE OR REPLACE FUNCTION liste_champ_set_libelle(prm_token integer, prm_cha_id integer, prm_libelle character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE liste.champ SET cha_libelle = prm_libelle WHERE cha_id = prm_cha_id;
END;
$$;
COMMENT ON FUNCTION liste_champ_set_libelle(prm_token integer, prm_cha_id integer, prm_libelle character varying) IS 
'Modifie le libellé du champ dans la liste.';

CREATE OR REPLACE FUNCTION liste_champ_set_ordre(prm_token integer, prm_cha_id integer, prm_ordre integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE liste.champ SET cha_ordre = prm_ordre WHERE cha_id = prm_cha_id;
END;
$$;
COMMENT ON FUNCTION liste_champ_set_ordre(prm_token integer, prm_cha_id integer, prm_ordre integer) IS
'Modifie l''ordre du champ dans la liste.';

CREATE OR REPLACE FUNCTION liste_champ_set_verrouiller(prm_token integer, prm_cha_id integer, prm_verrouiller boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE liste.champ SET cha_verrouiller = prm_verrouiller WHERE cha_id = prm_cha_id;
END;
$$;
COMMENT ON FUNCTION liste_champ_set_verrouiller(prm_token integer, prm_cha_id integer, prm_verrouiller boolean) IS
'Indique si les valeurs de filtrage par défaut sont verrouillées.';

CREATE OR REPLACE FUNCTION liste_champ_set_contact_filtre_utilisateur(prm_token integer, prm_cha_id integer, prm_filtre_utilisateur boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE liste.champ SET cha__contact_filtre_utilisateur = prm_filtre_utilisateur WHERE cha_id = prm_cha_id;
END;
$$;
COMMENT ON FUNCTION liste_champ_set_contact_filtre_utilisateur(prm_token integer, prm_cha_id integer, prm_filtre_utilisateur boolean) IS
'Indique si un champ Contact filtré le sera par défaut sur l''utilisateur connecté.';

CREATE OR REPLACE FUNCTION liste_champ_set_champs_supp(prm_token integer, prm_cha_id integer, prm_champs_supp boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE liste.champ SET cha_champs_supp = prm_champs_supp WHERE cha_id = prm_cha_id;
END;
$$;
COMMENT ON FUNCTION liste_champ_set_champs_supp(prm_token integer, prm_cha_id integer, prm_champs_supp boolean) IS
'Indique si des champs supplémentaires seront affichés dans ce champs.';

CREATE OR REPLACE FUNCTION liste_champ_supprime(prm_token integer, prm_cha_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	DELETE FROM liste.champ WHERE cha_id = prm_cha_id;
END;
$$;
COMMENT ON FUNCTION liste_champ_supprime(prm_token integer, prm_cha_id integer) IS
'Supprime un champ d''une page liste.';

CREATE OR REPLACE FUNCTION liste_defaut_ajoute_groupe(prm_token integer, prm_cha_id integer, prm_val integer, prm_val2 integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	INSERT INTO liste.defaut (cha_id, def_valeur_int, def_valeur_int2) VALUES (prm_cha_id, prm_val, prm_val2)
		RETURNING def_id INTO ret;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION liste_defaut_ajoute_groupe(prm_token integer, prm_cha_id integer, prm_val integer, prm_val2 integer) IS
'Ajoute une valeur par défaut à un champ de type affectation, etc';

CREATE OR REPLACE FUNCTION liste_defaut_ajoute_selection(prm_token integer, prm_cha_id integer, prm_val integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	INSERT INTO liste.defaut (cha_id, def_valeur_int) VALUES (prm_cha_id, prm_val)
		RETURNING def_id INTO ret;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION liste_defaut_ajoute_selection(prm_token integer, prm_cha_id integer, prm_val integer) IS
'Ajoute une valeur par défaut à un champ de type sélection, etc';

CREATE OR REPLACE FUNCTION liste_defaut_ajoute_texte(prm_token integer, prm_cha_id integer, prm_val character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	INSERT INTO liste.defaut (cha_id, def_valeur_texte) VALUES (prm_cha_id, prm_val)
		RETURNING def_id INTO ret;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION liste_defaut_ajoute_texte(prm_token integer, prm_cha_id integer, prm_val character varying) IS
'Ajoute une valeur par défaut à un champ de type texte, etc';

CREATE OR REPLACE FUNCTION liste_defaut_liste(prm_token integer, prm_cha_id integer) RETURNS SETOF defaut
    LANGUAGE plpgsql
    AS $$
DECLARE
	row liste.defaut;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT * FROM liste.defaut WHERE cha_id = prm_cha_id ORDER BY def_ordre
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION liste_defaut_liste(prm_token integer, prm_cha_id integer) IS
'Retourne la liste des valeurs de filtrage par défaut d''un champ dans la liste.';

CREATE OR REPLACE FUNCTION liste_defaut_supprime(prm_token integer, prm_def_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	cha integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	SELECT cha_id INTO cha FROM liste.defaut WHERE def_id = prm_def_id;
	DELETE FROM liste.defaut WHERE def_id = prm_def_id;
	IF NOT EXISTS (SELECT 1 FROM liste.defaut WHERE cha_id = cha) THEN
		UPDATE liste.champ SET cha_verrouiller = FALSE WHERE cha_id = cha;
	END IF;
END;
$$;
COMMENT ON FUNCTION liste_defaut_supprime(prm_token integer, prm_def_id integer) IS
'Supprime une valeur de filtrage par défaut pour un champ dans la liste.';

CREATE OR REPLACE FUNCTION liste_liste_all(prm_token integer) RETURNS SETOF liste
    LANGUAGE plpgsql
    AS $$
DECLARE
	row liste.liste;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	FOR row IN
		SELECT * FROM liste.liste 
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION liste_liste_all(prm_token integer) IS
'Retourne la liste des configurations de pages liste.';

DROP FUNCTION IF EXISTS liste_liste_details(prm_token integer);
DROP TYPE IF EXISTS liste_liste_details;
CREATE TYPE liste_liste_details AS (
  lis_id integer, 
  lis_nom varchar,
  ent_libelle varchar);

CREATE OR REPLACE FUNCTION liste_liste_details(prm_token integer) RETURNS SETOF liste.liste_liste_details
    LANGUAGE plpgsql
    AS $$
DECLARE
	row liste.liste_liste_details;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT lis_id, lis_nom, ent_libelle FROM liste.liste INNER JOIN meta.entite USING(ent_id) ORDER BY ent_libelle, lis_nom
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION liste_liste_details(prm_token integer) IS
'Retourne la liste des configurations de pages liste, avec détails.';

CREATE OR REPLACE FUNCTION liste_liste_inutilisees(prm_token integer) RETURNS SETOF liste
    LANGUAGE plpgsql
    AS $$
DECLARE
	row liste.liste;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT * FROM liste.liste 
		WHERE lis_id NOT IN (SELECT DISTINCT tsm_type_id FROM meta.topsousmenu WHERE tsm_type = 'liste')
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;

DROP FUNCTION IF EXISTS liste_liste_create(prm_token integer, prm_nom character varying, prm_ent_id integer, prm_inverse boolean, prm_pagination_tout boolean);
CREATE OR REPLACE FUNCTION liste_liste_create(prm_token integer, prm_nom character varying, prm_code varchar, prm_ent_id integer, prm_inverse boolean, prm_pagination_tout boolean) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	INSERT INTO liste.liste (lis_nom, lis_code, ent_id, lis_inverse, lis_pagination_tout) VALUES (prm_nom, pour_code (prm_code), prm_ent_id, prm_inverse, prm_pagination_tout) RETURNING lis_id INTO ret;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION liste_liste_create(prm_token integer, prm_nom character varying, prm_code varchar, prm_ent_id integer, prm_inverse boolean, prm_pagination_tout boolean) IS
'Crée une nouvelle configuration de page liste.';

CREATE OR REPLACE FUNCTION liste_liste_get(prm_token integer, prm_lis_id integer) RETURNS liste
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret liste.liste;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT * INTO ret FROM liste.liste WHERE lis_id = prm_lis_id;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION liste_liste_get(prm_token integer, prm_lis_id integer) IS
'Retourne les informations d''une configuration de page liste.';

CREATE OR REPLACE FUNCTION liste_liste_get_par_code(prm_token integer, prm_lis_code varchar) RETURNS liste
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret liste.liste;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT * INTO ret FROM liste.liste WHERE lis_code = prm_lis_code;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION liste_liste_get_par_code(prm_token integer, prm_lis_code varchar) IS
'Retourne les informations d''une configuration de page liste.';

CREATE OR REPLACE FUNCTION liste_liste_supprime(prm_token integer, prm_lis_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE meta.topsousmenu SET tsm_type_id = NULL WHERE tsm_type = 'liste' AND tsm_type_id = prm_lis_id;
	DELETE FROM liste.defaut WHERE cha_id IN (SELECT cha_id FROM liste.champ WHERE lis_id = prm_lis_id);
	DELETE FROM liste.champ WHERE lis_id = prm_lis_id;
	DELETE FROM liste.liste WHERE lis_id = prm_lis_id;
END;
$$;
COMMENT ON FUNCTION liste_liste_supprime(prm_token integer, prm_lis_id integer) IS
'Supprime une configuration de page liste.';

CREATE OR REPLACE FUNCTION liste_liste_update(prm_token integer, prm_lis_id integer, prm_nom character varying, prm_code varchar, prm_ent_id integer, prm_inverse boolean, prm_pagination_tout boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE liste.liste SET lis_nom = prm_nom, lis_code = pour_code (prm_code), ent_id = prm_ent_id, lis_inverse = prm_inverse, lis_pagination_tout = prm_pagination_tout WHERE lis_id = prm_lis_id;
END;
$$;
COMMENT ON FUNCTION liste_liste_update(prm_token integer, prm_lis_id integer, prm_nom character varying, prm_code varchar, prm_ent_id integer, prm_inverse boolean, prm_pagination_tout boolean) IS
'Modifie les informations d''une configuration de page liste.';

CREATE OR REPLACE FUNCTION liste_supp_edit (prm_token integer, prm_cha_id integer, prm_inf_ids integer[])
RETURNS VOID 
LANGUAGE plpgsql
AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	DELETE FROM liste.supp WHERE cha_id = prm_cha_id;
	FOR i IN 1 .. array_upper(prm_inf_ids, 1) LOOP
	    INSERT INTO liste.supp (cha_id, inf_id, sup_ordre) 
	    	   VALUES (prm_cha_id, prm_inf_ids[i], i-1);
	END LOOP;	
END;
$$;
COMMENT ON FUNCTION liste_supp_edit (prm_token integer, prm_cha_id integer, prm_inf_ids integer[]) IS 
'Indique la liste des champs à afficher pour détailler une colonne de tableau donnée.';

CREATE OR REPLACE FUNCTION liste_supp_list (prm_token integer, prm_cha_id integer)
RETURNS SETOF meta.info
LANGUAGE plpgsql
AS $$
DECLARE
	row meta.info;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
	    SELECT info.* FROM liste.supp
	    	   INNER JOIN meta.info USING(inf_id)
		   WHERE (prm_cha_id ISNULL OR cha_id = prm_cha_id)
		   ORDER BY sup_ordre
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION liste_supp_list (prm_token integer, prm_cha_id integer) IS
'Retourne la liste des champs afficher pour détailler une colonne de tableau.';

CREATE OR REPLACE FUNCTION liste_supp_supprime (prm_token integer, prm_cha_id integer, prm_inf_id integer) 
RETURNS VOID 
LANGUAGE plpgsql
AS $$
BEGIN
	DELETE FROM liste.supp WHERE cha_id = prm_cha_id AND inf_id = prm_inf_id;
END;
$$;
COMMENT ON FUNCTION liste_supp_supprime (prm_token integer, prm_cha_id integer, prm_inf_id integer) IS
'Supprime un champs supplémentaire.';

CREATE OR REPLACE FUNCTION liste_liste_duplicate(prm_token integer, prm_lis_id_src integer, prm_libelle varchar)
RETURNS integer
LANGUAGE plpgsql
AS $$
DECLARE
  tmp_liste liste.liste;
  tmp_cha_id integer;
BEGIN
  PERFORM login._token_assert (prm_token, FALSE, FALSE);
  SELECT * INTO tmp_liste FROM liste.liste WHERE lis_id = prm_lis_id_src;
  tmp_liste.lis_id = nextval(pg_get_serial_sequence('liste.liste', 'lis_id'));
  tmp_liste.lis_nom = prm_libelle;
  tmp_liste.lis_code = tmp_liste.lis_code || '_dup';
  WHILE EXISTS (SELECT 1 FROM liste.liste WHERE lis_code = tmp_liste.lis_code) LOOP
    tmp_liste.lis_code = tmp_liste.lis_code || '_dup';
  END LOOP;  
  INSERT INTO liste.liste VALUES (tmp_liste.*);

  FOR tmp_cha_id IN SELECT cha_id FROM liste.champ WHERE lis_id = prm_lis_id_src LOOP
    PERFORM liste.liste_champ_duplicate (prm_token, tmp_cha_id, tmp_liste.lis_id);
  END LOOP;
  RETURN tmp_liste.lis_id;
END;
$$;

CREATE OR REPLACE FUNCTION liste_champ_duplicate(prm_token integer, prm_cha_id_src integer, prm_lis_id integer)
RETURNS integer
LANGUAGE plpgsql
AS $$
DECLARE
  tmp_champ liste.champ;
  tmp_def_id integer;
  tmp_sup_id integer;
BEGIN
  PERFORM login._token_assert (prm_token, FALSE, FALSE);
  SELECT * INTO tmp_champ FROM liste.champ WHERE cha_id = prm_cha_id_src;
  tmp_champ.cha_id = nextval(pg_get_serial_sequence('liste.champ', 'cha_id'));
  tmp_champ.lis_id = prm_lis_id;
  INSERT INTO liste.champ VALUES (tmp_champ.*);

  FOR tmp_def_id IN SELECT def_id FROM liste.defaut WHERE cha_id = prm_cha_id_src LOOP
    PERFORM liste.liste_defaut_duplicate (prm_token, tmp_def_id, tmp_champ.cha_id);
  END LOOP;
  FOR tmp_sup_id IN SELECT sup_id FROM liste.supp WHERE cha_id = prm_cha_id_src LOOP
    PERFORM liste.liste_supp_duplicate (prm_token, tmp_sup_id, tmp_champ.cha_id);
  END LOOP;
  RETURN tmp_champ.cha_id;
END;
$$;

CREATE OR REPLACE FUNCTION liste_defaut_duplicate(prm_token integer, prm_def_id_src integer, prm_cha_id integer)
RETURNS integer
LANGUAGE plpgsql
AS $$
DECLARE
  tmp_defaut liste.defaut;
BEGIN
  PERFORM login._token_assert (prm_token, FALSE, FALSE);
  SELECT * INTO tmp_defaut FROM liste.defaut WHERE def_id = prm_def_id_src;
  tmp_defaut.def_id = nextval(pg_get_serial_sequence('liste.defaut', 'def_id'));
  tmp_defaut.cha_id = prm_cha_id;
  INSERT INTO liste.defaut VALUES (tmp_defaut.*);
  RETURN tmp_defaut.def_id;
END;
$$;

CREATE OR REPLACE FUNCTION liste_supp_duplicate(prm_token integer, prm_sup_id_src integer, prm_cha_id integer)
RETURNS integer
LANGUAGE plpgsql
AS $$
DECLARE
  tmp_supp liste.supp;
BEGIN
  PERFORM login._token_assert (prm_token, FALSE, FALSE);
  SELECT * INTO tmp_supp FROM liste.supp WHERE sup_id = prm_sup_id_src;
  tmp_supp.sup_id = nextval(pg_get_serial_sequence('liste.supp', 'sup_id'));
  tmp_supp.cha_id = prm_cha_id;
  INSERT INTO liste.supp VALUES (tmp_supp.*);
  RETURN tmp_supp.sup_id;
END;
$$;
