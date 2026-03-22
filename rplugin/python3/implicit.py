import pynvim
import ly.document as document
import ly.rhythm as rhythm
import lib.lyutils as lyutils


@pynvim.plugin
class Implicit(object):
    def __init__(self, nvim):
        self.nvim = nvim

    @pynvim.command("Implicit", range="", nargs="*", sync=True)
    def command_handler(self, args, rng):
        lyutils.apply_transformation(self.nvim, args, rhythm.rhythm_implicit)
