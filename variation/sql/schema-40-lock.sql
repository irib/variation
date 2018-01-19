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
-- SCHEMA lock
--
-- Module: Interface
--
-- Dependences: Users, Persons, (Portals)
CREATE SCHEMA lock;
COMMENT ON schema lock IS 'Système de verrouillage de fiches.';

SET search_path = lock, pg_catalog;

--
-- fiche
--
CREATE TABLE fiche (
    loc_id serial PRIMARY KEY,
    uti_id integer REFERENCES login.utilisateur,
    per_id integer REFERENCES public.personne,
    loc_date timestamp with time zone,
    sme_id integer
);
COMMENT ON TABLE fiche IS 'Fiche verrouillée.';
COMMENT ON COLUMN fiche.loc_id IS 'Identifiant';
COMMENT ON COLUMN fiche.uti_id IS 'Utilisateur ayant verrouillé la fiche';
COMMENT ON COLUMN fiche.per_id IS 'Identifiant de la personne affichée par la fiche';
COMMENT ON COLUMN fiche.loc_date IS 'Date de dernière consultation de la fiche par l''utilisateur';
COMMENT ON COLUMN fiche.sme_id IS 'Dernier menu visité dans la fiche';
CREATE INDEX fki_fiche_per_id_fkey ON fiche USING btree (per_id);
CREATE INDEX fki_fiche_uti_id_fkey ON fiche USING btree (uti_id);

-- todo fk sme_id
