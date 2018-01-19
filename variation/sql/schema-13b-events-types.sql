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
-- SCHEMA events
--
-- Module: Events Types
-- 
-- Dependences: Topics
--
SET search_path = events, pg_catalog;

--
-- events_categorie
--
CREATE TABLE events_categorie (
    eca_id serial PRIMARY KEY,
    eca_nom character varying,
    eca_code character varying,
    eca_icone character varying
);
COMMENT ON TABLE events_categorie IS 'Catégories d''évenements';

--
-- event_type
--
CREATE TABLE event_type (
    ety_id serial PRIMARY KEY,
    eca_id integer REFERENCES events.events_categorie,
    ety_intitule character varying,
    ety_intitule_individuel boolean
);
COMMENT ON TABLE event_type IS 'Types d''événements (sous-niveau de catégories d''événements)';
CREATE INDEX fki_event_type_eca_id_fkey ON event_type USING btree (eca_id);

--
-- event_type_secteur
--
CREATE TABLE event_type_secteur (
    ets_id serial PRIMARY KEY,
    ety_id integer REFERENCES events.event_type,
    sec_id integer REFERENCES meta.secteur
);
COMMENT ON TABLE event_type_secteur IS 'Affectation d''un type d''événement à des secteurs';
CREATE INDEX fki_event_type_secteur_ety_id_fkey ON event_type_secteur USING btree (ety_id);
CREATE INDEX fki_event_type_secteur_sec_id_fkey ON event_type_secteur USING btree (sec_id);
