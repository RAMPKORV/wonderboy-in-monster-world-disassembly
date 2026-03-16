# pyright: reportUndefinedVariable=false, reportOptionalMemberAccess=false, reportPossiblyUnboundVariable=false

import json
import os

try:
    getScriptArgs
except NameError:
    def getScriptArgs():
        return []

try:
    currentProgram
except NameError:
    currentProgram = None

try:
    monitor
except NameError:
    class _MonitorStub(object):
        def isCancelled(self):
            return False

    monitor = _MonitorStub()


def write_json(output_path, payload):
    with open(output_path, 'w') as handle:
        json.dump(payload, handle, indent=2, sort_keys=False)
        handle.write('\n')


args = getScriptArgs()
if len(args) < 1:
    raise Exception('Expected output directory argument')

output_dir = args[0]
if not os.path.isdir(output_dir):
    os.makedirs(output_dir)

symbol_rows = []
symbol_iterator = currentProgram.getSymbolTable().getAllSymbols(True)
while symbol_iterator.hasNext() and not monitor.isCancelled():
    symbol = symbol_iterator.next()
    symbol_rows.append({
        'name': symbol.getName(),
        'address': str(symbol.getAddress()),
        'type': str(symbol.getSymbolType())
    })

function_rows = []
function_iterator = currentProgram.getFunctionManager().getFunctions(True)
while function_iterator.hasNext() and not monitor.isCancelled():
    function = function_iterator.next()
    function_rows.append({
        'name': function.getName(),
        'entry': str(function.getEntryPoint()),
        'body_min': str(function.getBody().getMinAddress()),
        'body_max': str(function.getBody().getMaxAddress())
    })

comment_rows = []
code_units = currentProgram.getListing().getCodeUnits(True)
while code_units.hasNext() and not monitor.isCancelled():
    code_unit = code_units.next()
    comment = code_unit.getComment(code_unit.EOL_COMMENT)
    if comment is None:
        comment = code_unit.getComment(code_unit.PRE_COMMENT)
    if comment:
        comment_rows.append({
            'address': str(code_unit.getAddress()),
            'comment': comment
        })

bookmark_rows = []
bookmark_manager = currentProgram.getBookmarkManager()
bookmarks = list(bookmark_manager.getBookmarks(currentProgram.getMinAddress(), currentProgram.getMaxAddress()))
for bookmark in bookmarks:
    bookmark_rows.append({
        'address': str(bookmark.getAddress()),
        'type': bookmark.getTypeString(),
        'category': bookmark.getCategory(),
        'comment': bookmark.getComment()
    })

write_json(os.path.join(output_dir, 'symbols.json'), symbol_rows)
write_json(os.path.join(output_dir, 'functions.json'), function_rows)
write_json(os.path.join(output_dir, 'comments.json'), comment_rows)
write_json(os.path.join(output_dir, 'bookmarks.json'), bookmark_rows)
