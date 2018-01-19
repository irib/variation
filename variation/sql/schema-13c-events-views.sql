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
-- Module: Events Views
--
-- Dependences: Topics, Events Types
--
SET search_path = events, pg_catalog;

--
-- events
--
CREATE TABLE events (
    evs_id serial PRIMARY KEY,
    evs_titre character varying,
    evs_code character varying,
    ety_id integer REFERENCES events.event_type
);
COMMENT ON TABLE events IS 'Configuration des pages d''événements disponibles pour placer dans le menu principal ou usager';
CREATE INDEX fki_events_ety_id_fkey ON events USING btree (ety_id);

--
-- secteur_events
--
CREATE TABLE secteur_events (
    sev_id serial PRIMARY KEY,
    sec_id integer REFERENCES meta.secteur,
    evs_id integer REFERENCES events.events
);
COMMENT ON TABLE secteur_events IS 'Spécialisation des pages d''événements à certains secteurs';
CREATE INDEX fki_secteur_events_evs_id_fkey ON secteur_events USING btree (evs_id);
CREATE INDEX fki_secteur_events_sec_id_fkey ON secteur_events USING btree (sec_id);

--
-- categorie_events
--
CREATE TABLE categorie_events (
    cev_id serial PRIMARY KEY,
    eca_id integer REFERENCES events.events_categorie,
    evs_id integer REFERENCES events.events
);
COMMENT ON TABLE categorie_events IS 'Spécialisation des pages d''événements à certaines catégories d''événements';
