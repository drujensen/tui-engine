# Text Based Gaming Engine

A library to support Text Based Games.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     text-based-gaming-engine:
       github: drujensen/text-based-gaming-engine
   ```

2. Run `shards install`

## Usage

```crystal
require "text-based-gaming-engine"
```

The core of this library is the layered TextMap.

A TextMap provides a way to build maps in a higharchical layered manner.

There should be a single root map that handles the background and covers the whole playing area.
Then you add other smaller maps on top of it that represent Menus, Objects or Characters in the game.
When rendering the root TextMap, it will call render on each of the children.  If there is a conflict
where two TextMaps collide, an action is triggered.

## Development

This library is written using the Crystal programming language. No other dependencies are needed.

## Contributing

1. Fork it (<https://github.com/drujensen/text-based-gaming-engine/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Dru Jensen](https://github.com/drujensen) - creator and maintainer
