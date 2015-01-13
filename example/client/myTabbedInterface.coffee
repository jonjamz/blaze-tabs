ReactiveTabs.createInterface
  template: 'basicTabs'
  onChange: (slug, template) ->
    console.log('[tabs] Tab has changed! Current tab:', slug)
    console.log('[tabs] Template instance calling onChange:', template)


Template['myTabbedInterface'].helpers
  tabs: ->
    return [
      { name: 'People', slug: 'people' }
      { name: 'Places', slug: 'places' }
      { name: 'Things', slug: 'things' }
    ]
