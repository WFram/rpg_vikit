set(Sophus_LIBRARY_HEADER_DIRNAME sophus)
set(Sophus_LIBRARY_FILENAME libSophus.so)

find_package(PkgConfig)
pkg_check_modules(PC_SOPHUS ${Sophus_LIBRARY_HEADER_DIRNAME})
set(SOPHUS_DEFINITIONS ${PC_SOPHUS_CFLAGS_OTHER})


find_path(SOPHUS_INCLUDE_DIR ${Sophus_LIBRARY_HEADER_DIRNAME}/se3.h
    HINTS ${PC_SOPHUS_INCLUDEDIR} ${PC_SOPHUS_INCLUDE_DIRS}
          "${Sophus_ROOT_DIR}" "$ENV{SOPHUS_ROOT_DIR}"
          "${SOPHUS_ROOT}" "$ENV{SOPHUS_ROOT}"  # Backwards Compatibility
    PATH_SUFFIXES ${Sophus_LIBRARY_HEADER_DIRNAME}
          include/${Sophus_LIBRARY_HEADER_DIRNAME}
          include)

find_path(SOPHUS_LIBRARIES ${Sophus_LIBRARY_FILENAME}
    HINTS ${PC_SOPHUS_LIBRARIES}
          "${Sophus_ROOT_DIR}" "$ENV{SOPHUS_ROOT_DIR}"
          "${SOPHUS_ROOT}" "$ENV{SOPHUS_ROOT}"  # Backwards Compatibility
    PATH_SUFFIXES ${Sophus_LIBRARY_HEADER_DIRNAME} lib)

set(Sophus_INCLUDE_DIRS ${SOPHUS_INCLUDE_DIR})
set(Sophus_LIBRARIES ${SOPHUS_LIBRARIES}/${Sophus_LIBRARY_FILENAME})
