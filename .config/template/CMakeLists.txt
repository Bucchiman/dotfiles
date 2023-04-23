#
# FileName:     {{_file_name_}}
# Author:       {{_author_}}
# CreatedDate:  {{_date_}}
# LastModified: 2023-03-29 18:30:18 +0900
# Reference:    https://qiita.com/shohirose/items/45fb49c6b429e8b204ac
# Description:  ---
#


{{_cursor_}}




# cmake -S . -B build -DBUILD_SHARED_LIBS=ON    # 共有ライブラリ指定

####################
# 静的ライブラリ作成
####################
cmake_minimum_required(VERSION 3.13)
project(test_cmake CXX)
# hello.cppとgood_morning.cppをコンパイルして静的ライブラリlibgreetings.aを作成
add_library(greetings STATIC hello.cpp good_morning.cpp)
# a.outという実行ファイルをmain.cppから作成
add_executable(a.out main.cpp)
# a.outを作成する際にlibgreetings.aをリンク
target_link_libraries(a.out greetings)


####################
# 動的ライブラリ作成
####################
cmake_minimum_required(VERSION 3.13)
project(test_cmake CXX)
# hello.cppとgood_morning.cppをコンパイルして共有ライブラリlibgreetings.soを作成
add_library(greetings SHARED hello.cpp good_morning.cpp)
add_executable(a.out main.cpp)
# a.outを作成する際にlibgreetings.soをリンク
target_link_libraries(a.out greetings)


####################
# 各ライブラリ毎に静的、動的を指定する
# cmake -S . -B build -DGREETINGS_BUILD_SHARED_LIBS=ON
####################
# GREETINGS_BUILD_SHARED_LIBSというオプションを作成。デフォルトをOFFに設定。
option(GREETINGS_BUILD_SHARED_LIBS "build greetings as a shared library" OFF)

if (GREETINGS_BUILD_SHARED_LIBS)
  add_library(greetings SHARED hello.cpp good_morning.cpp)
else()
  add_library(greetings STATIC hello.cpp good_morning.cpp)
endif()

####################
# サブディレクトリ登録
####################
add_subdirectory(src)
add_subdirectory(test)
