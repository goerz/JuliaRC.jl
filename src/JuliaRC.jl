# __precompile__()

module JuliaRC

"""Forcefully install my own fork of OhMyREPL"""
function check_OhMyREPL()
    if isdir(Pkg.dir("OhMyREPL"))
        fname = joinpath(Pkg.dir("OhMyREPL"), ".git", "config")
        config = readstring(open(fname))
        if !contains(config, "git@github.com:goerz/OhMyREPL.jl.git")
            warn("OhMyREPL not from git@github.com:goerz/OhMyREPL.jl.git")
            warn("OhMyREPL will now be reinstalled")
            Base.Filesystem.rm(Pkg.dir("OhMyREPL"), recursive=true)
            Pkg.clone("git@github.com:goerz/OhMyREPL.jl.git")
        end
    else
        warn("OhMyREPL not available. It will now be installed")
        Pkg.clone("git@github.com:goerz/OhMyREPL.jl.git")
    end
end


"""Check if we're about to start the REPL"""
function in_repl()
    # program
    if !isempty(ARGS) && !isempty(first(ARGS))
        return false
    end
    options = Base.JLOptions()
    # command-line
    if (options.eval != C_NULL) || (options.print != C_NULL)
        return false
    end
    return true
end


if in_repl()

    check_OhMyREPL()
    import OhMyREPL
    STH = OhMyREPL.Passes.SyntaxHighlighter

    # aliases
    export ls

    # helpers
    export @sexpr, @methods, @methodswith, @dump, @esc

    # emerge
    export emerge

    source_files = [
        "constants.jl",
        "aliases.jl",
        "helpers.jl",
        "emerge.jl",
        "repl.jl",
        "setup.jl",
    ]

    foreach(include, source_files)

    setup()

    println("Julia REPL has been initalized from JuliaRC package")

end


end
