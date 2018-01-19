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
-- Copyright (c) 2014-2016 Kavarna SARL

SET search_path = meta, pg_catalog;

-----------------
-- meta.entite --
-----------------
--
-- meta_entite_infos_par_code:prm_token:prm_code
--
CREATE OR REPLACE FUNCTION meta_entite_infos_par_code(prm_token integer, prm_code character varying) RETURNS entite
    LANGUAGE plpgsql
    AS $$
DECLARE
	ret meta.entite%ROWTYPE;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	SELECT * INTO ret FROM meta.entite WHERE ent_code = prm_code;
	RETURN ret;
END;
$$;
COMMENT ON FUNCTION meta_entite_infos_par_code(prm_token integer, prm_code character varying) IS
'Retourne les informations sur un type de personne.';

--
-- meta_entite_liste:prm_token
--
CREATE OR REPLACE FUNCTION meta_entite_liste(prm_token integer) RETURNS SETOF entite
    LANGUAGE plpgsql
    AS $$
DECLARE
	row RECORD;
BEGIN
	PERFORM login._token_assert (prm_token, FALSE, FALSE);
	FOR row IN
		SELECT * FROM meta.entite ORDER BY ent_id
	LOOP
		RETURN NEXT row;
	END LOOP;
END;
$$;
COMMENT ON FUNCTION meta_entite_liste(prm_token integer) IS
'Retourne la liste des types de personnes.';
