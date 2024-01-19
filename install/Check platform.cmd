cd %1

@if /I "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
  Setup64.exe
) else if /I "%PROCESSOR_ARCHITECTURE%" == "X86" (
  @if /I "%PROCESSOR_ARCHITEW6432%" == "AMD64" (
    Setup64.exe
  ) else (
    Setup.exe
  )
)