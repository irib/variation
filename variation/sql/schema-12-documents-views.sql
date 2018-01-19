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
-- Module: Documents Views
--
-- dependences: Topics, Documents Types
--

SET search_path = document, pg_catalog;

--
-- TABLE documents
--
CREATE TABLE documents (
    dos_id serial PRIMARY KEY,
    dos_titre character varying,
    dty_id integer REFERENCES document.document_type,
    dos_code character varying UNIQUE
);
COMMENT ON TABLE documents IS 'Configuration des pages de documents disponibles pour placer dans le menu princiapl ou usager';
CREATE INDEX fki_documents_dty_id_fkey ON documents USING btree (dty_id);

--
-- TABLE documents_secteur
--
CREATE TABLE documents_secteur (
    dss_id serial PRIMARY KEY,
    dos_id integer REFERENCES document.documents,
    sec_id integer REFERENCES meta.secteur
);
COMMENT ON TABLE documents_secteur IS 'Spécialisation des pages de documents à certains secteurs';
CREATE INDEX fki_documents_secteur_dos_id_fkey ON documents_secteur USING btree (dos_id);
CREATE INDEX fki_documents_secteur_sec_id_fkey ON documents_secteur USING btree (sec_id);
