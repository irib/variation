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
-- SCHEMA document
--
-- Module: Documents Types
--
-- Dependences: Topics
-- 

SET search_path = document, pg_catalog;

--
-- TABLE document_type
--
CREATE TABLE document_type (
    dty_id serial PRIMARY KEY,
    dty_nom character varying,
    dty_nom_individuel boolean
);
COMMENT ON TABLE document_type IS 'Types de documents';

--
-- TABLE document_type_secteur
--
CREATE TABLE document_type_secteur (
    dts_id serial PRIMARY KEY,
    dty_id integer REFERENCES document.document_type,
    sec_id integer REFERENCES meta.secteur
);
COMMENT ON TABLE document_type_secteur IS 'Affectation d''un type de document à des secteurs';
CREATE INDEX fki_document_type_secteur_dty_id_fkey ON document_type_secteur USING btree (dty_id);
CREATE INDEX fki_document_type_secteur_sec_id_fkey ON document_type_secteur USING btree (sec_id);

