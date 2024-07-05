config.load_autoconfig(False)

config.bind('xb', 'config-cycle statusbar.show always never')
config.bind('xt', 'config-cycle tabs.show always never')
config.bind('xx', 'config-cycle tabs.show always never ;; config-cycle statusbar.show always never')

c.fonts.default_family = 'Terminus'
c.fonts.default_size = '12px'

c.scrolling.bar = 'never'
