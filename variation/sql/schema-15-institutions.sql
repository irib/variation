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
-- SCHEMA public
--
-- Module: Institutions
--
-- Dependences: Portals, Topics, Documents Types, Events Types
--
SET search_path = public, pg_catalog;

--
-- TABLE adresse
--
CREATE TABLE adresse (
    adr_id serial PRIMARY KEY,
    adr_adresse character varying,
    adr_cp character varying,
    adr_ville character varying,
    adr_tel character varying,
    adr_fax character varying,
    adr_email character varying,
    adr_web character varying
);
COMMENT ON TABLE adresse IS 'Adresse et moyens de contact d''un établissement/partenaire.';
COMMENT ON COLUMN adresse.adr_id IS 'Identifiant de l''adresse';
COMMENT ON COLUMN adresse.adr_adresse IS 'Ligne d''adresse';
COMMENT ON COLUMN adresse.adr_cp IS 'Code postal';
COMMENT ON COLUMN adresse.adr_ville IS 'Ville';
COMMENT ON COLUMN adresse.adr_tel IS 'Téléphone';
COMMENT ON COLUMN adresse.adr_fax IS 'Fax';
COMMENT ON COLUMN adresse.adr_email IS 'Adresse email de contact de l''établissement';
COMMENT ON COLUMN adresse.adr_web IS 'Site web de l''établissement';

--
-- TABLE etablissement
--
CREATE TABLE etablissement (
    eta_id serial PRIMARY KEY,
    cat_id integer REFERENCES meta.categorie DEFERRABLE,
    eta_nom character varying,
    adr_id integer REFERENCES public.adresse
);
COMMENT ON TABLE etablissement IS 'Etablissement (internes) et partenaires (externes).
cat_id est NULL pour les partenaires, non NULL pour les établissements.';
COMMENT ON COLUMN etablissement.eta_id IS 'Identifiant de l''établissement/partenaire';
COMMENT ON COLUMN etablissement.cat_id IS 'Identifiant de la catégorie de l''établissement, NULL pour un partenaire';
COMMENT ON COLUMN etablissement.eta_nom IS 'Nom de l''établissement/partenaire';
COMMENT ON COLUMN etablissement.adr_id IS 'Identifiant de l''adresse';
CREATE INDEX fki_etablissement_adr_id_fkey ON etablissement USING btree (adr_id);
CREATE INDEX fki_etablissement_cat_id_fkey ON etablissement USING btree (cat_id);

--
-- TABLE etablissement_secteur
--
CREATE TABLE etablissement_secteur (
    ets_id serial PRIMARY KEY,
    eta_id integer REFERENCES public.etablissement,
    sec_id integer REFERENCES meta.secteur
);
COMMENT ON TABLE etablissement_secteur IS 'Liste des secteurs couverts par les établissements/partenaires.';
COMMENT ON COLUMN etablissement_secteur.ets_id IS 'Identifiant de la relation';
COMMENT ON COLUMN etablissement_secteur.eta_id IS 'Identifiant de l''établissement/partenaire';
COMMENT ON COLUMN etablissement_secteur.sec_id IS 'Identifiant du secteur';
CREATE INDEX fki_etablissement_secteur_eta_id_fkey ON etablissement_secteur USING btree (eta_id);
CREATE INDEX fki_etablissement_secteur_sec_id_fkey ON etablissement_secteur USING btree (sec_id);

--
-- TABLE etablissement_secteur_edit
--
CREATE TABLE etablissement_secteur_edit (
    ese_id serial PRIMARY KEY,
    eta_id integer REFERENCES public.etablissement,
    sec_id integer REFERENCES meta.secteur
);
COMMENT ON TABLE etablissement_secteur_edit IS 'Liste des secteurs pour lesquels les utilisateurs ont le droit de rajouter des groupes à un établissement/partenaire.';
COMMENT ON COLUMN etablissement_secteur_edit.ese_id IS 'Identifiant de la relation';
COMMENT ON COLUMN etablissement_secteur_edit.eta_id IS 'Identifiant de l''établissement';
COMMENT ON COLUMN etablissement_secteur_edit.sec_id IS 'Identifiant du secteur';
CREATE INDEX fki_etablissement_secteur_edit_eta_id_fkey ON etablissement_secteur_edit USING btree (eta_id);
CREATE INDEX fki_etablissement_secteur_edit_sec_id_fkey ON etablissement_secteur_edit USING btree (sec_id);

SET search_path = document, pg_catalog;

--
-- TABLE document_type_etablissement
--
CREATE TABLE document_type_etablissement (
    dte_id serial PRIMARY KEY,
    dty_id integer REFERENCES document.document_type,
    eta_id integer REFERENCES public.etablissement
);
COMMENT ON TABLE document_type_etablissement IS 'Utilisation d''un type de document par un établissement';
CREATE INDEX fki_document_type_etablissement_dty_id_fkey ON document_type_etablissement USING btree (dty_id);
CREATE INDEX fki_document_type_etablissement_eta_id_fkey ON document_type_etablissement USING btree (eta_id);


SET search_path = events, pg_catalog;

--
-- event_type_etablissement
--
CREATE TABLE event_type_etablissement (
    ete_id serial PRIMARY KEY,
    ety_id integer REFERENCES events.event_type,
    eta_id integer REFERENCES public.etablissement
);
COMMENT ON TABLE event_type_etablissement IS 'Utilisation d''un type d''événement par un établissement';
CREATE INDEX fki_event_type_etablissement_eta_id_fkey ON event_type_etablissement USING btree (eta_id);
CREATE INDEX fki_event_type_etablissement_ety_id_fkey ON event_type_etablissement USING btree (ety_id);

-- 
SET search_path = public, pg_catalog;
