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
-- SCHEMA login
--
-- Module: Users Groups
--
-- Dependences: Groups, Portals, Users
--

SET search_path = login, pg_catalog;

--
-- grouputil
--
CREATE TABLE grouputil (
    gut_id serial PRIMARY KEY,
    gut_nom character varying
);
COMMENT ON TABLE grouputil IS 'Liste des groupes d''utilisateurs.';
COMMENT ON COLUMN grouputil.gut_id IS 'Identifiant du groupe d''utilisateurs';
COMMENT ON COLUMN grouputil.gut_nom IS 'Nom du groupe';

--
-- grouputil_groupe
--
CREATE TABLE grouputil_groupe (
    ggr_id serial PRIMARY KEY,
    gut_id integer REFERENCES login.grouputil,
    grp_id integer REFERENCES public.groupe
);
COMMENT ON TABLE grouputil_groupe IS 'Groupes d''usagers auxquels un groupe d''utilisateurs a accès';
COMMENT ON COLUMN grouputil_groupe.ggr_id IS 'Identifiant de la relation';
COMMENT ON COLUMN grouputil_groupe.gut_id IS 'Identifiant du groupe d''utilisateurs';
COMMENT ON COLUMN grouputil_groupe.grp_id IS 'Identifiant du groupe d''usagers';
CREATE INDEX fki_grouputil_groupe_grp_id_fkey ON grouputil_groupe USING btree (grp_id);
CREATE INDEX fki_grouputil_groupe_gut_id_fkey ON grouputil_groupe USING btree (gut_id);

--
-- grouputil_portail
--
CREATE TABLE grouputil_portail (
    gpo_id serial PRIMARY KEY,
    gut_id integer REFERENCES login.grouputil,
    por_id integer REFERENCES meta.portail
);
COMMENT ON TABLE grouputil_portail IS 'Portails auxquels un groupe d''utilisateurs a accès';
COMMENT ON COLUMN grouputil_portail.gpo_id IS 'Identifiant de la relation';
COMMENT ON COLUMN grouputil_portail.gut_id IS 'Identifiant du groupe d''utilisateurs';
COMMENT ON COLUMN grouputil_portail.por_id IS 'Identifiant du portail';
CREATE INDEX fki_grouputil_portail_gut_id_fkey ON grouputil_portail USING btree (gut_id);
CREATE INDEX fki_grouputil_portail_por_id_fkey ON grouputil_portail USING btree (por_id);

--
-- utilisateur_grouputil
--
CREATE TABLE utilisateur_grouputil (
    ugr_id serial PRIMARY KEY,
    uti_id integer REFERENCES login.utilisateur,
    gut_id integer REFERENCES login.grouputil
);
COMMENT ON TABLE utilisateur_grouputil IS 'Affectation des utilisateurs aux groupes d''utilisateurs.';
COMMENT ON COLUMN utilisateur_grouputil.ugr_id IS 'Identifiant de la relation';
COMMENT ON COLUMN utilisateur_grouputil.uti_id IS 'Identifiant de l''utilisateur';
COMMENT ON COLUMN utilisateur_grouputil.gut_id IS 'Identifiant du groupe d''utilisateurs';
CREATE INDEX fki_utilisateur_grouputil_gut_id_fkey ON utilisateur_grouputil USING btree (gut_id);
CREATE INDEX fki_utilisateur_grouputil_uti_id_fkey ON utilisateur_grouputil USING btree (uti_id);
