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
-- Copyright (c) 2014-2016 Kavarna SARL
--
-- SCHEMA meta
--
-- Module: Portals
--
-- Dependences: Entities
--
-- categorie
--
SET search_path = meta, pg_catalog;

CREATE TABLE categorie (
    cat_id serial PRIMARY KEY,
    cat_nom character varying,
    cat_code character varying
);
COMMENT ON TABLE categorie IS 'Catégorie d''établissement';

--
-- portail
--
CREATE TABLE portail (
    por_id serial PRIMARY KEY,
    cat_id integer REFERENCES meta.categorie,
    por_libelle character varying
);
COMMENT ON TABLE portail IS 'Liste des portails';
CREATE INDEX fki_portail_cat_id_fkey ON portail USING btree (cat_id);

--
-- topmenu
--
CREATE TABLE topmenu (
    tom_id serial PRIMARY KEY,
    tom_libelle character varying,
    tom_ordre integer,
    por_id integer REFERENCES meta.portail
);
COMMENT ON TABLE topmenu IS 'Menu principal';
CREATE INDEX fki_topmenu_por_id_fkey ON topmenu USING btree (por_id);

--
-- topsousmenu
--
CREATE TABLE topsousmenu (
    tsm_id serial PRIMARY KEY,
    tom_id integer REFERENCES meta.topmenu,
    tsm_libelle character varying,
    tsm_ordre integer,
    tsm_icone character varying,
    tsm_script character varying,
    tsm_type character varying,
    tsm_type_id integer, -- TODO
    tsm_titre character varying,
    tsm_droit_modif boolean DEFAULT true,
    tsm_droit_suppression boolean DEFAULT true,
    sme_id_lien_usager integer -- TODO
);
COMMENT ON TABLE topsousmenu IS 'Sous-menus du menu principal';
CREATE INDEX fki_topsousmenu_tom_id_fkey ON topsousmenu USING btree (tom_id);

--
-- menu
--
CREATE TABLE menu (
    men_id serial PRIMARY KEY,
    men_libelle character varying,
    men_ordre integer,
    ent_id integer REFERENCES meta.entite,
    por_id integer REFERENCES meta.portail
);
COMMENT ON TABLE menu IS 'Menu du dialogue d''édition d''une personne';
CREATE INDEX fki_menu_ent_id_fkey ON menu USING btree (ent_id);
CREATE INDEX fki_menu_por_id_fkey ON menu USING btree (por_id);

--
-- sousmenu
--
CREATE TABLE sousmenu (
    sme_id serial PRIMARY KEY,
    men_id integer REFERENCES meta.menu,
    sme_libelle character varying,
    sme_ordre integer,
    sme_type character varying,
    sme_type_id integer, -- TODO
    sme_droit_modif boolean DEFAULT true,
    sme_droit_suppression boolean DEFAULT true,
    sme_icone character varying
);
COMMENT ON TABLE sousmenu IS 'Sous-menu du dialogue d''édition d''une personne';
-- TODO index men_id
