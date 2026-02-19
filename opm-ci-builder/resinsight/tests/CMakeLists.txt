cmake_minimum_required(VERSION 3.23)

project(opm_ci_tests)

set(REPO_ROOT "https://github.com/OPM/ResInsight"
    CACHE STRING "Git repository root URL/directory")
set(DOCKER_IMAGE ""
    CACHE STRING "docker image to run tests for")

option(CLEAN_DIRS "Clean directories after test finishes?" ON)

if(NOT DOCKER_IMAGE)
  message(FATAL_ERROR "DOCKER_IMAGE must be set")
endif()

include(CTest)

add_test(
  NAME
    post+resinsight
  COMMAND
    ${PROJECT_SOURCE_DIR}/build.sh
    -b ${PROJECT_BINARY_DIR}
    -c ${CLEAN_DIRS}
    -d ${DOCKER_IMAGE}
    -R ${REPO_ROOT}
)
set_tests_properties(post+resinsight PROPERTIES TIMEOUT 5000)
