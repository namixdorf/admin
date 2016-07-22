
class window.CohesiveAdmin
  @config = null

  @initialize: (@config) ->
    # publish initialize event
    $(document).trigger('cohesive_admin.initialized')
