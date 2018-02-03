;(function() {

  /* buttonDropdownInput */
  var dropdownButtonInputBinding = new Shiny.InputBinding()
  console.log("I exist.")

  $.extend(dropdownButtonInputBinding, {
      /* shiny API */
      find: function(scope) {
          return $(scope).find(".dropdown-button-input")
      },

      initialize: function(el) {
        var widget = $(el)
        widget.data("value", null)

        widget.on("click", "a", function(event) {
          widget.data('value', $(event.target).attr('value'))

          widget.trigger("change")
          event.preventDefault()
        })
      },

      getValue: function(el) {
        return $(el).data('value')
      },

      setValue: function(el, value) {
        $(el).data('value', value)
      },

      subscribe: function(el, callback) {
        $(el).on("change.dropdownButtonInputBinding", function(e) { callback() })
      },

      unsubscribe: function(el) {
        $(el).off(".dropdownButtonInputBinding")
      },

      receiveMessage: function(el, value) {
        $(el).data('value', value)
        $(el).trigger('change')
      }


  })

  Shiny.inputBindings.register(dropdownButtonInputBinding)

})();
