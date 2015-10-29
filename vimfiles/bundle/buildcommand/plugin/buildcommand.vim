
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
command Gw AsyncBuild("./build/cmake_generate_win32_2012.bat")
command Bw AsyncBuild("./build/build_win32_2012_unity_debug.bat")

command Gi AsyncBuild("./build/cmake_generate_ios_xcode.sh")
command Bi AsyncBuild("./build/build_ios_xcode_debug.sh")

