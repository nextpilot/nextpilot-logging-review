

file(GLOB_RECURSE ALL_SOURCE_FILES
	${CMAKE_SOURCE_DIR}/src/common/*.cpp
	${CMAKE_SOURCE_DIR}/src/plugin/*.cpp
    ${CMAKE_SOURCE_DIR}/src/main/*.cpp
)

file(GLOB_RECURSE ALL_HEADER_FILES
	${CMAKE_SOURCE_DIR}/src/common/*.hpp
	${CMAKE_SOURCE_DIR}/src/plugin/*.hpp
    ${CMAKE_SOURCE_DIR}/src/main/*.hpp
)


add_custom_target(
	format
	COMMAND clang-format
	-style=file -i
	${ALL_SOURCE_FILES}
	${ALL_HEADER_FILES}
	USES_TERMINAL
)


add_custom_target(
	clang-tidy
	COMMAND ${PROJECT_SOURCE_DIR}/tools/run-clang-tidy.py
		-p . -use-color -header-filter='.*' -quiet
		-extra-arg=-std=c++17
		-ignore ${PROJECT_SOURCE_DIR}/.clang-tidy-ignore
	WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
	USES_TERMINAL
)
