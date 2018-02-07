function setup()
    push!(LOAD_PATH, pwd())
    ohmyrepl()
    atreplinit(customize_colors)
end
