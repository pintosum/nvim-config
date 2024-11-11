return {
  "pintosum/reverb.nvim",
  --[[name = "reverb.nvim",
  dev = {true},
  dir = "~/nvim_forks/reverb.nvim",]]--
  event = "User",
  opts = {
    player = "pw-play", -- options: paplay (default), pw-play, mpv
    max_sounds = 20, -- Limit the amount of sounds that can play at the same time
    sounds = {
      -- add custom sound paths for other events here
      -- eg. EVENT = "/some/path/to/sound.mp3"
      User = { path = "/home/serush/.config/nvim/lua/pintosum/badapple.mp3", volume = 50, match = "badapple"},
    },
  },
}
