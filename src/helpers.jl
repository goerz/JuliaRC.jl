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

macro esc(sym)
    isexpr(sym, :quote) || throw(ArgumentError("expected quoted symbol"))
    esc(sym.args[1])
end


"""Print a tree of sub-types for the given type"""
function subtypetree(t, level=1, indent=4)
    level == 1 && println(t)
    for s in subtypes(t)
        println(join(fill(" ", level * indent)) * string(s))
        subtypetree(s, level+1, indent)
    end
end


"""Print the supertypes of the given type"""
function supertypes(io::IO, t)
    print(io, t)
    while t != Any
        t = supertype(t)
        print(io, " <: ", t)
    end
end

supertypes(t) = supertypes(STDOUT, t)
