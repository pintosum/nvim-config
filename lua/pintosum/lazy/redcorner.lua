local redcorner = {
  "redcorner",
  dir = "~/nvim_personal/Redcorner",
  config = function()
    local redcorner = require("redcorner")

    redcorner:setup()
  end
}

return redcorner
