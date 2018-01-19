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
-- Module: Events
--
-- Dependences: Topics, Users, Events Types, Persons, Resources
--

SET search_path = events, pg_catalog;

--
-- event
--
CREATE TABLE event (
    eve_id serial PRIMARY KEY,
    eve_intitule character varying,
    eve_debut timestamp with time zone,
    eve_fin timestamp with time zone,
    eve__depenses_montant numeric,
    uti_id_creation integer REFERENCES login.utilisateur(uti_id),
    eca_id integer,
    ety_id integer REFERENCES events.event_type,
    eve_date_creation timestamp with time zone,
    eve_journee boolean DEFAULT false NOT NULL,
    eve_ponctuel boolean DEFAULT false NOT NULL
);
COMMENT ON TABLE event IS 'Les événements.
Un événement est caractérisé par un type d''événement (les types étant eux-mêmes classifiés en catégories) et une période de temps. La période est expérimée soit par un intervalle entre 2 heures précises, soit par journées entières, soit par une heure précise pour un événement ponctuel.
Certains champs sont spécifiques aux secteurs associés à l''événement.
';
COMMENT ON COLUMN event.eve_intitule IS 'Intitulé de l''événement';
COMMENT ON COLUMN event.eve__depenses_montant IS 'Si le secteur depenses est associé à l''événement, ce champs indique le montant de la dépense associée à l''événement';
COMMENT ON COLUMN event.eca_id IS 'Identifiant de la catégorie d''événement (découle directement du type donné par ety_id)';
COMMENT ON COLUMN event.ety_id IS 'Identifiant du type d''événement';
COMMENT ON COLUMN event.eve_debut IS 'Date de début de l''événement. 
Si l''événement est de type journée, l''heure doit être 00:00';
COMMENT ON COLUMN event.eve_fin IS 'Date de fin de l''événement. 
Si l''événement est de type journée, l''heure doit être 00:00 et l''événement termine à la fin de la journée indiquée.
Si l''événement est de type ponctuel, cette valeur doit être égale à celle de eve_debut.';
COMMENT ON COLUMN event.eve_journee IS 'Indique s''il s''agit d''un événement sur une ou des journées entières.';
COMMENT ON COLUMN event.eve_ponctuel IS 'Indique s''il s''agit d''un événement à une heure précise, sans durée particulière.';
CREATE INDEX fki_event_ety_id_fkey ON event USING btree (ety_id);
CREATE INDEX fki_event_uti_id_creation_fkey ON event USING btree (uti_id_creation);

--
-- event_memo
--
CREATE TABLE event_memo (
    eme_id serial PRIMARY KEY,
    eve_id integer REFERENCES events.event,
    eme_timestamp timestamp with time zone,
    eme_type character varying,
    eme_texte text
);
COMMENT ON TABLE event_memo IS 'Textes accompagnant les événements (objet, compte-rendu)';
COMMENT ON COLUMN event_memo.eme_type IS 'Type de mémo : bilan ou description';
CREATE INDEX event_memo_eme_type_idx ON event_memo USING btree (eme_type);
CREATE INDEX fki_event_memo_eve_id_fkey ON event_memo USING btree (eve_id);

--
-- event_personne
--
CREATE TABLE event_personne (
    epe_id serial PRIMARY KEY,
    eve_id integer REFERENCES events.event,
    per_id integer REFERENCES public.personne
);
COMMENT ON TABLE event_personne IS 'Rattachement de personnes (usager, personnel, contact, famille) aux événements';
CREATE INDEX fki_event_personne_eve_id_fkey ON event_personne USING btree (eve_id);
CREATE INDEX fki_event_personne_per_id_fkey ON event_personne USING btree (per_id);

--
-- event_ressource
--
CREATE TABLE event_ressource (
    ere_id serial PRIMARY KEY,
    eve_id integer REFERENCES events.event,
    res_id integer REFERENCES ressource.ressource
);
COMMENT ON TABLE event_ressource IS 'Affectation de ressources aux événements';
CREATE INDEX fki_event_ressource_eve_id_fkey ON event_ressource USING btree (eve_id);
CREATE INDEX fki_event_ressource_res_id_fkey ON event_ressource USING btree (res_id);

--
-- secteur_event
--
CREATE TABLE secteur_event (
    set_id serial PRIMARY KEY,
    sec_id integer REFERENCES meta.secteur,
    eve_id integer REFERENCES events.event
);
COMMENT ON TABLE secteur_event IS 'Affectation des événements à des secteurs';
-- TODO index sec_id eve_id
