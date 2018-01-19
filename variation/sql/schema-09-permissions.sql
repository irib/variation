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
-- SCHEMA permission
--
-- Module: Permissions
--
-- Dependences: Entities, Portals
-- 
CREATE SCHEMA permission;
COMMENT ON SCHEMA permission IS 'Enregistrement des diverses permissions.';
SET search_path = permission, pg_catalog;

--
-- droit_ajout_entite_portail
--
CREATE TABLE droit_ajout_entite_portail (
    daj_id serial PRIMARY KEY,
    ent_code character varying REFERENCES meta.entite(ent_code),
    por_id integer REFERENCES meta.portail,
    daj_droit boolean DEFAULT true NOT NULL
);
COMMENT ON TABLE droit_ajout_entite_portail IS 'Droit pour les utilisateurs d''ajouter des personnes d''une certaine catégorie (usager, personnel, contact, famille) par portail.';
CREATE INDEX fki_droit_ajout_entite_portail_ent_code_fkey ON droit_ajout_entite_portail USING btree (ent_code);
CREATE INDEX fki_droit_ajout_entite_portail_por_id_fkey ON droit_ajout_entite_portail USING btree (por_id);

--
-- droit_portail
--
CREATE TABLE permission.droit_portail (
  drp_id serial PRIMARY KEY,
  por_id integer REFERENCES meta.portail,
  drp_droit varchar NOT NULL,
  drp_valeur boolean DEFAULT FALSE
);
COMMENT ON TABLE droit_portail IS 'Divers droits pour les utilisateurs d''un portail';
-- TODO index por_id
