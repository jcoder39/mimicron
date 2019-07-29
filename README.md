# Mimicron

**Simple callstack tracer. It was written for educational purposes**

## Installation

Add `mimicron` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:mimicron, "~> 0.1.1"}
  ]
end
```

## Usage

Add `use Mimicron` in every module that you want to being traced.
If you want to disable tracing, add `config :mimicron, active: false` to `config/config.ex`

### Sample

run `mix test`

## TODO

- [ ] support private functions
- [ ] display params of function

## License

[The MIT License (MIT)](LICENSE.md)