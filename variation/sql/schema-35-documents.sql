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
-- Module Documents
--
-- Dependences: Topics, Persons, Documents Types, Users
--
SET search_path = document, pg_catalog;

--
-- TABLE document
--
CREATE TABLE document (
    doc_id serial PRIMARY KEY,
    per_id_responsable integer REFERENCES public.personne(per_id),
    dty_id integer REFERENCES document.document_type,
    doc_titre character varying,
    doc_statut integer,
    doc_date_obtention date,
    doc_date_realisation date,
    doc_date_validite date,
    doc_description text,
    doc_fichier character varying,
    doc_date_creation timestamp with time zone,
    uti_id_creation integer REFERENCES login.utilisateur(uti_id)
);
COMMENT ON TABLE document IS 'Les documents';
CREATE INDEX fki_document_dty_id_fkey ON document USING btree (dty_id);
CREATE INDEX fki_document_per_id_responsable_fkey ON document USING btree (per_id_responsable);
CREATE INDEX fki_document_uti_id_creation_fkey ON document USING btree (uti_id_creation);

--
-- TABLE document_secteur
--
CREATE TABLE document_secteur (
    dse_id serial PRIMARY KEY,
    doc_id integer REFERENCES document.document,
    sec_id integer REFERENCES meta.secteur
);
COMMENT ON TABLE document_secteur IS 'Rattachement d''un document à des secteurs';
CREATE INDEX fki_document_secteur_doc_id_fkey ON document_secteur USING btree (doc_id);
CREATE INDEX fki_document_secteur_sec_id_fkey ON document_secteur USING btree (sec_id);

--
-- TABLE document_usager
--
CREATE TABLE document_usager (
    dus_id serial PRIMARY KEY,
    doc_id integer REFERENCES document.document,
    per_id_usager integer REFERENCES public.personne(per_id)
);
COMMENT ON TABLE document_usager IS 'Rattachement d''un document à des usagers';
CREATE INDEX fki_document_usager_doc_id_fkey ON document_usager USING btree (doc_id);
CREATE INDEX fki_document_usager_per_id_usager_fkey ON document_usager USING btree (per_id_usager);
