project "NativeFileDialogExtended"
    location "NativeFileDialogExtended" --项目文件和premake脚本放在同一目录，与源码同级，这样VS"显示所有文件"时可以展开完整的文件夹树方便添加新文件
    kind "StaticLib"
    language "C++"
    cppdialect "C++23" 
    staticruntime "On"
    
    targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}") --输出路径
    objdir ("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}") --中间文件路径

    buildoptions 
    {
        "/utf-8",       --保证能够使用log，文件编码时utf-8没错，但是编码器所选择的解释方式并不默认按照文本的格式来，否则 Microsoft Visual C++ (MSVC) 编译器默认会使用系统的本地代码页（如 Windows-1252）来读取它们。所以我们需要指定utf-8，否则log系统会报错
    }

    files{
        "src/include/**.h",
        "src/include/**.hpp"
    }

    includedirs
    {
        "src/include"
    }

    filter "system:windows"
        systemversion "latest"

        files{
            "src/nfd_win.cpp"
        }
        links{
            "ole32.lib",
            "uuid.lib",
            "shell32.lib"
        }


    filter "configurations:Debug" --暂时没用，但先写着
        defines "AYIN_DEBUG"
        runtime "Debug"
        symbols "On"

    filter "configurations:Release"
        defines "AYIN_RELEASE"
        runtime "Release"
        optimize "On"
        
    filter "configurations:Dist"
        defines "AYIN_DIST"
        runtime "Release"
        optimize "On"
