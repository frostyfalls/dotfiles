config.load_autoconfig(False)

c.content.autoplay = False

c.confirm_quit = ["always"]
c.zoom.default = "100%"

# config.set("colors.webpage.darkmode.enabled", True)
config.set("colors.webpage.preferred_color_scheme", "dark")

config.set("content.blocking.method", "both")

c.url.open_base_url = True
c.url.start_pages = "about:blank"
c.url.default_page = "about:blank"

c.fonts.default_family = 'Terminus'
c.fonts.default_size = '8px'

c.aliases = {
    "o": "open",
    "q": "quit",
    "Q": "close",
    "w": "session-save",
    "x": "quit --save",
}

c.url.searchengines = {
    "DEFAULT": "https://google.com/search?q={}",
    "aw": "https://wiki.archlinux.org/?search={}",
    "ud": "https://urbandictionary.com/define.php?term={}",
    "wk": "https://en.wikipedia.org/wiki/{}",
    "yt": "https://youtube.com/results?search_query={}",
}
