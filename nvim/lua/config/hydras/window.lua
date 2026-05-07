local Hydra = require('hydra')

Hydra({
  name = 'Window Management',
  hint = [[
 ^ ^          Window Control
 ^ ^ _h_ _j_ _k_ _l_ : Navigate
 ^ ^ _H_ _J_ _K_ _L_ : Resize
 ^ ^ _s_ / _v_ : Split (H/V)
 ^ ^ _c_ : Close  _o_ : Only
 ^ ^          _<Esc>_ : Quit
]],
  config = {
    color = 'pink',
    invoke_on_body = true,
    hint = { position = 'middle' },
  },
  mode = 'n',
  body = '<leader>w',
  heads = {
    { 'h',     '<C-w>h' },
    { 'j',     '<C-w>j' },
    { 'k',     '<C-w>k' },
    { 'l',     '<C-w>l' },
    { 'H',     '<C-w>3<' },
    { 'L',     '<C-w>3>' },
    { 'K',     '<C-w>2+' },
    { 'J',     '<C-w>2-' },
    { 's',     '<C-w>s' },
    { 'v',     '<C-w>v' },
    { 'c',     '<C-w>c' },
    { 'o',     '<C-w>o' },
    { '<Esc>', nil,      { exit = true } },
  }
})
