import pynvim
import ly.document as document
import ly.rhythm as rhythm
import lib.lyutils as lyutils


@pynvim.plugin
class Half(object):
    def __init__(self, nvim):
        self.nvim = nvim

    @pynvim.command("Half", range="", nargs="*", sync=True)
    def command_handler(self, args, rng):
        lyutils.apply_rhythm(self.nvim, args, rhythm.rhythm_halve)
