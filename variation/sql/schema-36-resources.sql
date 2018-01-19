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
-- SCHEMA ressource
--
-- Module: Resources
--
-- Dependences: Topics
--
CREATE SCHEMA ressource;
COMMENT ON SCHEMA ressource IS 'Ressources à affecter à des événements.';
SET search_path = ressource, pg_catalog;

--
-- ressource
--
CREATE TABLE ressource (
    res_id serial PRIMARY KEY,
    res_nom character varying
);
COMMENT ON TABLE ressource IS 'Les ressources.';

--
-- ressource_secteur
--
CREATE TABLE ressource_secteur (
    rse_id serial PRIMARY KEY,
    res_id integer REFERENCES ressource.ressource,
    sec_id integer REFERENCES meta.secteur
);
COMMENT ON TABLE ressource_secteur IS 'Affectation des ressources à des secteurs.';
CREATE INDEX fki_ressource_secteur_res_id_fkey ON ressource_secteur USING btree (res_id);
CREATE INDEX fki_ressource_secteur_sec_id_fkey ON ressource_secteur USING btree (sec_id);
