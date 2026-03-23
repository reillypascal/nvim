import pynvim
import ly.document as document
import ly.rhythm as rhythm
import lib.lyutils as lyutils


@pynvim.plugin
class RPaste(object):
    def __init__(self, nvim):
        self.nvim = nvim

    @pynvim.command("RPaste", range="", nargs="0", sync=True)
    def command_handler(self, args, rng):
        durations = self.nvim.funcs.getreg("l").split()
        doc, input_has_brackets = lyutils.get_selection_as_doc(self.nvim)
        lyutils.update_buffer(
            self.nvim, durations, doc, input_has_brackets, rhythm.rhythm_overwrite
        )
