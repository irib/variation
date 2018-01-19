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
-- SCHEMA localise
--
-- Module: Localize
--
-- Dependences: Topics
--
CREATE SCHEMA localise;
COMMENT ON schema localise IS 'Système de localisation. A ce point, il est possible de localiser un terme pour un secteur particulier.';

SET search_path = localise, pg_catalog;

--
-- terme
--
CREATE TABLE terme (
    ter_id serial PRIMARY KEY,
    ter_code character varying,
    ter_commentaire character varying
);
COMMENT ON TABLE terme IS 'Terme à localiser.';

--
-- localisation_secteur
--

CREATE TABLE localisation_secteur (
    loc_id serial PRIMARY KEY,
    ter_id integer REFERENCES localise.terme,
    loc_valeur character varying,
    sec_id integer REFERENCES meta.secteur DEFERRABLE
);
COMMENT ON TABLE localisation_secteur IS 'Localisation d''un terme pour un secteur particulier.';
CREATE INDEX fki_localisation_sec_id_fkey ON localisation_secteur USING btree (sec_id);
CREATE INDEX fki_localisation_ter_id_fkey ON localisation_secteur USING btree (ter_id);
