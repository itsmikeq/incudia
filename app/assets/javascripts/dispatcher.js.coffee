class Dispatcher
  constructor: () ->
    @page = $('body').attr('data-page')

$ ->
  new Dispatcher()

