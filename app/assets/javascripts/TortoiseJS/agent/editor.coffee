window.EditorWidget = Ractive.extend({
  onrender: ->
    window.editor = CodeMirror(@find('.netlogo-code'), {
      value: @get('code'),
      tabSize: 2,
      mode: 'netlogo',
      theme: 'netlogo-default',
      readOnly: @get('readOnly')
    })
    editor.on('change', =>
      @set('code', editor.getValue())
    )

  template:
    """
    <div class="netlogo-code-container">
      {{# !readOnly }}
        <button class="netlogo-widget" on-click="recompile">compile</button>
      {{/}}
      {{! Triple bars around code lets it use html formatting if it's there. }}
      {{! The <pre> tags keep formmatting nice even if it's not html already. }}
      <div class="netlogo-code">
      </div>
    </div>
    """
})

keywords = [
  'BREED'
  'TO',
  'TO-REPORT',
  'END',
  'GLOBALS',
  'TURTLES-OWN',
  'LINKS-OWN',
  'PATCHES-OWN',
  'DIRECTED-LINK-BREED',
  'UNDIRECTED-LINK-BREED',
  'EXTENSIONS',
  '__INCLUDES'
]

commands = [
  '__bench',
  '__change-topology',
  '__done',
  '__experimentstepend',
  '__export-drawing',
  '__foreverbuttonend',
  '__ignore',
  '__let',
  '__linkcode',
  '__make-preview',
  '__mkdir',
  '__observercode',
  '__patchcode',
  '__plot-pen-hide',
  '__plot-pen-show',
  '__pwd',
  '__reload-extensions',
  '__set-line-thickness',
  '__stderr',
  '__stdout',
  '__thunk-did-finish',
  '__turtlecode',
  'ask',
  'ask-concurrent',
  'auto-plot-off',
  'auto-plot-on',
  'back',
  'beep',
  'bk',
  'ca',
  'carefully',
  'cd',
  'clear-all',
  'clear-all-plots',
  'clear-drawing',
  'clear-globals',
  'clear-links',
  'clear-output',
  'clear-patches',
  'clear-plot',
  'clear-ticks',
  'clear-turtles',
  'cp',
  'create-link-from',
  'create-link-to',
  'create-link-with',
  'create-links-from',
  'create-links-to',
  'create-links-with',
  'create-ordered-turtles',
  'create-temporary-plot-pen',
  'create-turtles',
  'cro',
  'crt',
  'ct',
  'die',
  'diffuse',
  'diffuse4',
  'display',
  'downhill',
  'downhill4',
  'error',
  'every',
  'export-all-plots',
  'export-interface',
  'export-output',
  'export-plot',
  'export-view',
  'export-world',
  'face',
  'facexy',
  'fd',
  'file-close',
  'file-close-all',
  'file-delete',
  'file-flush',
  'file-open',
  'file-print',
  'file-show',
  'file-type',
  'file-write',
  'follow',
  'follow-me',
  'foreach',
  'forward',
  'hatch',
  'hide-link',
  'hide-turtle',
  'histogram',
  'home',
  'ht',
  'if',
  'if-else',
  'ifelse',
  'import-drawing',
  'import-pcolors',
  'import-pcolors-rgb',
  'import-world',
  'inspect',
  'jump',
  'layout-circle',
  'layout-radial',
  'layout-spring',
  'layout-tutte',
  'left',
  'let',
  'loop',
  'lt',
  'move-to',
  'no-display',
  'output-print',
  'output-show',
  'output-type',
  'output-write',
  'pd',
  'pe',
  'pen-down',
  'pen-erase',
  'pen-up',
  'pendown',
  'penup',
  'plot',
  'plot-pen-down',
  'plot-pen-reset',
  'plot-pen-up',
  'plotxy',
  'print',
  'pu',
  'random-seed',
  'repeat',
  'report',
  'reset-perspective',
  'reset-ticks',
  'reset-timer',
  'resize-world',
  'ride',
  'ride-me',
  'right',
  'rp',
  'rt',
  'run',
  'set',
  'set-current-directory',
  'set-current-plot',
  'set-current-plot-pen',
  'set-default-shape',
  'set-histogram-num-bars',
  'set-patch-size',
  'set-plot-pen-color',
  'set-plot-pen-interval',
  'set-plot-pen-mode',
  'set-plot-x-range',
  'set-plot-y-range',
  'setup-plots',
  'setxy',
  'show',
  'show-link',
  'show-turtle',
  'sprout',
  'st',
  'stamp',
  'stamp-erase',
  'stop',
  'tick',
  'tick-advance',
  'tie',
  'type',
  'untie',
  'update-plots',
  'uphill',
  'uphill4',
  'user-message',
  'wait',
  'watch',
  'watch-me',
  'while',
  'with-local-randomness',
  'without-interruption',
  'write'
].reverse() # Want reverse alphabetic so longer strings match first - BCH 1/9/2015

