package("gl-interface")
    set_homepage("https://github.com/sunrisepeak/gl-interface")
    set_description("gli...")
    set_license("Apache-2.0")

    add_urls("https://github.com/sunrisepeak/gl-interface.git")
    --add_versions("1.0", "<shasum256 or gitcommit>")

    add_configs("backend", {description = "gli's backend", default = "opengl", type = "string"})

    add_includedirs("include")

    on_load("macosx", "linux", "windows", function (package)
        if package:config("backend") == "opengl" then
            package:add("deps", "glad")
        end
    end)

    on_install(function (package)
        local configs = {}
        if package:config("shared") then
            configs.kind = "shared" -- TODO: no-effect
        end
        os.cp("gl_interface.h", package:installdir("include")) -- TODO: use gli's xmake.lua
        import("package.tools.xmake").install(package, configs)
    end)

    on_test(function (package)
        -- TODO check includes and interfaces
        --assert(package:has_cfuncs("gli_backend_deinit", {includes = "gl_interface.h"}))
    end)