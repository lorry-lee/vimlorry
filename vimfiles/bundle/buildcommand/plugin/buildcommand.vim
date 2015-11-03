let g:default_errorfile = $errorfile

function! s:AsyncBuild(command)
    setlocal errorformat=%f:%l:%c:\ %m
    setlocal errorfile=g:default_errorfile
    let make_cmd = a:command
    let title = 'Make [%d]: '
    let title .= "(default)"
    call asynccommand#run(make_cmd, asynchandler#quickfix(&errorformat, title))
endfunction

command! -nargs=+ -complete=file -complete=shellcmd AsyncBuild call s:AsyncBuild(<q-args>)

command Ga AsyncBuild("./build/cmake_generate_android_eclipse.bat")
command Ba AsyncBuild("./build/build_android_native_debug.bat")
command Bar AsyncBuild("./build/build_android_native_release.bat")
command Baf AsyncBuild("./build/build_android_native_retail.bat")
command Baj AsyncBuild("./demo/native/android/java/build_run_debug.bat")
command Bac AsyncBuild("./demo/native/android/cpp/build_run_debug.bat")
command Baw AsyncBuild("./demo/native/android/web/build_run_debug.bat")

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

