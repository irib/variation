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
    $.fn.printdossierusager = function (options) {
		var defaults = {
			"title": "Impression dossier",
			"per_id": null,
			"por_id": null,
			"token" : null
		}
		var o = jQuery.extend (defaults, options);
		return this.each (function () {
			var div = $(this);
			show_loader();
			// $.post ('/ajax/meta_sous_menu_liste.php',{ prm_token: o.token, men_id: [men_id], output: 'json' }, 
			$.getJSON ('/ajax/meta_menu_liste_recursif.php',{ prm_token: o.token, prm_por_id: o.por_id, prm_ent_code: 'usager', output: 'json' }, 
			 function (data){
				hide_loader();
				div.empty().html('<div id="print_form_gauche"><h3>Période</h3></div>');
				$('#print_form_gauche').append("Imprimer depuis le <input id='date_debut' size='10' class='datepicker' />*<br /> <small><em>* Laisser vide pour imprimer le dossier depuis l'inscription.</em></small>");
				$(".datepicker").datepicker ({
					showOn: "button",
					buttonImage: "/Images/datepicker.png",
					buttonImageOnly: true,
					showButtonPanel: true,
					changeYear: true,
					showWeek: true,
					gotoCurrent: true,
					yearRange: "c-64:c+10"
				});
				
				div.append('<div id="print_form_droite"><h3>&Eacute;léments à imprimer</h3></div>');
				$('#print_form_droite').append('<input name="choix_print" type="radio" id="radio_print_all" checked /><label for="radio_print_all">Tout le dossier</label>');
				$('#print_form_droite').append('<input name="choix_print" type="radio" id="radio_print_select" /><label for="radio_print_select">Personnaliser</label>');
				
				div.append('<div style="clear:both"></div><div id="perso" style="display:none"></div>');
				
				var men_id=0;
				var count_section = 0;
				$.each (data, function (idx, val) {
					if(val['sme_id']==""){
						count_section = count_section + 1;
						if(count_section>4){
							count_section = 1;
							$('#perso').append('<div style="clear:both"></div>');
						}
						men_id=val['men_id'];
						
						$('#perso').append('<div class="section" id="section'+val['men_id']+'"><div class="section_title"><input type="checkbox" class="checkAll" id="check'+men_id+'" /><label for="check'+men_id+'">'+val['men_libelle']+'</label></div></div>');
					}
					else{
						var is_checked="";
						console.log(localStorage.getItem("print_select"+men_id));
						if(localStorage.getItem("print_select"+val['sme_id'])=='true')is_checked="checked";
						$('#section'+men_id).append('<div><input type="checkbox" name="check'+men_id+'" class="checkbox_perso" id="select'+val['sme_id']+'" '+is_checked+'><label for = "select'+val['sme_id']+'">'+val['sme_libelle']+'</label></div>');
					}
					
					
				});
				$('#perso').append('<div style="clear:both"></div>');
				div.append('<div id="div_print_button"><button id="start_print_usager_button">Lancer l\'impression</button></div>');
				
				
				
				
				$('#start_print_usager_button').click (function () {
					date_debut = $('#date_debut').val();
					if(date_debut==""){
						date_debut = "debut";
					}
					
					liste_menu_a_imprimer = [];
					$('#perso .checkbox_perso').each(function(){
						id_sme = $(this).attr('id');
						id_sme = id_sme.replace("select","");
						
						if($(this).is(':checked')){
							liste_menu_a_imprimer.push(id_sme);
						}else if($('#radio_print_all').is(':checked')){
							liste_menu_a_imprimer.push(id_sme);
						}
					});
					
					setting_url = "";
					for(var i=0; i<liste_menu_a_imprimer.length; i++){
						setting_url = setting_url + "&i[]="+liste_menu_a_imprimer[i];
					}
					setting_url = setting_url + "&debut="+encodeURIComponent(date_debut);
					
					
					window.open("/export/dossier.php?per_id="+o.per_id+setting_url); 
					div.dialog('destroy').empty();
				});
				$('#radio_print_select,#radio_print_all').change(function(){
					if($('#radio_print_select').is(':checked')){
						$('#perso').slideDown(200);
					}
					else{
						$('#perso').slideUp(200);
					}
				});
				$('.checkbox_perso').change(function(){
					id = $(this).attr('id');
					localStorage.setItem("print_"+id,$(this).is(':Checked'));
					console.log(localStorage.getItem("print_"+id));
				});
				div.dialog ({
					title: o.title,
					width: 800,
					autoResize: true,
					modal: true,
					resizable: false,
					position: { my: "top", at: "top", of: window }
				});
				
				$('.checkAll').change(function(){
					checkAll($(this).attr('id'),$(this).is(':checked'));
				})
				function checkAll(name, checked){
					var inputs = document.getElementsByTagName('input');
					for(var i=0; i<inputs.length; i++){
						if(inputs[i].type == 'checkbox' && inputs[i].name == name){
							inputs[i].checked = checked;
							localStorage.setItem("print_"+inputs[i].id,$("#"+inputs[i].id).is(':Checked'));
							console.log(localStorage.getItem("print_"+inputs[i].id));
						}
					}
				}
			 });
		});
		
    }
}) (jQuery);
