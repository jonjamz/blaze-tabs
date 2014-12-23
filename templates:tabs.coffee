
@ReactiveTabs = do ->

  createInterface = (options) ->

    check options, Match.ObjectIncluding
      template: String
      onChange: Match.Optional(Function)

    template = Template[options.template]

    if template

      events = {}

      events['click .tab-item'] = (e, t) ->
        t._activeTab.set(this.slug)

      created = ->
        self = this
        activeTab = null
        check(self.data.tabs, Array)
        check(self.data.activeTab, Match.Optional(String))

        if self.data.activeTab
          activeTab = self.data.activeTab # should use slug for routes compatibility

        self._tabs = new ReactiveArray(self.data.tabs)
        self._activeTab = new Blaze.ReactiveVar(activeTab)

      rendered = ->
        self = this
        tabs = self._tabs.get()
        contentBlocks = self.findAll('.tabs-content-container > div')

        # Add data-tab attribute to all tabbed content areas
        for tab, i in tabs
          ($ contentBlocks[i]).addClass('tabs-content').attr('data-tab', tab.slug)

        # Sync corresponding content areas with active tab
        self.autorun ->
          activeTab = self._activeTab.get()
          ($ self.findAll('.tabs-content')).hide()
          ($ self.find("[data-tab='#{activeTab}']")).show()
          if options?.onChange?
              options.onChange(activeTab)

        # If no active tab specified, default to the first tab
        if self._activeTab.get() is null
          self._activeTab.set(tabs[0].slug)

      helpers = {
        activeTab: (slug) ->
          if Template.instance()._activeTab.get() is slug
            return 'active'
      }

      # Put it all together!
      template.created = created
      template.rendered = rendered
      template.helpers(helpers)
      template.events(events)

  return {
    createInterface: createInterface
  }
