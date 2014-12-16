window.EditorWidget = Ractive.extend({
  template:
    """
    <div class="netlogo-code-container">
      <button class="netlogo-widget" on-click="recompile">compile</button>
      {{! Triple bars around code lets it use html formatting if it's there. }}
      {{! The <pre> tags keep formmatting nice even if it's not html already. }}
      <textarea class="netlogo-code" style="width: 100%" spellcheck="false" value='{{code}}'></textarea>
    </div>
    """
})
