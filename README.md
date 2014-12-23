About
-----

Build any tabbed interface *really easily*.

All instances of tabbed interfaces will be self-contained and individually reactive.

Install
-------

`meteor add templates:tabs`

This package works on the client-side only.

Usage
-----

#### Basic use

Use the included `basicTabs` template. First, register it with ReactiveTabs:

```javascript
ReactiveTabs.createInterface({
  template: 'basicTabs',
  onChange: function (slug) {
    // Do whatever you want here--this fires every time the tab changes
    console.log('Tab has changed:', slug);
  }
})
```

Then, provide tabs like this in a parent template.

```javascript
Template.myTemplate.helpers({
  tabs: function () {
    // Every tab object MUST have a name and a slug!
    return [
      { name: 'People', slug: 'people' },
      { name: 'Places', slug: 'places' },
      { name: 'Things', slug: 'things', onRender: function() {
        alert("Initialize things.");
      }}
    ];
  },
  activeTab: function () {
    // This is optional.
    // If you don't provide an active tab, the first one is selected by default.
    // You can also set this using an Iron Router param if you want--
    // or a Session variable, or any reactive value from anywhere.
  }
});
```

Finally, wrap your tabbed interface using `basicTabs` as a block helper:

```handlebars
<template name="myTemplate">

  <!-- Use `name` to add a custom class to the outer container -->
  {{#basicTabs name="" tabs=tabs}}
    <!--
      Note:

      Each tabbed section is wrapped in a blank <div>.
      These sections correspond with the order of the tabs you specified.
    -->
    <div>
      <h2>People</h2>
      <button class="add-people">
        Add People
      </button>
    </div>

    <div>
      <h2>Places</h2>
      <button class="add-places">
        Add Places
      </button>
    </div>

    <div>
      <h2>Things</h2>
      <button class="add-things">
        Add Things
      </button>
    </div>

  {{/basicTabs}}

</template>
```

#### Roll your own template

Turn any compatible template into a tabbed interface by calling `ReactiveTabs.createInterface()`.

Follow this model:

```handlebars

<template name="yourTabbedInterface">

  <div class="yourTabbedInterface-container">

    <!-- You can put the tabs anywhere and style them however you want! -->
    <ul class="tabs-list">
      {{#each tabs}}
        <li class="tab-item {{activeTab slug}}">{{name}}</li>
      {{/each}}
    </ul>

    <!-- Here's where the active tab will be displayed -->
    <div class="tabs-content-container">
      {{> UI.contentBlock}}
    </div>

  </div>

</template>

```

And then, as you saw above:

```javascript
ReactiveTabs.createInterface({
  template: 'yourTabbedInterface',
  onChange: function (slug) {
    // Do whatever you want here--this fires every time the tab changes
    console.log('Tab has changed:', slug);
  }
})
```

Now you can go...

```handlebars
{{#yourTabbedInterface tabs=tabsHelper}}

  <!-- First tab's section -->
  <div></div>

  <!-- Second tab's section -->
  <div></div>

  <!-- And so on... -->
{{/yourTabbedInterface}}
```
Provided that `tabsHelper` (in this example) has the array of tab objects.

#### How to specify tabs

Tabbed interfaces created with this package exist as template block helpers.

These block helpers require an array of tabs to be passed into them:

```handlebars
{{#yourTabbedInterface tabs=thisIsTheArrayOfTabs}}
  <!-- Content -->
{{/yourTabbedInterface}}
```

Each tab in the array exists as an object with the following properties and methods:

Field     | Type | Required
:---------|:------|:---------
name | *String* | **Yes**
slug | *String* | **Yes**
onRender | *Function* | No

```javascript
var tabs = [
  { name: 'People', slug: 'people' },
  { name: 'Places', slug: 'places' },
  { name: 'Things', slug: 'things', onRender: function() {
    alert("Initialize things.");
  }}
];
```

Slugs should be URL-compatible strings without capital letters or spaces.

**To be extra clear: you must provide both name and slug.**

Contributors
------------

* [Jon James](http://github.com/jonjamz)
* [Andrew Reedy](http://github.com/andrewreedy)

My goal with this package is to keep it simple and flexible, similar to core packages.

As such, it may already have everything it needs.

**Please create issues to discuss feature contributions before creating a pull request.**
