set(program_name "ruby")
set(program_version 3.2.1-1)

if(CMAKE_HOST_WIN32)
    if(VCPKG_TARGET_ARCHITECTURE STREQUAL "x86")
        set(subdir_name "rubyinstaller-${program_version}-x86")
        set(download_urls "https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-${program_version}/rubyinstaller-${program_version}-x86.7z")
        set(download_filename "rubyinstaller-${program_version}-x86.7z")
        set(download_sha512 e938a88f34926f2f3344acf6d45a5eca533488d38ff91cb287bd0ba5169b7d0c394025e4d30f79b5c78e4b55265aea4a6925079e1d7fa73cce63a54e5f839c03)
    else()
        set(subdir_name "rubyinstaller-${program_version}-x64")
        set(download_urls "https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-${program_version}/rubyinstaller-${program_version}-x64.7z")
        set(download_filename "rubyinstaller-${program_version}-x64.7z")
        set(download_sha512 96ea4f2c6fa992e20767c03effb5e8ab7fbddcd3035e150e187c3d164094b9ef40820eca911332262b876f0e1e9591f39824251d3119577371fb39a3ae3b650f)
    endif()
    set(paths_to_search "${DOWNLOADS}/tools/ruby/${subdir_name}/bin")
else()
    set(brew_name ruby)
    set(apt_package_name "ruby")
endif()
