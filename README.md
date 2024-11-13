% README.md

`Sampler` provides the ability to render `ERB` templates based on models expressed in JSON file. The main idea is to turn JSON into `OpenStruct` and pass it to templates as `model` variable.

# Usage

Run `exe/sampler.rb` and see the options

    $ ruby exe/sampler.rb

# Model

Sampler reads JSON file and builds the tree of `OpenStruct` objects so fields that you see in the JSON become methods of the object.

Suppose one has the following JSON:

```json
{
  "name": "Device",
  "desc": "Device",
  "classes": [
    {
      "name": "Memory Block",
      "addresses": [1, 2, 3]
    }
    {
      "name": "Identificatioin Page",
      "addresses": [1, 2, 3]
    }
  ]
}
```

After parsing, it becomes full fledged Ruby object, where you can access JSON fields as methods:

```ruby
model.name
model.desc
model.classes.size
model.classes.first.name
model.classes.first.addresses
model.classes.first.addresses.first
```

# Samples

The `samples` folder provides examples of JSON model, ERB template, and custom helper (`helper.rb`). All custom objects and functions placed in the helper will be available inside templates.
