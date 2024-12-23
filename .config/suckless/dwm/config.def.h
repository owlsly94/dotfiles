
/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft = 0;    /* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;        /* 0 means no systray */
static const unsigned int gappih    = 10;       /* horiz inner gap between windows */
static const unsigned int gappiv    = 10;       /* vert inner gap between windows */
static const unsigned int gappoh    = 10;       /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 10;       /* vert outer gap between windows and screen edge */
static const int smartgaps          = 1;        /* 1 means no outer gap when there is only one window */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "Iosevka Nerd Font:style=Bold:size=11" };
static const char col_gray1[]       = "#1e1e2e";
static const char col_gray2[]       = "#f38ba8";
static const char col_gray3[]       = "#cba6f7";
static const char col_gray4[]       = "#cdd6f4";
static const char col_cyan[]        = "#1e1e2e";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};

static const char *const autostart[] = {
  "xset", "s", "off", NULL,
  "xset", "-dpms", NULL,
  "dbus-update-activation-environment", "--systemd", "--all", NULL,
  "sh", "-c", "feh --bg-scale ~/.config/wallpapers/jinx04.jpg", NULL,
  "/usr/lib/polkit-kde-authentication-agent-1", NULL,
	"dunst", NULL,
  "picom", NULL,
  "slstatus", NULL,
	NULL /* terminate */
};

/* tagging */
static const char *tags[] = { "", "", "", "", "", "", "", "", "" };

static const char *tagsel[][2] = {
	{ "#f38ba8", "#1e1e2e" },
	{ "#fab387", "#1e1e2e" },
	{ "#f9e2af", "#1e1e2e" },
	{ "#a6e3a1", "#1e1e2e" },
	{ "#94e2d5", "#1e1e2e" },
	{ "#74c7ec", "#1e1e2e" },
	{ "#89b4fa", "#1e1e2e" },
	{ "#b4befe", "#1e1e2e" },
	{ "#cba6f7", "#1e1e2e" },
};

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class        instance    title       tags mask     isfloating   monitor */
	{ "firefox",    NULL,       NULL,       1 << 1,       0,           -1 },
  { "zen-beta",   NULL,       NULL,       1 << 1,       0,           -1 },
  { "Thunar",     NULL,       NULL,       1 << 3,       0,           -1 },
  { "steam",      NULL,       NULL,       1 << 4,       0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.5; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ " 󰕴 ",      tile },    /* first entry is default */
	{ "  ",      NULL },    /* no layout function means floating behavior */
	{ " 󰕫 ",      monocle },
};

/* key definitions */
#define MODKEY Mod1Mask
#define SUPERKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static const char *termcmd[]        = { "kitty", NULL };
static const char *rofi[]           = { "rofi", "-show", "drun", "-show-icons", NULL }; /* Use rofi launcher */
static const char *web[]            = { "firefox", NULL }; /* Firefox launcher */
static const char *firefox[]        = { "firefox", "-p", NULL }; /* Firefox profile launcher*/
static const char *zen[]            = { "zen-browser", NULL }; /* Zen launcher */
static const char *thunar[]         = { "thunar", NULL }; /* File manager */
static const char *code[]           = { "code", NULL }; /* Code Editor */
static const char *volup[]          = { "pamixer", "-i", "5", NULL }; /* Pulse Audio Volume Up string */
static const char *voldown[]        = { "pamixer", "-d", "5", NULL }; /* Pulse Audio Volume Down string */
static const char *mute[]           = { "pamixer", "--mute", NULL }; /* Pulse Audio Mute Volume string */
static const char *unmute[]         = { "pamixer", "--unmute", NULL }; /* Pulse Audio Unmute Volume string */
static const char *steam[]          = { "steam", NULL }; /* Steam */

static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
  { MODKEY,                       XK_p,      spawn,          {.v = rofi } },
  { SUPERKEY,                     XK_f,      spawn,          {.v = web } },
  { SUPERKEY|ShiftMask,           XK_f,      spawn,          {.v = firefox } },
  { SUPERKEY,                     XK_b,      spawn,          {.v = zen } },
  { MODKEY,                       XK_d,      spawn,          {.v = thunar } },
  { SUPERKEY,                     XK_c,      spawn,          {.v = code } },
  { MODKEY,			                  XK_F3,     spawn,	         {.v = volup } },
	{ MODKEY,			                  XK_F2,	   spawn,	         {.v = voldown} },
	{ MODKEY,			                  XK_F4,	   spawn,	         {.v = mute } },
	{ MODKEY,			                  XK_F1,	   spawn, 	       {.v = unmute } },
  { SUPERKEY,                     XK_g,      spawn,          {.v = steam } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ SUPERKEY,                     XK_Left,   focusstack,     {.i = +1 } },
	{ SUPERKEY,                     XK_Right,  focusstack,     {.i = -1 } },
	{ SUPERKEY,                     XK_i,      incnmaster,     {.i = +1 } },
	{ SUPERKEY,                     XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_Left,   setmfact,       {.f = -0.05} },
	{ MODKEY|ShiftMask,             XK_Right,  setmfact,       {.f = +0.05} },
	{ MODKEY|Mod4Mask,              XK_h,      incrgaps,       {.i = +1 } },
	{ MODKEY|Mod4Mask,              XK_l,      incrgaps,       {.i = -1 } },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_h,      incrogaps,      {.i = +1 } },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_l,      incrogaps,      {.i = -1 } },
	{ MODKEY|Mod4Mask|ControlMask,  XK_h,      incrigaps,      {.i = +1 } },
	{ MODKEY|Mod4Mask|ControlMask,  XK_l,      incrigaps,      {.i = -1 } },
	{ MODKEY|Mod4Mask,              XK_0,      togglegaps,     {0} },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_0,      defaultgaps,    {0} },
	{ MODKEY,                       XK_y,      incrihgaps,     {.i = +1 } },
	{ MODKEY,                       XK_o,      incrihgaps,     {.i = -1 } },
	{ MODKEY|ControlMask,           XK_y,      incrivgaps,     {.i = +1 } },
	{ MODKEY|ControlMask,           XK_o,      incrivgaps,     {.i = -1 } },
	{ MODKEY|Mod4Mask,              XK_y,      incrohgaps,     {.i = +1 } },
	{ MODKEY|Mod4Mask,              XK_o,      incrohgaps,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_y,      incrovgaps,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_o,      incrovgaps,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

