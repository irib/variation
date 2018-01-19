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

SET search_path = meta, pg_catalog;

--
-- Data for Name: lien_familial; Type: TABLE DATA; Schema: meta; Owner: accueil
--

COPY lien_familial (lfa_id, lfa_nom) FROM stdin;
1	Père
2	Mère
3	Frère
4	Soeur
5	Oncle
6	Tante
7	Grand-père
8	Grand-mère
9	Belle-mère
10	Beau-père
11	Tuteur/trice
12	Parrain
13	Marraine
14	Cousin
15	Cousine
16	Famille d'accueil
\.


--
-- Name: lien_familial_lfa_id_seq; Type: SEQUENCE SET; Schema: meta; Owner: accueil
--

SELECT pg_catalog.setval('lien_familial_lfa_id_seq', 16, true);


--
-- PostgreSQL database dump complete
--

