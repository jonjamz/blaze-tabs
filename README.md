About
-----

Build any tabbed interface:
* *really easily*.
* *with custom templates*.
* *with router integration*.

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
  onChange: function (slug, templateInstance) {
    // Do whatever you want here--this runs every time the tab changes, across all instances of this template
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
      { name: 'Things', slug: 'things', onRender: function(templateInstance) {
        // This runs every time this tab's content renders, unique to the instance(s) using this array
        alert("Initialize things.");
      }}
    ];
  },
  activeTab: function () {
    /* This is optional.
     * If you don't provide an active tab, the first one is selected by default.
     * You can also set this using an Iron Router param if you want--
     * or a Session variable, or any reactive value from anywhere.
     *
     * See the `advanced use` section below to learn about dynamic tabs.
     * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
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

#### Advanced use

Try the included `dynamicTabs` template. Just register it with ReactiveTabs first.

```javascript
ReactiveTabs.createInterface({
  template: 'dynamicTabs',
  onChange: function (slug) {
    // Do whatever you want here--this fires every time the tab changes
    console.log('Tab has changed:', slug);
  }
})
```

View that template's source code, and note this:

```handlebars
{{trackTabs tabs}}
{{trackActiveTab activeTab}}
```

These helpers allow us to sync data from the parent with internal data in the tabbed interface.

This presents us with some interesting abilities, detailed below.

**1. Changing active tab from the parent template**

Sometimes, you want to change active tab reactively--for example, based on a route.

To do this, you need your ReactiveTabs interface to respond when you change your `activeTab` helper in the parent template.

Enabling this functionality is simple:

* Make sure you specify an `activeTab` helper in the parent template, as we did in the first example.
* Pass `activeTab` into your block helper, like `{{#dynamicTabs tabs=tabs activeTab=activeTab}}`
* Include `{{trackActiveTab activeTab}}` at the top of your tabbed interface template (see below).
* The value of `activeTab` can be either:
  * **slug** (a string, the name of the currently active slug)
  * **tab** (an object, including at least the `slug` property)

**2. Changing the number or order of tabs dynamically**

Usually, you never need to update your array of tabs. But if you do, ReactiveTabs can handle it.

Here's what you need to change to work with dynamic tabs:

* Instead of using a normal array for your `tabs` helper, use a [ReactiveArray](https://github.com/meteortemplates/array/) instance.
* At the top of your tabbed interface template, add `{{trackTabs tabs}}` (see below).
* Consider separating your tab content into separate templates, named by slug, and using [Template.dynamic](http://docs.meteor.com/#/full/template_dynamic).
* If you don't add reactivity to your tab content that somehow syncs it with the state of your `tabs` array, you'll need to manually update the DOM *before* you change the value of the tab array.

> If easier dynamic tabs becomes a much-requested feature, we can optimize the package more for that use.

#### Roll your own template

Turn any compatible template into a tabbed interface by calling `ReactiveTabs.createInterface()`.

Follow this model:

```handlebars

<template name="yourTabbedInterface">

  <div class="yourTabbedInterface-container">

    <!-- These are optional if you want to track parent data (see above) -->
    {{trackTabs tabs}}
    {{trackActiveTab activeTab}}

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
  onChange: function (slug, templateInstance) {
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

Field     | Type       | Required
:---------|:-----------|:---------
name      | *String*   | **Yes**
slug      | *String*   | **Yes**
onRender  | *Function* | No

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
