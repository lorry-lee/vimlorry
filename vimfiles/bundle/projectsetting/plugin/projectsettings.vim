" Set project path to go to include file
set path=src/private;src/include

function! s:AsyncBuild(command)
    cexpr "Building..."
    let format = "%f:%l:%c:\ %m"
    call asynccommand#run(a:command, asynchandler#quickfix(format, 'Make [%d]: ' . a:command))
endfunction

function! s:AsyncBuildJava(command)
    cexpr "Building..."
    let format = "%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#"
    call asynccommand#run(a:command, asynchandler#quickfix(format, 'Make [%d]: ' . a:command))
endfunction

command! -nargs=+ -complete=file -complete=shellcmd AsyncBuild call s:AsyncBuild(<q-args>)
command! -nargs=+ -complete=file -complete=shellcmd AsyncBuildJava call s:AsyncBuildJava(<q-args>)

command Ga AsyncBuild("./build/cmake_generate_android_eclipse.bat")
command Ba AsyncBuild("./build/build_android_native_debug.bat")
command Bar AsyncBuild("./build/build_android_native_release.bat")
command Baf AsyncBuild("./build/build_android_native_retail.bat")
command Baj AsyncBuildJava("./demo/native/android/java/build_run_debug.bat")
command Bac AsyncBuildJava("./demo/native/android/cpp/build_run_debug.bat")
command Baw AsyncBuildJava("./demo/native/android/web/build_run_debug.bat")

command Gw AsyncBuild("./build/cmake_generate_win32_2012.bat")
command Bw AsyncBuild("./build/build_win32_2012_debug.bat")
command Bwr AsyncBuild("./build/build_win32_2012_release.bat")
command Bwf AsyncBuild("./build/build_win32_2012_retail.bat")

command Gi AsyncBuild("./build/cmake_generate_ios_xcode.sh")
command Bi AsyncBuild("./build/build_ios_xcode_debug.sh")
command Bir AsyncBuild("./build/build_ios_xcode_release.sh")
command Bif AsyncBuild("./build/build_ios_xcode_retail.sh")

command Go AsyncBuild("./build/cmake_generate_osx_xcode.sh")
command Bo AsyncBuild("./build/build_osx_xcode_debug.sh")
command Bor AsyncBuild("./build/build_osx_xcode_release.sh")
command Bof AsyncBuild("./build/build_osx_xcode_retail.sh")

command Bma AsyncBuildJava("./build/build_run_android_debug.bat")
command Bmar AsyncBuildJava("./build/build_run_android_retail.bat")

command Bmi AsyncBuild("./build/build_run_ios_debug.sh")
command Bmir AsyncBuild("./build/build_run_ios_retail.sh")
