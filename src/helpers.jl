using Base.Meta: quot, show_sexpr, isexpr


macro sexpr(expr)
    :((show_sexpr($(quot(expr))); println()))
end


macro methods(func::Symbol)
    :(methods($func))
end


macro methodswith(expr)
    :(methodswith($expr))
end


macro dump(expr)
    :(dump($(quot(expr))))
end


macro macroexpand(expr)
    :(macroexpand($(quot(expr))))
end


macro esc(sym)
    isexpr(sym, :quote) || throw(ArgumentError("expected quoted symbol"))
    esc(sym.args[1])
end
