$(function(){
	// handles switching the url when changing the value of the section select box
	$('#sectionSelect').change(function(){
		window.location = $(this).val();
	})
	$('.expand_works_link') .click(function(){
		if ($(this) .parent('td') .children('div') .attr('class') == 'expand_works_div_hidden'){
			$(this) .parent('td') .children('div') .fadeIn('slow');
			$(this) .parent('td') .children('div') .attr('class', 'expand_works_div_visible')
			$(this) .html('(less)');
		}
		else if ($(this) .parent('td') .children('div') .attr('class') == 'expand_works_div_visible'){
			$(this) .parent('td') .children('div') .fadeOut('slow');
			$(this) .parent('td') .children('div') .attr('class', 'expand_works_div_hidden');
			$(this) .html('(more)');
		}
	})
})

/* Function to display new work genre input field when needed. */
function addAnotherWorkGenre() {
	var nextWorkGenre = $('#genreList').children('div').length;
	var genreDiv = '<div id="work_new_genre_' + nextWorkGenre + '"><label for="work_genres_attributes_' + nextWorkGenre + '_value">Value: </label>';
  genreDiv += '<input id="work_genres_attributes_' + nextWorkGenre + '_value" type="text" size="40" name="work[genres_attributes][' +nextWorkGenre + '][value]"/>';
	genreDiv += ' <label for="work_genres_attributes_' + nextWorkGenre + '_clear">Clear? </label>';
//	genreDiv += ' <label for="work_genres_attributes_' + nextWorkGenre + '__delete">Delete? </label>';
//	genreDiv += '<input type="hidden" value="0" name="work[genres_attributes][' + nextWorkGenre + '][_delete]"/>';
//	genreDiv += '<input id="work_genres_attributes_' + nextWorkGenre + '__delete" type="checkbox" value="1" name="work[genres_attributes][' + nextWorkGenre + '][_delete]"/>';
	genreDiv += '<input id="work_genres_attributes_' + nextWorkGenre + '_clear" type="checkbox" value="0" name="work_genres_attributes_' + nextWorkGenre + '_clear" onclick="clearAndHideWorkGenre(' + nextWorkGenre + ')"/>';
	genreDiv += '</div>';
	$('#genreList').append(genreDiv);
}

/* Function to display new metaphor category input field when needed. */
function addAnotherMetaphorCategory() {
	var nextMetaphorCategory = $('#categoryList').children('div').length;
	var categoryDiv = '<div id="metaphor_new_category_' + nextMetaphorCategory + '"><label for="metaphor_categories_attributes_' + nextMetaphorCategory + '_value">Value: </label>';
  categoryDiv += '<input id="metaphor_categories_attributes_' + nextMetaphorCategory + '_value" type="text" size="40" name="metaphor[categories_attributes][' +nextMetaphorCategory + '][value]"/>';
	categoryDiv += ' <label for="metaphor_categories_attributes_' + nextMetaphorCategory + '_clear">Clear? </label>';
//	categoryDiv += ' <label for="metaphor_categories_attributes_' + nextMetaphorCategory + '__delete">Delete? </label>';
//	categoryDiv += '<input type="hidden" value="0" name="metaphor[categories_attributes][' + nextMetaphorCategory + '][_delete]"/>';
//	categoryDiv += '<input id="metaphor_categories_attributes_' + nextMetaphorCategory + '__delete" type="checkbox" value="1" name="metaphor[categories_attributes][' + nextMetaphorCategory + '][_delete]"/>';
	categoryDiv += '<input id="metaphor_categories_attributes_' + nextMetaphorCategory + '_clear" type="checkbox" value="0" name="metaphor_categories_attributes_' + nextMetaphorCategory + '_clear" onclick="clearAndHideMetaphorCategory(' + nextMetaphorCategory + ')"/>';
	categoryDiv += '</div>';
	$('#categoryList').append(categoryDiv);
}

/* Function to display new metaphor type input field when needed. */
function addAnotherMetaphorType() {
	var nextMetaphorType = $('#typeList').children('div').length;
	var typeDiv = '<div id="metaphor_new_type_' + nextMetaphorType + '"><label for="metaphor_types_attributes_' + nextMetaphorType + '_name">Value: </label>';
  typeDiv += '<input id="metaphor_types_attributes_' + nextMetaphorType + '_value" type="text" size="40" name="metaphor[types_attributes][' +nextMetaphorType + '][name]"/>';
	typeDiv += ' <label for="metaphor_types_attributes_' + nextMetaphorType + '_clear">Clear? </label>';
//	typeDiv += ' <label for="metaphor_types_attributes_' + nextMetaphorType + '__delete">Delete? </label>';
//	typeDiv += '<input type="hidden" value="0" name="metaphor[types_attributes][' + nextMetaphorType + '][_delete]"/>';
//	typeDiv += '<input id="metaphor_types_attributes_' + nextMetaphorType + '__delete" type="checkbox" value="1" name="metaphor[types_attributes][' + nextMetaphorType + '][_delete]"/>';
	typeDiv += '<input id="metaphor_types_attributes_' + nextMetaphorType + '_clear" type="checkbox" value="1" name="metaphor_types_attributes_' + nextMetaphorType + '_clear" onclick="clearAndHideMetaphorType(' + nextMetaphorType + ')"/>';
	typeDiv += '</div>';
	$('#typeList').append(typeDiv);	
}

/* Function to clear out a newly added work genre text input field and hide its div. */
function clearAndHideWorkGenre(index) {
	$('#work_genres_attributes_' + index + '_value').val('');
	$('#work_new_genre_'+ index).hide();
}

/* Function to clear out a newly added metaphor category text input field and hide its div. */
function clearAndHideMetaphorCategory(index) {
	$('#metaphor_categories_attributes_' + index + '_value').val('');
	$('#metaphor_new_category_'+ index).hide();
}

/* Function to clear out a newly added metaphor type text input field and hide its div. */
function clearAndHideMetaphorType(index) {
	$('#metaphor_types_attributes_' + index + '_value').val('');
	$('#metaphor_new_type_'+ index).hide();
}

/*Function to show/hide expanded work titles on author page.  The initial limitation is five*/

