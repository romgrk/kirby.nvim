# kirby.nvim

Fuzzy picker based on [kui.nvim](https://github.com/romgrk/kui.nvim).

![demo](./assets/demo.png)

This plugin depends on the ones listed below. If you're using lazy.nvim, the config would 
probably look something like the one below. I'm guessing. It also has the following hard
dependencies that you need to ensure.
 - POSIX-compliant enough OS
 - libcairo
 - terminal with kitty graphics protocol support

```lua
{ "romgrk/kirby.nvim", dependencies = {
    { "romgrk/fzy-lua-native", build = "make install" },
    { "romgrk/kui.nvim" },
  },
},
```

## Usage

This plugin maps `<C-p>` to opening the file picker, unless that key is already mapped.
You can create your own mapping by using the command `:KirbyFilePicker`.

## License

JSON license (MIT license + non-evilness clause)
