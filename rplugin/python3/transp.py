import pynvim

# from pynvim import api, attach

# zuban complains it can't find imports, but they seem
# to be available if 'ly' CLI tool is installed globally
import ly.document as document
import ly.pitch as pitch
import ly.pitch.transpose as transpose

# dictionary associates the absolute value of
# transposition with Lilypond note and modifier
intervals = {
    "a1": [0, 0.5],
    "m2": [1, -0.5],
    "M2": [1, 0],
    "a2": [1, 0.5],
    "m3": [2, -0.5],
    "M3": [2, 0],
    "a3": [2, 0.5],
    "d4": [3, -0.5],
    "p4": [3, 0],
    "a4": [3, 0.5],
    "d5": [4, -0.5],
    "p5": [4, 0],
    "a5": [4, 0.5],
    "m6": [5, -0.5],
    "M6": [5, 0],
    "a6": [5, 0.5],
    "m7": [6, -0.5],
    "M7": [6, 0],
    "a7": [6, 0.5],
}


@pynvim.plugin
class Transp(object):
    def __init__(self, nvim):
        self.nvim = nvim

    @pynvim.command("Transp", range="", nargs="*", sync=True)
    def command_handler(self, args, range):
        # string slice: 'm2+' becomes 'm2' transp and '+' direction
        transp = intervals[args[0][:2]]
        direction = args[0][2:]
        # oct is an optional argument; set to 0 if not set,
        # else convert passed string to int
        oct = int(args[1]) if len(args) >= 2 else 0

        # assign c to starting pitch if going up,
        # else assign it to dest
        start = (
            pitch.Pitch(0, 0, 0)
            if direction == "+"
            else pitch.Pitch(transp[0], transp[1], 0)
        )
        # dest always has octave
        dest = (
            pitch.Pitch(transp[0], transp[1], oct)
            if direction == "+"
            else pitch.Pitch(0, 0, oct)
        )
        transposer = transpose.Transposer(start, dest)

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
        transpose.transpose(document.Cursor(doc, 0, None), transposer, "english")

        # result as string; remove '{}'/space
        output = doc.plaintext().replace("{", "").replace("}", "").strip(" ")
        # put output string in '*' register
        self.nvim.funcs.setreg("*", output)
        self.nvim.api.feedkeys('gv"*p', "n", False)
