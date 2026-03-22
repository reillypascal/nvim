import pynvim

# from pynvim import api, attach

# zuban complains it can't find imports, but they seem
# to be available if 'ly' CLI tool is installed globally
import ly.document as document
import ly.rhythm as rhythm


@pynvim.plugin
class Double(object):
    def __init__(self, nvim):
        self.nvim = nvim

    @pynvim.command("Double", range="", nargs="*", sync=True)
    def command_handler(self, args, rng):
        # get entire current buffer
        buffer = self.nvim.current.buffer
        # get visual boundary marks
        vstart = buffer.mark("<")
        vend = buffer.mark(">")

        # index/slice portion of buffer
        string = buffer[vstart[0] - 1][vstart[1] : vend[1] + 1]
        # if selection doesn't include '{}',
        # `ly` requires them, so wrap around string
        if "{" not in string and "}" not in string:
            string = "{" + string + "}"

        # turn string into Document
        doc = document.Document(string)
        # perform transposition
        rhythm.rhythm_double(document.Cursor(doc, 0, None))

        # result as string; remove '{}'/space
        output = doc.plaintext().replace("{", "").replace("}", "").strip(" ")
        # put output string in '*' register
        self.nvim.funcs.setreg("*", output)
        self.nvim.api.feedkeys('gv"*p', "n", False)
