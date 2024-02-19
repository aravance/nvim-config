return {
  'chrisgrieser/nvim-genghis',
  dependencies = {
    {
      'stevearc/dressing.nvim',
      config = function()
        require('dressing').setup {}

        local cmp = require('cmp')
        cmp.setup.filetype('DressingInput', {
          sources = cmp.config.sources { { name = 'omni' } }
        })
      end,
    },
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-omni',
  }
}
