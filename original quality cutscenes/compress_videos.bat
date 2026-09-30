@echo off
setlocal

:: Config
set "ffmpeg_path=%~dp0ffmpeg.exe"
set "width=1280"
set "bitrate=3500k"
set "output_dir=compressed"

cd /d "%~dp0"
if not exist "%output_dir%" mkdir "%output_dir%"

echo Compressing *\_original.ogv files into "%output_dir%"...

for %%F in ("*_original.ogv") do (
    rem %%~nF is the filename without extension, e.g. "menu_original"
    rem strip the "_original" suffix:
    set "base=%%~nF"
    setlocal enabledelayedexpansion
    set "name=!base:_original=!"
    echo Processing %%F → !name!.ogv...
    "%ffmpeg_path%" -y -i "%%F" ^
      -vf "scale=%width%:-1" ^
      -b:v %bitrate% -c:v libtheora -c:a libvorbis -q:a 4 "%output_dir%\!name!.ogv"
    endlocal
)

echo.
echo Done! Check "%output_dir%" for your compressed .ogv files.
pause
