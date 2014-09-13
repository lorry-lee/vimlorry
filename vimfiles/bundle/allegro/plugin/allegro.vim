" Set file include search and goto file path
set path=include,src,game,D:\MinGW\include

" Compile my project
set makeprg=mingw32-make

function DebugCurrentProject()
    exec ":Cfile ".GetExecutablePath()
endfunction

function CompileLauncher()
    cd ./tools/batch
    :silent !refresh_make.bat
    cd ../..
    cd ./build
    :AsyncMake
    cd ..
endfunction

function DebugLauncher()
    let result="./build/game/stormfighter.exe"
    let result=substitute(result, "/", "\\", "g")
    exec ":Cfile ".result
endfunction

function StartClient()
    cd y:/stormfighter/main
    :Crun
endfunction

map <F5>    :call DebugCurrentProject()<CR>

map <F7> :call CompileLauncher()<CR>
map <F5> :call DebugLauncher()<CR>

map <A-1> :call StartClient()<CR>
map <A-2> :silent !.\tools\editor\main.lua<CR>
map <A-3> :silent !.\tools\batch\refresh_make.bat<CR>

map <F10> :Cmapkeys<CR>
map <F11> :Cunmapkeys<CR>



function <SID>PythonGrep(tool)
  set lazyredraw
  " Close any existing cwindows.
  cclose
  let l:grepformat_save = &grepformat
  let l:grepprogram_save = &grepprg
  set grepformat&vim
  set grepformat&vim
  let &grepformat = '%f:%l:%m'
  if a:tool == "pylint"
    let &grepprg = 'pylint --output-format=parseable --reports=n --rcfile=pylint.conf'
  elseif a:tool == "pychecker"
    let &grepprg = 'pychecker --quiet -q'
  else
    echohl WarningMsg
    echo "PythonGrep Error: Unknown Tool"
    echohl none
  endif
  if &readonly == 0 | update | endif
  silent! grep! %
  let &grepformat = l:grepformat_save
  let &grepprg = l:grepprogram_save
  let l:mod_total = 0
  let l:win_count = 1
  " Determine correct window height
  windo let l:win_count = l:win_count + 1
  if l:win_count <= 2 | let l:win_count = 4 | endif
  windo let l:mod_total = l:mod_total + winheight(0)/4 |
        \ execute 'resize +'.l:mod_total
  " Open cwindow
  execute 'belowright cwindow'
  ".l:mod_total
  nnoremap <buffer> <silent> c :cclose<CR>
  set nolazyredraw
  redraw!
endfunction

if ( !hasmapto('<SID>PythonGrep(pylint)') && (maparg('<C-F10>') == '') )
  map <C-F10> :call <SID>PythonGrep('pylint')<CR>
  map! <C-F10> :call <SID>PythonGrep('pylint')<CR>
else
  if ( !has("gui_running") || has("win32") )
    echo "Python Pylint Error: No Key mapped.\n".
          \ "<C-F10> is taken and a replacement was not assigned."
  endif
endif

if ( !hasmapto('<SID>PythonGrep(pychecker)') && (maparg('<C-F11>') == '') )
  map <C-F11> :call <SID>PythonGrep('pychecker')<CR>
  map! <C-F11> :call <SID>PythonGrep('pychecker')<CR>
else
  if ( !has("gui_running") || has("win32") )
    echo "Python Pychecker Error: No Key mapped.\n".
          \ "<C-F11> is taken and a replacement was not assigned."
  endif
endif

[MASTER]

# Specify a configuration file.
#rcfile=

# Python code to execute, usually for sys.path manipulation such as

# pygtk.require().
init-hook='import sys; sys.path.append("X:/dungeonraiders/Main/Platform/ZmqService")'

# Profiled execution.
profile=no

# Add files or directories to the blacklist. They should be base names, not

# paths.
ignore=CVS

# Pickle collected data for later comparisons.
persistent=no

# List of plugins (as comma separated values of python modules names) to load,

# usually to register additional checkers.
load-plugins=



[MESSAGES CONTROL]

# Enable the message, report, category or checker with the given id(s). You can

# either give multiple identifier separated by comma (,) or put this option

# multiple time.
#enable=

# Disable the message, report, category or checker with the given id(s). You

# can either give multiple identifier separated by comma (,) or put this option

# multiple time (only on the command line, not in the configuration file where

# it should appear only once).
disable=E0203,C0112,C0111,C0301,W0201,W0232,R0903,I0011
#Code: E0203 Access to member %r before its definition line %s
#Reason: This kinds of error will appear on generated member sometimes
#Code: C0111 Missing docstring
#Reason: The document name should comment itself
#Code: W0201 Attribute %r defined outside __init__
#Reason: This kinds of error will appear on generated member
#Code: W0232 Class has no __init__ method
#Reason: Some class is small class for library and we don't need __init__ method
#Code: R0903 Too few public methods (%s/%s)
#Reason: Some class is small class for library and we don't need public method
#Code: I0011 Locally disabling %s
#Reason: The unit test case setUp and tearDown is python internally, so we need to disable it locally

[REPORTS]

# Set the output format. Available formats are text, parseable, colorized, msvs

# (visual studio) and html. You can also give a reporter class, eg

# mypackage.mymodule.MyReporterClass.
output-format=text

# Include message's id in output
include-ids=no

# Include symbolic ids of messages in output
symbols=no

# Put messages in a separate file for each module / package specified on the

# command line instead of printing them on stdout. Reports (if any) will be

# written in a file name "pylint_global.[txt|html]".
files-output=no

# Tells whether to display a full report or only the messages
reports=yes

# Python expression which should return a note less than 10 (10 is the highest

# note). You have access to the variables errors warning, statement which

# respectively contain the number of errors / warnings messages and the total

