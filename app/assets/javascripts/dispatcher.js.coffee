$ ->
  new Dispatcher()

class Dispatcher
  constructor: () ->
    @page = $('body').attr('data-page')
