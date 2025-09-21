## Breaking changes

- We have officially removed support for the properties `tag`, `alias`, `cssclass` in favor of `tags`, `aliases` and `cssclasses`. In addition, the values of these properties _must_ be a list. If the current value is a text property, it will no longer be recognized by Obsidian.  
    In the "Format converter" core plugin, there is a new option to fix any incorrectly formatted `aliases`, `tags`, and `cssclasses` in your vault. It will also migrate your old `alias`, `tag`, and `cssclass` properties to the new format.