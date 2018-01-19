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
-- Copyright (c) 2014-2015 Kavarna SARL
--
-- SCHEMA notes
--
-- Module: Notes Topics
-- 
-- Dependences: Portals
--
SET search_path = notes, pg_catalog;

--
-- theme
--
CREATE TABLE theme (
    the_id serial PRIMARY KEY,
    the_nom character varying
);
COMMENT ON TABLE theme IS 'Liste des boîtes thématiques';

--
-- theme_portail
--
CREATE TABLE theme_portail (
    tpo_id serial PRIMARY KEY,
    the_id integer REFERENCES notes.theme,
    por_id integer REFERENCES meta.portail
);
COMMENT ON TABLE theme_portail IS 'Affectation des boîtes thématiques aux portails';
CREATE INDEX fki_theme_portail_por_id_fkey ON theme_portail USING btree (por_id);
CREATE INDEX fki_theme_portail_the_id_fkey ON theme_portail USING btree (the_id);
