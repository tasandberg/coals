# Coals

Built to ease the pain of navigating a large collection of rake tasks.  Simply type `coals` from a project root and
coals will walk you through the available groups, tasks, and any necessary arguments to run the command.

Features:
* See all rake tasks in your project in an organized format.
* Easily find the task you're looking for.
* No need to dig through the code to recall what arguments a task requires
* Verification step so you can see the fully constructed command before execution.
* TODO: Configurable execution prefix (`bundle exec`(default), `zeus rake`, etc..)
* TODO: Aliases for common task arguments, e.g.
  ```
  $ coals --set-alias me timmehs@github.com
  Coals alias "me" set to timmehs@github.com
  ```
* TODO: Colors and Formatting
* TODO: Command help docs


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'coals'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install coals

## Usage

From within a ruby project with a Rakefile, run `coals` and follow the prompts. ...
```
$ coals
Available Task Groups
1.  build (1)                     2.  clean (1)                     3.  clobber (1)                   4.  install (2)
5.  release (1)                   6.  test (1)
Choose an option:
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Timmehs/coals. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
