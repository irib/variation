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
-- Module: Fields Views
--
-- Dependences: Portals, Fields
--
-- groupe_infos
--
SET search_path = meta, pg_catalog;

CREATE TABLE groupe_infos (
    gin_id serial PRIMARY KEY,
    sme_id integer REFERENCES meta.sousmenu,
    gin_libelle character varying,
    gin_ordre integer
);
COMMENT ON TABLE groupe_infos IS 'Groupe de champs dans un sous-menu (édition de personnes)';
-- TODO index sme_id

--
-- info_groupe
--
CREATE TABLE info_groupe (
    ing_id serial PRIMARY KEY,
    inf_id integer REFERENCES meta.info,
    gin_id integer REFERENCES meta.groupe_infos,
    ing_ordre integer,
    ing__groupe_cycle boolean,
    ing_obligatoire boolean DEFAULT false NOT NULL
);
COMMENT ON TABLE info_groupe IS 'Assignation d''un champ dans un groupe de champs';
CREATE INDEX fki_info_groupe_gin_id_fkey ON info_groupe USING btree (gin_id);
CREATE INDEX fki_info_groupe_inf_id_fkey ON info_groupe USING btree (inf_id);

