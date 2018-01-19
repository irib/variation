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
-- 
-- Module: Topics
-- 
-- Dependences: -
--

SET search_path = meta, pg_catalog;

--
-- secteur
--
CREATE TABLE secteur (
    sec_id serial PRIMARY KEY,
    sec_code character varying UNIQUE,
    sec_nom character varying,
    sec_est_prise_en_charge boolean,
    sec_icone character varying
);
COMMENT ON TABLE secteur IS 'Liste des thématiques';

--
-- secteur_type
--
CREATE TABLE secteur_type (
    set_id serial PRIMARY KEY,
    sec_id integer REFERENCES meta.secteur,
    set_nom character varying
);
COMMENT ON TABLE secteur_type IS 'Sous-catégorie des thématiques';
CREATE INDEX fki_secteur_type_sec_id_fkey ON secteur_type USING btree (sec_id);

--
-- secteur_groupe
--
CREATE TABLE secteur_groupe (
    seg_id serial PRIMARY KEY,
    seg_nom character varying
);

-- 
-- secteur_groupe_secteur
--
CREATE TABLE secteur_groupe_secteur (
    sgs_id serial PRIMARY KEY,
    seg_id integer REFERENCES meta.secteur_groupe,
    sec_id integer REFERENCES meta.secteur
);


SET search_path = public, pg_catalog;
--
-- TABLE secteur_infos
--
CREATE TABLE secteur_infos (
    sei_id serial PRIMARY KEY,
    sec_id integer REFERENCES meta.secteur,
    sec_editable boolean
);
COMMENT ON TABLE secteur_infos IS 'Informations supplémentaires sur les thématiques';
COMMENT ON COLUMN secteur_infos.sec_id IS 'Identifiant de la thématique';
COMMENT ON COLUMN secteur_infos.sec_editable IS 'Indique si les utilisateurs ont le droit de créer des partenaires et d''éditer des groupes chez ces partenaires dans la thématique donnée.';
CREATE INDEX fki_secteur_infos_sec_id_fkey ON secteur_infos USING btree (sec_id);

SET search_path = meta, pg_catalog;