reporters = [
  '!=',
  '\\*',
  '\\+',
  '-',
  '/',
  '<',
  '<=',
  '=',
  '>',
  '>=',
  '\\^',
  '__boom',
  '__check-syntax',
  '__dump',
  '__dump-extension-prims',
  '__dump-extensions',
  '__dump1',
  '__hubnet-in-q-size',
  '__hubnet-out-q-size',
  '__nano-time',
  '__patchcol',
  '__patchrow',
  '__processors',
  '__random-state',
  '__stack-trace',
  '__to-string',
  'abs',
  'acos',
  'all?',
  'and',
  'any?',
  'approximate-hsb',
  'approximate-rgb',
  'asin',
  'at-points',
  'atan',
  'autoplot?',
  'base-colors',
  'behaviorspace-run-number',
  'bf',
  'bl',
  'both-ends',
  'but-first',
  'but-last',
  'butfirst',
  'butlast',
  'can-move?',
  'ceiling',
  'cos',
  'count',
  'date-and-time',
  'distance',
  'distance-nowrap',
  'distancexy',
  'distancexy-nowrap',
  'dx',
  'dy',
  'empty?',
  'end1',
  'end2',
  'error-message',
  'exp',
  'extract-hsb',
  'extract-rgb',
  'file-at-end?',
  'file-exists?',
  'file-read',
  'file-read-characters',
  'file-read-line',
  'filter',
  'first',
  'floor',
  'fput',
  'hsb',
  'hubnet-clients-list',
  'hubnet-enter-message?',
  'hubnet-exit-message?',
  'hubnet-message',
  'hubnet-message-source',
  'hubnet-message-tag',
  'hubnet-message-waiting?',
  'ifelse-value',
  'in-cone',
  'in-cone-nowrap',
  'in-link-from',
  'in-link-neighbor?',
  'in-link-neighbors',
  'in-radius',
  'in-radius-nowrap',
  'int',
  'is-agent?',
  'is-agentset?',
  'is-boolean?',
  'is-command-task?',
  'is-directed-link?',
  'is-link-set?',
  'is-link?',
  'is-list?',
  'is-number?',
  'is-patch-set?',
  'is-patch?',
  'is-reporter-task?',
  'is-string?',
  'is-turtle-set?',
  'is-turtle?',
  'is-undirected-link?',
  'item',
  'last',
  'length',
  'link',
  'link-heading',
  'link-length',
  'link-neighbor?',
  'link-neighbors',
  'link-set',
  'link-shapes',
  'link-with',
  'links',
  'list',
  'ln',
  'log',
  'lput',
  'map',
  'max',
  'max-n-of',
  'max-one-of',
  'max-pxcor',
  'max-pycor',
  'mean',
  'median',
  'member?',
  'min',
  'min-n-of',
  'min-one-of',
  'min-pxcor',
  'min-pycor',
  'mod',
  'modes',
  'mouse-down?',
  'mouse-inside?',
  'mouse-xcor',
  'mouse-ycor',
  'movie-status',
  'my-in-links',
  'my-links',
  'my-out-links',
  'myself',
  'n-of',
  'n-values',
  'neighbors',
  'neighbors4',
  'netlogo-applet?',
  'netlogo-version',
  'new-seed',
  'no-links',
  'no-patches',
  'no-turtles',
  'not',
  'of',
  'one-of',
  'or',
  'other',
  'other-end',
  'out-link-neighbor?',
  'out-link-neighbors',
  'out-link-to',
  'patch',
  'patch-ahead',
  'patch-at',
  'patch-at-heading-and-distance',
  'patch-here',
  'patch-left-and-ahead',
  'patch-right-and-ahead',
  'patch-set',
  'patch-size',
  'patches',
  'plot-name',
  'plot-pen-exists?',
  'plot-x-max',
  'plot-x-min',
  'plot-y-max',
  'plot-y-min',
  'position',
  'precision',
  'random',
  'random-exponential',
  'random-float',
  'random-gamma',
  'random-normal',
  'random-or-random-float',
  'random-poisson',
  'random-pxcor',
  'random-pycor',
  'random-xcor',
  'random-ycor',
  'read-from-string',
  'reduce',
  'remainder',
  'remove',
  'remove-duplicates',
  'remove-item',
  'replace-item',
  'reverse',
  'rgb',
  'round',
  'run-result',
  'runresult',
  'scale-color',
  'se',
  'self',
  'sentence',
  'shade-of?',
  'shapes',
  'shuffle',
  'sin',
  'sort',
  'sort-by',
  'sort-on',
  'sqrt',
  'standard-deviation',
  'subject',
  'sublist',
  'substring',
  'subtract-headings',
  'sum',
  'tan',
  'task',
  'ticks',
  'timer',
  'towards',
  'towards-nowrap',
  'towardsxy',
  'towardsxy-nowrap',
  'turtle',
  'turtle-set',
  'turtles',
  'turtles-at',
  'turtles-here',
  'turtles-on',
  'user-directory',
  'user-file',
  'user-input',
  'user-new-file',
  'user-one-of',
  'user-yes-or-no?',
  'value-from',
  'values-from',
  'variance',
  'with',
  'with-max',
  'with-min',
  'word',
  'world-height',
  'world-width',
  'wrap-color',
  'xor',

# Turtle variables:
  'WHO',
  'COLOR',
  'HEADING',
  'XCOR',
  'YCOR',
  'SHAPE',
  'LABEL',
  'LABEL-COLOR',
  'BREED',
  'HIDDEN?',
  'SIZE',
  'PEN-SIZE',
  'PEN-MODE'

# Patch variables
  'PXCOR',
  'PYCOR',
  'PCOLOR',
  'PLABEL',
  'PLABEL-COLOR',

# Link variable
  'END1',
  'END2',
  'COLOR',
  'LABEL',
  'LABEL-COLOR',
  'HIDDEN?',
  'BREED',
  'THICKNESS',
  'SHAPE',
  'TIE-MODE'
].reverse() # Want reverse alphabetic so longer strings match first - BCH 1/9/2015

