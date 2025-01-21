static const char norm_fg[] = "#bfad99";
static const char norm_bg[] = "#071115";
static const char norm_border[] = "#85796b";

static const char sel_fg[] = "#bfad99";
static const char sel_bg[] = "#344A4D";
static const char sel_border[] = "#bfad99";

static const char urg_fg[] = "#bfad99";
static const char urg_bg[] = "#273D42";
static const char urg_border[] = "#273D42";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
