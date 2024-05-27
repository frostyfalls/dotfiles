from libqtile import bar, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

app_bindings = [
    (["mod4"], "F1", "thunar"),
    (["mod4"], "F2", "firefox"),
    (["mod4"], "p", "dmenu_run"),
    (["mod4"], "Return", "st"),
]

keys = [
    Key(["mod4"], "j", lazy.layout.next()),
    Key(["mod4"], "k", lazy.layout.previous()),
    Key(["mod4", "shift"], "j", lazy.layout.shuffle_down()),
    Key(["mod4", "shift"], "k", lazy.layout.shuffle_up()),

    Key(["mod4"], "i", lazy.layout.decrease_nmaster()),
    Key(["mod4"], "d", lazy.layout.increase_nmaster()),

    Key(["mod4"], "h", lazy.layout.decrease_ratio()),
    Key(["mod4"], "l", lazy.layout.increase_ratio()),
    Key(["mod4"], "n", lazy.layout.normalize()),

    Key(["mod4", "shift"], "c", lazy.window.kill()),
    Key(["mod4", "shift"], "f", lazy.window.toggle_fullscreen()),
    Key(["mod4", "shift"], "space", lazy.window.toggle_floating()),

    Key(["mod4", "control"], "r", lazy.reload_config()),
    Key(["mod4", "control"], "q", lazy.shutdown()),
]
keys.extend(
    Key(mod, key, lazy.spawn(command))
    for mod, key, command in app_bindings
)

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            Key(["mod4"], i.name,lazy.group[i.name].toscreen()),
            Key(["mod4", "shift"], i.name, lazy.window.togroup(i.name)),
        ]
    )


layout_defaults = {
    "border_focus": "#ff0000",
    "border_normal": "#555555",
    "border_width": 1,
    "margin": 0,
    "ratio": 0.50,
}

class MyMonadTall(layout.MonadTall):
    def add_client(self, client):
        self.clients.add_client(client, client_position=self.new_client_position)
        self.do_normalize = True


layouts = [
    # layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    # layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    MyMonadTall(
        **layout_defaults,
    ),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        bottom=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(),
                widget.WindowName(),
                widget.Systray(),
                widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
                widget.QuickExit(),
            ],
            24,
        ),
    ),
]

mouse = [
    Drag(["mod4"], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag(["mod4"], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click(["mod4"], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        *layout.Floating.default_float_rules,
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

auto_minimize = True
