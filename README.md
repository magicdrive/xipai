# [WIP] Xipai

Reproducible based on seeds or random shuffling tool.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'xipai'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install xipai

## Usage

```
$ xipai help
Commands:
  xipai help [COMMAND]                                                # Describe available commands or one specific command
  xipai lottery -A, --items=ITEMS -m, --number-of-winners=N           # Reproducible based on seeds or random shuffling, then extruct lottery winner.
  xipai pair -K, --key-items=KEY_ITEMS -V, --value-items=VALUE_ITEMS  # Reproducible based on seeds or random shuffling, then pairing key-items and value-items.
  xipai replay -c, --replay-yaml=REPLAY_YAML                          # Replay shuffling with xipai-replay yaml
  xipai order -A, --items=ITEMS                                      # Reproducible based on seeds or random shuffling.
  xipai team -A, --items=ITEMS -m, --number-of-members=N              # Reproducible based on seeds or random shuffling, then create teams
  xipai version                                                       # Show xipai version
```

```
$ xipai help order
Usage:
  xipai order -A, --items=ITEMS

Options:
  -w, [--key-words=KEY_WORDS]                        # Comma-separated seed string
  -c, [--hashcode=HASHCODE]                          # Hashcode to identify this randomization
  -n, [--without-hashcode], [--no-without-hashcode]  # Do not use hashcode for randomization
  -A, --items=ITEMS                                  # Items to be shuffled. (comma-separated)
  -p, [--pretty], [--no-pretty]                      # Pretty print output.
  -o, [--replay-output=REPLAY_OUTPUT]                # Output xeplay-replay yaml to specified path
  -v, [--verbose], [--no-verbose]                    # Verbose mode Output

Reproducible based on seeds or random shuffling, then ordered
```

```
$ xipai help lottery
Usage:
  xipai lottery -A, --items=ITEMS -m, --number-of-winners=N

Options:
  -m, --number-of-winners=N                          # Number of winners
  -w, [--key-words=KEY_WORDS]                        # Comma-separated seed string
  -c, [--hashcode=HASHCODE]                          # Hashcode to identify this randomization
  -n, [--without-hashcode], [--no-without-hashcode]  # Do not use hashcode for randomization
  -A, --items=ITEMS                                  # Items to be shuffled. (comma-separated)
  -p, [--pretty], [--no-pretty]                      # Pretty print output.
  -o, [--replay-output=REPLAY_OUTPUT]                # Output xeplay-replay yaml to specified path
  -v, [--verbose], [--no-verbose]                    # Verbose mode Output

Reproducible based on seeds or random shuffling, then extruct lottery winner.
```


```
$ xipai help pair
Usage:
  xipai pair -K, --key-items=KEY_ITEMS -V, --value-items=VALUE_ITEMS

Options:
  -w, [--key-words=KEY_WORDS]                        # Comma-separated seed string
  -c, [--hashcode=HASHCODE]                          # Hashcode to identify this randomization
  -n, [--without-hashcode], [--no-without-hashcode]  # Do not use hashcode for randomization
  -K, --key-items=KEY_ITEMS                          # Items to be shuffled. (comma-separated)
  -V, --value-items=VALUE_ITEMS                      # Items to be shuffled. (comma-separated)
  -p, [--pretty], [--no-pretty]                      # Pretty print output.
  -o, [--replay-output=REPLAY_OUTPUT]                # Output xeplay-replay yaml to specified path
  -v, [--verbose], [--no-verbose]                    # Verbose mode Output

Reproducible based on seeds or random shuffling, then pairing key-items and value-items.
```

```bash
$ xipai help team
Usage:
  xipai team -A, --items=ITEMS -m, --number-of-members=N

Options:
  -m, --number-of-members=N                          # Number of team-members
  -w, [--key-words=KEY_WORDS]                        # Comma-separated seed string
  -c, [--hashcode=HASHCODE]                          # Hashcode to identify this randomization
  -n, [--without-hashcode], [--no-without-hashcode]  # Do not use hashcode for randomization
  -A, --items=ITEMS                                  # Items to be shuffled. (comma-separated)
  -p, [--pretty], [--no-pretty]                      # Pretty print output.
  -o, [--replay-output=REPLAY_OUTPUT]                # Output xeplay-replay yaml to specified path
  -v, [--verbose], [--no-verbose]                    # Verbose mode Output

Reproducible based on seeds or random shuffling, then create teams
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/magicdrive/xipai. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/magicdrive/xipai/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Xipai project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/magicdrive/xipai/blob/main/CODE_OF_CONDUCT.md).