# number of statements analyzed. This is used by the global evaluation report

# (RP0004).
evaluation=10.0 - ((float(5 * error + warning + refactor + convention) / statement) * 10)

# Add a comment according to your evaluation note. This is used by the global

# evaluation report (RP0004).
comment=no


[BASIC]

# Required attributes for module, separated by a comma
required-attributes=

# List of builtins function names that should not be used, separated by a comma
bad-functions=map,filter,apply,input

# Regular expression which should only match correct module names
module-rgx=(([a-z_][a-z0-9_]*)|([A-Z][a-zA-Z0-9]+))$

# Regular expression which should only match correct module level names
const-rgx=(([A-Z_][A-Z0-9_]*)|(__.*__))$

# Regular expression which should only match correct class names
class-rgx=[A-Z_][a-zA-Z0-9]+$

# Regular expression which should only match correct function names
function-rgx=[a-z_][a-z0-9_]{0,30}$

# Regular expression which should only match correct method names
method-rgx=[a-z_][a-z0-9_]{0,30}$

# Regular expression which should only match correct instance attribute names
attr-rgx=[a-z_][a-z0-9_]{0,30}$

# Regular expression which should only match correct argument names
argument-rgx=[a-z_][a-z0-9_]{0,30}$

# Regular expression which should only match correct variable names
variable-rgx=[a-z_][a-z0-9_]{0,30}$

# Regular expression which should only match correct list comprehension /

# generator expression variable names
inlinevar-rgx=[A-Za-z_][A-Za-z0-9_]*$

# Good variable names which should always be accepted, separated by a comma
good-names=i,j,k,ex,Run,_

# Bad variable names which should always be refused, separated by a comma
bad-names=foo,bar,baz,toto,tutu,tata

# Regular expression which should only match functions or classes name which do

# not require a docstring
no-docstring-rgx=__.*__


[FORMAT]

# Maximum number of characters on a single line.
# We change it to 160 because we think we can't avoid to write reasonable long line
max-line-length=160

# Maximum number of lines in a module
max-module-lines=1000

# String used as indentation unit. This is usually " " (4 spaces) or "\t" (1

# tab).
indent-string='    '


[MISCELLANEOUS]

# List of note tags to take in consideration, separated by a comma.
notes=FIXME,XXX,TODO


[SIMILARITIES]

# Minimum lines number of a similarity.
min-similarity-lines=4

# Ignore comments when computing similarities.
ignore-comments=yes

# Ignore docstrings when computing similarities.
ignore-docstrings=yes

# Ignore imports when computing similarities.
ignore-imports=no


[TYPECHECK]

# Tells whether missing members accessed in mixin class should be ignored. A

# mixin class is detected if its name ends with "mixin" (case insensitive).
ignore-mixin-members=yes

# List of classes names for which member attributes should not be checked

# (useful for classes with attributes dynamically set).
ignored-classes=SQLObject,ForeignKey

# When zope mode is activated, add a predefined set of Zope acquired attributes

# to generated-members.
zope=no

# List of members which are set dynamically and missed by pylint inference

# system, and so shouldn't trigger E0201 when accessed. Python regular

# expressions are accepted.
generated-members=REQUEST,acl_users,aq_parent,objects,_meta,id,[a-zA-Z]+_id,DoesNotExist,[a-zA-Z]+_set

[VARIABLES]

# Tells whether we should check for unused import in __init__ files.
init-import=no

# A regular expression matching the beginning of the name of dummy variables

# (i.e. not used).
dummy-variables-rgx=_|dummy

# List of additional names supposed to be defined in builtins. Remember that

# you should avoid to define new builtins when possible.
additional-builtins=


[CLASSES]

# List of interface methods to ignore, separated by a comma. This is used for

# instance to not check methods defines in Zope's Interface base class.
ignore-iface-methods=isImplementedBy,deferred,extends,names,namesAndDescriptions,queryDescriptionFor,getBases,getDescriptionFor,getDoc,getName,getTaggedValue,getTaggedValueTags,isEqualOrExtendedBy,setTaggedValue,isImplementedByInstancesOf,adaptWith,is_implemented_by

# List of method names used to declare (i.e. assign) instance attributes.
defining-attr-methods=__init__,__new__,setUp

# List of valid names for the first argument in a class method.
valid-classmethod-first-arg=cls

# List of valid names for the first argument in a metaclass class method.
valid-metaclass-classmethod-first-arg=mcs


[DESIGN]

# Maximum number of arguments for function / method
max-args=5

# Argument names that match this expression will be ignored. Default to name

# with leading underscore
ignored-argument-names=_.*

# Maximum number of locals for function / method body
max-locals=15

# Maximum number of return / yield for function / method body
max-returns=6

# Maximum number of branch for function / method body
max-branchs=12

# Maximum number of statements in function / method body
max-statements=50

# Maximum number of parents for a class (see R0901).
max-parents=7

# Maximum number of attributes for a class (see R0902).
max-attributes=7

# Minimum number of public methods for a class (see R0903).
min-public-methods=2

# Maximum number of public methods for a class (see R0904).
max-public-methods=20


[IMPORTS]

# Deprecated modules which should not be used, separated by a comma
deprecated-modules=regsub,string,TERMIOS,Bastion,rexec

# Create a graph of every (i.e. internal and external) dependencies in the

# given file (report RP0402 must not be disabled)
import-graph=

# Create a graph of external dependencies in the given file (report RP0402 must

# not be disabled)
ext-import-graph=

# Create a graph of internal dependencies in the given file (report RP0402 must

# not be disabled)
int-import-graph=


[EXCEPTIONS]

# Exceptions that will emit a warning when being caught. Defaults to

# "Exception"
overgeneral-exceptions=Exception
