x5050
=====

A macOS command-line script to set up a split layout of a terminal emulator
and a web browser.

```
,-------------------.                               ,-----------.,-----------.
|-------------------|                               |-----------||-----------|
|                   |                               |           ||           |
| $ x5050 right     |--.         ,-.(  ).-,         |           ||           |
|                   |--|      ,-(          )-.      | $ x5050   ||  Google   |
|                   |  |  +~~(     *MAGIC*    )~~>  | $         ||           |
|                   |  |      `-(          ),-'     |           || [_______] |
`------+------------'  |          `-.( ).-'         |           ||   == ==   |
       |               |                            |           ||           |
       `---------------'                            |           ||           |
                                                    `-----------'`-----------'
```

Build
-----

```sh
make
```

And put `x5050` in a directory in `$PATH`.

Run
---

`x5050` takes four optional arguments. The order of arguments doesn't matter.

- Position: `right` (default), `left`, `up`, `down`
- Percent size: 1 ~ 100 (default 50)
- Browser: Tested with `Chrome` (default) and `Safari`
- URL to open

### Examples

```sh
x5050
x5050 left
x5050 down 40
x5050 https://github.com/junegunn
x5050 up Safari https://google.com
```

Rationale
---------

A few years ago, I wrote [vim-xmark][xmark], a minimal Markdown preview plugin
for Vim. It does two things:

1. Set up a split layout, Vim and a web browser, using AppleScript
2. Convert Markdown document using [pandoc][pandoc] and display it in the
   browser window

The implementation is simple and it still works fine, but lately I've been
trying out [markdown-preview.nvim][mkdp] which provides better preview
functionality (e.g. immediate update, synchronized scroll, etc). So
I extracted the split layout code from [vim-xmark][xmark] into *x5050* so
I can use it with the new plugin.

```vim
if has('mac') && executable('x5050')
  function! MKDPSplit(url)
    call system('x5050 '.shellescape(a:url))
  endfunction

  let g:mkdp_browserfunc = 'MKDPSplit'
endif
```

[mkdp]:   https://github.com/iamcco/markdown-preview.nvim
[pandoc]: https://pandoc.org/
[xmark]:  https://github.com/junegunn/vim-xmark

Alternatives
------------

You can do the same thing pretty easily with
[Hammerspoon](http://www.hammerspoon.org/) like so:

```lua
local screen = hs.window.focusedWindow():screen()
hs.layout.apply({
  { hs.window.focusedWindow(), nil, screen, hs.layout.left50 },
  { "Chrome", nil, screen, hs.layout.right50 }
})
```

License
-------

MIT
