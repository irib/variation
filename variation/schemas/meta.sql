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
DROP FUNCTION IF EXISTS meta_info_groupe_obligatoire_liste(prm_por_id integer, prm_ent_code varchar);
DROP FUNCTION IF EXISTS meta_info_groupe_liste(prm_gin_id integer);
DROP FUNCTION IF EXISTS meta_info_groupe_obligatoire_liste(prm_por_id integer, prm_ent_code varchar);
DROP FUNCTION IF EXISTS meta_sousmenus_liste_depuis_topmenu(prm_tom_id integer, prm_ent_code character varying);
DROP FUNCTION IF EXISTS metier_liste_details(prm_ent_id integer, prm_sec_id integer);
DROP FUNCTION IF EXISTS aide_enreg(prm_code character varying, prm_contenu text);
DROP FUNCTION IF EXISTS aide_get(prm_code character varying);
DROP FUNCTION IF EXISTS meta_adminsousmenu_liste();
DROP FUNCTION IF EXISTS meta_categorie_add(prm_nom character varying, prm_code character varying);
DROP FUNCTION IF EXISTS meta_categorie_delete(prm_cat_id integer);
DROP FUNCTION IF EXISTS meta_categorie_get(prm_code character varying);
DROP FUNCTION IF EXISTS meta_categorie_liste();
DROP FUNCTION IF EXISTS meta_categorie_rename(prm_cat_id integer, prm_nom character varying);
DROP FUNCTION IF EXISTS meta_dirinfo_add(prm_din_id_parent integer, prm_libelle character varying);
DROP FUNCTION IF EXISTS meta_dirinfo_add_avec_id(prm_id integer, prm_din_id_parent integer, prm_libelle character varying);
DROP FUNCTION IF EXISTS meta_dirinfo_delete(prm_din_id integer);
DROP FUNCTION IF EXISTS meta_dirinfo_dernier ();
DROP FUNCTION IF EXISTS meta_dirinfo_list(prm_din_id_parent integer);
DROP FUNCTION IF EXISTS meta_dirinfo_move(prm_din_id integer, prm_din_id_parent integer);
DROP FUNCTION IF EXISTS meta_dirinfo_update(prm_din_id integer, prm_libelle character varying);
DROP FUNCTION IF EXISTS meta_entite_infos_par_code(prm_code character varying);
DROP FUNCTION IF EXISTS meta_entite_liste();
DROP FUNCTION IF EXISTS meta_groupe_infos_add(prm_sme_id integer, prm_libelle character varying, prm_ordre integer);
DROP FUNCTION IF EXISTS meta_groupe_infos_add_end(prm_sme_id integer, prm_libelle character varying);
DROP FUNCTION IF EXISTS meta_groupe_infos_delete(prm_gin_id integer);
DROP FUNCTION IF EXISTS meta_groupe_infos_liste(prm_sme_id integer);
DROP FUNCTION IF EXISTS meta_groupe_infos_update(prm_gin_id integer, prm_ordre integer);
DROP FUNCTION IF EXISTS meta_info_add(prm_int_id integer, prm_code character varying, prm_libelle character varying, prm_etendu boolean, prm_historique boolean, prm_multiple boolean);
DROP FUNCTION IF EXISTS meta_info_add(prm_int_id integer, prm_code character varying, prm_libelle character varying, prm_libelle_complet character varying, prm_etendu boolean, prm_historique boolean, prm_multiple boolean);
DROP FUNCTION IF EXISTS meta_info_add_avec_id(prm_inf_id integer, prm_int_id integer, prm_code character varying, prm_libelle character varying, prm__textelong_nblignes integer, prm__selection_code integer, prm_etendu boolean, prm_historique boolean, prm_multiple boolean, prm__groupe_type character varying, prm__contact_filtre character varying, prm__metier_secteur character varying, prm__contact_secteur character varying, prm__etablissement_interne boolean, prm_din_id integer,   prm__groupe_soustype integer, prm_libelle_complet character varying, prm__date_echeance boolean, prm__date_echeance_icone character varying, prm__date_echeance_secteur character varying, prm__etablissement_secteur character varying);
DROP FUNCTION IF EXISTS meta_info_aide_get(prm_inf_id integer);
DROP FUNCTION IF EXISTS meta_info_aide_set(prm_inf_id integer, prm_aide text);
DROP FUNCTION IF EXISTS meta_info_dernier ();
DROP FUNCTION IF EXISTS meta_info_get(prm_inf_id integer);
DROP FUNCTION IF EXISTS meta.meta_infos_formule_update(prm_inf_id integer, prm_formule text);
DROP FUNCTION IF EXISTS meta_info_get_par_code(prm_inf_code character varying);
DROP FUNCTION IF EXISTS meta_info_get_type_par_code(prm_code character varying);
DROP FUNCTION IF EXISTS meta_info_groupe_add(prm_inf_code character varying, prm_gin_id integer, prm_gin_ordre integer);
DROP FUNCTION IF EXISTS meta_info_groupe_add_by_id(prm_inf_id integer, prm_gin_id integer, prm_gin_ordre integer);
DROP FUNCTION IF EXISTS meta_info_groupe_add_end(prm_inf_code character varying, prm_gin_id integer);
DROP FUNCTION IF EXISTS meta_info_groupe_add_end(prm_inf_code character varying, prm_gin_id integer, prm__groupe_cycle boolean);
DROP FUNCTION IF EXISTS meta_categorie_add(prm_nom character varying);
DROP FUNCTION IF EXISTS meta_info_groupe_delete(prm_ing_id integer);
DROP FUNCTION IF EXISTS meta_info_groupe_get(prm_ing_id integer);
DROP FUNCTION IF EXISTS meta_info_groupe_update(prm_ing_id integer, prm_gin_id integer, prm_ordre integer);
DROP FUNCTION IF EXISTS meta_info_liste();
DROP FUNCTION IF EXISTS meta_info_liste(str character varying);
DROP FUNCTION IF EXISTS meta_info_liste(str character varying, usedonly boolean);
DROP FUNCTION IF EXISTS meta_info_liste_champs_par_secteur_categorie(prm_cat_id integer, prm_sec_code character varying);
DROP FUNCTION IF EXISTS meta_info_move(prm_inf_id integer, prm_din_id integer);
DROP FUNCTION IF EXISTS meta_info_update(prm_inf_id integer, prm_int_id integer, prm_code character varying, prm_libelle character varying, prm_libelle_complet character varying, prm_etendu boolean, prm_historique boolean, prm_multiple boolean);
DROP FUNCTION IF EXISTS meta_info_usage (prm_inf_id integer);
DROP FUNCTION IF EXISTS meta_infos_contact_update(prm_inf_id integer, prm_filtre character varying, prm_secteur character varying);
DROP FUNCTION IF EXISTS meta_infos_date_update(prm_inf_id integer, prm__date_echeance boolean, prm__date_echeance_icone character varying, prm__date_echeance_secteur character varying);
DROP FUNCTION IF EXISTS meta_infos_etablissement_update(prm_inf_id integer, prm_interne boolean, prm__etablissement_secteur character varying);
DROP FUNCTION IF EXISTS meta_infos_groupe_update(prm_inf_id integer, prm_type character varying, prm_soustype integer);
DROP FUNCTION IF EXISTS meta_infos_metier_update(prm_inf_id integer, prm_secteur character varying);
DROP FUNCTION IF EXISTS meta_infos_selection_update(prm_inf_id integer, prm_code integer); 
DROP FUNCTION IF EXISTS meta_infos_selection_update_non_utilise(prm_inf_id integer, prm_code character varying);
DROP FUNCTION IF EXISTS meta_infos_textelong_update(prm_inf_id integer, prm_nblignes integer);
DROP FUNCTION IF EXISTS meta_infos_type_liste();
DROP FUNCTION IF EXISTS meta_ing__groupe_cycle_set(prm_ing_id integer, prm_val boolean);
DROP FUNCTION IF EXISTS meta_ing_obligatoire_set(prm_ing_id integer, prm_val boolean);
DROP FUNCTION IF EXISTS meta_lien_familial_get(prm_lfa_id integer);
DROP FUNCTION IF EXISTS meta_lien_familial_cherche(prm_lfa_nom varchar);
DROP FUNCTION IF EXISTS meta_lien_familial_liste();
DROP FUNCTION IF EXISTS meta_menu_add(prm_cat_id integer, prm_libelle character varying, prm_ordre integer, prm_ent_id integer);
DROP FUNCTION IF EXISTS meta_menu_add_end(prm_por_id integer, prm_libelle character varying, prm_ent_id integer);
DROP FUNCTION IF EXISTS meta_menu_delete(prm_men_id integer);
DROP FUNCTION IF EXISTS meta_menu_deplacer_bas(prm_men_id integer);
DROP FUNCTION IF EXISTS meta_menu_deplacer_haut(prm_men_id integer);
DROP FUNCTION IF EXISTS meta_menu_infos(prm_men_id integer);
DROP FUNCTION IF EXISTS meta_menu_liste(prm_por_id integer, prm_ent_code character varying);
DROP FUNCTION IF EXISTS meta_menu_rename(prm_men_id integer, prm_libelle character varying);
DROP FUNCTION IF EXISTS meta_menu_un_seul_niveau(prm_por_id integer, prm_ent_code character varying);
DROP FUNCTION IF EXISTS meta_menus_reordonne(prm_por_id integer, prm_ent_id integer);
DROP FUNCTION IF EXISTS meta_menus_supprime_recursif(prm_ent_code character varying, prm_por_id integer);
DROP FUNCTION IF EXISTS meta_portail_add(prm_cat_id integer, prm_libelle character varying);
DROP FUNCTION IF EXISTS meta_portail_delete(prm_por_id integer);
DROP FUNCTION IF EXISTS meta_portail_delete_rec(prm_por_id integer);
DROP FUNCTION IF EXISTS meta_portail_purge(prm_por_id integer);
DROP FUNCTION IF EXISTS meta_portail_get(prm_cat_id integer, prm_por_id integer);
DROP FUNCTION IF EXISTS meta_portail_get_old(prm_cat_id integer, prm_libelle character varying);
DROP FUNCTION IF EXISTS meta_portail_infos(prm_por_id integer);
DROP FUNCTION IF EXISTS meta_portail_liste(prm_cat_id integer);
DROP FUNCTION IF EXISTS meta_portail_liste_libelles();
DROP FUNCTION IF EXISTS meta_portail_rename(prm_por_id integer, prm_libelle character varying);
DROP FUNCTION IF EXISTS meta_rootsousmenu_liste();
DROP FUNCTION IF EXISTS meta_secteur_get(prm_sec_id integer);
DROP FUNCTION IF EXISTS meta_secteur_get_par_code(prm_sec_code character varying);
DROP FUNCTION IF EXISTS meta_secteur_liste();
DROP FUNCTION IF EXISTS meta_secteur_liste(prm_est_prise_en_charge boolean);
DROP FUNCTION IF EXISTS meta_secteur_liste_par_eta(prm_eta_id integer);
DROP FUNCTION IF EXISTS meta_secteur_save(prm_code character varying, prm_nom character varying);
DROP FUNCTION IF EXISTS meta_secteur_save(prm_code character varying, prm_nom character varying, prm_icone varchar);
DROP FUNCTION IF EXISTS meta_secteur_type_add(prm_sec_id integer, prm_nom character varying);
DROP FUNCTION IF EXISTS meta_secteur_type_delete(prm_set_id integer);
DROP FUNCTION IF EXISTS meta_secteur_type_liste(prm_sec_id integer);
DROP FUNCTION IF EXISTS meta_secteur_type_liste_par_code(prm_sec_code character varying);
DROP FUNCTION IF EXISTS meta_secteur_type_update(prm_set_id integer, prm_nom character varying);
DROP FUNCTION IF EXISTS meta_selection_add(prm_code character varying, prm_libelle character varying, prm_info character varying);
DROP FUNCTION IF EXISTS meta_selection_add_avec_id(prm_id integer, prm_code character varying, prm_libelle character varying, prm_info character varying);
DROP FUNCTION IF EXISTS meta_selection_dernier ();
DROP FUNCTION IF EXISTS meta_selection_entree_add(prm_sel_id integer, prm_libelle character varying, prm_ordre integer);
DROP FUNCTION IF EXISTS meta_selection_entree_get(prm_sen_id integer);
DROP FUNCTION IF EXISTS meta_selection_entree_get_par_valeur(prm_sel_id integer, prm_libelle character varying);
DROP FUNCTION IF EXISTS meta_selection_entree_liste(prm_sel_id integer);
DROP FUNCTION IF EXISTS meta_selection_entree_liste_par_cha(prm_cha_id integer);
DROP FUNCTION IF EXISTS meta_selection_entree_liste_par_code(prm_sel_code character varying);
DROP FUNCTION IF EXISTS meta_selection_entree_set_ordre(prm_sen_id integer, prm_ordre integer);
DROP FUNCTION IF EXISTS meta_selection_entree_supprime(prm_sen_id integer);
DROP FUNCTION IF EXISTS meta_selection_infos(prm_sel_id integer);
DROP FUNCTION IF EXISTS meta_selection_infos_par_code(prm_sel_code character varying);
DROP FUNCTION IF EXISTS meta_selection_liste();
DROP FUNCTION IF EXISTS meta_selection_truncate();
DROP FUNCTION IF EXISTS meta_selection_update(prm_sel_id integer, prm_code character varying, prm_libelle character varying, prm_info character varying);
DROP FUNCTION IF EXISTS meta_sousmenu_add(prm_men_id integer, prm_libelle character varying, prm_ordre integer);
DROP FUNCTION IF EXISTS meta_sousmenu_add_end(prm_men_id integer, prm_libelle character varying);
DROP FUNCTION IF EXISTS meta_sousmenu_add_end(prm_men_id integer, prm_libelle character varying, prm_type varchar, prm_type_id integer, prm_droit_modif boolean, prm_droit_suppression boolean);
DROP FUNCTION IF EXISTS meta_sousmenu_add_end(prm_men_id integer, prm_libelle character varying, prm_type varchar, prm_type_id integer, prm_droit_modif boolean, prm_droit_suppression boolean, prm_icone varchar);
DROP FUNCTION IF EXISTS meta_sousmenu_delete(prm_sme_id integer);
DROP FUNCTION IF EXISTS meta_sousmenu_deplacer_bas(prm_sme_id integer);
DROP FUNCTION IF EXISTS meta_sousmenu_deplacer_haut(prm_sme_id integer);
DROP FUNCTION IF EXISTS meta_sousmenu_infos(prm_sme_id integer);
DROP FUNCTION IF EXISTS meta_sousmenu_liste(prm_men_id integer);
DROP FUNCTION IF EXISTS meta_sousmenu_rename(prm_sme_id integer, prm_libelle character varying);
DROP FUNCTION IF EXISTS meta_sousmenu_set_droit_modif(prm_id integer, prm_droit_modif boolean);
DROP FUNCTION IF EXISTS meta_sousmenu_set_droit_suppression(prm_id integer, prm_droit_suppression boolean);
DROP FUNCTION IF EXISTS meta_sousmenu_set_type(prm_sme_id integer, prm_type character varying, prm_type_id integer);
DROP FUNCTION IF EXISTS meta_sousmenu_set_type(prm_sme_id integer, prm_type character varying, prm_type_id integer, prm_icone varchar);
DROP FUNCTION IF EXISTS meta_sousmenus_reordonne(prm_men_id integer);
DROP FUNCTION IF EXISTS meta_topmenu_add(prm_cat_id integer, prm_libelle character varying, prm_ordre integer);
DROP FUNCTION IF EXISTS meta_topmenu_add_end(prm_por_id integer, prm_libelle character varying);
DROP FUNCTION IF EXISTS meta_topmenu_delete(prm_tom_id integer);
DROP FUNCTION IF EXISTS meta_topmenu_deplacer_bas(prm_tom_id integer);
DROP FUNCTION IF EXISTS meta_topmenu_deplacer_haut(prm_tom_id integer);
DROP FUNCTION IF EXISTS meta_topmenu_get(prm_tom_id integer);
DROP FUNCTION IF EXISTS meta_topmenu_liste(prm_por_id integer);
DROP FUNCTION IF EXISTS meta_topmenu_liste_contenant_type(prm_por_id integer, prm_type varchar);
DROP FUNCTION IF EXISTS meta_topmenu_rename(prm_tom_id integer, prm_libelle character varying);
DROP FUNCTION IF EXISTS meta_topmenus_reordonne(prm_por_id integer);
DROP FUNCTION IF EXISTS meta_topsousmenu_add(prm_tom_id integer, prm_libelle character varying, prm_ordre integer, prm_icone character varying, prm_script character varying);
DROP FUNCTION IF EXISTS meta.meta_topsousmenu_add_end(prm_tom_id integer, prm_libelle character varying, prm_icone character varying, prm_type character varying, prm_type_id integer, prm_titre character varying);
DROP FUNCTION IF EXISTS meta_topsousmenu_add_end(prm_tom_id integer, prm_libelle character varying, prm_icone character varying, prm_script character varying);
DROP FUNCTION IF EXISTS meta_topsousmenu_add_end(prm_tom_id integer, prm_libelle character varying, prm_icone character varying, prm_type character varying, prm_type_id integer, prm_titre character varying, prm_droit_modif boolean, prm_droit_suppression boolean);
DROP FUNCTION IF EXISTS meta_topsousmenu_delete(prm_tsm_id integer);
DROP FUNCTION IF EXISTS meta_topsousmenu_deplacer_bas(prm_tsm_id integer);
DROP FUNCTION IF EXISTS meta_topsousmenu_deplacer_haut(prm_tsm_id integer);
DROP FUNCTION IF EXISTS meta_topsousmenu_get(prm_tsm_id integer);
DROP FUNCTION IF EXISTS meta_topsousmenu_liste(prm_tom_id integer);
DROP FUNCTION IF EXISTS meta_topsousmenu_liste_type(prm_tom_id integer, prm_type varchar);
DROP FUNCTION IF EXISTS meta_topsousmenu_rename(prm_tsm_id integer, prm_libelle character varying);
DROP FUNCTION IF EXISTS meta_topsousmenu_set_droit_modif(prm_id integer, prm_droit_modif boolean);
DROP FUNCTION IF EXISTS meta_topsousmenu_set_droit_suppression(prm_id integer, prm_droit_suppression boolean);
DROP FUNCTION IF EXISTS meta_topsousmenu_update(prm_tsm_id integer, prm_icone character varying, prm_script character varying);
DROP FUNCTION IF EXISTS meta_topsousmenu_update(prm_tsm_id integer, prm_titre character varying, prm_icone character varying, prm_type character varying, prm_type_id integer, prm_sme_id_lien_usager integer);
DROP FUNCTION IF EXISTS meta_topsousmenus_reordonne(prm_tom_id integer);
DROP FUNCTION IF EXISTS meta_truncate();
DROP FUNCTION IF EXISTS metier_add(prm_nom character varying);
DROP FUNCTION IF EXISTS metier_entite_liste(prm_met_id integer);
DROP FUNCTION IF EXISTS metier_entites_set(prm_met_id integer, prm_entites character varying[]);
DROP FUNCTION IF EXISTS metier_get(prm_met_id integer);
DROP FUNCTION IF EXISTS metier_liste(prm_ent_code character varying);
DROP FUNCTION IF EXISTS metier_secteur_liste(prm_met_id integer);
DROP FUNCTION IF EXISTS metier_secteur_metier_liste(prm_sec_id integer);
DROP FUNCTION IF EXISTS metier_secteurs_set(prm_met_id integer, prm_secteurs character varying[]);
DROP FUNCTION IF EXISTS metier_supprime(prm_met_id integer);
DROP FUNCTION IF EXISTS metier_update(prm_met_id integer, prm_nom character varying);
DROP FUNCTION IF EXISTS topmenu_truncate();
DROP FUNCTION IF EXISTS meta._tmp_numerote_sousmenus();
DROP FUNCTION IF EXISTS meta._tmp_numerote_topsousmenus();

