set -xe

declare -a CMAKE_PLATFORM_FLAGS
if [[ -n "${OSX_ARCH}" ]]; then
    CMAKE_PLATFORM_FLAGS+=(-DCMAKE_OSX_SYSROOT="${CONDA_BUILD_SYSROOT}")
else
     CMAKE_PLATFORM_FLAGS+=(-DCMAKE_TOOLCHAIN_FILE="${RECIPE_DIR}/cross-linux.cmake")
fi

BUILD_DIR="${SRC_DIR}/build"
mkdir -p "${BUILD_DIR}"
cd "${BUILD_DIR}"

export CMAKE_PROJECT_PATH="${PREFIX}/lib/cmake/ElementsProject:${PREFIX}/lib64/cmake/ElementsProject"

cmake -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON \
    -DCMAKE_BUILD_TYPE:STRING=RELEASE \
    -DINSTALL_DOC:BOOL=OFF \
    -DUSE_SPHINX:BOOL=OFF \
    -DELEMENTS_BUILD_TESTS:BOOL=OFF \
    -DBoost_NO_BOOST_CMAKE:BOOL=ON \
    -DELEMENTS_FLAGS_SET=ON \
    -DM_LIBRARY:STRING="-lm" \
    ${CMAKE_PLATFORM_FLAGS[@]} \
    "${SRC_DIR}"

# Do not use all cores, or the memory consumption will explode!
make ${MAKEFLAGS} 
make install

install -p "${RECIPE_DIR}/sextractorxx_launch.sh" "${PREFIX}/bin"
