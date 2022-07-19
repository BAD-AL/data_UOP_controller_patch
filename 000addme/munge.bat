:: adjust the paths and platforms below to fit your setup

:: Art 
:: https://www.deviantart.com/wojtekfus/art/Star-Wars-Ahsoka-651933804
MD MUNGED
del addme.script addme.lvl 
del MUNGED\*.files 

:: un-comment to Generate Debug Code:
set LUA_DEBUG_SYMBOLS=""

C:\BF2_ModTools\ToolsFL\bin\pc_TextureMunge.exe -inputfile $*.tga  -checkdate -continue -platform PC -sourcedir texture -outputdir MUNGED 

C:\BF2_ModTools\ToolsFL\bin\ScriptMunge.exe -inputfile *.lua   -continue -platform PC -sourcedir  scripts -outputdir MUNGED  

::C:\BF2_ModTools\ToolsFL\bin\ConfigMunge.exe -inputfile $*.mcfg -continue -platform PC -sourcedir . -outputdir MUNGED -hashstrings 

C:\BF2_ModTools\ToolsFL\bin\levelpack.exe -inputfile addme.req -writefiles MUNGED\addme.files -continue -platform PC -sourcedir  req -inputdir MUNGED\ -outputdir . 

rename addme.lvl addme.script 

::move *.lvl ..
move *.log MUNGED 