--
-- Suppression anciennes fonctions
--
DROP FUNCTION IF EXISTS meta_adminsousmenu_liste(prm_token integer);
DROP FUNCTION IF EXISTS meta_info_groupe_add_end(prm_token integer, prm_inf_code character varying, prm_gin_id integer, prm__groupe_cycle boolean);
DROP FUNCTION IF EXISTS meta_info_liste(prm_token integer, str character varying, usedonly boolean);
DROP FUNCTION IF EXISTS meta_rootsousmenu_liste(prm_token integer);

--
--
--
DROP FUNCTION IF EXISTS meta_info_groupe_obligatoire_liste(prm_token integer, prm_por_id integer, prm_ent_code varchar);
DROP FUNCTION IF EXISTS meta_info_groupe_liste(prm_token integer, prm_gin_id integer);
DROP TYPE IF EXISTS meta_info_groupe_liste;
CREATE TYPE meta_info_groupe_liste AS (
	ing_id integer,
	ing_ordre integer,
        ing__groupe_cycle boolean,
        ing_obligatoire boolean,
	inf_id integer,
	int_id integer,
	inf_code character varying,
	inf_libelle character varying,
	inf__textelong_nblignes integer,
	inf__selection_code integer,
	inf_etendu boolean,
	inf_historique boolean,
	inf_multiple boolean,
	inf__groupe_type character varying,
	inf__contact_filtre character varying,
	inf__metier_secteur character varying,
	inf__contact_secteur character varying,
	inf__etablissement_interne boolean,
	din_id integer,
	inf__groupe_soustype integer,
    	inf_libelle_complet character varying,
    	inf__date_echeance boolean,
    	inf__date_echeance_icone character varying,
    	inf__date_echeance_secteur character varying,
    	inf__etablissement_secteur character varying,
	inf_formule text
);

