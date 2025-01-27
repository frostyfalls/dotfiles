config.load_autoconfig(False)

# Behvaior
c.confirm_quit = ["downloads"]
c.editor.command = ["footclient", "vim", "{file}"]

# Blocking intrusiveness
c.content.autoplay = False
c.content.geolocation = False
c.content.cookies.accept = "never"
c.content.javascript.clipboard = "none"
c.content.blocking.method = "both"
c.content.blocking.adblock.lists = [
    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://www.i-dont-care-about-cookies.eu/abp/",
]

# Interface
c.downloads.position = "bottom"
c.fonts.default_family = "Terminus"
c.fonts.default_size = "12px"
c.colors.webpage.preferred_color_scheme = "dark"
c.tabs.show = "multiple"
c.tabs.indicator.width = 0
c.tabs.favicons.show = "never"
c.scrolling.bar = "never"
c.completion.open_categories = ["quickmarks", "bookmarks", "searchengines"]
c.completion.web_history.max_items = 0

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
