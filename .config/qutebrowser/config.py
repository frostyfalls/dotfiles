config.load_autoconfig(False)

# Behvaior
c.confirm_quit = ["downloads"]
c.editor.command = ["footclient", "vim", "{file}"]
c.changelog_after_upgrade = "never"
c.aliases = {
    "q": "close",
    "qa": "quit",
    "w": "session-save",
    "wq": "quit --save",
    "wqa": "quit --save",
    "so": "config-source ;; greasemonkey-reload",
}

# Site settings
c.content.autoplay = False
c.content.geolocation = False
# c.content.cookies.accept = "never"
c.content.javascript.clipboard = "none"
c.content.blocking.method = "both"
c.content.blocking.adblock.lists = [
    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://www.i-dont-care-about-cookies.eu/abp/",
]
c.colors.webpage.preferred_color_scheme = "dark"

# Browser interface
c.downloads.position = "bottom"
c.fonts.default_family = "Cascadia Mono"
c.fonts.default_size = "9pt"
c.fonts.hints = "16px default_family"
c.tabs.indicator.width = 0
c.tabs.favicons.show = "never"
c.scrolling.bar = "never"
c.completion.open_categories = ["quickmarks", "bookmarks", "searchengines"]
c.completion.web_history.max_items = 0
c.statusbar.padding = {"bottom": 2, "left": 0, "right": 0, "top": 2}
c.tabs.padding = {"bottom": 1, "left": 5, "right": 5, "top": 1}
c.completion.height = "30%"

# Default pages and search engines
c.url.default_page = "https://start.duckduckgo.com"
c.url.start_pages = "https://start.duckduckgo.com"
c.url.searchengines = {
    "DEFAULT": "https://google.com/search?q={}",
    "aw": "https://wiki.archlinux.org/?search={}",
    "ddg": "https://duckduckgo.com/?q={}",
    "gg": "https://google.com/search?q={}",
    "ud": "https://urbandictionary.com/define.php?term={}",
    "vd": "https://voidlinux.org/packages/?arch=x86_64&q={}",
    "wk": "https://en.wikipedia.org/wiki/{}",
    "yt": "https://youtube.com/results?search_query={}",
}
c.url.open_base_url = True
c.messages.timeout = 1000

# External configurations
config.source("perdomain.py")
config.source("colors.py")

c.url.default_page = "about:blank"
c.url.start_pages = "about:blank"