CREATE OR REPLACE FUNCTION meta_info_groupe_liste(prm_token integer, prm_gin_id integer) RETURNS SETOF meta_info_groupe_liste
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.meta_info_groupe_liste%ROWTYPE;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT info_groupe.ing_id, info_groupe.ing_ordre, info_groupe.ing__groupe_cycle, info_groupe.ing_obligatoire, info.* FROM meta.info
		INNER JOIN meta.info_groupe USING(inf_id) WHERE gin_id = prm_gin_id ORDER BY ing_ordre 
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_info_groupe_liste(prm_token integer, prm_gin_id integer) IS
'Retourne les informations sur les champs affectés à un groupe de champs (dont les caractéristiques d''affectation).';

CREATE FUNCTION meta_info_groupe_obligatoire_liste(prm_token integer, prm_por_id integer, prm_ent_code varchar) RETURNS SETOF meta_info_groupe_liste 
       LANGUAGE plpgsql
       AS $$
DECLARE
	row meta.meta_info_groupe_liste%ROWTYPE;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
	    SELECT info_groupe.ing_id, info_groupe.ing_ordre, info_groupe.ing__groupe_cycle, info_groupe.ing_obligatoire, info.* 
    	    FROM meta.info
	    INNER JOIN meta.info_groupe USING(inf_id) 
	    INNER JOIN meta.groupe_infos USING(gin_id)
	    INNER JOIN meta.sousmenu USING(sme_id)
	    INNER JOIN meta.menu USING(men_id)
	    INNER JOIN meta.entite USING(ent_id)
	    WHERE por_id = prm_por_id AND ent_code = prm_ent_code AND ing_obligatoire ORDER BY men_ordre, sme_ordre, gin_ordre, ing_ordre 
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_info_groupe_obligatoire_liste(prm_token integer, prm_por_id integer, prm_ent_code varchar) IS
'Retourne les informations sur les champs obligatoires à la création d''une personne d''un type donné sur un portail donné.';

