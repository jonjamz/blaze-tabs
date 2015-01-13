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