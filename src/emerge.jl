function recompile_packages()
    for pkg in keys(Pkg.installed())
        try
            info("Compiling: $pkg")
            @eval using $(Symbol(pkg))
        catch err
            warn("Unable to precompile: $pkg")
            warn(err)
        finally
            println(SEPARATOR)
        end
    end
end

"""
    emerge(;update=true, build=true, precompile=true)

update: Update all packages

build: re-build all packages

precompile: precompile all packages by importing them
"""
function emerge(;update=true, build=true, precompile=true)
    tic()
    if update Pkg.update() end
    if build Pkg.build() end
    if precompile recompile_packages() end
    println("You may now rebuild the user image:\n")
    println("    include(joinpath(JULIA_HOME, Base.DATAROOTDIR, \"julia\", \"build_sysimg.jl\"))")
    println("    @time build_sysimg(default_sysimg_path(), \"native\", joinpath(homedir(), \".userimg.jl\"); force=true)\n")
    println("where ~/.userimg.jl contains \"using\" statements for all " *
            "packages you want to include in the image")
    toc()
end