DROP FUNCTION IF EXISTS meta_sousmenus_liste_depuis_topmenu(prm_token integer, prm_tom_id integer, prm_ent_code character varying);
DROP TYPE IF EXISTS meta_sousmenus_liste_depuis_topmenu;
CREATE TYPE meta_sousmenus_liste_depuis_topmenu AS (
	men_id integer,
	men_libelle character varying,
	sme_id integer,
	sme_libelle character varying
);

CREATE OR REPLACE FUNCTION meta_sousmenus_liste_depuis_topmenu(prm_token integer, prm_tom_id integer, prm_ent_code character varying) RETURNS SETOF meta_sousmenus_liste_depuis_topmenu
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.meta_sousmenus_liste_depuis_topmenu;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	FOR row IN SELECT men_id, menu.men_libelle, sousmenu.sme_id, sousmenu.sme_libelle FROM meta.sousmenu
		INNER JOIN meta.menu USING(men_id) 
		WHERE ent_id = (SELECT ent_id FROM meta.entite WHERE ent_code = prm_ent_code)
		  AND por_id = (SELECT por_id FROM meta.topmenu WHERE tom_id = prm_tom_id)
		  ORDER BY men_ordre, sme_ordre
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_sousmenus_liste_depuis_topmenu(prm_token integer, prm_tom_id integer, prm_ent_code character varying) IS
'Retourne la liste des fiches d''un type de personne accessible dans un portail.';

