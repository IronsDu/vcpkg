vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO wiredtiger/wiredtiger
    REF 11.3.1           # MongoDB 官方维护的分支，质量最好
    SHA512 b2499496bd149600a01e41567dddde5229ff7074111601db2f0a9f6bb196a4765a358fa010dd684a9f5476558fa69c875d8de3d02751c0f04ab842d1ae421e5d
    HEAD_REF develop
)

# 2024-2025 年 WiredTiger 已经默认使用 CMake，不再需要自己打补丁
vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DENABLE_SNAPPY=ON
        -DENABLE_LZ4=ON
        -DENABLE_ZLIB=ON
        -DENABLE_ZSTD=ON
        -DWT_STANDALONE_BUILD=ON
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()

file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/debug/share/wiredtiger")
file(GLOB WT_CONFIG_FILES "${CURRENT_PACKAGES_DIR}/lib/cmake/WiredTiger/*")
if(WT_CONFIG_FILES)
    file(COPY ${WT_CONFIG_FILES} DESTINATION "${CURRENT_PACKAGES_DIR}/share/wiredtiger")
    file(COPY ${WT_CONFIG_FILES} DESTINATION "${CURRENT_PACKAGES_DIR}/debug/share/wiredtiger")
endif()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")