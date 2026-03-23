import pynvim
import ly.barcheck as barcheck
import ly.document as document
import lib.lyutils as lyutils


@pynvim.plugin
class BarcheckRemove(object):
    def __init__(self, nvim):
        self.nvim = nvim

    @pynvim.command("BarcheckRemove", range="", nargs="0", sync=True)
    def command_handler(self, args, rng):
        doc, input_has_brackets = lyutils.get_selection_as_doc(self.nvim)
        lyutils.update_buffer(self.nvim, args, doc, input_has_brackets, barcheck.remove)
