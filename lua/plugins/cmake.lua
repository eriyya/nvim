local util = require('util')

return {
  {
    'Civitasv/cmake-tools.nvim',
    config = function()
      require('cmake-tools').setup({
        cmake_build_directory = function()
          if util.IS_WINDOWS then
            return 'out\\${variant:buildType}'
          else
            return 'out/${varient:buildType}'
          end
        end,
      })
    end,
  },
}