DROP FUNCTION IF EXISTS metier_liste_details(prm_token integer, prm_ent_id integer, prm_sec_id integer);
DROP TYPE IF EXISTS metier_liste_details;
CREATE TYPE metier_liste_details AS (
	met_id integer,
	met_nom character varying,
	secteurs character varying,
	entites character varying
);

CREATE OR REPLACE FUNCTION metier_liste_details(prm_token integer, prm_ent_id integer, prm_sec_id integer) RETURNS SETOF metier_liste_details
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.metier_liste_details;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT met_id, met_nom, concatenate (DISTINCT sec_nom), concatenate (DISTINCT ent_libelle)
		FROM meta.metier
		LEFT JOIN meta.metier_secteur USING(met_id)
		LEFT JOIN meta.secteur USING(sec_id)
		LEFT JOIN meta.metier_entite USING(met_id)
		LEFT JOIN meta.entite USING(ent_id)
		WHERE (prm_ent_id ISNULL OR ent_id = prm_ent_id)
		AND (prm_sec_id ISNULL OR sec_id = prm_sec_id)
		GROUP BY met_id, met_nom
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION metier_liste_details(prm_token integer, prm_ent_id integer, prm_sec_id integer) IS
'Retourne la liste détaillée des métiers affectés à un type de personne et assignés à un secteur donné.';

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

