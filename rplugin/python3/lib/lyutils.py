import pynvim
import ly.document as document


def apply_transformation(nvim, args, handler):
    # get entire current buffer
    buffer = nvim.current.buffer
    # get visual boundary marks
    vstart = buffer.mark("<")
    vend = buffer.mark(">")

    # join lines into string w/ '\n' if multi-line, else just slice line
    if vend[0] > vstart[0]:
        # number of lines needs to be *inclusive*
        numlines = vend[0] - vstart[0] + 1
        lines = []
        for i in range(numlines):
            # first and last lines *may* need to be sliced
            if i == 0:
                # convert starting/ending line to 0-index
                lines.append(buffer[vstart[0] - 1][vstart[1] :])
            elif i == numlines - 1:
                # add 1 to end column to make inclusive
                lines.append(buffer[vend[0] - 1][: vend[1] + 1])
            else:
                lines.append(buffer[vstart[0] - 1 + i])
        string = "\n".join(lines)
    else:
        # index/slice portion of buffer; make start row 0-indexed, end column inclusive
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
