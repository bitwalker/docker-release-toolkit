## Docker Release Toolkit

This repo contains the core of what is needed to build an Elixir release via Docker. It
first builds the app and release in one container, then exports that container into a new,
minimal container.

## Usage

All you should have to do is edit `Makefile` and set `APP` to your app's name, and edit
`VERSION` to set the correct version. You can also modify how those are set to your heart's
content. That's it!

Run `make` for available commands.

## License

MIT
