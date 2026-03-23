import pynvim
import ly.document as document
import ly.rhythm as rhythm
import lib.lyutils as lyutils


@pynvim.plugin
class Halve(object):
    def __init__(self, nvim):
        self.nvim = nvim

    @pynvim.command("Halve", range="", nargs="*", sync=True)
    def command_handler(self, args, rng):
        doc, input_has_brackets = lyutils.get_selection_as_doc(self.nvim)
        lyutils.update_buffer(
            self.nvim, args, doc, input_has_brackets, rhythm.rhythm_halve
        )
