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

SET search_path = meta, pg_catalog;

--------------------
-- meta.selection --
--------------------
--
-- meta_selection_add:prm_token:prm_code:prm_libelle:prm_info
--
CREATE OR REPLACE FUNCTION meta_selection_add(prm_token integer, prm_code character varying, prm_libelle character varying, prm_info character varying) RETURNS integer
     LANGUAGE plpgsql
     AS $$
 DECLARE
 	ret integer;
 BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
 	INSERT INTO meta.selection (sel_code, sel_libelle, sel_info) VALUES (prm_code, prm_libelle, prm_info) 
 		RETURNING sel_id INTO ret;
 	RETURN ret;
 END;
 $$;

--
-- meta_selection_add_avec_id:prm_token:prm_id:prm_code:prm_libelle:prm_info
--
CREATE OR REPLACE FUNCTION meta_selection_add_avec_id(prm_token integer, prm_id integer, prm_code character varying, prm_libelle character varying, prm_info character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	INSERT INTO meta.selection (sel_id, sel_code, sel_libelle, sel_info) VALUES (prm_id, prm_code, prm_libelle, prm_info) 
		RETURNING sel_id INTO ret;
	PERFORM setval ('meta.selection_sel_id_seq', coalesce((select max(sel_id)+1 from meta.selection), 1), false);
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_selection_add_avec_id(prm_token integer, prm_id integer, prm_code character varying, prm_libelle character varying, prm_info character varying) IS
'Ajoute une liste de sélection (utilisé avec la banque de champs).';

--
-- meta_selection_dernier:prm_token
--
CREATE OR REPLACE FUNCTION meta_selection_dernier (prm_token integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	SELECT MAX(sel_id) INTO ret FROM meta.selection;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_selection_dernier (prm_token integer) IS
'Retourne la dernière liste de sélection en base (utilisé avec la banque de champs).';

--
-- meta_selection_infos:prm_token:prm_sel_id
--
CREATE OR REPLACE FUNCTION meta_selection_infos(prm_token integer, prm_sel_id integer) RETURNS selection
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret meta.selection%ROWTYPE;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT * INTO ret FROM meta.selection WHERE sel_id = prm_sel_id;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_selection_infos(prm_token integer, prm_sel_id integer) IS
'Retourne les infos d''une liste de sélection.';

--
-- meta_selection_infos_par_code:prm_token:prm_sel_code
--
CREATE OR REPLACE FUNCTION meta_selection_infos_par_code(prm_token integer, prm_sel_code character varying) RETURNS selection
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret meta.selection%ROWTYPE;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT * INTO ret FROM meta.selection WHERE sel_code = prm_sel_code;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_selection_infos_par_code(prm_token integer, prm_sel_code character varying) IS
'Retourne les infos d''une liste de sélection à partir de son code.';

--
-- meta_selection_liste:prm_token
--
CREATE OR REPLACE FUNCTION meta_selection_liste(prm_token integer) RETURNS SETOF selection
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.selection;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	FOR row IN
		SELECT * FROM meta.selection ORDER BY sel_libelle
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_selection_liste(prm_token integer) IS
'Retourne la liste des listes de sélection.';

--
-- meta_selection_update:prm_token:prm_sel_id:prm_code:prm_libelle:prm_info 
--
CREATE OR REPLACE FUNCTION meta_selection_update(prm_token integer, prm_sel_id integer, prm_code character varying, prm_libelle character varying, prm_info character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	UPDATE meta.selection SET 
		sel_code = prm_code, 
		sel_libelle = prm_libelle, 
		sel_info = prm_info
		WHERE sel_id = prm_sel_id; 
END;
$$;
COMMENT ON FUNCTION meta_selection_update(prm_token integer, prm_sel_id integer, prm_code character varying, prm_libelle character varying, prm_info character varying) IS
'Modifie les informations d''une liste de sélection.';

--
-- meta_selection_inutilisees:prm_token
--
CREATE OR REPLACE FUNCTION meta_selection_inutilisees(prm_token integer) RETURNS SETOF selection
LANGUAGE plpgsql
AS $$
DECLARE
	row meta.selection;
BEGIN
	FOR row IN
	    SELECT selection.* FROM meta.selection WHERE sel_id NOT IN (
                SELECT DISTINCT inf__selection_code FROM meta.info WHERE inf__selection_code NOTNULL)
        LOOP
	    RETURN NEXT row;
        END LOOP;
END;
$$;

--
-- meta_selection_supprime:prm_token:prm_sel_id
--
CREATE OR REPLACE FUNCTION meta_selection_supprime(prm_token integer, prm_sel_id integer) RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN
	PERFORM login._token_assert (prm_token, TRUE, TRUE);
	DELETE FROM meta.selection_entree WHERE sel_id = prm_sel_id;
	DELETE FROM meta.selection WHERE sel_id = prm_sel_id;	
END;
$$;
COMMENT ON FUNCTION meta_selection_supprime(prm_token integer, prm_sel_id integer) IS 
'Supprime une liste de sélection.
Entrées :
 - prm_token : Token d''authentification
 - prm_sel_id : Identification de la liste de sélection

La liste de sélection ne doit pas être utilisée.';

--
-- meta_selection_isused:prm_token:prm_sel_id
--
CREATE OR REPLACE FUNCTION meta_selection_isused(prm_token integer, prm_sel_id integer) RETURNS BOOLEAN
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM meta.info WHERE info.inf__selection_code = prm_sel_id) THEN
        RETURN true;
    END IF;
    RETURN false;
END;
$$;
COMMENT ON FUNCTION meta_selection_isused(prm_token integer, prm_sel_id integer) IS 
'Indique si une liste de sélection est utilisée.
Entrées :
 - prm_token : Token d''authentification
 - prm_sel_id : Identification de la liste de sélection
';

---------------------------
-- meta.selection_entree --
---------------------------
--
-- meta_selection_entree_add:prm_token:prm_sel_id:prm_libelle:prm_ordre
--
CREATE OR REPLACE FUNCTION meta_selection_entree_add(prm_token integer, prm_sel_id integer, prm_libelle character varying, prm_ordre integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	INSERT INTO meta.selection_entree (sel_id, sen_libelle, sen_ordre) VALUES (prm_sel_id, prm_libelle, prm_ordre) 
		RETURNING sen_id INTO ret;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_selection_entree_add(prm_token integer, prm_sel_id integer, prm_libelle character varying, prm_ordre integer) IS
'Ajoute une entrée à une liste de sélection.';

--
-- meta_selection_entree_get:prm_token:prm_sen_id
--
CREATE OR REPLACE FUNCTION meta_selection_entree_get(prm_token integer, prm_sen_id integer) RETURNS selection_entree
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret meta.selection_entree;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT * INTO ret FROM meta.selection_entree WHERE sen_id = prm_sen_id;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_selection_entree_get(prm_token integer, prm_sen_id integer) IS
'Retourne les informations sur une entrée de liste de sélection.';

--
-- meta_selection_entree_liste:prm_token:prm_sel_id
--
CREATE OR REPLACE FUNCTION meta_selection_entree_liste(prm_token integer, prm_sel_id integer) RETURNS SETOF selection_entree
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.selection_entree%ROWTYPE;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT * FROM meta.selection_entree WHERE sel_id = prm_sel_id ORDER BY sen_ordre
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_selection_entree_liste(prm_token integer, prm_sel_id integer) IS
'Retourne les entrées d''une liste de sélection.';

--
-- meta_selection_entree_liste_par_cha:prm_token:prm_cha_id
--
CREATE OR REPLACE FUNCTION meta_selection_entree_liste_par_cha(prm_token integer, prm_cha_id integer) RETURNS SETOF selection_entree
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.selection_entree%ROWTYPE;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT selection_entree.* FROM meta.selection_entree 
		INNER JOIN meta.info ON info.inf__selection_code = sel_id
		INNER JOIN liste.champ USING (inf_id)
		WHERE cha_id = prm_cha_id ORDER BY sen_ordre
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_selection_entree_liste_par_cha(prm_token integer, prm_cha_id integer) IS
'Retourne les entrées d''une liste de sélection d''après l''identifiant du champ de type sélection.';

--
-- meta_selection_entree_liste_par_code:prm_token:prm_sel_code
--
CREATE OR REPLACE FUNCTION meta_selection_entree_liste_par_code(prm_token integer, prm_sel_code character varying) RETURNS SETOF selection_entree
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.selection_entree%ROWTYPE;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT * FROM meta.selection_entree WHERE sel_id = (SELECT sel_id FROM meta.selection WHERE sel_code = prm_sel_code) ORDER BY sen_ordre
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_selection_entree_liste_par_code(prm_token integer, prm_sel_code character varying) IS
'Retourne les entrées d''une liste de sélection à partir du code de la liste.';

--
-- meta_selection_entree_set_ordre:prm_token:prm_sen_id:prm_ordre
--
CREATE OR REPLACE FUNCTION meta_selection_entree_set_ordre(prm_token integer, prm_sen_id integer, prm_ordre integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE meta.selection_entree SET sen_ordre = prm_ordre WHERE sen_id = prm_sen_id;
END;
$$;
COMMENT ON FUNCTION meta_selection_entree_set_ordre(prm_token integer, prm_sen_id integer, prm_ordre integer) IS
'Modifie l''ordre d''apparition d''une entrée dans la liste de sélection.';

--
-- meta_selection_entree_set_libelle:prm_token:prm_sen_id:prm_libelle
--
CREATE OR REPLACE FUNCTION meta_selection_entree_set_libelle(prm_token integer, prm_sen_id integer, prm_libelle varchar) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE meta.selection_entree SET sen_libelle = prm_libelle WHERE sen_id = prm_sen_id;
END;
$$;
COMMENT ON FUNCTION meta_selection_entree_set_libelle(prm_token integer, prm_sen_id integer, prm_libelle varchar) IS
'Modifie le libellé d''une entrée de liste de sélection.';

--
-- meta_selection_entree_supprime:prm_token:prm_sen_id
--
CREATE OR REPLACE FUNCTION meta_selection_entree_supprime(prm_token integer, prm_sen_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	DELETE FROM meta.selection_entree WHERE sen_id = prm_sen_id;
END;
$$;
COMMENT ON FUNCTION meta_selection_entree_supprime(prm_token integer, prm_sen_id integer) IS
'Supprime une entrée de liste de sélection.';

---------------------
-- meta.infos_type --
---------------------
--
-- meta_infos_type_liste:prm_token
--
CREATE OR REPLACE FUNCTION meta_infos_type_liste(prm_token integer) RETURNS SETOF infos_type
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.infos_type%ROWTYPE;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT * FROM meta.infos_type 
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_infos_type_liste(prm_token integer) IS
'Retourne la liste des types de champs.';

------------------
-- meta.dirinfo --
------------------
--
-- meta_dirinfo_add:prm_token:prm_din_id_parent:prm_libelle
-- 
CREATE OR REPLACE FUNCTION meta_dirinfo_add(prm_token integer, prm_din_id_parent integer, prm_libelle character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	INSERT INTO meta.dirinfo (din_id_parent, din_libelle) VALUES (prm_din_id_parent, prm_libelle)
		RETURNING din_id INTO ret;
	RETURN ret;
END;
$$;

--
-- meta_dirinfo_add_avec_id:prm_token:prm_id:prm_din_id_parent:prm_libelle
--
CREATE OR REPLACE FUNCTION meta_dirinfo_add_avec_id(prm_token integer, prm_id integer, prm_din_id_parent integer, prm_libelle character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	INSERT INTO meta.dirinfo (din_id, din_id_parent, din_libelle) VALUES (prm_id, prm_din_id_parent, prm_libelle)
		RETURNING din_id INTO ret;
	PERFORM setval ('meta.dirinfo_din_id_seq', coalesce((select max(din_id)+1 from meta.dirinfo), 1), false);
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_dirinfo_add_avec_id(prm_token integer, prm_id integer, prm_din_id_parent integer, prm_libelle character varying) IS
'Ajoute un nouveau répertoire de champs (utilisé avec la banque de champs).';

--
--meta_dirinfo_delete:prm_token:prm_din_id
--
CREATE OR REPLACE FUNCTION meta_dirinfo_delete(prm_token integer, prm_din_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	DELETE FROM meta.dirinfo WHERE din_id = prm_din_id;
END;
$$;

--
-- meta_dirinfo_dernier:prm_token 
--
CREATE OR REPLACE FUNCTION meta_dirinfo_dernier (prm_token integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	SELECT MAX(din_id) INTO ret FROM meta.dirinfo;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_dirinfo_dernier (prm_token integer) IS
'Retourne l''identifiant du dernier répertoire de champ présent (utilisé avec la banque de champs).';

--
-- meta_dirinfo_list:prm_token:prm_din_id_parent
--
CREATE OR REPLACE FUNCTION meta_dirinfo_list(prm_token integer, prm_din_id_parent integer) RETURNS SETOF dirinfo
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.dirinfo;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	FOR row IN
		SELECT * FROM meta.dirinfo WHERE (prm_din_id_parent ISNULL AND din_id_parent ISNULL) OR (din_id_parent = prm_din_id_parent)
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_dirinfo_list(prm_token integer, prm_din_id_parent integer) IS
'Retourne la liste des répertoires de champs inclus dans un répertoire donné.';

--
-- meta_dirinfo_move:prm_token:prm_din_id:prm_din_id_parent
--
CREATE OR REPLACE FUNCTION meta_dirinfo_move(prm_token integer, prm_din_id integer, prm_din_id_parent integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE meta.dirinfo SET din_id_parent = prm_din_id_parent WHERE din_id = prm_din_id;
END;
$$;

--
-- meta_dirinfo_update:prm_token:prm_din_id:prm_libelle
--
CREATE OR REPLACE FUNCTION meta_dirinfo_update(prm_token integer, prm_din_id integer, prm_libelle character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE meta.dirinfo SET din_libelle = prm_libelle WHERE din_id = prm_din_id;
END;
$$;

---------------
-- meta.info --
---------------
CREATE OR REPLACE FUNCTION meta_info_add(prm_token integer, prm_int_id integer, prm_code character varying, prm_libelle character varying, prm_libelle_complet character varying, prm_etendu boolean, prm_historique boolean, prm_multiple boolean) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	INSERT INTO meta.info(int_id, inf_code, inf_libelle, inf_libelle_complet, inf_etendu, inf_historique, inf_multiple) VALUES (prm_int_id, prm_code, prm_libelle, prm_libelle_complet, prm_etendu, prm_historique, prm_multiple) RETURNING inf_id INTO ret;
	RETURN ret;
END;
$$;

CREATE OR REPLACE FUNCTION meta_info_add_avec_id(prm_token integer, prm_inf_id integer, prm_int_id integer, prm_code character varying, prm_libelle character varying, prm__textelong_nblignes integer, prm__selection_code integer, prm_etendu boolean, prm_historique boolean, prm_multiple boolean, prm__groupe_type character varying, prm__contact_filtre character varying, prm__metier_secteur character varying, prm__contact_secteur character varying, prm__etablissement_interne boolean, prm_din_id integer,   prm__groupe_soustype integer, prm_libelle_complet character varying, prm__date_echeance boolean, prm__date_echeance_icone character varying, prm__date_echeance_secteur character varying, prm__etablissement_secteur character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	INSERT INTO meta.info(inf_id, int_id, inf_code, inf_libelle, inf__textelong_nblignes, inf__selection_code, inf_etendu, inf_historique, inf_multiple, inf__groupe_type, inf__contact_filtre, inf__metier_secteur, inf__contact_secteur, inf__etablissement_interne, din_id, inf__groupe_soustype, inf_libelle_complet, inf__date_echeance, inf__date_echeance_icone, inf__date_echeance_secteur, inf__etablissement_secteur) VALUES (prm_inf_id, prm_int_id, prm_code, prm_libelle, prm__textelong_nblignes, prm__selection_code, prm_etendu, prm_historique, prm_multiple, prm__groupe_type, prm__contact_filtre, prm__metier_secteur, prm__contact_secteur, prm__etablissement_interne, prm_din_id,   prm__groupe_soustype, prm_libelle_complet, prm__date_echeance, prm__date_echeance_icone, prm__date_echeance_secteur, prm__etablissement_secteur) RETURNING inf_id INTO ret;
	PERFORM setval ('meta.info_inf_id_seq', coalesce((select max(inf_id)+1 from meta.info), 1), false);
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_info_add_avec_id(prm_token integer, prm_inf_id integer, prm_int_id integer, prm_code character varying, prm_libelle character varying, prm__textelong_nblignes integer, prm__selection_code integer, prm_etendu boolean, prm_historique boolean, prm_multiple boolean, prm__groupe_type character varying, prm__contact_filtre character varying, prm__metier_secteur character varying, prm__contact_secteur character varying, prm__etablissement_interne boolean, prm_din_id integer,   prm__groupe_soustype integer, prm_libelle_complet character varying, prm__date_echeance boolean, prm__date_echeance_icone character varying, prm__date_echeance_secteur character varying, prm__etablissement_secteur character varying) IS
'Ajoute un champ dans la bibliothèque de champs disponibles.';

CREATE OR REPLACE FUNCTION meta_info_dernier (prm_token integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	SELECT MAX(inf_id) INTO ret FROM meta.info;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_info_dernier (prm_token integer) IS
'Retourne l''identifiant du dernier champ dans la bibliothèque de champs locale.';

CREATE OR REPLACE FUNCTION meta_info_get(prm_token integer, prm_inf_id integer) RETURNS info
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret meta.info;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT * INTO ret FROM meta.info WHERE inf_id = prm_inf_id;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_info_get(prm_token integer, prm_inf_id integer) IS
'Retourne les informations sur un champ.';

CREATE OR REPLACE FUNCTION meta_infos_formule_update(prm_token integer, prm_inf_id integer, prm_formule text)
RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN
  PERFORM login._token_assert (prm_token, FALSE, FALSE);
  UPDATE meta.info SET 
    inf_formule = prm_formule
    WHERE inf_id = prm_inf_id;
END;
$$;


CREATE OR REPLACE FUNCTION meta_info_get_par_code(prm_token integer, prm_inf_code character varying) RETURNS info
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret meta.info;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT * INTO ret FROM meta.info WHERE inf_code = prm_inf_code;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_info_get_par_code(prm_token integer, prm_inf_code character varying) IS
'Retourne les informations sur un champ, à partir de son code.';

CREATE OR REPLACE FUNCTION meta_info_get_type_par_code(prm_token integer, prm_code character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret varchar;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT int_code INTO ret FROM meta.info
		INNER JOIN meta.infos_type USING(int_id)
		WHERE inf_code = prm_code;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_info_get_type_par_code(prm_token integer, prm_code character varying) IS
'Retourne le type d''un champ.';

CREATE OR REPLACE FUNCTION meta_info_liste(prm_token integer, str character varying, usedonly boolean, prm_int_code character varying) RETURNS SETOF info
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.info;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	IF usedonly THEN
		FOR row IN
			SELECT DISTINCT info.* FROM meta.info 
			   INNER JOIN meta.info_groupe USING(inf_id) 
			   INNER JOIN meta.infos_type USING(int_id)
			   WHERE (str ISNULL OR inf_code ilike '%'||str||'%' OR inf_libelle ilike '%'||str||'%')
			   AND (prm_int_code ISNULL OR prm_int_code = infos_type.int_code)
		         UNION
                        SELECT DISTINCT info.* FROM meta.info
                           INNER JOIN liste.champ USING(inf_id)
			   INNER JOIN meta.infos_type USING(int_id)
			   WHERE (str ISNULL OR inf_code ilike '%'||str||'%' OR inf_libelle ilike '%'||str||'%')
			   AND (prm_int_code ISNULL OR prm_int_code = infos_type.int_code)
			   ORDER BY inf_libelle
		LOOP
			RETURN NEXT row;
		END LOOP;
	ELSE
		FOR row IN
		    SELECT info.* FROM meta.info 
		       INNER JOIN meta.infos_type USING(int_id)
		       WHERE (str ISNULL OR inf_code ilike '%'||str||'%' OR inf_libelle ilike '%'||str||'%') 
		       AND (prm_int_code ISNULL OR prm_int_code = infos_type.int_code)
		       ORDER BY inf_libelle
		LOOP
		    RETURN NEXT row;
		END LOOP;
	END IF;
END;
$$;
COMMENT ON FUNCTION meta_info_liste(prm_token integer, str character varying, usedonly boolean, prm_int_code character varying) IS
'Retourne la liste des champs dans le nom ou le code contient une chaîne, parmi tous les champs disponibles ou seulement ceux utilisés.';

CREATE OR REPLACE FUNCTION meta_info_inutilises(prm_token integer) RETURNS SETOF info
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.info;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT DISTINCT info.* FROM meta.info WHERE inf_id NOT IN (
		   SELECT DISTINCT inf_id FROM meta.info_groupe 
		   UNION 
                   SELECT DISTINCT inf_id FROM liste.champ)
		   ORDER BY inf_libelle
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;

CREATE OR REPLACE FUNCTION meta_info_listes_non_editables(prm_token integer) RETURNS SETOF info
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.info;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
	  SELECT DISTINCT info.* FROM meta.info 
	    INNER JOIN liste.champ USING(inf_id)
	    LEFT JOIN meta.info_groupe ON info_groupe.inf_id = info.inf_id
	    WHERE ing_id ISNULL 
            AND int_id NOT IN (SELECT int_id FROM meta.infos_type WHERE int_code IN ('coche_calcule', 'date_calcule', 'statut_usager'))
            ORDER BY inf_libelle
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;

CREATE OR REPLACE FUNCTION meta_info_liste_dans_dirinfo(prm_token integer, prm_din_id integer)
RETURNS SETOF info
LANGUAGE plpgsql
AS $$
DECLARE
  row meta.info;
BEGIN
  FOR row IN
    SELECT * FROM meta.info WHERE din_id = prm_din_id
  LOOP
    RETURN NEXT row;
  END LOOP;
END;
$$;

CREATE OR REPLACE FUNCTION meta_info_move(prm_token integer, prm_inf_id integer, prm_din_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE meta.info SET din_id = prm_din_id WHERE inf_id = prm_inf_id;
END;
$$;

CREATE OR REPLACE FUNCTION meta_info_supprime(prm_token integer, prm_inf_id integer)
RETURNS boolean 
LANGUAGE plpgsql
AS $$
DECLARE

BEGIN
  PERFORM login._token_assert (prm_token, FALSE, FALSE);
  PERFORM login._token_assert_interface (prm_token);
  BEGIN
    DELETE FROM meta.info_aide WHERE inf_id = prm_inf_id;
    DELETE FROM meta.info WHERE inf_id = prm_inf_id;
    RETURN TRUE;
  EXCEPTION 
    WHEN OTHERS THEN RETURN FALSE;  
  END;
END;
$$;

CREATE OR REPLACE FUNCTION meta_info_update(prm_token integer, prm_inf_id integer, prm_int_id integer, prm_code character varying, prm_libelle character varying, prm_libelle_complet character varying, prm_etendu boolean, prm_historique boolean, prm_multiple boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE meta.info SET 
		int_id = prm_int_id,
		inf_code = prm_code, 
		inf_libelle = prm_libelle, 
		inf_libelle_complet = prm_libelle_complet, 
		inf_etendu = prm_etendu, 
		inf_historique = prm_historique, 
		inf_multiple = prm_multiple 
	WHERE inf_id = prm_inf_id;
END;
$$;
COMMENT ON FUNCTION meta_info_update(prm_token integer, prm_inf_id integer, prm_int_id integer, prm_code character varying, prm_libelle character varying, prm_libelle_complet character varying, prm_etendu boolean, prm_historique boolean, prm_multiple boolean) IS
'Modifie les informations d''un champ.';

DROP FUNCTION IF EXISTS meta_info_usage (prm_token integer, prm_inf_id integer);
DROP TYPE IF EXISTS meta_info_usage;
CREATE TYPE meta_info_usage AS (
       cat_nom varchar,
       por_libelle varchar,
       ent_libelle varchar,
       men_libelle varchar, 
       sme_libelle varchar
);

CREATE OR REPLACE FUNCTION meta_info_usage (prm_token integer, prm_inf_id integer) RETURNS SETOF meta_info_usage
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.meta_info_usage;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	FOR row IN
	    select cat_nom, por_libelle, ent_libelle, men_libelle, sme_libelle FROM meta.info 
	    	   inner join meta.info_groupe using(inf_id)
		   inner join meta.groupe_infos using(gin_id)
		   inner join meta.sousmenu using(sme_id)
		   inner join meta.menu using(men_id)
		   inner join meta.entite using(ent_id)
		   inner join meta.portail using(por_id)
		   inner join meta.categorie using(cat_id)
		   where inf_id = prm_inf_id
	      union
	    select 'Liste', lis_nom, null, null, null FROM meta.info
	           inner join liste.champ USING(inf_id)
		   INNER JOIN liste.liste USING(lis_id)
		   where inf_id = prm_inf_id
            ORDER BY cat_nom, por_libelle, ent_libelle, men_libelle, sme_libelle
        LOOP
	    RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_info_usage (prm_token integer, prm_inf_id integer) IS
'Retourne les pages sur lesquelles est utilisé un champ.';

CREATE OR REPLACE FUNCTION meta_infos_contact_update(prm_token integer, prm_inf_id integer, prm_filtre character varying, prm_secteur character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE meta.info SET 
		inf__contact_filtre = prm_filtre,
		inf__contact_secteur = prm_secteur
		WHERE inf_id = prm_inf_id;
END;
$$;
COMMENT ON FUNCTION meta_infos_contact_update(prm_token integer, prm_inf_id integer, prm_filtre character varying, prm_secteur character varying) IS
'Modifie les informations spécifiques d''un champ de type "contact".';

CREATE OR REPLACE FUNCTION meta_infos_date_update(prm_token integer, prm_inf_id integer, prm__date_echeance boolean, prm__date_echeance_icone character varying, prm__date_echeance_secteur character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE meta.info SET 
		inf__date_echeance = prm__date_echeance,
		inf__date_echeance_icone = prm__date_echeance_icone,
		inf__date_echeance_secteur = prm__date_echeance_secteur
		WHERE inf_id = prm_inf_id;
END;
$$;
COMMENT ON FUNCTION meta_infos_date_update(prm_token integer, prm_inf_id integer, prm__date_echeance boolean, prm__date_echeance_icone character varying, prm__date_echeance_secteur character varying) IS
'Modifie les informations spécifiques d''un champ de type "date".';

CREATE OR REPLACE FUNCTION meta_infos_etablissement_update(prm_token integer, prm_inf_id integer, prm_interne boolean, prm__etablissement_secteur character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE meta.info SET 
		inf__etablissement_interne = prm_interne,
		inf__etablissement_secteur = prm__etablissement_secteur
		WHERE inf_id = prm_inf_id;
END;
$$;
COMMENT ON FUNCTION meta_infos_etablissement_update(prm_token integer, prm_inf_id integer, prm_interne boolean, prm__etablissement_secteur character varying) IS
'Modifie les informations spécifiques d''un champ de type "etablissement".';

CREATE OR REPLACE FUNCTION meta_infos_groupe_update(prm_token integer, prm_inf_id integer, prm_type character varying, prm_soustype integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE meta.info SET 
		inf__groupe_type = prm_type,
		inf__groupe_soustype = prm_soustype
		WHERE inf_id = prm_inf_id;
END;
$$;
COMMENT ON FUNCTION meta_infos_groupe_update(prm_token integer, prm_inf_id integer, prm_type character varying, prm_soustype integer) IS 
'Modifie les informations spécifiques d''un champ de type "etablissement".';

CREATE OR REPLACE FUNCTION meta_infos_metier_update(prm_token integer, prm_inf_id integer, prm_secteur character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE meta.info SET 
		inf__metier_secteur = prm_secteur
		WHERE inf_id = prm_inf_id;
END;
$$;
COMMENT ON FUNCTION meta_infos_metier_update(prm_token integer, prm_inf_id integer, prm_secteur character varying) IS
'Modifie les informations spécifiques d''un champ de type "metier".';

CREATE OR REPLACE FUNCTION meta_infos_selection_update(prm_token integer, prm_inf_id integer, prm_code integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE meta.info SET 
		inf__selection_code = prm_code
		WHERE inf_id = prm_inf_id;
END;
$$;
COMMENT ON FUNCTION meta_infos_selection_update(prm_token integer, prm_inf_id integer, prm_code integer) IS
'Modifie les informations spécifiques d''un champ de type "selection".';

CREATE OR REPLACE FUNCTION meta_infos_textelong_update(prm_token integer, prm_inf_id integer, prm_nblignes integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE meta.info SET 
		inf__textelong_nblignes = prm_nblignes
		WHERE inf_id = prm_inf_id;
END;
$$;
COMMENT ON FUNCTION meta_infos_textelong_update(prm_token integer, prm_inf_id integer, prm_nblignes integer) IS
'Modifie les informations spécifiques d''un champ de type "textelong".';
