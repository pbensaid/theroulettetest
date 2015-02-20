# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  counter = 3

  $('form').on 'click', '.remove_fields', (event) ->
    fieldsets = $('form').first().find('fieldset')

    if fieldsets.length < 4
      event.preventDefault()
      return

    i = fieldsets.length - 1
    while i > fieldsets.length - 4
      fieldsets[i].remove()
      i--

    counter -= 3

    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    ids = $(this).data('id').split(',')

    i = 1
    fields = $(this).data('fields')
    while i < 4
      regexp = new RegExp(ids[i - 1], 'g')
      fields = fields.replace(regexp, counter)
      counter++
      i++
    $(this).before(fields)
    event.preventDefault()

  $(document).on 'click', '#option-block', ->
    $('#new_vote').submit()
    return

$(document).ready(ready)
$(document).on('page:load', ready)

