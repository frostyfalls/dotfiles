config.load_autoconfig()

# Behvaior
c.confirm_quit = ["downloads"]
c.editor.command = ["foot", "vim", "{file}"]

# Blocking intrusiveness
c.content.autoplay = False
c.content.geolocation = False
c.content.blocking.method = "both"
c.content.cookies.accept = "never"

# Interface
c.downloads.position = "bottom"
c.statusbar.padding = {"bottom": 2, "left": 0, "right": 0, "top": 2}
c.tabs.padding = {"bottom": 1, "left": 4, "right": 4, "top": 1}
c.fonts.default_family = "Terminus"
c.fonts.default_size = "8px"
c.colors.webpage.preferred_color_scheme = "dark"

# Default pages and search engines
c.url.default_page = "https://start.duckduckgo.com"
c.url.start_pages = "https://start.duckduckgo.com"
c.url.searchengines = {
    "DEFAULT": "https://google.com/search?q={}",
    "aw": "https://wiki.archlinux.org/?search={}",
    "ud": "https://urbandictionary.com/define.php?term={}",
    "wk": "https://en.wikipedia.org/wiki/{}",
    "yt": "https://youtube.com/results?search_query={}",
}
c.url.open_base_url = True
c.messages.timeout = 1000
c.statusbar.widgets = ["history", "url", "progress", "scroll"]

# External configurations
config.source("colors.py")
config.source("perdomain.py")
