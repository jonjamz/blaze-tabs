2.1.0
=====

* Add `tabContent` block helper to wrap tab content areas.
  * Removes the need to use jQuery to show/hide tab content.
  * Allows Blaze logic to be used in tabbed interface content block, for example to control permissions. Before, this would
    sometimes cause a race condition that would run the jQuery to add attributes to tab content containers before they rendered.
  * Tab content areas wrapped in `tabContent` can be defined out-of-order and still work properly.
  * The simpler `<div>` based content areas are still supported.
* Support passing interface-level context into tabs content block.
* Update example code and docs.

2.0.0
=====

* Change `activeTab` template helper to `isActiveTab` to prevent name clash with an `activeTab`
  expression, as seen in the `dynamicTabs` example.
  * Breaks API from 1.0, but should be a very easy update.

1.1.0
=====

* Add support for `onRender` callback specified in the tabs array.
* Add `dynamicTabs` example.

1.0.0
=====

* Manually tested working version.
* Includes `basicTabs` example template.
* Supports router integration.
  * The `onChange` callback, which runs every time a tab changes and gives access to the new slug,
    allows tabs to change active route if desired.
  * A reactive `activeTab` value can be passed into the template, so an external route or var
    can dictate the currently active tab.
* Docs written.