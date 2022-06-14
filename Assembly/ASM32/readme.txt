Run in cmd line:



>  cd path_to_modules_dir

>  nasm -fobj MMCfactorial.asm

>  nasm -fobj MMCmain.asm



>  alink MMCmain.obj MMCfactorial.obj -oPE  -subsys console -entry start



>  MMCmain.exe 
