window.EditorWidget = Ractive.extend({
  onrender: ->
    window.editor = CodeMirror(@find('.netlogo-code'), {
      value: @get('code'),
      tabSize: 2,
      mode: 'netlogo'
    })
  # See https://github.com/codemirror/CodeMirror/issues/2991 on why we need to
  # set this directly. BCH 12/17/2014
    editor.getMode().electricChars ="d])D\n"
    editor.on('change', =>
      console.log('change')
      @set('code', editor.getValue())
    )

  template:
    """
    <div class="netlogo-code-container">
      <button class="netlogo-widget" on-click="recompile">compile</button>
      {{! Triple bars around code lets it use html formatting if it's there. }}
      {{! The <pre> tags keep formmatting nice even if it's not html already. }}
      <div class="netlogo-code">
      </div>
    </div>
    """
})

keywords = [
  'globals',
  'breed'
]

commands = [
  'ask',
  'crt',
  'ca',
  'clear-all'
]

reporters = [
  'turtles',
  'patches',
  'one-of'
]

CodeMirror.defineSimpleMode('netlogo', {
  start: [
    {token: 'keyword', regex: /(?:to|to-report)(?:\s|$)/i, indent: true},
    {token: 'keyword', regex: /end(?:\s|$)/i, dedent: true},
    {token: 'keyword', regex: new RegExp("(?:#{keywords.join('|')})(?:\\s|$)")},
    {token: 'keyword', regex: /[^\s()\[\]]*-own(?:\s|$)/},
    {token: 'builtin', regex: new RegExp("(?:#{commands.join('|')})(?:\\s|$)")},
    {token: 'variable-2', regex: new RegExp("(?:#{reporters.join('|')})(?:\\s|$)")},
    {token: 'comment', regex: /;.*/}
    {regex: /[\[(]/, indent: true}
    {regex: /[\])]/, dedent: true}
  ]
}, {
  electricChars: "d])D\n" # This is actually ignored: https://github.com/codemirror/CodeMirror/issues/2991
})
