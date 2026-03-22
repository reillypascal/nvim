import pynvim
import ly.document as document


def apply_transformation(nvim, args, handler):
    # get entire current buffer
    buffer = nvim.current.buffer
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
    if len(args) > 0:
        handler(document.Cursor(doc, 0, None), args)
    else:
        handler(document.Cursor(doc, 0, None))

    # result as string; remove '{}'/space
    output = doc.plaintext().replace("{", "").replace("}", "").strip(" ")
    # put output string in '*' register
    nvim.funcs.setreg("*", output)
    nvim.api.feedkeys('gv"*p', "n", False)
