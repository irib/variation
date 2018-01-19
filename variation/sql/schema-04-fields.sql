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
-- Module: Fields
--
-- Dependences: Topics
--
-- selection
--
SET search_path = meta, pg_catalog;

CREATE TABLE selection (
    sel_id serial PRIMARY KEY,
    sel_code character varying UNIQUE,
    sel_libelle character varying,
    sel_info character varying
);
COMMENT ON TABLE selection IS 'Liste des sélection (pour les champs sélection d''édition des personnes)';

--
-- selection_entree
--
CREATE TABLE selection_entree (
    sen_id serial PRIMARY KEY,
    sel_id integer REFERENCES meta.selection,
    sen_libelle character varying,
    sen_ordre integer
);
COMMENT ON TABLE selection_entree IS 'Valeurs des listes de sélection';
-- TODO index sel_id

--
-- infos_type
--
CREATE TABLE infos_type (
    int_id serial PRIMARY KEY,
    int_code character varying,
    int_libelle character varying,
    int_multiple boolean,
    int_historique boolean
);
COMMENT ON TABLE infos_type IS 'Types de champs (édition des personnes)';

--
-- dirinfo
--
CREATE TABLE dirinfo (
    din_id serial PRIMARY KEY,
    din_id_parent integer REFERENCES meta.dirinfo(din_id),
    din_libelle character varying
);
COMMENT ON TABLE dirinfo IS 'Banque de champs : répertoire contenant les champs';
CREATE INDEX fki_dirinfo_din_id_parent_fkey ON dirinfo USING btree (din_id_parent);

--
-- info
--
CREATE TABLE info (
    inf_id serial PRIMARY KEY,
    int_id integer REFERENCES meta.infos_type,
    inf_code character varying UNIQUE,
    inf_libelle character varying,
    inf__textelong_nblignes integer,
    inf__selection_code integer REFERENCES meta.selection(sel_id) DEFERRABLE,
    inf_etendu boolean DEFAULT false NOT NULL,
    inf_historique boolean DEFAULT false NOT NULL,
    inf_multiple boolean DEFAULT false NOT NULL,
    inf__groupe_type character varying,
    inf__contact_filtre character varying,
    inf__metier_secteur character varying,
    inf__contact_secteur character varying,
    inf__etablissement_interne boolean,
    din_id integer REFERENCES meta.dirinfo,
    inf__groupe_soustype integer,
    inf_libelle_complet character varying,
    inf__date_echeance boolean,
    inf__date_echeance_icone character varying,
    inf__date_echeance_secteur character varying REFERENCES meta.secteur(sec_code),
    inf__etablissement_secteur character varying REFERENCES meta.secteur(sec_code),
    inf_formule text
);
COMMENT ON TABLE info IS 'Champ d''édition d''une personne';
CREATE INDEX fki_info_inf__date_echeance_secteur_fkey ON info USING btree (inf__date_echeance_secteur);
CREATE INDEX fki_info_inf__etablissement_secteur_fkey ON info USING btree (inf__etablissement_secteur);
CREATE INDEX fki_info_inf__selection_code_fkey ON info USING btree (inf__selection_code);
CREATE INDEX fki_info_din_id_fkey ON info USING btree (din_id);
CREATE INDEX info_inf_code_idx ON info USING btree (inf_code);
-- TODO index int_id

--
-- info_aide
--
CREATE TABLE info_aide (
    ina_id serial PRIMARY KEY,
    inf_id integer REFERENCES meta.info,
    ina_aide text
);
COMMENT ON TABLE info_aide IS 'Texte d''aide d''un champ';
CREATE INDEX fki_info_aide_inf_id_fkey ON info_aide USING btree (inf_id);
