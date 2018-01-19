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
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = localise, pg_catalog;

--
-- Data for Name: terme; Type: TABLE DATA; Schema: localise; Owner: accueil
--

COPY terme (ter_id, ter_code, ter_commentaire) FROM stdin;
1	info_groupe_date_demande	Entête colonne dans édition appartenance usagers aux groupe (avec cycle)
2	info_groupe_date_demande_renouvellement	Entête colonne dans édition appartenance usagers aux groupe (avec cycle)
3	info_groupe_etablissement	Etiquette dans popup édition appartenance usagers aux groupes
4	info_groupe_groupe	Etiquette dans popup édition appartenance usagers aux groupes
5	info_groupe_date_debut	"Etiquette dans popup édition appartenance usagers aux groupes
6	info_groupe_date_fin	"Etiquette dans popup édition appartenance usagers aux groupes
\.


--
-- Name: terme_ter_id_seq; Type: SEQUENCE SET; Schema: localise; Owner: accueil
--

SELECT pg_catalog.setval('terme_ter_id_seq', 6, true);


--
-- PostgreSQL database dump complete
--

