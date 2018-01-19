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
-- Copyright (c) 2014,2016 Kavarna SARL

SET search_path = meta, pg_catalog;

-- ---------------
-- meta.secteur --
------------------
--
-- meta_secteur_get:prm_token:prm_sec_id
--
CREATE OR REPLACE FUNCTION meta_secteur_get(prm_token integer, prm_sec_id integer) RETURNS secteur
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret meta.secteur;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT * INTO ret FROM meta.secteur WHERE sec_id = prm_sec_id;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_secteur_get(prm_token integer, prm_sec_id integer) IS
'Retourne les informations sur un secteur.';

--
-- meta_secteur_get_par_code:prm_token:prm_sec_code
--
CREATE OR REPLACE FUNCTION meta_secteur_get_par_code(prm_token integer, prm_sec_code character varying) RETURNS secteur
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret meta.secteur;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT * INTO ret FROM meta.secteur WHERE sec_code = prm_sec_code;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_secteur_get_par_code(prm_token integer, prm_sec_code character varying) IS
'Retourne les informations sur un secteur à partir de son code.';

--
-- meta_secteur_liste:prm_token:prm_est_prise_en_charge
--
CREATE OR REPLACE FUNCTION meta_secteur_liste(prm_token integer, prm_est_prise_en_charge boolean) RETURNS SETOF secteur
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.secteur;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT * FROM meta.secteur WHERE (prm_est_prise_en_charge ISNULL OR sec_est_prise_en_charge = prm_est_prise_en_charge) ORDER BY sec_nom
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_secteur_liste(prm_token integer, prm_est_prise_en_charge boolean) IS
'Retourne la liste des secteurs.';

--
-- meta_secteur_save:prm_token:prm_code:prm_nom:prm_icone
--
CREATE OR REPLACE FUNCTION meta_secteur_save(prm_token integer, prm_code character varying, prm_nom character varying, prm_icone varchar) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, TRUE);
	UPDATE meta.secteur SET sec_nom = prm_nom, sec_icone = prm_icone WHERE sec_code = prm_code;
END;
$$;
COMMENT ON FUNCTION meta_secteur_save(prm_token integer, prm_code character varying, prm_nom character varying, prm_icone varchar) IS
'Modifie les informations d''un secteur.';

