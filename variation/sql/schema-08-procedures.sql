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
-- SCHEMA procedure
--
-- Module: Procedures
--
-- Dependences: Portals
-- 
CREATE SCHEMA procedure;
COMMENT ON SCHEMA procedure IS 'Documentations à afficher sur diverses pages.';
SET search_path = procedure, pg_catalog;

--
-- procedure
--
CREATE TABLE procedure (
    pro_id serial PRIMARY KEY,
    pro_titre character varying,
    pro_contenu text
);
COMMENT ON TABLE procedure IS 'Contenu de la documentation.';

--
-- procedure_affectation
--
CREATE TABLE procedure_affectation (
    paf_id serial PRIMARY KEY,
    pro_id integer REFERENCES procedure.procedure,
    tsm_id integer REFERENCES meta.topsousmenu,
    sme_id integer REFERENCES meta.sousmenu
);
COMMENT ON TABLE procedure_affectation IS 'Affichage de la documentation sur une page donnée.';
CREATE INDEX fki_procedure_affectation_pro_id_fkey ON procedure_affectation USING btree (pro_id);
CREATE INDEX fki_procedure_affectation_sme_id_fkey ON procedure_affectation USING btree (sme_id);
CREATE INDEX fki_procedure_affectation_tsm_id_fkey ON procedure_affectation USING btree (tsm_id);
