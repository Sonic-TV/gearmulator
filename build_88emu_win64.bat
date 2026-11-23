@echo off
setlocal
cd /d "%~dp0"

rem 88emuplayer is currently enabled by the Standalone option, even for plugin builds.
rem Pass additional CMake options on the command line, e.g. -T v145 for VS 2026.
set "outdir=temp\cmake_88emu_win64"
cmake -S . -B "%outdir%" -Dgearmulator_SYNTH_OSIRUS=OFF -Dgearmulator_SYNTH_OSTIRUS=OFF -Dgearmulator_SYNTH_VAVRA=OFF -Dgearmulator_SYNTH_XENIA=OFF -Dgearmulator_SYNTH_NODALRED2X=OFF -Dgearmulator_SYNTH_JE8086=OFF -Dgearmulator_SYNTH_88EMU=ON -Dgearmulator_COMPONENT_DSPBRIDGE=OFF -Dgearmulator_BUILD_INSTALLER=OFF -Dgearmulator_BUILD_JUCEPLUGIN=ON -Dgearmulator_BUILD_JUCEPLUGIN_Standalone=ON -Dgearmulator_BUILD_JUCEPLUGIN_VST3=ON -Dgearmulator_BUILD_JUCEPLUGIN_CLAP=ON -DBUILD_TESTING=OFF %*
if errorlevel 1 exit /b 1

cmake --build "%outdir%" --config Release --target 88emuplayer_VST3 88emuplayer_CLAP 88emuplayer_Standalone 88EmuCli --parallel 3
if errorlevel 1 exit /b 1

echo 88emu VST3, CLAP, Standalone and CLI are available in bin\plugins\Release.
exit /b 0
