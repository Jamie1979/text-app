describe 'services.settings', ->
  settings = storage = null

  beforeEach inject (_settings_, localStorage) ->
    settings = _settings_
    storage = localStorage

  describe 'on', ->

    it 'should call listeners when a property change', ->
      themeSpy = jasmine.createSpy 'theme'
      keyModeSpy = jasmine.createSpy 'keyMode'
      useSoftSpy = jasmine.createSpy 'useSoftTabs'
      tabSizeSpy = jasmine.createSpy 'tabSize'

      settings.on 'theme', themeSpy
      settings.on 'keyMode', keyModeSpy
      settings.on 'useSoftTabs', useSoftSpy
      settings.on 'tabSize', tabSizeSpy

      value = {}
      settings.theme = value
      expect(themeSpy).toHaveBeenCalledWith value

      settings.keyMode = value
      expect(keyModeSpy).toHaveBeenCalledWith value

      settings.useSoftTabs = value
      expect(useSoftSpy).toHaveBeenCalledWith value

      settings.tabSize = value
      expect(tabSizeSpy).toHaveBeenCalledWith value

  describe 'load', ->

    it 'should load theme from localStorage', ->
      storage.setItem 'theme', 'ace/theme/monokai'
      settings.load()

      expect(settings.theme).toBeDefined()
      expect(settings.theme.name).toBe 'Monokai'


    it 'should load keyMode from localStorage', ->
      storage.setItem 'keyMode', 'vim'
      settings.load()

      expect(settings.keyMode).toBeDefined()
      expect(settings.keyMode.name).toBe 'Vim'


    it 'should load useSoftTabs', ->
      storage.setItem 'useSoftTabs', '0'
      settings.load()
      expect(settings.useSoftTabs).toBe false

      storage.setItem 'useSoftTabs', '1'
      settings.load()
      expect(settings.useSoftTabs).toBe true


    it 'should load tabSize', ->
      storage.setItem 'tabSize', '10'
      settings.load()
      expect(settings.tabSize).toBe 10


    it 'should set defaults', ->
      settings.load()
      expect(settings.useSoftTabs).toBe true
      expect(settings.tabSize).toBe 4
      expect(settings.keyMode.id).toBe 'ace'
      expect(settings.theme.id).toBe 'ace/theme/monokai'


  describe 'store', ->

    it 'should save theme into localStorage', ->
      settings.theme = settings.THEMES[0]
      settings.store()

      expect(storage.getItem 'theme').toBe 'ace/theme/chrome'


    it 'should save keyMode into localStorage', ->
      settings.keyMode = settings.KEY_MODES[1]
      settings.store()

      expect(storage.getItem 'keyMode').toBe 'vim'


    it 'should save useSoftTabs', ->
      settings.useSoftTabs = true
      settings.store()

      expect(storage.getItem 'useSoftTabs').toBe '1'


    it 'should save tabSize', ->
      settings.tabSize = 10
      settings.store()

      expect(storage.getItem 'tabSize').toBe '10'
