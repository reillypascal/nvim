import pynvim
import ly.document as document
import ly.pitch as pitch
import ly.pitch.transpose as transpose
import lib.lyutils as lyutils

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
    def command_handler(self, args, rng):
        # pass handler into apply_transformation
        # similarly to e.g., rhythm.rhythm_explicit
        def transposition_handler(cursor, args):
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

            transpose.transpose(cursor, transposer, "english")

        lyutils.apply_transformation(self.nvim, args, transposition_handler)
