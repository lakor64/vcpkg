vcpkg_find_acquire_program(RUBY)
get_filename_component(RUBY_EXE_PATH ${RUBY} DIRECTORY)
vcpkg_add_to_path("${RUBY_EXE_PATH}")

vcpkg_find_acquire_program(BISON)
get_filename_component(BISON_EXE_PATH ${BISON} DIRECTORY)
vcpkg_add_to_path("${BISON_EXE_PATH}")

vcpkg_find_acquire_program(FLEX)
get_filename_component(FLEX_EXE_PATH ${FLEX} DIRECTORY)
vcpkg_add_to_path("${FLEX_EXE_PATH}")

vcpkg_find_acquire_program(SED)
get_filename_component(SED_EXE_PATH ${SED} DIRECTORY)
vcpkg_add_to_path("${SED_EXE_PATH}")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO ruby/ruby
    REF v3_1_3
    SHA512 2d26fbe818a6d27a080a548938fc8d17d2d114cc193939ba4e8bf9e65a996ee74e87ad0a16e4015c39010bbe637b0f47640e3dc53a2bf3c70ec3e0c081856704
    HEAD_REF master
)

if(VCPKG_TARGET_IS_WINDOWS)
    vcpkg_execute_required_process(
        COMMAND ${SOURCE_PATH}/win32/configure.bat --with-baseruby=ruby
        WORKING_DIRECTORY ${SOURCE_PATH}
        LOGNAME autogen-${TARGET_TRIPLET}
    )

    set(ENV{YACC} win_bison)

    vcpkg_install_nmake(
        SOURCE_PATH "${SOURCE_PATH}"
        PROJECT_NAME Makefile
    )
# Linux, etc.
elseif(VCPKG_TARGET_IS_LINUX OR VCPKG_TARGET_IS_OSX)
    vcpkg_execute_required_process(
        COMMAND "${SOURCE_PATH}/autogen.sh" PREFIX=$${CURRENT_PACKAGES_DIR}
        WORKING_DIRECTORY ${SOURCE_PATH}
        LOGNAME autogen-${TARGET_TRIPLET}
    )

    vcpkg_configure_make(
        SOURCE_PATH "${SOURCE_PATH}"
        AUTOCONFIG
        CONFIGURE_ENVIRONMENT_VARIABLES CC CXX LD
    )

    vcpkg_install_make()
    vcpkg_fixup_pkgconfig()
endif()
