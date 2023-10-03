cmake_minimum_required(VERSION 3.13)

execute_process(COMMAND
    git describe --always
    OUTPUT_VARIABLE APP_VERSION
    OUTPUT_STRIP_TRAILING_WHITESPACE)

project(AquariusPlusEmulator)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

include_directories(
    .
    Shared
    Shared/VFS
    UI
    libz80
    imgui
)

set(SOURCES
    Audio.cpp
    AY8910.cpp
    cJSON.c
    Config.cpp
    EmuState.cpp
    main.cpp
    tinyfiledialogs.cpp
    Version.cpp
    Video.cpp

    imgui/imgui_demo.cpp
    imgui/imgui_draw.cpp
    imgui/imgui_impl_sdl2.cpp
    imgui/imgui_impl_sdlrenderer2.cpp
    imgui/imgui_tables.cpp
    imgui/imgui_widgets.cpp
    imgui/imgui.cpp

    Shared/AqKeyboard.cpp
    Shared/AqUartProtocol.cpp
    Shared/EspSettingsConsole.cpp
    Shared/VFS/EspVFS.cpp
    Shared/VFS/SDCardVFS.cpp
    Shared/VFS/VFS.cpp

    UI/AssemblyListing.cpp
    UI/MemoryEditor.cpp
    UI/UI.cpp

    libz80/z80.c
)

if (APPLE)
    set(AquariusPlusEmulator_ICON ${CMAKE_CURRENT_SOURCE_DIR}/macos/AquariusPlusEmu.icns)

    add_executable(
        ${CMAKE_PROJECT_NAME}
        MACOSX_BUNDLE

        ${AquariusPlusEmulator_ICON}
        ${SOURCES}
    )

    set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES
        BUNDLE True
        MACOSX_BUNDLE_GUI_IDENTIFIER net.aquariusplus.aquariusemu
        MACOSX_BUNDLE_BUNDLE_NAME AquariusPlusEmu
        MACOSX_BUNDLE_ICON_FILE AquariusPlusEmu.icns
        # MACOSX_BUNDLE_BUNDLE_VERSION "0.1"
        # MACOSX_BUNDLE_SHORT_VERSION_STRING "0.1"
        # MACOSX_BUNDLE_INFO_PLIST ${CMAKE_SOURCE_DIR}/cmake/customtemplate.plist.in
    )
    set_source_files_properties(${AquariusPlusEmulator_ICON} PROPERTIES MACOSX_PACKAGE_LOCATION "Resources")
endif()

if (LINUX)
    add_executable(
        ${CMAKE_PROJECT_NAME}
        ${SOURCES}
    )
endif()

if (WIN32)
    include_directories(
        windows
        windows/SDL2-2.0.20/include
    )

    add_executable(
        ${CMAKE_PROJECT_NAME}
        WIN32
        ${SOURCES}
        windows/Resource.rc
    )

    target_link_libraries(${CMAKE_PROJECT_NAME}
        ${CMAKE_CURRENT_SOURCE_DIR}/windows/SDL2-2.0.20/lib/x64/SDL2.lib
        ${CMAKE_CURRENT_SOURCE_DIR}/windows/SDL2-2.0.20/lib/x64/SDL2main.lib
    )
endif()

target_compile_definitions(${CMAKE_PROJECT_NAME} PRIVATE EMULATOR=1)

if (NOT WIN32)
    find_package(PkgConfig)

    # Set compiler options
    target_compile_options(${CMAKE_PROJECT_NAME} PRIVATE -Wno-psabi -Wall -Wextra -Wpedantic)

    # pkg-config
    find_package(PkgConfig)

    # Add SDL includes/library/options
    find_package(SDL2 REQUIRED)
    target_link_libraries(${CMAKE_PROJECT_NAME} ${SDL2_LIBRARIES})
    target_include_directories(${CMAKE_PROJECT_NAME} PUBLIC ${SDL2_INCLUDE_DIRS})
    target_compile_options(${CMAKE_PROJECT_NAME} PUBLIC ${SDL2_CFLAGS_OTHER})
endif()

if (WIN32)
    include(InstallRequiredSystemLibraries)
    install(TARGETS ${CMAKE_PROJECT_NAME} RUNTIME DESTINATION bin)
    install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/windows/SDL2-2.0.20/lib/x64/SDL2.dll DESTINATION bin)

    # set(CPACK_PACKAGE_VERSION_MAJOR 1)
    # set(CPACK_PACKAGE_VERSION_MINOR 0)
    # set(CPACK_PACKAGE_VERSION_PATCH 0)
    set(CPACK_PACKAGE_NAME "Aquarius+ Emulator")
    set(CPACK_PACKAGE_VENDOR "The Aquarius+ Project")
    set(CPACK_PACKAGE_DESCRIPTION "Emulator for the Aquarius+ system")
    set(CPACK_PACKAGE_FILE_NAME "AquariusPlusEmu-Windows-x64-${APP_VERSION}")
    set(CPACK_PACKAGE_INSTALL_DIRECTORY "AquariusPlusEmulator")
    set(CPACK_PACKAGE_ICON ${CMAKE_CURRENT_SOURCE_DIR}/windows/AquariusPlusEmu.ico)
    set(CPACK_WIX_UPGRADE_GUID "f97b24e4-36c5-42a8-9925-2182c67db3d3")
    set(CPACK_SOURCE_GENERATOR "WIX")
    set(CPACK_GENERATOR "WIX")
    set(CPACK_PACKAGE_EXECUTABLES "AquariusPlusEmulator;Aquarius+ Emulator")
    set(CPACK_CREATE_DESKTOP_LINKS "AquariusPlusEmulator;Aquarius+ Emulator")
    set(CPACK_WIX_PRODUCT_ICON ${CMAKE_CURRENT_SOURCE_DIR}/windows/AquariusPlusEmu.ico)
    set(CPACK_WIX_PROGRAM_MENU_FOLDER .)
    include(CPack)
endif()
