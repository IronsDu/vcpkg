vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO wiredtiger/wiredtiger
    REF mongodb-8.2.5           # MongoDB 官方维护的分支，质量最好
    SHA512 351d24dd4bd63e4cda565a0296392f7882c248fd6889154292ce77dc113e5d49d013ae125d1fc8d87c8debb1bc1fdffbb2b238264da0d89e64392e1d8cdbc615
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
        -DCMAKE_C_FLAGS="-w"
        -DCMAKE_CXX_FLAGS="-w"
        -DCMAKE_BUILD_TYPE=RelWithDebInfo
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")