-----------------------
-- meta.secteur_type --
-----------------------
--
-- meta_secteur_type_add:prm_token:prm_sec_id:prm_nom
--
CREATE OR REPLACE FUNCTION meta_secteur_type_add(prm_token integer, prm_sec_id integer, prm_nom character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret INTEGER;
BEGIN
	PERFORM login._token_assert (prm_token, TRUE, TRUE);
	INSERT INTO meta.secteur_type (sec_id, set_nom) VALUES (prm_sec_id, prm_nom) RETURNING set_id INTO ret;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_secteur_type_add(prm_token integer, prm_sec_id integer, prm_nom character varying) IS
'Ajoute un type à un secteur.';

--
-- meta_secteur_type_delete:prm_token:prm_set_id
--
CREATE OR REPLACE FUNCTION meta_secteur_type_delete(prm_token integer, prm_set_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, TRUE, TRUE);
	DELETE FROM meta.secteur_type WHERE set_id = prm_set_id;
END;
$$;
COMMENT ON FUNCTION meta_secteur_type_delete(prm_token integer, prm_set_id integer) IS
'Supprime un type d''un secteur.';

-- 
-- meta_secteur_type_liste:prm_token:prm_sec_id
--
CREATE OR REPLACE FUNCTION meta_secteur_type_liste(prm_token integer, prm_sec_id integer) RETURNS SETOF secteur_type
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.secteur_type;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT * FROM meta.secteur_type WHERE sec_id = prm_sec_id ORDER BY set_nom
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_secteur_type_liste(prm_token integer, prm_sec_id integer) IS
'Retourne la liste des types d''un secteur.';

-- 
-- meta_secteur_type_liste_par_code:prm_token:prm_sec_code
--
CREATE OR REPLACE FUNCTION meta_secteur_type_liste_par_code(prm_token integer, prm_sec_code character varying) RETURNS SETOF secteur_type
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.secteur_type;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT meta.secteur_type.* FROM meta.secteur_type 
		INNER JOIN meta.secteur USING(sec_id)
		WHERE sec_code = prm_sec_code ORDER BY set_nom
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_secteur_type_liste_par_code(prm_token integer, prm_sec_code character varying) IS
'Retourne la liste des types d''un secteur, à partir du code du secteur.';

-- 
-- meta_secteur_type_update:prm_token:prm_set_id:prm_nom
--
CREATE OR REPLACE FUNCTION meta_secteur_type_update(prm_token integer, prm_set_id integer, prm_nom character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, TRUE, TRUE);
	UPDATE meta.secteur_type SET set_nom = prm_nom WHERE set_id = prm_set_id;
END;
$$;
COMMENT ON FUNCTION meta_secteur_type_update(prm_token integer, prm_set_id integer, prm_nom character varying) IS
'Modifie les informations d''un type d''un secteur.';

---------------------------------
-- meta.secteur_groupe         --
-- meta.secteur_groupe_secteur --
---------------------------------
--
-- meta_secteur_groupe_add:prm_token:prm_nom
--
CREATE OR REPLACE FUNCTION meta_secteur_groupe_add(prm_token integer, prm_nom varchar)
RETURNS integer
LANGUAGE plpgsql
AS $$
DECLARE
  ret integer;
BEGIN
  PERFORM login._token_assert (prm_token, TRUE, TRUE);
  INSERT INTO meta.secteur_groupe (seg_nom) VALUES (prm_nom) 
    RETURNING seg_id INTO ret;
  RETURN ret;
END;
$$;

--
-- meta_secteur_groupe_secteur_add:prm_token:prm_seg_id:prm_sec_id
--
CREATE OR REPLACE FUNCTION meta_secteur_groupe_secteur_add(prm_token integer, prm_seg_id integer, prm_sec_id integer)
RETURNS integer
LANGUAGE plpgsql
AS $$
DECLARE
  ret integer;
BEGIN
  PERFORM login._token_assert (prm_token, TRUE, TRUE);
  INSERT INTO meta.secteur_groupe_secteur (seg_id, sec_id) VALUES (prm_seg_id, prm_sec_id) 
    RETURNING sgs_id INTO ret;
  RETURN ret;
END;
$$;

-- 
-- meta_secteur_groupe_list_details:prm_token
--
DROP FUNCTION IF EXISTS meta_secteur_groupe_list_details (prm_token integer);
DROP TYPE IF EXISTS meta_secteur_groupe_list_details;
CREATE TYPE meta_secteur_groupe_list_details AS (
  seg_id integer,
  seg_nom varchar,
  secteurs varchar
);
CREATE FUNCTION meta_secteur_groupe_list_details (prm_token integer)
RETURNS SETOF meta.meta_secteur_groupe_list_details
LANGUAGE plpgsql
AS $$
DECLARE 
  row meta.meta_secteur_groupe_list_details;
BEGIN
  FOR row IN
    SELECT seg_id, seg_nom, string_agg(sec_code, ',') 
      FROM meta.secteur_groupe
      INNER JOIN meta.secteur_groupe_secteur USING(seg_id)
      INNER JOIN meta.secteur USING(sec_id)
      GROUP BY seg_id, seg_nom
  LOOP
    RETURN NEXT row;
  END LOOP;
END;
$$;


SET search_path = public, pg_catalog;
--------------------------
-- public.secteur_infos --
--------------------------
--
-- secteur_infos_get:prm_token:prm_sec_id
--
CREATE OR REPLACE FUNCTION secteur_infos_get(prm_token integer, prm_sec_id integer) RETURNS secteur_infos
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret secteur_infos;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT * INTO ret FROM secteur_infos WHERE sec_id = prm_sec_id;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION secteur_infos_get(prm_token integer, prm_sec_id integer) IS
'Retourne les informations supplémentaires sur un secteur.';

--
-- secteur_infos_update:prm_token:prm_sec_id:prm_editable
--
CREATE OR REPLACE FUNCTION secteur_infos_update(prm_token integer, prm_sec_id integer, prm_editable boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, TRUE, FALSE);
	UPDATE secteur_infos SET sec_editable = prm_editable WHERE sec_id = prm_sec_id;
	IF NOT FOUND THEN
		INSERT INTO secteur_infos (sec_id, sec_editable) VALUES (prm_sec_id, prm_editable);
	END IF;
END;
$$;
COMMENT ON FUNCTION secteur_infos_update(prm_token integer, prm_sec_id integer, prm_editable boolean) IS
'Modifie les informations supplémentaires sur un secteur.';
