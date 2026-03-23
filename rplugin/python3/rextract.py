import pynvim
import ly.document as document
import ly.rhythm as rhythm
import lib.lyutils as lyutils


@pynvim.plugin
class RExtract(object):
    def __init__(self, nvim):
        self.nvim = nvim

    @pynvim.command("RExtract", range="", nargs="0", sync=True)
    def command_handler(self, args, rng):
        doc, _ = lyutils.get_selection_as_doc(self.nvim)
        durations = rhythm.rhythm_extract(document.Cursor(doc, 0, None))
        self.nvim.funcs.setreg("l", " ".join(durations))
