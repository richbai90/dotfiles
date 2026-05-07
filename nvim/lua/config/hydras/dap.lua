local Hydra = require("hydra")
local dap = require('dap')

Hydra({
  name = 'Debug',
  hint = [[
 ^ ^      Step Controls
 _n_: Next (Over)  _i_: Into
 _o_: Out          _c_: Continue
 _b_: Breakpoint   _x_: Terminate
 ^ ^      _<Esc>_ : Exit
]],
  config = {
    color = 'pink',
    invoke_on_body = true,
  },
  mode = 'n',
  body = '<leader>d',
  heads = {
    { 'n',     dap.step_over },
    { 'i',     dap.step_into },
    { 'o',     dap.step_out },
    { 'c',     dap.continue },
    { 'b',     dap.toggle_breakpoint },
    { 'x',     dap.terminate },
    { '<Esc>', nil,                  { exit = true } },
  }
})
