# TUI Engine

TUI Engine is a text based gaming engine.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     tui-engine:
       github: drujensen/tui-engine
   ```

2. Run `shards install`

## Usage

```crystal
require "tui-engine"
```

This library provides a gaming engine, a text based ui components for display, and an event system for actions.

A base Map provides a way to build a hierarchical layered UI.

There should be a root map that handles the background and covers the whole playing area.
Then you add other layers of maps on top of it that represent Menus, Objects or Characters in the game.
When rendering the root Map, it will call render on each of the children.

An Event system is provide to register for events. There are 4 events:
 - TickEvent - Every tick in the game loop
 - KeyEvent - When a key is pressed
 - BumpEvent - When a map is moved outside of the parent maps boundary
 - ActionEvent - When two sibling maps collide that are on the same z axis

A game engine is provided that handles the game loop.  It reads any input, calls the update to render the maps and then outputs the rendered up.  The loop is ran at 30fps.

## Development

This library is written using the Crystal programming language. No other dependencies are needed.

## Contributing

1. Fork it (<https://github.com/drujensen/tui-engine/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Dru Jensen](https://github.com/drujensen) - creator and maintainer
