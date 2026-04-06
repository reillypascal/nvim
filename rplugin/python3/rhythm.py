import pynvim
import ly.document as document
import ly.rhythm as rhythm
import lib.lyutils as lyutils


@pynvim.plugin
class RExtract(object):
    def __init__(self, nvim):
        self.nvim = nvim

    @pynvim.command("Rhythm", range="", nargs="*", sync=True)
    def command_handler(self, args, rng):
        doc, input_has_brackets = lyutils.get_selection_as_doc(self.nvim)
        match args[0]:
            case "double":
                lyutils.update_buffer(
                    self.nvim, [], doc, input_has_brackets, rhythm.rhythm_double
                )
            case "half":
                lyutils.update_buffer(
                    self.nvim, [], doc, input_has_brackets, rhythm.rhythm_halve
                )
            case "dot":
                lyutils.update_buffer(
                    self.nvim, [], doc, input_has_brackets, rhythm.rhythm_dot
                )
            case "undot":
                lyutils.update_buffer(
                    self.nvim, [], doc, input_has_brackets, rhythm.rhythm_undot
                )
            case "copy":
                durations = rhythm.rhythm_extract(document.Cursor(doc, 0, None))
                self.nvim.funcs.setreg("l", " ".join(durations))
            case "paste":
                durations = self.nvim.funcs.getreg("l").split()
                lyutils.update_buffer(
                    self.nvim,
                    durations,
                    doc,
                    input_has_brackets,
                    rhythm.rhythm_overwrite,
                )
            case "write":
                lyutils.update_buffer(
                    self.nvim, args, doc, input_has_brackets, rhythm.rhythm_overwrite
                )
            case "exp":
                lyutils.update_buffer(
                    self.nvim, [], doc, input_has_brackets, rhythm.rhythm_explicit
                )
            case "imp":
                lyutils.update_buffer(
                    self.nvim, [], doc, input_has_brackets, rhythm.rhythm_implicit
                )
            case _:
                print(f"Rhythm: no action available for {args[0]}")
