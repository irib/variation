/*
This file is part of Variation.

Variation is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published
by the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Variation is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with Variation.  If not, see <http://www.gnu.org/licenses/>.
--------------------------------------------------------------------------------
Ce fichier fait partie de Variation.

Variation est un logiciel libre ; vous pouvez le redistribuer ou le modifier 
suivant les termes de la GNU Affero General Public License telle que publiée 
par la Free Software Foundation ; soit la version 3 de la licence, soit 
(à votre gré) toute version ultérieure.

Variation est distribué dans l'espoir qu'il sera utile, 
mais SANS AUCUNE GARANTIE ; sans même la garantie tacite de 
QUALITÉ MARCHANDE ou d'ADÉQUATION à UN BUT PARTICULIER. Consultez la 
GNU Affero General Public License pour plus de détails.

Vous devez avoir reçu une copie de la GNU Affero General Public License 
en même temps que Variation ; si ce n'est pas le cas, 
consultez <http://www.gnu.org/licenses>.
--------------------------------------------------------------------------------
Copyright (c) 2014 Kavarna SARL
*/
(function ($) {
    $.fn.gethisto = function (options) {
		var defaults = {
			"title": "Historique",
			'type': null,
			'per': null,
			'code': null,
			'token': null
		}
		var o = jQuery.extend (defaults, options);
		return this.each (function () {
			var div = $(this);
			show_loader();
			$.post ('/ajax/personne_info_'+o.type+'_get_histo.php',{ prm_token: o.token, prm_per_id: o.per, prm_inf_code: o.code, output: 'json' }, 
			function (data){
				hide_loader();
				div.empty().html('<table id="histoTable"></table>');
				$('#histoTable').append('<tr><th class="firstCol">Du > Au<br />Ajouté par</th><th>Valeur</th></tr>');
				nb_val=0;
				$.each (data, function (idx, val) {
					nb_val=nb_val+1;
					$('#histoTable').append('<tr><td class="firstCol">'+val.debut+' > '+(val.fin ? val.fin : '(en cours)')+'<br />'+val.utilisateur+'</td><td>'+val.valeur+"</td></tr>") ;
				});
				if(nb_val==0){
					$('#histoTable').append('<tr><td colspan="3" class="noHistory"><em>Pas d\'historique pour cette valeur.</em></td></tr>') ;
				}
				div.dialog ({
					title: o.title,
					width: 600,
					autoResize: true,
					modal: true,
					resizable: false
				});
				
			});
		});
		
    }
}) (jQuery);
