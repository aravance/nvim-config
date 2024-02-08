require('dressing').setup {}

local cmp = require('cmp')
cmp.setup.filetype('DressingInput', {
  sources = cmp.config.sources { { name = 'omni' } }
})
