$ ->
  init_sections_sortable()
  activateAJAXwysiwyg()
  activateAJAXsortable()

  $(document).on 'click', 'a.button.section_has_many_remove', (e)->
    e.preventDefault()
    parent    = $(@).closest '.section_has_many_container'
    to_remove = $(@).closest 'fieldset'
    recompute_positions parent

    parent.trigger 'section_has_many_remove:before', [to_remove, parent]
    to_remove.remove()
    parent.trigger 'section_has_many_remove:after', [to_remove, parent]

  $(document).on 'click', 'a.button.section_has_many_add', (e)->
    e.preventDefault()
    parent = $(@).closest '.section_has_many_container'
    parent.trigger before_add = $.Event('section_has_many_add:before'), [parent]

    unless before_add.isDefaultPrevented()
      index = parent.data('section_has_many_index') || parent.children('fieldset').length - 1
      parent.data has_many_index: ++index

      regex = new RegExp $(@).data('placeholder'), 'g'
      html  = $(@).data('html').replace regex, index

      fieldset = $(html).insertBefore(@)
      recompute_positions parent
      parent.trigger 'section_has_many_add:after', [fieldset, parent]

  $('.json_container').on 'change', '.section_type_select', (event) ->
    fieldset = $(this).closest 'fieldset'

    selectedOption = $(this).find 'option:selected'
    formPath = selectedOption.data 'path'

    label = $(this).prev 'label'
    label.remove()

    # hiddenField = $('<input type="hidden" />')
    # hiddenField.attr 'name', $(this).attr('name')
    # hiddenField.val $(this).val()

    $(this).parents('ol').first().remove()#replaceWith hiddenField

    newListItem = $ '<li>'

    formName = $(this).attr('name').split("[parts]")[0]

    extractAndInsertSectionForm formPath, fieldset, formName

activateAJAXwysiwyg = ->
  $(document).ajaxSuccess( ->
    $('.wysihtml5:not(.initialized)').each( ->
      editor = new wysihtml5.Editor($(this).find('textarea').attr('id'), # id of textarea element
      { 
        toolbar: $(this).find('.toolbar').attr('id'),                    # id of toolbar element
        parserRules:  wysihtml5ParserRules                               # defined in parser rules set 
      })
      $(@).addClass('initialized')
    )
  )

activateAJAXsortable = ->
  $(document).ajaxSuccess( ->
    init_sections_sortable()
  )


window.extractAndInsertSectionForm= (url, target, formName)->
  target = $ target

  $.get url + "?form_name=#{formName}", (data) ->
    target.prepend data
    return false


init_sections_sortable = ->
  elems = $('.json_container[data-sortable]:not(.ui-sortable)')
  if elems.length
    elems.sortable
      axis: 'y'
      items: '> fieldset',
      handle: '> ol > .handle',
      stop: recompute_positions
    elems.each recompute_positions

recompute_positions = (parent)->
  parent     = if parent instanceof jQuery then parent else $(@)
  input_name = parent.data 'sortable'
  position   = parseInt(parent.data('sortable-start') || 0, 10)

  parent.children('fieldset').each ->
    # We ignore nested inputs, so when defining your has_many, be sure to keep
    # your sortable input at the root of the has_many block.
    destroy_input  = $(@).find "> .input > :input[name$='[_destroy]']"
    sortable_input = $(@).find "> .input > :input[name$='[#{input_name}]']"

    if sortable_input.length
      sortable_input.val if destroy_input.is ':checked' then '' else position++