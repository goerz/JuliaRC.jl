"""Custom color scheme (adapts to terminal background)"""
function _create_goerz_cs(background::String)
    # Adapated from Vim color scheme
    if background == "light"
        my_gray40     =  59
        my_gray50     = 102
        my_gray75     = 145
        my_gray90     = 188
        my_black      =  16
        my_white      =  15
        my_red        = 124
        my_lightred   = 161
        my_orange     = 166
        my_yellow     =  11
        my_green      =  64
        my_darkgreen  =  28
        my_pink       =  54
        my_blue       =  25
        my_darkblue   =  24
        my_purple     =  97
    else
        my_gray40     = 102
        my_gray50     = 102
        my_gray75     =  59
        my_gray90     =   0
        my_black      = 231
        my_white      =   0
        my_red        = 124
        my_lightred   = 168
        my_orange     = 166
        my_yellow     = 142
        my_green      =  64
        my_darkgreen  =  71
        my_pink       =  53
        my_blue       =  27
        my_darkblue   =  33
        my_purple     = 176
    end
    cs = STH.ColorScheme()
    STH.symbol!(cs, Crayon(foreground=my_darkblue))
    STH.comment!(cs, Crayon(foreground=my_gray50))
    STH.string!(cs, Crayon(foreground=my_darkgreen))
    STH.call!(cs, Crayon(foreground=my_black))
    STH.op!(cs, Crayon(foreground=my_lightred))
    STH.keyword!(cs, Crayon(foreground=my_darkblue))
    STH.text!(cs, Crayon(foreground=my_black))
    STH.macro!(cs, Crayon(foreground=my_darkblue))
    STH.function_def!(cs, Crayon(foreground=my_black))
    STH.error!(cs, Crayon(foreground=my_red))
    STH.argdef!(cs, Crayon(foreground=my_darkblue))
    STH.number!(cs, Crayon(foreground=my_blue))
    return cs
end


"""Set up OhMyREPL"""
function ohmyrepl()
    OhMyREPL.enable_autocomplete_brackets(false)
    #=OhMyREPL.enable_highlight_markdown(false)=#
    _background = OhMyREPL.background()
    if _background == "light"
        OhMyREPL.input_prompt!("julia> ", :black)
    end
    STH = OhMyREPL.Passes.SyntaxHighlighter

    STH.add!(STH.SYNTAX_HIGHLIGHTER_SETTINGS, "goerz",
             _create_goerz_cs(_background))
    OhMyREPL.colorscheme!("goerz")
end


"""Change only the colors that OhMyRepl can't handle"""
function customize_colors(repl)
    if OhMyREPL.background() == "light"
        #=repl.prompt_color = Base.text_colors[:black]=#
        repl.help_color = Base.text_colors[:black]
        #=repl.shell_color = Base.text_colors[:black]=#
        #=repl.input_color = Base.text_colors[:green]=#
        #=repl.answer_color = Base.text_colors[:red]=#
    end
end
