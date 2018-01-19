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