constants = [
  'TRUE',
  'FALSE',
  'NOBODY',
  'E',
  'PI',
  'gray',
  'grey',
  'red',
  'orange',
  'brown',
  'yellow',
  'green',
  'lime',
  'turquoise',
  'cyan',
  'sky',
  'blue',
  'violet',
  'magenta',
  'pink',
  'black',
  'white'
]
notWordCh = /[\s\[\(\]\)]/.source
wordCh    = /[^\s\[\(\]\)]/.source
wordEnd   = "(?=#{notWordCh}|$)"

wordRegEx    = (pattern) -> new RegExp("#{pattern}#{wordEnd}", 'i')
memberRegEx  = (words)   -> wordRegEx("(?:#{words.join('|')})")

# Rules for multiple states
commentRule  = {token: 'comment', regex: /;.*/}
constantRule = {token: 'constant', regex: memberRegEx(constants)}
openBracket  = {regex: /[\[\(]/, indent: true}
closeBracket = {regex: /[\]\)]/, dedent: true}
variable     = {token: 'variable', regex: new RegExp(wordCh + "+")}

CodeMirror.defineSimpleMode('netlogo', {
  start: [
    {token: 'keyword', regex: wordRegEx("to(?:-report)?"), indent: true, next: 'body'},
    {token: 'keyword', regex: memberRegEx(keywords)},
    {token: 'keyword', regex: wordRegEx("#{wordCh}*-own")},
    constantRule,
    commentRule,
    openBracket,
    closeBracket,
    variable,
  ],
  body: [
    {token: 'keyword',  regex: wordRegEx("end"), dedent: true, next: 'start'},
    {token: 'command',  regex: memberRegEx(commands)},
    {token: 'reporter', regex: memberRegEx(reporters)},
    {token: 'string',   regex: /"(?:[^\\]|\\.)*?"/},
    {token: 'number',   regex: /0x[a-f\d]+|[-+]?(?:\.\d+|\d+\.?\d*)(?:e[-+]?\d+)?/i},
    constantRule,
    commentRule,
    openBracket,
    closeBracket,
    variable,
  ],
  meta: {
    electricChars: "dD])\n" # The 'd's here are so that it reindents on `end`. BCH 1/9/2015
  }
})