CREATE OR REPLACE FUNCTION meta_dirinfo_delete(prm_token integer, prm_din_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	DELETE FROM meta.dirinfo WHERE din_id = prm_din_id;
END;
$$;

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

CREATE OR REPLACE FUNCTION meta_dirinfo_move(prm_token integer, prm_din_id integer, prm_din_id_parent integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE meta.dirinfo SET din_id_parent = prm_din_id_parent WHERE din_id = prm_din_id;
END;
$$;

CREATE OR REPLACE FUNCTION meta_dirinfo_update(prm_token integer, prm_din_id integer, prm_libelle character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE meta.dirinfo SET din_libelle = prm_libelle WHERE din_id = prm_din_id;
END;
$$;

CREATE OR REPLACE FUNCTION meta_entite_infos_par_code(prm_token integer, prm_code character varying) RETURNS entite
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret meta.entite%ROWTYPE;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT * INTO ret FROM meta.entite WHERE ent_code = prm_code;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_entite_infos_par_code(prm_token integer, prm_code character varying) IS
'Retourne les informations sur un type de personne.';

CREATE OR REPLACE FUNCTION meta_entite_liste(prm_token integer) RETURNS SETOF entite
    LANGUAGE plpgsql
    AS $$
DECLARE
	row RECORD;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT * FROM meta.entite ORDER BY ent_id
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_entite_liste(prm_token integer) IS
'Retourne la liste des types de personnes.';

CREATE OR REPLACE FUNCTION meta_groupe_infos_add_end(prm_token integer, prm_sme_id integer, prm_libelle character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	int_ordre integer;
	ret integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	SELECT MAX(gin_ordre) + 1 INTO int_ordre FROM meta.groupe_infos WHERE sme_id = prm_sme_id;
	IF int_ordre ISNULL THEN int_ordre = 0; END IF;
	INSERT INTO meta.groupe_infos(sme_id, gin_libelle, gin_ordre) VALUES (prm_sme_id, prm_libelle, int_ordre) RETURNING gin_id INTO ret;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_groupe_infos_add_end(prm_token integer, prm_sme_id integer, prm_libelle character varying) IS
'Ajoute un groupe de champs à la fin d''une page de champs.';

CREATE OR REPLACE FUNCTION meta_groupe_infos_delete(prm_token integer, prm_gin_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	DELETE FROM meta.info_groupe WHERE gin_id = prm_gin_id;
	DELETE FROM meta.groupe_infos WHERE gin_id = prm_gin_id;
END;
$$;
COMMENT ON FUNCTION meta_groupe_infos_delete(prm_token integer, prm_gin_id integer) IS
'Supprime un groupe de champs.';

CREATE OR REPLACE FUNCTION meta_groupe_infos_liste(prm_token integer, prm_sme_id integer) RETURNS SETOF groupe_infos
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.groupe_infos%ROWTYPE;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT * FROM meta.groupe_infos WHERE sme_id = prm_sme_id ORDER BY gin_ordre 
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_groupe_infos_liste(prm_token integer, prm_sme_id integer) IS
'Retourne la liste des groupes de champs d''une page de champs.';

CREATE OR REPLACE FUNCTION meta_groupe_infos_update(prm_token integer, prm_gin_id integer, prm_ordre integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE meta.groupe_infos SET 
		gin_ordre = prm_ordre
		WHERE gin_id = prm_gin_id;
END;
$$;
COMMENT ON FUNCTION meta_groupe_infos_update(prm_token integer, prm_gin_id integer, prm_ordre integer) IS
'Modifie l''ordre d''apparition d''un groupe de champs.';

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

CREATE OR REPLACE FUNCTION meta_info_aide_get(prm_token integer, prm_inf_id integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret text;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	SELECT ina_aide INTO ret FROM meta.info_aide WHERE inf_id = prm_inf_id;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_info_aide_get(prm_token integer, prm_inf_id integer) IS
'Retourne le message d''aide d''un champ.';

CREATE OR REPLACE FUNCTION meta_info_aide_set(prm_token integer, prm_inf_id integer, prm_aide text) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	IF prm_aide ISNULL THEN
		DELETE FROM meta.info_aide WHERE inf_id = prm_inf_id;
	ELSE
		UPDATE meta.info_aide SET ina_aide = prm_aide WHERE inf_id = prm_inf_id;
		IF NOT FOUND THEN
			INSERT INTO meta.info_aide (inf_id, ina_aide) VALUES (prm_inf_id, prm_aide);
		END IF;
	END IF;
END;
$$;
COMMENT ON FUNCTION meta_info_aide_set(prm_token integer, prm_inf_id integer, prm_aide text) IS
'Modifie le message d''aide d''un champ.';

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

CREATE OR REPLACE FUNCTION meta_info_groupe_add_by_id(prm_token integer, prm_inf_id integer, prm_gin_id integer, prm_gin_ordre integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	INSERT INTO meta.info_groupe (inf_id, gin_id, ing_ordre) VALUES 
		(prm_inf_id, prm_gin_id, prm_gin_ordre)
		RETURNING ing_id INTO ret;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_info_groupe_add_by_id(prm_token integer, prm_inf_id integer, prm_gin_id integer, prm_gin_ordre integer) IS
'Ajoute un champ à une page (en le rajoutant à un groupe de champs).';

CREATE OR REPLACE FUNCTION meta_info_groupe_add_end(prm_token integer, prm_inf_code character varying, prm_gin_id integer, prm__groupe_cycle boolean, prm_obligatoire boolean) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer;
	int_ordre integer;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	SELECT MAX(ing_ordre) + 1 INTO int_ordre FROM meta.info_groupe WHERE gin_id = prm_gin_id;
	IF int_ordre ISNULL THEN int_ordre = 0; END IF;
	INSERT INTO meta.info_groupe (inf_id, gin_id, ing_ordre, ing__groupe_cycle, ing_obligatoire) VALUES 
		((SELECT inf_id FROM meta.info WHERE inf_code = prm_inf_code), prm_gin_id, int_ordre, prm__groupe_cycle, prm_obligatoire)
		RETURNING ing_id INTO ret;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_info_groupe_add_end(prm_token integer, prm_inf_code character varying, prm_gin_id integer, prm__groupe_cycle boolean, prm_obligatoire boolean) IS
'Ajoute un champ à un groupe de champs, en le plaçant à la fin.';

CREATE OR REPLACE FUNCTION meta_info_groupe_delete(prm_token integer, prm_ing_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	DELETE FROM meta.info_groupe where ing_id = prm_ing_id;
END;
$$;
COMMENT ON FUNCTION meta_info_groupe_delete(prm_token integer, prm_ing_id integer) IS
'Retire un champ d''un groupe de champs.';

CREATE OR REPLACE FUNCTION meta_info_groupe_get(prm_token integer, prm_ing_id integer) RETURNS info_groupe
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.info_groupe;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT * INTO row FROM meta.info_groupe WHERE ing_id = prm_ing_id;
	RETURN row;
END;
$$;
COMMENT ON FUNCTION meta_info_groupe_get(prm_token integer, prm_ing_id integer) IS
'Retourne les caractéristiques de l''affectation d''un champ à un groupe.';

CREATE OR REPLACE FUNCTION meta_info_groupe_update(prm_token integer, prm_ing_id integer, prm_gin_id integer, prm_ordre integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE meta.info_groupe SET gin_id = prm_gin_id, ing_ordre = prm_ordre WHERE ing_id = prm_ing_id;
END;
$$;
COMMENT ON FUNCTION meta_info_groupe_update(prm_token integer, prm_ing_id integer, prm_gin_id integer, prm_ordre integer)IS
'Modifie les informations d''affectation d''un champ à un groupe.';

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


CREATE OR REPLACE FUNCTION meta_info_liste_champs_par_secteur_categorie(prm_token integer, prm_cat_id integer, prm_sec_code character varying) RETURNS SETOF info
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.info;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		select distinct info.* FROM meta.info 
		inner join meta.infos_type using(int_id)
		inner join meta.info_groupe using(inf_id)
		inner join meta.groupe_infos using(gin_id)
		inner join meta.sousmenu using(sme_id)
		inner join meta.menu using(men_id)
		inner join meta.portail using(por_id)
		where int_code = 'groupe' 
		AND cat_id = prm_cat_id
		AND inf__groupe_type = prm_sec_code
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_info_liste_champs_par_secteur_categorie(prm_token integer, prm_cat_id integer, prm_sec_code character varying) IS 'Retourne la liste des champs de type "groupe" couvrant le secteur donné affectés dans une fiche du portail';

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

CREATE OR REPLACE FUNCTION meta_ing__groupe_cycle_set(prm_token integer, prm_ing_id integer, prm_val boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE meta.info_groupe SET ing__groupe_cycle = prm_val WHERE ing_id = prm_ing_id;
END;
$$;
COMMENT ON FUNCTION meta_ing__groupe_cycle_set(prm_token integer, prm_ing_id integer, prm_val boolean) IS
'Indique si un champ de type "groupe" utilise le cycle.';

CREATE OR REPLACE FUNCTION meta_ing_obligatoire_set(prm_token integer, prm_ing_id integer, prm_val boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	PERFORM login._token_assert_interface (prm_token);
	UPDATE meta.info_groupe SET ing_obligatoire = prm_val WHERE ing_id = prm_ing_id;
END;
$$;
COMMENT ON FUNCTION meta_ing_obligatoire_set(prm_token integer, prm_ing_id integer, prm_val boolean) IS
'Indique si un champ doit être rempli à la création d''une personne.';

CREATE OR REPLACE FUNCTION meta_lien_familial_get(prm_token integer, prm_lfa_id integer) RETURNS lien_familial
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret meta.lien_familial;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT * INTO ret FROM meta.lien_familial WHERE lfa_id = prm_lfa_id;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_lien_familial_get(prm_token integer, prm_lfa_id integer) IS
'Retourne les informations d''un lien familial.';

CREATE OR REPLACE FUNCTION meta_lien_familial_cherche(prm_token integer, prm_lfa_nom varchar) RETURNS lien_familial
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret meta.lien_familial;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT * INTO ret FROM meta.lien_familial WHERE lfa_nom ilike prm_lfa_nom;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_lien_familial_cherche(prm_token integer, prm_lfa_nom varchar) IS
'Recherche un lien familial par son nom.';

CREATE OR REPLACE FUNCTION meta_lien_familial_liste(prm_token integer) RETURNS SETOF lien_familial
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.lien_familial;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT * FROM meta.lien_familial ORDER BY lfa_nom
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_lien_familial_liste(prm_token integer) IS
'Retourne la liste des liens familiaux.';

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

DROP FUNCTION IF EXISTS meta_secteur_save(prm_token integer, prm_code character varying, prm_nom character varying);
DROP FUNCTION IF EXISTS meta_secteur_save(prm_token integer, prm_code character varying, prm_nom character varying, prm_icone varchar);
CREATE OR REPLACE FUNCTION meta_secteur_save(prm_token integer, prm_code character varying, prm_nom character varying, prm_icone varchar, prm_couleur text) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, TRUE);
	UPDATE meta.secteur SET sec_nom = prm_nom, sec_icone = prm_icone, sec_couleur = prm_couleur WHERE sec_code = prm_code;
END;
$$;
COMMENT ON FUNCTION meta_secteur_save(prm_token integer, prm_code character varying, prm_nom character varying, prm_icone varchar, prm_couleur text) IS
'Modifie les informations d''un secteur.';

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

CREATE OR REPLACE FUNCTION meta_statut_usager_calcule(prm_inf_code character varying, prm_per_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer;
	pin integer;
	pii integer;
BEGIN
	SELECT pin_id INTO pin FROM personne_info WHERE inf_code = prm_inf_code AND per_id = prm_per_id;
	IF NOT FOUND THEN
		INSERT INTO personne_info (inf_code, per_id) VALUES (prm_inf_code, prm_per_id) RETURNING pin_id INTO pin;
	END IF;

	SELECT pii_id INTO pii FROM personne_info_integer WHERE pin_id = pin;
	IF NOT FOUND THEN
		INSERT INTO personne_info_integer (pin_id) VALUES (pin) RETURNING pii_id INTO pii;
	END IF;

	ret = 5;
	IF EXISTS (SELECT 1 FROM personne_groupe WHERE per_id = prm_per_id AND peg_cycle_statut = 3) THEN -- Terminé
		ret = 1; -- Sorti
	END IF;
	IF EXISTS (SELECT 1 FROM personne_groupe WHERE per_id = prm_per_id AND peg_cycle_statut = 1) THEN -- Demandé
		ret = 2; -- Pré-admission
	END IF;
	IF EXISTS (SELECT 1 FROM personne_groupe WHERE per_id = prm_per_id AND peg_cycle_statut = 2 AND (peg_debut ISNULL OR peg_debut > CURRENT_TIMESTAMP)) THEN -- Accepté, pas encore présent
		ret = 3; -- Admission
	END IF;
	IF EXISTS (SELECT 1 FROM personne_groupe WHERE per_id = prm_per_id AND peg_cycle_statut = 2 AND (peg_debut ISNULL OR peg_debut < CURRENT_TIMESTAMP)) THEN -- Accepté, présent
		ret = 4; -- Présent
	END IF;

	UPDATE personne_info_integer SET pii_valeur = ret WHERE pii_id = pii;
--	RAISE WARNING 'statut % : %', prm_per_id, ret;
	RETURN ret;
END;
$$;

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

CREATE OR REPLACE FUNCTION metier_add(prm_token integer, prm_nom character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret integer;
BEGIN
	PERFORM login._token_assert (prm_token, TRUE, FALSE);
	INSERT INTO meta.metier (met_nom) VALUES (prm_nom) RETURNING met_id INTO ret;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION metier_add(prm_token integer, prm_nom character varying) IS
'Ajoute un métier.';

CREATE OR REPLACE FUNCTION metier_entite_liste(prm_token integer, prm_met_id integer) RETURNS SETOF entite
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.entite;
BEGIN
	PERFORM login._token_assert (prm_token, TRUE, FALSE);
	FOR row IN
		SELECT entite.* FROM meta.entite
		INNER JOIN meta.metier_entite USING(ent_id)
		WHERE met_id = prm_met_id
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION metier_entite_liste(prm_token integer, prm_met_id integer) IS
'Retourne la liste des types de personnes auxquels est affecté un métier.';

CREATE OR REPLACE FUNCTION metier_entites_set(prm_token integer, prm_met_id integer, prm_entites character varying[]) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, TRUE, FALSE);
	DELETE FROM meta.metier_entite WHERE met_id = prm_met_id;
	IF prm_entites NOTNULL THEN
		FOR i IN 1 .. array_upper(prm_entites, 1) LOOP
			INSERT INTO meta.metier_entite (met_id, ent_id) VALUES (prm_met_id, (SELECT ent_id FROM meta.entite WHERE ent_code = prm_entites[i]));
		END LOOP;
	END IF;
END;
$$;
COMMENT ON FUNCTION metier_entites_set(prm_token integer, prm_met_id integer, prm_entites character varying[]) IS
'Affecte un métier à des types de personnes.';

CREATE OR REPLACE FUNCTION metier_get(prm_token integer, prm_met_id integer) RETURNS metier
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret meta.metier;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT * INTO ret FROM meta.metier WHERE met_id = prm_met_id;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION metier_get(prm_token integer, prm_met_id integer) IS
'Retourne les informations d''un métier.';

CREATE OR REPLACE FUNCTION metier_liste(prm_token integer, prm_ent_code character varying) RETURNS SETOF metier
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.metier;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT metier.* FROM meta.metier 
			INNER JOIN meta.metier_entite USING(met_id)
			INNER JOIN meta.entite USING(ent_id) 
			WHERE ent_code = prm_ent_code
			ORDER BY metier.met_nom
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION metier_liste(prm_token integer, prm_ent_code character varying) IS
'Retourne la liste des métiers affectés à un type de personne.';

CREATE OR REPLACE FUNCTION metier_secteur_liste(prm_token integer, prm_met_id integer) RETURNS SETOF secteur
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.secteur;
BEGIN
	PERFORM login._token_assert (prm_token, TRUE, FALSE);
	FOR row IN
		SELECT secteur.* FROM meta.secteur
		INNER JOIN meta.metier_secteur USING(sec_id)
		WHERE met_id = prm_met_id
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION metier_secteur_liste(prm_token integer, prm_met_id integer) IS
'Retourne la liste des secteurs assignés à un métier.';

CREATE OR REPLACE FUNCTION metier_secteur_metier_liste(prm_token integer, prm_sec_id integer) RETURNS SETOF metier
    LANGUAGE plpgsql
    AS $$
DECLARE
	row meta.metier;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT metier.* FROM meta.metier
		INNER JOIN meta.metier_secteur USING(met_id)
		WHERE sec_id = prm_sec_id
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION metier_secteur_metier_liste(prm_token integer, prm_sec_id integer) IS
'Retourne la liste des métiers assignés à un secteur donné.';

CREATE OR REPLACE FUNCTION metier_secteurs_set(prm_token integer, prm_met_id integer, prm_secteurs character varying[]) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, TRUE, FALSE);
	DELETE FROM meta.metier_secteur WHERE met_id = prm_met_id;
	IF prm_secteurs NOTNULL THEN
		FOR i IN 1 .. array_upper(prm_secteurs, 1) LOOP
			INSERT INTO meta.metier_secteur (met_id, sec_id) VALUES (prm_met_id, (SELECT sec_id FROM meta.secteur WHERE sec_code = prm_secteurs[i]));
		END LOOP;
	END IF;
END;
$$;
COMMENT ON FUNCTION metier_secteurs_set(prm_token integer, prm_met_id integer, prm_secteurs character varying[]) IS
'Assigne des secteurs à un métier.';

CREATE OR REPLACE FUNCTION metier_supprime(prm_token integer, prm_met_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, TRUE, FALSE);
	DELETE FROM meta.metier_secteur WHERE met_id = prm_met_id;
	DELETE FROM meta.metier_entite WHERE met_id = prm_met_id;
	DELETE FROM meta.metier WHERE met_id = prm_met_id;
END;
$$;
COMMENT ON FUNCTION metier_supprime(prm_token integer, prm_met_id integer) IS
'Supprime un métier.';

CREATE OR REPLACE FUNCTION metier_update(prm_token integer, prm_met_id integer, prm_nom character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	PERFORM login._token_assert (prm_token, TRUE, FALSE);
	UPDATE meta.metier SET met_nom = prm_nom WHERE met_id = prm_met_id;
END;
$$;
COMMENT ON FUNCTION metier_update(prm_token integer, prm_met_id integer, prm_nom character varying) IS
'Modifie les informations d''un métier.';

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

CREATE OR REPLACE FUNCTION meta_menu_duplicate(prm_token integer, prm_men_id_src integer, prm_por_id integer)
RETURNS integer
LANGUAGE plpgsql
AS $$
DECLARE
  tmp_menu meta.menu;
  tmp_sme_id integer;
BEGIN
  SELECT * INTO tmp_menu FROM meta.menu WHERE men_id = prm_men_id_src;
  tmp_menu.men_id = nextval(pg_get_serial_sequence('meta.menu', 'men_id'));
  tmp_menu.por_id = prm_por_id;
  INSERT INTO meta.menu VALUES (tmp_menu.*);
  FOR tmp_sme_id IN SELECT sme_id FROM meta.sousmenu WHERE men_id = prm_men_id_src LOOP
    PERFORM meta.meta_sousmenu_duplicate (prm_token, tmp_sme_id, tmp_menu.men_id);
  END LOOP;
  RETURN tmp_menu.men_id;
END;
$$;

CREATE OR REPLACE FUNCTION meta_sousmenu_duplicate(prm_token integer, prm_sme_id_src integer, prm_men_id integer)
RETURNS integer
LANGUAGE plpgsql
AS $$
DECLARE
  tmp_sousmenu meta.sousmenu;
  tmp_gin_id integer;
BEGIN
  SELECT * INTO tmp_sousmenu FROM meta.sousmenu WHERE sme_id = prm_sme_id_src;
  tmp_sousmenu.sme_id = nextval(pg_get_serial_sequence('meta.sousmenu', 'sme_id'));
  tmp_sousmenu.men_id = prm_men_id;
  INSERT INTO meta.sousmenu VALUES (tmp_sousmenu.*);
  FOR tmp_gin_id IN SELECT gin_id FROM meta.groupe_infos WHERE sme_id = prm_sme_id_src LOOP
    PERFORM meta.meta_groupe_infos_duplicate (prm_token, tmp_gin_id, tmp_sousmenu.sme_id);
  END LOOP;
  RETURN tmp_sousmenu.sme_id;
END;
$$;

CREATE OR REPLACE FUNCTION meta_groupe_infos_duplicate(prm_token integer, prm_gin_id_src integer, prm_sme_id integer)
RETURNS integer
LANGUAGE plpgsql
AS $$
DECLARE
  tmp_groupe_infos meta.groupe_infos;
  tmp_ing_id integer;
BEGIN
  SELECT * INTO tmp_groupe_infos FROM meta.groupe_infos WHERE gin_id = prm_gin_id_src;
  tmp_groupe_infos.gin_id = nextval(pg_get_serial_sequence('meta.groupe_infos', 'gin_id'));
  tmp_groupe_infos.sme_id = prm_sme_id;
  INSERT INTO meta.groupe_infos VALUES (tmp_groupe_infos.*);
  FOR tmp_ing_id IN SELECT ing_id FROM meta.info_groupe WHERE gin_id = prm_gin_id_src LOOP
   PERFORM meta.meta_info_groupe_duplicate (prm_token, tmp_ing_id, tmp_groupe_infos.gin_id);
  END LOOP;
  RETURN tmp_groupe_infos.gin_id;
END;
$$;

CREATE OR REPLACE FUNCTION meta_info_groupe_duplicate(prm_token integer, prm_ing_id_src integer, prm_gin_id integer)
RETURNS integer
LANGUAGE plpgsql
AS $$
DECLARE
  tmp_info_groupe meta.info_groupe;
BEGIN
  SELECT * INTO tmp_info_groupe FROM meta.info_groupe WHERE ing_id = prm_ing_id_src;
  tmp_info_groupe.ing_id = nextval(pg_get_serial_sequence('meta.info_groupe', 'ing_id'));
  tmp_info_groupe.gin_id = prm_gin_id;
  INSERT INTO meta.info_groupe VALUES (tmp_info_groupe.*);
  RETURN tmp_info_groupe.ing_id;
END;
$$;

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
