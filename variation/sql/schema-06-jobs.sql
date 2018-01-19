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
-- Module: Jobs
-- 
-- Dependences: Topics, Entities
--
-- metier
--
-- TODO: place in Fields
--
SET search_path = meta, pg_catalog;

CREATE TABLE metier (
    met_id serial PRIMARY KEY,
    met_nom character varying
);
COMMENT ON TABLE metier IS 'Liste des métiers';

--
-- metier_entite
--
CREATE TABLE metier_entite (
    mee_id serial PRIMARY KEY,
    met_id integer REFERENCES meta.metier,
    ent_id integer REFERENCES meta.entite
);
COMMENT ON TABLE metier_entite IS 'Affectation d''un métier à un type de personne';
CREATE INDEX fki_metier_entite_ent_id_fkey ON metier_entite USING btree (ent_id);
CREATE INDEX fki_metier_entite_met_id_fkey ON metier_entite USING btree (met_id);

--
-- metier_secteur
--
CREATE TABLE metier_secteur (
    mes_id serial PRIMARY KEY,
    met_id integer REFERENCES meta.metier,
    sec_id integer REFERENCES meta.secteur
);
COMMENT ON TABLE metier_secteur IS 'Asignation d''un métier à un secteur';
CREATE INDEX fki_metier_secteur_met_id_fkey ON metier_secteur USING btree (met_id);
CREATE INDEX fki_metier_secteur_sec_id_fkey ON metier_secteur USING btree (sec_id);
