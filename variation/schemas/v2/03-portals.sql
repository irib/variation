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
-- meta.categorie --
--------------------
--
-- meta_categorie_add:prm_token:prm_nom:prm_code 
--
CREATE OR REPLACE FUNCTION meta_categorie_add(prm_token integer, prm_nom character varying, prm_code character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer;
	code varchar;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	INSERT INTO meta.categorie (cat_nom, cat_code) 
	       VALUES (prm_nom, COALESCE (prm_code, pour_code(prm_nom))) 
	       RETURNING cat_id INTO ret;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_categorie_add(prm_token integer, prm_nom character varying, prm_code character varying) IS
'Ajoute une nouvelle catégorie d''établissement.
Entrées : 
 - prm_token : Token d''authentification
 - prm_nom : Nom de la catégorie
 - prm_code : Code de la catégorie, ou NULL pour une affectation automatique selon le nom';

--
-- meta_categorie_delete:prm_token:prm_cat_id
--
CREATE OR REPLACE FUNCTION meta_categorie_delete(prm_token integer, prm_cat_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
--	DELETE FROM meta.info_groupe WHERE gin_id IN (SELECT gin_id FROM meta.groupe_infos WHERE sme_id IN (SELECT sme_id FROM meta.sousmenu WHERE men_id IN (SELECT men_id FROM meta.menu WHERE por_id IN (SELECT por_id FROM meta.portail WHERE cat_id = prm_cat_id))));
--	DELETE FROM meta.groupe_infos WHERE sme_id IN (SELECT sme_id FROM meta.sousmenu WHERE men_id IN (SELECT men_id FROM meta.menu WHERE por_id IN (SELECT por_id FROM meta.portail WHERE cat_id = prm_cat_id)));
--	DELETE FROM meta.sousmenu WHERE men_id IN (SELECT men_id FROM meta.menu WHERE por_id IN (SELECT por_id FROM meta.portail WHERE cat_id = prm_cat_id));
--	DELETE FROM meta.menu WHERE por_id IN (SELECT por_id FROM meta.portail WHERE cat_id = prm_cat_id);

--	DELETE FROM meta.topsousmenu WHERE tom_id IN (SELECT tom_id FROM meta.topmenu WHERE por_id IN (SELECT por_id FROM meta.portail WHERE cat_id = prm_cat_id));
--	DELETE FROM meta.topmenu WHERE por_id IN (SELECT por_id FROM meta.portail WHERE cat_id = prm_cat_id);
	
--	DELETE FROM meta.portail WHERE cat_id = prm_cat_id;

	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	DELETE FROM meta.categorie WHERE cat_id = prm_cat_id;
END;
$$;
COMMENT ON FUNCTION meta_categorie_delete(prm_token integer, prm_cat_id integer) IS
'Supprime une catégorie de manière non récursive (les portails de la catégorie doivent être supprimés auparavant).';

--
-- meta_categorie_liste:prm_token
--
CREATE OR REPLACE FUNCTION meta_categorie_liste(prm_token integer) RETURNS SETOF categorie
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.categorie;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT * FROM meta.categorie ORDER BY cat_nom
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_categorie_liste(prm_token integer) IS
'Retourne la liste des catégories.';

--
-- meta_categorie_rename:prm_token:prm_cat_id:prm_nom
--
CREATE OR REPLACE FUNCTION meta_categorie_rename(prm_token integer, prm_cat_id integer, prm_nom character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE meta.categorie SET cat_nom = prm_nom WHERE cat_id = prm_cat_id;
END;
$$;
COMMENT ON FUNCTION meta_categorie_rename(prm_token integer, prm_cat_id integer, prm_nom character varying) IS
'Renomme une catégorie.';

------------------
-- meta.portail --
------------------
--
-- meta_portail_add:prm_token:prm_cat_id:prm_libelle
--
CREATE OR REPLACE FUNCTION meta_portail_add(prm_token integer, prm_cat_id integer, prm_libelle character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer;
	row meta.entite;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	INSERT INTO meta.portail (cat_id, por_libelle) VALUES (prm_cat_id, prm_libelle) RETURNING por_id INTO ret;
	FOR row IN SELECT * FROM meta.entite LOOP
		INSERT INTO permission.droit_ajout_entite_portail (ent_code, por_id, daj_droit) VALUES (row.ent_code, ret, TRUE);
	END LOOP;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_portail_add(prm_token integer, prm_cat_id integer, prm_libelle character varying) IS
'Ajoute un portail.';

--
-- meta_portail_delete:prm_token:prm_por
--
CREATE OR REPLACE FUNCTION meta_portail_delete(prm_token integer, prm_por_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	DELETE FROM permission.droit_ajout_entite_portail WHERE por_id = prm_por_id;
	DELETE FROM meta.portail WHERE por_id = prm_por_id;
END;
$$;
COMMENT ON FUNCTION meta_portail_delete(prm_token integer, prm_por_id integer) IS
'Supprime un portail.';

--
-- meta_portail_delete_rec:prm_token:prm_por_id
--
CREATE OR REPLACE FUNCTION meta_portail_delete_rec(prm_token integer, prm_por_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	row_ent meta.entite;
	row_tom meta.topmenu;
	row_tsm meta.topsousmenu;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	FOR row_ent IN SELECT * FROM meta.entite LOOP
		PERFORM meta.meta_menus_supprime_recursif (prm_token, row_ent.ent_code, prm_por_id);
	END LOOP; 
	FOR row_tom IN SELECT * FROM meta.topmenu WHERE por_id = prm_por_id LOOP
		PERFORM meta.meta_topmenu_delete (prm_token, row_tom.tom_id);
	END LOOP; 
	DELETE FROM permission.droit_ajout_entite_portail WHERE por_id = prm_por_id;
	DELETE FROM notes.theme_portail WHERE por_id = prm_por_id;
	DELETE FROM meta.portail WHERE por_id = prm_por_id;
END;
$$;
COMMENT ON FUNCTION meta_portail_delete_rec(prm_token integer, prm_por_id integer) IS
'Supprime un portail et tout ce qu''il contient.';

--
-- meta_portail_purge:prm_tokenprm_por_id
--
CREATE OR REPLACE FUNCTION meta_portail_purge(prm_token integer, prm_por_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	row_ent meta.entite;
	row_tom meta.topmenu;
	row_tsm meta.topsousmenu;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	FOR row_ent IN SELECT * FROM meta.entite LOOP
		PERFORM meta.meta_menus_supprime_recursif (prm_token, row_ent.ent_code, prm_por_id);
	END LOOP; 
	FOR row_tom IN SELECT * FROM meta.topmenu WHERE por_id = prm_por_id LOOP
		PERFORM meta.meta_topmenu_delete (prm_token, row_tom.tom_id);
	END LOOP; 
END;
$$;
COMMENT ON FUNCTION meta_portail_purge(prm_token integer, prm_por_id integer) IS
'Vide un portail de ses menus.';

-- 
-- meta_portail_get:prm_token:prm_cat_id:prm_por_id
--
CREATE OR REPLACE FUNCTION meta_portail_get(prm_token integer, prm_cat_id integer, prm_por_id integer) RETURNS portail
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret meta.portail;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT * INTO ret FROM meta.portail WHERE cat_id = prm_cat_id AND por_id = prm_por_id;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_portail_get(prm_token integer, prm_cat_id integer, prm_por_id integer) IS
'Retourne les informations sur un portail.';

--
-- meta_portail_infos:prm_token:prm_por_id
--
CREATE OR REPLACE FUNCTION meta_portail_infos(prm_token integer, prm_por_id integer) RETURNS portail
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret meta.portail;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT * INTO ret FROM meta.portail WHERE por_id = prm_por_id;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_portail_infos(prm_token integer, prm_por_id integer) IS
'Retourne les informations sur un portail.';

--
-- meta_portail_liste:prm_token:prm_cat_id
--
CREATE OR REPLACE FUNCTION meta_portail_liste(prm_token integer, prm_cat_id integer) RETURNS SETOF portail
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.portail;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT * FROM meta.portail WHERE (prm_cat_id ISNULL OR cat_id = prm_cat_id) ORDER BY por_libelle
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_portail_liste(prm_token integer, prm_cat_id integer) IS
'Retourne la liste des portails définis pour une catégorie donnée.';

--
-- meta_portail_rename:prm_token:prm_por_id:prm_libelle
--
CREATE OR REPLACE FUNCTION meta_portail_rename(prm_token integer, prm_por_id integer, prm_libelle character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE meta.portail SET por_libelle = prm_libelle WHERE por_id = prm_por_id;
END;
$$;
COMMENT ON FUNCTION meta_portail_rename(prm_token integer, prm_por_id integer, prm_libelle character varying) IS
'Renomme un portail.';

--
-- meta_portail_duplicate:prm_token:prm_por_id_src:prm_libelle
--
CREATE OR REPLACE FUNCTION meta_portail_duplicate(prm_token integer, prm_por_id_src integer, prm_libelle varchar)
RETURNS integer
LANGUAGE plpgsql
AS $$
DECLARE
  por_id_dest integer;
  tmp_men_id integer;
  tmp_tom_id integer;
  tmp_the_id integer;
  tmp_droits RECORD;
BEGIN
  PERFORM login._token_assert (prm_token, FALSE, FALSE);
  PERFORM login._token_assert_interface (prm_token);
  SELECT * INTO por_id_dest FROM meta.meta_portail_add(
  	                   prm_token, 
			   (SELECT cat_id FROM meta.portail WHERE por_id = prm_por_id_src),
			   prm_libelle);
  FOR tmp_men_id IN SELECT men_id FROM meta.menu WHERE por_id = prm_por_id_src LOOP
    PERFORM meta.meta_menu_duplicate (prm_token, tmp_men_id, por_id_dest);
  END LOOP;
  FOR tmp_tom_id IN SELECT tom_id FROM meta.topmenu WHERE por_id = prm_por_id_src LOOP
    PERFORM meta.meta_topmenu_duplicate (prm_token, tmp_tom_id, por_id_dest);
  END LOOP;
  -- Duplication des themes affectes au portail
  FOR tmp_the_id IN SELECT the_id FROM notes.theme_portail WHERE por_id = prm_por_id_src LOOP
    INSERT INTO notes.theme_portail(the_id, por_id) VALUES (tmp_the_id, por_id_dest);
  END LOOP;
  -- Duplication droit ajout entites sur depuis portail
  FOR tmp_droits IN SELECT ent_code, daj_droit FROM permission.droit_ajout_entite_portail WHERE por_id = prm_por_id_src LOOP
    PERFORM permission.droit_ajout_entite_portail_set(prm_token, tmp_droits.ent_code, por_id_dest, tmp_droits.daj_droit);
  END LOOP;
  RETURN por_id_dest;
END;
$$;

------------------
-- meta.topmenu --
------------------
--
-- meta_topmenu_add_end:prm_token:prm_por_id:prm_libelle 
--
CREATE OR REPLACE FUNCTION meta_topmenu_add_end(prm_token integer, prm_por_id integer, prm_libelle character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer;
	int_ordre integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	SELECT MAX(tom_ordre) + 1 INTO int_ordre FROM meta.topmenu WHERE por_id = prm_por_id;
	IF int_ordre ISNULL THEN int_ordre = 0; END IF;
	INSERT INTO meta.topmenu (por_id, tom_libelle, tom_ordre) VALUES (prm_por_id, prm_libelle, int_ordre)
		RETURNING tom_id INTO ret;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_topmenu_add_end(prm_token integer, prm_por_id integer, prm_libelle character varying) IS
'Ajoute une entrée dans un menu principal.';

--
-- meta_topmenu_delete:prm_token:prm_tom_id
--
CREATE OR REPLACE FUNCTION meta_topmenu_delete(prm_token integer, prm_tom_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	row_tsm meta.topsousmenu;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	FOR row_tsm IN SELECT * FROM meta.topsousmenu WHERE tom_id = prm_tom_id LOOP
		PERFORM meta.meta_topsousmenu_delete (prm_token, row_tsm.tsm_id);
	END LOOP;
	DELETE FROM meta.topmenu WHERE tom_id = prm_tom_id;
END;
$$;
COMMENT ON FUNCTION meta_topmenu_delete(prm_token integer, prm_tom_id integer) IS
'Supprime une entrée dans un menu principal.';

--
-- meta_topmenu_deplacer_bas:prm_token:prm_tom_id
--
CREATE OR REPLACE FUNCTION meta_topmenu_deplacer_bas(prm_token integer, prm_tom_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	PERFORM meta.meta_topmenus_reordonne (prm_token, (SELECT por_id FROM meta.topmenu WHERE tom_id = prm_tom_id));
	IF (SELECT tom_ordre FROM meta.topmenu WHERE tom_id = prm_tom_id) = (SELECT MAX(tom_ordre) FROM meta.topmenu WHERE
	 		por_id = (SELECT por_id FROM meta.topmenu WHERE tom_id = prm_tom_id))
	THEN RETURN; END IF;
	UPDATE meta.topmenu SET tom_ordre = tom_ordre + 1 WHERE tom_id = prm_tom_id;
	UPDATE meta.topmenu SET tom_ordre = tom_ordre - 1 WHERE 
		por_id = (SELECT por_id FROM meta.topmenu WHERE tom_id = prm_tom_id) AND 
		tom_ordre = (SELECT tom_ordre FROM meta.topmenu WHERE tom_id = prm_tom_id) AND
		tom_id <> prm_tom_id;
END;
$$;
COMMENT ON FUNCTION meta_topmenu_deplacer_bas(prm_token integer, prm_tom_id integer) IS
'Déplace une entrée de menu principal vers le bas.';

--
-- meta_topmenu_deplacer_haut:prm_token:prm_tom_id 
--
CREATE OR REPLACE FUNCTION meta_topmenu_deplacer_haut(prm_token integer, prm_tom_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	PERFORM meta.meta_topmenus_reordonne (prm_token, (SELECT por_id FROM meta.topmenu WHERE tom_id = prm_tom_id));
	IF (SELECT tom_ordre FROM meta.topmenu WHERE tom_id = prm_tom_id) = 1 THEN RETURN; END IF;
	UPDATE meta.topmenu SET tom_ordre = tom_ordre - 1 WHERE tom_id = prm_tom_id;
	UPDATE meta.topmenu SET tom_ordre = tom_ordre + 1 WHERE 
		por_id = (SELECT por_id FROM meta.topmenu WHERE tom_id = prm_tom_id) AND 
		tom_ordre = (SELECT tom_ordre FROM meta.topmenu WHERE tom_id = prm_tom_id) AND
		tom_id <> prm_tom_id;
END;
$$;
COMMENT ON FUNCTION meta_topmenu_deplacer_haut(prm_token integer, prm_tom_id integer) IS
'Déplace une entrée de menu principal vers le haut.';

--
-- meta_topmenu_get:prm_token:prm_tom_id
--
CREATE OR REPLACE FUNCTION meta_topmenu_get(prm_token integer, prm_tom_id integer) RETURNS topmenu
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret meta.topmenu;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT * INTO ret FROM meta.topmenu WHERE tom_id = prm_tom_id;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_topmenu_get(prm_token integer, prm_tom_id integer) IS
'Retourne les informations d''une entrée de menu principal (pour webdav).';

--
-- meta_topmenu_liste:prm_token:prm_por_id
--
CREATE OR REPLACE FUNCTION meta_topmenu_liste(prm_token integer, prm_por_id integer) RETURNS SETOF topmenu
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.topmenu%ROWTYPE;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT * FROM meta.topmenu WHERE por_id = prm_por_id ORDER BY tom_ordre 
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_topmenu_liste(prm_token integer, prm_por_id integer) IS
'Retourne la liste des entrées de menu principal d''un portail donné.';

-- 
-- meta_topmenu_liste_contenant_type:prm_token:prm_por_id:prm_type
--
CREATE OR REPLACE FUNCTION meta_topmenu_liste_contenant_type(prm_token integer, prm_por_id integer, prm_type varchar) RETURNS SETOF topmenu
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.topmenu%ROWTYPE;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT topmenu.* FROM meta.topmenu
 	        INNER JOIN meta.topsousmenu USING(tom_id)
		INNER JOIN liste.liste ON liste.lis_id = tsm_type_id
		INNER JOIN meta.entite USING(ent_id)		
	        WHERE tsm_type = 'liste' AND ent_code = prm_type AND por_id = prm_por_id ORDER BY tom_ordre 
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_topmenu_liste_contenant_type(prm_token integer, prm_por_id integer, prm_type varchar) IS
'Retourne la liste des entrées de menu contenant des fiches de type liste pour une catégorie de personne donnée (pour webdav).';

-- 
-- meta_topmenu_events:prm_token:prm_por_id
--
CREATE OR REPLACE FUNCTION meta_topmenu_events(prm_token integer, prm_por_id integer) RETURNS SETOF topmenu
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.topmenu%ROWTYPE;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT topmenu.* FROM meta.topmenu
 	        INNER JOIN meta.topsousmenu USING(tom_id)
	        WHERE tsm_type = 'event' AND por_id = prm_por_id ORDER BY tom_ordre 
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_topmenu_events(prm_token integer, prm_por_id integer) IS
'Retourne la liste des entrées de menu contenant des vues événements (pour webdav).';

--
-- meta_topmenu_rename:prm_token:prm_tom_id:prm_libelle
--
CREATE OR REPLACE FUNCTION meta_topmenu_rename(prm_token integer, prm_tom_id integer, prm_libelle character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE meta.topmenu SET tom_libelle = prm_libelle WHERE tom_id = prm_tom_id;
END;
$$;
COMMENT ON FUNCTION meta_topmenu_rename(prm_token integer, prm_tom_id integer, prm_libelle character varying) IS
'Renomme une entrée de menu principal.';

--
-- meta_topmenus_reordonne:prm_token:prm_por_id
--
CREATE OR REPLACE FUNCTION meta_topmenus_reordonne(prm_token integer, prm_por_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	i integer;
	row RECORD;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	i = 1;
	FOR row IN
		SELECT tom_id FROM meta.topmenu WHERE por_id = prm_por_id ORDER BY tom_ordre
	LOOP
		UPDATE meta.topmenu SET tom_ordre = i WHERE tom_id = row.tom_id;
		i = i + 1;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_topmenus_reordonne(prm_token integer, prm_por_id integer) IS
'Réordonne les entrées du menu principal d''un portail donné.';

--
-- meta_topmenu_duplicate:prm_token:prm_tom_id_src:prm_por_id
--
CREATE OR REPLACE FUNCTION meta_topmenu_duplicate(prm_token integer, prm_tom_id_src integer, prm_por_id integer)
RETURNS integer
LANGUAGE plpgsql
AS $$
DECLARE
  tmp_topmenu meta.topmenu;
  tmp_tsm_id integer;
BEGIN
  SELECT * INTO tmp_topmenu FROM meta.topmenu WHERE tom_id = prm_tom_id_src;
  tmp_topmenu.tom_id = nextval(pg_get_serial_sequence('meta.topmenu', 'tom_id'));
  tmp_topmenu.por_id = prm_por_id;
  INSERT INTO meta.topmenu VALUES (tmp_topmenu.*);
  FOR tmp_tsm_id IN SELECT tsm_id FROM meta.topsousmenu WHERE tom_id = prm_tom_id_src LOOP
    PERFORM meta.meta_topsousmenu_duplicate (prm_token, tmp_tsm_id, tmp_topmenu.tom_id);
  END LOOP;
  RETURN tmp_topmenu.tom_id;
END;
$$;

----------------------
-- meta.topsousmenu --
----------------------
--
--  meta_topsousmenu_add_end:prm_token:prm_tom_id:prm_libelle:prm_icone:prm_type:prm_type_id:prm_titre:prm_droit_modif:prm_droit_suppression
--
CREATE OR REPLACE FUNCTION meta_topsousmenu_add_end(prm_token integer, prm_tom_id integer, prm_libelle character varying, prm_icone character varying, prm_type character varying, prm_type_id integer, prm_titre character varying, prm_droit_modif boolean, prm_droit_suppression boolean) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer;
	int_ordre integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	SELECT MAX(tsm_ordre) + 1 INTO int_ordre FROM meta.topsousmenu WHERE tom_id = prm_tom_id;
	IF int_ordre ISNULL THEN int_ordre = 0; END IF;
	INSERT INTO meta.topsousmenu (tom_id, tsm_libelle, tsm_ordre,tsm_icone, tsm_type, tsm_type_id, tsm_titre, tsm_droit_modif, tsm_droit_suppression) VALUES (prm_tom_id, prm_libelle, int_ordre, prm_icone, prm_type, prm_type_id, prm_titre, prm_droit_modif, prm_droit_suppression)
		RETURNING tsm_id INTO ret;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_topsousmenu_add_end(prm_token integer, prm_tom_id integer, prm_libelle character varying, prm_icone character varying, prm_type character varying, prm_type_id integer, prm_titre character varying, prm_droit_modif boolean, prm_droit_suppression boolean) IS
'Rajoute une fiche de menu principal.';

--
-- meta_topsousmenu_delete:prm_token:prm_tsm_id
--
CREATE OR REPLACE FUNCTION meta_topsousmenu_delete(prm_token integer, prm_tsm_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	DELETE FROM procedure.procedure_affectation WHERE tsm_id = prm_tsm_id;
	DELETE FROM meta.topsousmenu WHERE tsm_id = prm_tsm_id;
END;
$$;
COMMENT ON FUNCTION meta_topsousmenu_delete(prm_token integer, prm_tsm_id integer) IS
'Supprime une fiche de menu principal.';

--
-- meta_topsousmenu_deplacer_bas:prm_token:prm_tsm_id
--
CREATE OR REPLACE FUNCTION meta_topsousmenu_deplacer_bas(prm_token integer, prm_tsm_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	PERFORM meta.meta_topsousmenus_reordonne (prm_token, (SELECT tom_id FROM meta.topsousmenu WHERE tsm_id = prm_tsm_id));
	IF (SELECT tsm_ordre FROM meta.topsousmenu WHERE tsm_id = prm_tsm_id) = (SELECT MAX(tsm_ordre) FROM meta.topsousmenu WHERE
	 		tom_id = (SELECT tom_id FROM meta.topsousmenu WHERE tsm_id = prm_tsm_id))
	THEN RETURN; END IF;
	UPDATE meta.topsousmenu SET tsm_ordre = tsm_ordre + 1 WHERE tsm_id = prm_tsm_id;
	UPDATE meta.topsousmenu SET tsm_ordre = tsm_ordre - 1 WHERE 
		tom_id = (SELECT tom_id FROM meta.topsousmenu WHERE tsm_id = prm_tsm_id) AND 
		tsm_ordre = (SELECT tsm_ordre FROM meta.topsousmenu WHERE tsm_id = prm_tsm_id) AND
		tsm_id <> prm_tsm_id;
END;
$$;
COMMENT ON FUNCTION meta_topsousmenu_deplacer_bas(prm_token integer, prm_tsm_id integer) IS
'Déplace une fiche de menu principal vers le bas.';

--
-- meta_topsousmenu_deplacer_haut:prm_token:prm_tsm_id
--
CREATE OR REPLACE FUNCTION meta_topsousmenu_deplacer_haut(prm_token integer, prm_tsm_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	PERFORM meta.meta_topsousmenus_reordonne (prm_token, (SELECT tom_id FROM meta.topsousmenu WHERE tsm_id = prm_tsm_id));
	IF (SELECT tsm_ordre FROM meta.topsousmenu WHERE tsm_id = prm_tsm_id) = 1 THEN RETURN; END IF;
	UPDATE meta.topsousmenu SET tsm_ordre = tsm_ordre - 1 WHERE tsm_id = prm_tsm_id;
	UPDATE meta.topsousmenu SET tsm_ordre = tsm_ordre + 1 WHERE 
		tom_id = (SELECT tom_id FROM meta.topsousmenu WHERE tsm_id = prm_tsm_id) AND 
		tsm_ordre = (SELECT tsm_ordre FROM meta.topsousmenu WHERE tsm_id = prm_tsm_id) AND
		tsm_id <> prm_tsm_id;
END;
$$;
COMMENT ON FUNCTION meta_topsousmenu_deplacer_haut(prm_token integer, prm_tsm_id integer) IS
'Déplace une fiche de menu principal vers le haut.';

--
-- meta_topsousmenu_get:prm_token:prm_tsm_id
--
CREATE OR REPLACE FUNCTION meta_topsousmenu_get(prm_token integer, prm_tsm_id integer) RETURNS topsousmenu
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret meta.topsousmenu;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT * INTO ret FROM meta.topsousmenu WHERE tsm_id = prm_tsm_id;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_topsousmenu_get(prm_token integer, prm_tsm_id integer) IS
'Retourne les informations d''une fiche de menu principal.';

-- 
-- meta_topsousmenu_liste:prm_token:prm_tom_id
--
CREATE OR REPLACE FUNCTION meta_topsousmenu_liste(prm_token integer, prm_tom_id integer) RETURNS SETOF topsousmenu
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.topsousmenu;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT * FROM meta.topsousmenu WHERE tom_id = prm_tom_id ORDER BY tsm_ordre 
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_topsousmenu_liste(prm_token integer, prm_tom_id integer) IS
'Retourne la liste des fiches d''une entrée de menu principal.';

--
-- meta_topsousmenu_liste_type:prm_token:prm_tom_id:prm_type
--
CREATE OR REPLACE FUNCTION meta_topsousmenu_liste_type(prm_token integer, prm_tom_id integer, prm_type varchar) RETURNS SETOF topsousmenu
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.topsousmenu;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT topsousmenu.* FROM meta.topsousmenu 
		INNER JOIN liste.liste ON liste.lis_id = tsm_type_id
		INNER JOIN meta.entite USING(ent_id)
		WHERE tsm_type = 'liste' AND ent_code = prm_type AND tom_id = prm_tom_id ORDER BY tsm_ordre 
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_topsousmenu_liste_type(prm_token integer, prm_tom_id integer, prm_type varchar) IS
'Retourne la liste des fiches de type liste pour une catégorie de personne donnée d''une entrée de menu principal d''un type donné (webdav).';

--
-- meta_topsousmenu_events:prm_token:prm_tom_id 
--
CREATE OR REPLACE FUNCTION meta_topsousmenu_events(prm_token integer, prm_tom_id integer) RETURNS SETOF topsousmenu
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.topsousmenu;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT topsousmenu.* FROM meta.topsousmenu 
		WHERE tsm_type = 'event' AND tom_id = prm_tom_id ORDER BY tsm_ordre 
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_topsousmenu_events(prm_token integer, prm_tom_id integer) IS
'Retourne la liste des vues événement d''une entrée de menu principal (webdav).';

--
-- meta_topsousmenu_rename:prm_token:prm_tsm_id:prm_libelle 
-- 
CREATE OR REPLACE FUNCTION meta_topsousmenu_rename(prm_token integer, prm_tsm_id integer, prm_libelle character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE meta.topsousmenu SET tsm_libelle = prm_libelle WHERE tsm_id = prm_tsm_id;
END;
$$;
COMMENT ON FUNCTION meta_topsousmenu_rename(prm_token integer, prm_tsm_id integer, prm_libelle character varying) IS
'Renomme une fiche de menu principal.';

--
-- meta_topsousmenu_set_droit_modif:prm_token:prm_id:prm_droit_modif 
--
CREATE OR REPLACE FUNCTION meta_topsousmenu_set_droit_modif(prm_token integer, prm_id integer, prm_droit_modif boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, TRUE);
	UPDATE meta.topsousmenu SET tsm_droit_modif = prm_droit_modif WHERE tsm_id = prm_id;
END;
$$;
COMMENT ON FUNCTION meta_topsousmenu_set_droit_modif(prm_token integer, prm_id integer, prm_droit_modif boolean) IS
'Indique si l''utilisateur a droit de modification sur cette fiche.';

--
-- meta_topsousmenu_set_droit_suppression:prm_token:prm_id:prm_droit_suppression 
--
CREATE OR REPLACE FUNCTION meta_topsousmenu_set_droit_suppression(prm_token integer, prm_id integer, prm_droit_suppression boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, TRUE);
	UPDATE meta.topsousmenu SET tsm_droit_suppression = prm_droit_suppression WHERE tsm_id = prm_id;
END;
$$;
COMMENT ON FUNCTION meta_topsousmenu_set_droit_suppression(prm_token integer, prm_id integer, prm_droit_suppression boolean) IS
'Indique si l''utilisateur a droit de suppression sur cette fiche.';

--
--meta_topsousmenu_update:prm_token:prm_tsm_id:prm_titre:prm_icone:prm_type:prm_type_id:prm_sme_id_lien_usager
--
CREATE OR REPLACE FUNCTION meta_topsousmenu_update(prm_token integer, prm_tsm_id integer, prm_titre character varying, prm_icone character varying, prm_type character varying, prm_type_id integer, prm_sme_id_lien_usager integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE meta.topsousmenu SET tsm_icone = prm_icone, tsm_type = prm_type, tsm_type_id = prm_type_id, tsm_titre = prm_titre, sme_id_lien_usager = prm_sme_id_lien_usager WHERE tsm_id = prm_tsm_id;
END;
$$;
COMMENT ON FUNCTION meta_topsousmenu_update(prm_token integer, prm_tsm_id integer, prm_titre character varying, prm_icone character varying, prm_type character varying, prm_type_id integer, prm_sme_id_lien_usager integer) IS
'Modifie les informations d''une fiche de menu principal.';

--
-- meta_topsousmenus_reordonne:prm_token:prm_tom_id
--
CREATE OR REPLACE FUNCTION meta_topsousmenus_reordonne(prm_token integer, prm_tom_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	i integer;
	row RECORD;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	i = 1;
	FOR row IN
		SELECT tsm_id FROM meta.topsousmenu WHERE tom_id = prm_tom_id ORDER BY tsm_ordre
	LOOP
		UPDATE meta.topsousmenu SET tsm_ordre = i WHERE tsm_id = row.tsm_id;
		i = i + 1;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_topsousmenus_reordonne(prm_token integer, prm_tom_id integer) IS
'Réordonne les fiches d''une entrée de menu principal.';

-- 
-- meta_topsousmenu_duplicate:prm_token:prm_tsm_id_src:prm_tom_id
--
CREATE OR REPLACE FUNCTION meta_topsousmenu_duplicate(prm_token integer, prm_tsm_id_src integer, prm_tom_id integer)
RETURNS integer
LANGUAGE plpgsql
AS $$
DECLARE
  tmp_topsousmenu meta.topsousmenu;
BEGIN
  SELECT * INTO tmp_topsousmenu FROM meta.topsousmenu WHERE tsm_id = prm_tsm_id_src;
  tmp_topsousmenu.tsm_id = nextval(pg_get_serial_sequence('meta.topsousmenu', 'tsm_id'));
  tmp_topsousmenu.tom_id = prm_tom_id;
  INSERT INTO meta.topsousmenu VALUES (tmp_topsousmenu.*);
  RETURN tmp_topsousmenu.tsm_id;
END;
$$;

---------------
-- meta.menu --
---------------
--
-- meta_menu_add_end:prm_token:prm_por_id:prm_libelle:prm_ent_id
--
CREATE OR REPLACE FUNCTION meta_menu_add_end(prm_token integer, prm_por_id integer, prm_libelle character varying, prm_ent_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer;
	int_ordre integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	SELECT MAX(men_ordre) + 1 INTO int_ordre FROM meta.menu WHERE por_id = prm_por_id AND ent_id = prm_ent_id;
	IF int_ordre ISNULL THEN int_ordre = 0; END IF;
	INSERT INTO meta.menu(por_id, men_libelle, men_ordre, ent_id) VALUES (prm_por_id, prm_libelle, int_ordre, prm_ent_id) RETURNING men_id INTO ret;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_menu_add_end(prm_token integer, prm_por_id integer, prm_libelle character varying, prm_ent_id integer) IS
'Ajoute une entrée de menu à un portail pour un type de personne.';

--
-- meta_menu_delete:prm_token:prm_men_id
--
CREATE OR REPLACE FUNCTION meta_menu_delete(prm_token integer, prm_men_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	row_sme meta.sousmenu;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	FOR row_sme IN SELECT * FROM meta.sousmenu WHERE men_id = prm_men_id LOOP
		PERFORM meta.meta_sousmenu_delete (prm_token, row_sme.sme_id);
	END LOOP;
	DELETE FROM meta.menu WHERE men_id = prm_men_id;
END;
$$;
COMMENT ON FUNCTION meta_menu_delete(prm_token integer, prm_men_id integer) IS
'Supprime une entrée de menu.';

--
-- meta_menu_deplacer_bas:prm_token:prm_men_id
--
CREATE OR REPLACE FUNCTION meta_menu_deplacer_bas(prm_token integer, prm_men_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	PERFORM meta.meta_menus_reordonne (prm_token,
					   (SELECT por_id FROM meta.menu WHERE men_id = prm_men_id),
					   (SELECT ent_id FROM meta.menu WHERE men_id = prm_men_id) );
	IF (SELECT men_ordre FROM meta.menu WHERE men_id = prm_men_id) = (SELECT MAX(men_ordre) FROM meta.menu WHERE
	 		por_id = (SELECT por_id FROM meta.menu WHERE men_id = prm_men_id) AND 
			ent_id = (SELECT ent_id FROM meta.menu WHERE men_id = prm_men_id))
	THEN RETURN; END IF;
	UPDATE meta.menu SET men_ordre = men_ordre + 1 WHERE men_id = prm_men_id;
	UPDATE meta.menu SET men_ordre = men_ordre - 1 WHERE 
		por_id = (SELECT por_id FROM meta.menu WHERE men_id = prm_men_id) AND 
		ent_id = (SELECT ent_id FROM meta.menu WHERE men_id = prm_men_id) AND 
		men_ordre = (SELECT men_ordre FROM meta.menu WHERE men_id = prm_men_id) AND
		men_id <> prm_men_id;
END;
$$;
COMMENT ON FUNCTION meta_menu_deplacer_bas(prm_token integer, prm_men_id integer) IS
'Déplace une entrée de menu vers le bas.';

--
-- meta_menu_deplacer_haut:prm_token:prm_men_id
--
CREATE OR REPLACE FUNCTION meta_menu_deplacer_haut(prm_token integer, prm_men_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	PERFORM meta.meta_menus_reordonne (prm_token,
					   (SELECT por_id FROM meta.menu WHERE men_id = prm_men_id),
					   (SELECT ent_id FROM meta.menu WHERE men_id = prm_men_id) );
	IF (SELECT men_ordre FROM meta.menu WHERE men_id = prm_men_id) = 1 THEN RETURN; END IF;
	UPDATE meta.menu SET men_ordre = men_ordre - 1 WHERE men_id = prm_men_id;
	UPDATE meta.menu SET men_ordre = men_ordre + 1 WHERE 
		por_id = (SELECT por_id FROM meta.menu WHERE men_id = prm_men_id) AND 
		ent_id = (SELECT ent_id FROM meta.menu WHERE men_id = prm_men_id) AND 
		men_ordre = (SELECT men_ordre FROM meta.menu WHERE men_id = prm_men_id) AND
		men_id <> prm_men_id;
END;
$$;
COMMENT ON FUNCTION meta_menu_deplacer_haut(prm_token integer, prm_men_id integer) IS
'Déplace une entrée de menu vers le haut.';

--
-- meta_menu_infos:prm_token:prm_men_id
--
CREATE OR REPLACE FUNCTION meta_menu_infos(prm_token integer, prm_men_id integer) RETURNS menu
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret meta.menu%ROWTYPE;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT * INTO ret FROM meta.menu WHERE men_id = prm_men_id;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_menu_infos(prm_token integer, prm_men_id integer) IS
'Retourne les informations d''une entrée de menu de fiche personne.';

--
-- meta_menu_liste:prm_token:prm_por_id:prm_ent_code
--
CREATE OR REPLACE FUNCTION meta_menu_liste(prm_token integer, prm_por_id integer, prm_ent_code character varying) RETURNS SETOF menu
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.menu%ROWTYPE;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT * FROM meta.menu WHERE por_id = prm_por_id AND ent_id = (SELECT ent_id FROM meta.entite WHERE ent_code = prm_ent_code) ORDER BY men_ordre 
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_menu_liste(prm_token integer, prm_por_id integer, prm_ent_code character varying) IS
'Retourne la liste des menus pour un portail et un type de personne donnés.';

DROP FUNCTION IF EXISTS meta_menu_liste_recursif(prm_token integer, prm_por_id integer, prm_ent_code character varying);
DROP TYPE IF EXISTS meta.meta_menu_liste_recursif;
CREATE TYPE meta.meta_menu_liste_recursif AS (
  men_id integer,
  men_libelle varchar,
  sme_id integer,
  sme_libelle varchar
);

--
-- meta_menu_liste_recursif:prm_token:prm_por_id:prm_ent_code
--
CREATE OR REPLACE FUNCTION meta_menu_liste_recursif(prm_token integer, prm_por_id integer, prm_ent_code character varying) RETURNS SETOF meta.meta_menu_liste_recursif
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.meta_menu_liste_recursif;
	row2 meta.meta_menu_liste_recursif;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT men_id, men_libelle, null, null FROM meta.menu WHERE por_id = prm_por_id AND ent_id = (SELECT ent_id FROM meta.entite WHERE ent_code = prm_ent_code) ORDER BY men_ordre 
	LOOP
		RETURN NEXT row;
		FOR row2 IN		
		  SELECT null, null, sme_id, sme_libelle FROM meta.sousmenu WHERE men_id = row.men_id ORDER BY sme_ordre 
		LOOP
		  RETURN NEXT row2;
		END LOOP;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_menu_liste_recursif(prm_token integer, prm_por_id integer, prm_ent_code character varying) IS
'Retourne les identifiants et noms des menus et sous-menus pour un portail et un type de personne donnés.';

--
-- meta_menu_rename:prm_token:prm_men_id:prm_libelle
--
CREATE OR REPLACE FUNCTION meta_menu_rename(prm_token integer, prm_men_id integer, prm_libelle character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE meta.menu SET men_libelle = prm_libelle WHERE men_id = prm_men_id;
END;
$$;
COMMENT ON FUNCTION meta_menu_rename(prm_token integer, prm_men_id integer, prm_libelle character varying) IS
'Renomme une entrée de menu.';

--
-- meta_menu_un_seul_niveau:prm_token:prm_por_id:prm_ent_code
--
CREATE OR REPLACE FUNCTION meta_menu_un_seul_niveau(prm_token integer, prm_por_id integer, prm_ent_code character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret boolean;
	mens meta.menu;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR mens IN 
		SELECT men_id FROM meta.menu WHERE por_id = prm_por_id AND ent_id = (SELECT ent_id FROM meta.entite WHERE ent_code = prm_ent_code)
	LOOP
		IF (SELECT COUNT(*) FROM meta.sousmenu WHERE men_id = mens.men_id) > 1 THEN
			RETURN FALSE;
		END IF;
	END LOOP;
	RETURN TRUE;
END;
$$;
COMMENT ON FUNCTION meta_menu_un_seul_niveau(prm_token integer, prm_por_id integer, prm_ent_code character varying) IS
'Retourne TRUE si le menu d''une fiche personne est à un seul niveau.';

--
-- meta_menus_reordonne:prm_token:prm_por_id:prm_ent_id
--
CREATE OR REPLACE FUNCTION meta_menus_reordonne(prm_token integer, prm_por_id integer, prm_ent_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	i integer;
	row RECORD;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	i = 1;
	FOR row IN
		SELECT men_id FROM meta.menu WHERE por_id = prm_por_id AND ent_id = prm_ent_id ORDER BY men_ordre
	LOOP
		UPDATE meta.menu SET men_ordre = i WHERE men_id = row.men_id;
		i = i + 1;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_menus_reordonne(prm_token integer, prm_por_id integer, prm_ent_id integer) IS
'Réordonne les entrées de menu d''un portail pour un type de personne.';

--
-- meta_menus_supprime_recursif:prm_token:prm_ent_code:prm_por_id
--
CREATE OR REPLACE FUNCTION meta_menus_supprime_recursif(prm_token integer, prm_ent_code character varying, prm_por_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	DELETE FROM meta.info_groupe WHERE gin_id IN (SELECT gin_id FROM meta.groupe_infos WHERE sme_id IN (SELECT sme_id FROM meta.sousmenu WHERE men_id IN (SELECT men_id FROM meta.menu WHERE ent_id = (SELECT ent_id FROM meta.entite WHERE ent_code = prm_ent_code) AND por_id = prm_por_id)));
	DELETE FROM meta.groupe_infos WHERE sme_id IN (SELECT sme_id FROM meta.sousmenu WHERE men_id IN (SELECT men_id FROM meta.menu WHERE ent_id = (SELECT ent_id FROM meta.entite WHERE ent_code = prm_ent_code) AND por_id = prm_por_id));
	DELETE FROM meta.sousmenu WHERE men_id IN (SELECT men_id FROM meta.menu WHERE ent_id = (SELECT ent_id FROM meta.entite WHERE ent_code = prm_ent_code) AND por_id = prm_por_id);
	DELETE FROM meta.menu WHERE ent_id = (SELECT ent_id FROM meta.entite WHERE ent_code = prm_ent_code) AND por_id = prm_por_id;
END;
$$;
COMMENT ON FUNCTION meta_menus_supprime_recursif(prm_token integer, prm_ent_code character varying, prm_por_id integer) IS
'Supprime un menu de fiche personne et toutes ses fiches.';

-------------------
-- meta.sousmenu --
-------------------
--
-- meta_sousmenu_add_end:prm_token:prm_men_id:prm_libelle:prm_type:prm_type_id:prm_droit_modif:prm_droit_suppression:prm_icone
--
CREATE OR REPLACE FUNCTION meta_sousmenu_add_end(prm_token integer, prm_men_id integer, prm_libelle character varying, prm_type varchar, prm_type_id integer, prm_droit_modif boolean, prm_droit_suppression boolean, prm_icone varchar) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer;
	int_ordre integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	SELECT MAX(sme_ordre) + 1 INTO int_ordre FROM meta.sousmenu WHERE men_id = prm_men_id;
	IF int_ordre ISNULL THEN int_ordre = 0; END IF;
	INSERT INTO meta.sousmenu(men_id, sme_libelle, sme_ordre, sme_type, sme_type_id, sme_droit_modif, sme_droit_suppression, sme_icone) VALUES (prm_men_id, prm_libelle, int_ordre, prm_type, prm_type_id, prm_droit_modif, prm_droit_suppression, prm_icone) RETURNING sme_id INTO ret;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_sousmenu_add_end(prm_token integer, prm_men_id integer, prm_libelle character varying, prm_type varchar, prm_type_id integer, prm_droit_modif boolean, prm_droit_suppression boolean, prm_icone varchar) IS
'Ajoute une fiche à un menu personne.';

--
-- meta_sousmenu_delete:prm_token:prm_sme_id 
--
CREATE OR REPLACE FUNCTION meta_sousmenu_delete(prm_token integer, prm_sme_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	row_gin meta.groupe_infos;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	FOR row_gin IN
		SELECT * FROM meta.groupe_infos WHERE sme_id = prm_sme_id 
	LOOP
		PERFORM meta.meta_groupe_infos_delete(prm_token, row_gin.gin_id);
	END LOOP;
	DELETE FROM procedure.procedure_affectation WHERE sme_id = prm_sme_id;
	DELETE FROM meta.sousmenu WHERE sme_id = prm_sme_id;
END;
$$;
COMMENT ON FUNCTION meta_sousmenu_delete(prm_token integer, prm_sme_id integer) IS
'Supprime une fiche d''un menu personne.';

--
-- meta_sousmenu_deplacer_bas:prm_token:prm_sme_id
--
CREATE OR REPLACE FUNCTION meta_sousmenu_deplacer_bas(prm_token integer, prm_sme_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	PERFORM meta.meta_sousmenus_reordonne (prm_token, (SELECT men_id FROM meta.sousmenu WHERE sme_id = prm_sme_id));
	IF (SELECT sme_ordre FROM meta.sousmenu WHERE sme_id = prm_sme_id) = (SELECT MAX(sme_ordre) FROM meta.sousmenu WHERE
	 		men_id = (SELECT men_id FROM meta.sousmenu WHERE sme_id = prm_sme_id))
	THEN RETURN; END IF;
	UPDATE meta.sousmenu SET sme_ordre = sme_ordre + 1 WHERE sme_id = prm_sme_id;
	UPDATE meta.sousmenu SET sme_ordre = sme_ordre - 1 WHERE 
		men_id = (SELECT men_id FROM meta.sousmenu WHERE sme_id = prm_sme_id) AND 
		sme_ordre = (SELECT sme_ordre FROM meta.sousmenu WHERE sme_id = prm_sme_id) AND
		sme_id <> prm_sme_id;
END;
$$;
COMMENT ON FUNCTION meta_sousmenu_deplacer_bas(prm_token integer, prm_sme_id integer) IS
'Déplace vers le bas une fiche d''un menu personne.';

--
-- meta_sousmenu_deplacer_haut:prm_token:prm_sme_id 
--
CREATE OR REPLACE FUNCTION meta_sousmenu_deplacer_haut(prm_token integer, prm_sme_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	PERFORM meta.meta_sousmenus_reordonne (prm_token, (SELECT men_id FROM meta.sousmenu WHERE sme_id = prm_sme_id));
	IF (SELECT sme_ordre FROM meta.sousmenu WHERE sme_id = prm_sme_id) = 1 THEN RETURN; END IF;
	UPDATE meta.sousmenu SET sme_ordre = sme_ordre - 1 WHERE sme_id = prm_sme_id;
	UPDATE meta.sousmenu SET sme_ordre = sme_ordre + 1 WHERE 
		men_id = (SELECT men_id FROM meta.sousmenu WHERE sme_id = prm_sme_id) AND 
		sme_ordre = (SELECT sme_ordre FROM meta.sousmenu WHERE sme_id = prm_sme_id) AND
		sme_id <> prm_sme_id;
END;
$$;
COMMENT ON FUNCTION meta_sousmenu_deplacer_haut(prm_token integer, prm_sme_id integer) IS
'Déplace vers le haut une fiche d''un menu personne.';

--
-- meta_sousmenu_infos:prm_token:prm_sme_id
--
CREATE OR REPLACE FUNCTION meta_sousmenu_infos(prm_token integer, prm_sme_id integer) RETURNS sousmenu
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret meta.sousmenu%ROWTYPE;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT * INTO ret FROM meta.sousmenu WHERE sme_id = prm_sme_id;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_sousmenu_infos(prm_token integer, prm_sme_id integer) IS
'Retourne les informations sur une fiche d''un menu personne.';

--
-- meta_sousmenu_liste:prm_token:prm_men_id
--
CREATE OR REPLACE FUNCTION meta_sousmenu_liste(prm_token integer, prm_men_id integer) RETURNS SETOF sousmenu
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.sousmenu%ROWTYPE;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT * FROM meta.sousmenu WHERE men_id = prm_men_id ORDER BY sme_ordre 
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_sousmenu_liste(prm_token integer, prm_men_id integer) IS
'Retourne la liste des fiches d''un menu personne.';

--
-- meta_sousmenu_rename:prm_token:prm_sme_id:prm_libelle
--
CREATE OR REPLACE FUNCTION meta_sousmenu_rename(prm_token integer, prm_sme_id integer, prm_libelle character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE meta.sousmenu SET sme_libelle = prm_libelle WHERE sme_id = prm_sme_id;
END;
$$;
COMMENT ON FUNCTION meta_sousmenu_rename(prm_token integer, prm_sme_id integer, prm_libelle character varying) IS
'Renomme une fiche de menu personne.';

--
-- meta_sousmenu_set_droit_modif:prm_token:prm_id:prm_droit_modif
--
CREATE OR REPLACE FUNCTION meta_sousmenu_set_droit_modif(prm_token integer, prm_id integer, prm_droit_modif boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, TRUE);
	UPDATE meta.sousmenu SET sme_droit_modif = prm_droit_modif WHERE sme_id = prm_id;
END;
$$;
COMMENT ON FUNCTION meta_sousmenu_set_droit_modif(prm_token integer, prm_id integer, prm_droit_modif boolean) IS
'Indique si l''utilisateur a droit de modification sur cette fiche.';

--
-- meta_sousmenu_set_droit_suppression:prm_token:prm_id:prm_droit_suppression
--
CREATE OR REPLACE FUNCTION meta_sousmenu_set_droit_suppression(prm_token integer, prm_id integer, prm_droit_suppression boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, TRUE);
	UPDATE meta.sousmenu SET sme_droit_suppression = prm_droit_suppression WHERE sme_id = prm_id;
END;
$$;
COMMENT ON FUNCTION meta_sousmenu_set_droit_suppression(prm_token integer, prm_id integer, prm_droit_suppression boolean) IS
'Indique si l''utilisateur a droit de suppression sur cette fiche.';

--
-- meta_sousmenu_set_type:prm_token:prm_sme_id:prm_type:prm_type_id:prm_icone
--
CREATE OR REPLACE FUNCTION meta_sousmenu_set_type(prm_token integer, prm_sme_id integer, prm_type character varying, prm_type_id integer, prm_icone varchar) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE meta.sousmenu SET sme_type = prm_type, sme_type_id = prm_type_id, sme_icone = prm_icone WHERE sme_id = prm_sme_id;
END;
$$;
COMMENT ON FUNCTION meta_sousmenu_set_type(prm_token integer, prm_sme_id integer, prm_type character varying, prm_type_id integer, prm_icone varchar) IS
'Modifie le type d''une fiche de menu personne.';

--
-- meta_sousmenus_reordonne:prm_token:prm_men_id
--
CREATE OR REPLACE FUNCTION meta_sousmenus_reordonne(prm_token integer, prm_men_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
	i integer;
	row RECORD;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	i = 1;
	FOR row IN
		SELECT sme_id FROM meta.sousmenu WHERE men_id = prm_men_id ORDER BY sme_ordre
	LOOP
		UPDATE meta.sousmenu SET sme_ordre = i WHERE sme_id = row.sme_id;
		i = i + 1;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_sousmenus_reordonne(prm_token integer, prm_men_id integer) IS
'Réordonne des fiches m''un menu personne.';

