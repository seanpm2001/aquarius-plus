cmake_minimum_required(VERSION 3.13)

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

elseif (LINUX)
    add_executable(
        ${CMAKE_PROJECT_NAME}
        ${SOURCES}
    )

elseif (WIN32)

endif()


find_package(PkgConfig)


# Set compiler options
target_compile_options(${CMAKE_PROJECT_NAME} PRIVATE -Wno-psabi -Wall -Wextra -Wpedantic)
target_compile_definitions(${CMAKE_PROJECT_NAME} PRIVATE EMULATOR=1)

# pkg-config
find_package(PkgConfig)

# Add SDL includes/library/options
find_package(SDL2 REQUIRED)
target_link_libraries(${CMAKE_PROJECT_NAME} ${SDL2_LIBRARIES})
target_include_directories(${CMAKE_PROJECT_NAME} PUBLIC ${SDL2_INCLUDE_DIRS})
target_compile_options(${CMAKE_PROJECT_NAME} PUBLIC ${SDL2_CFLAGS_OTHER})
