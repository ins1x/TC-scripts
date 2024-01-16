Cmdow
Win32 console application for manipulating program windows.
https://ritchielawrence.github.io/cmdow/

  CMDOW [window | /T] [/B] [/F] [/P]

  window  Window to list. Specify a window by its handle (in hex format, eg
          0x1A0142) or caption (window title). Caption is case insensitive.
          Use asterisk before/after caption to match zero or more characters.
          Windows without captions are matched by their ClassName. Use double
          quotes for captions containing whitespace or control characters. The
          At symbol '@' may be used to refer to this window. eg 'CMDOW @ /HID'.
  /T      List only the windows shown on the taskbar (these are typically
          visible level 1 windows that do not have an owner).
  /B      Bare format. Does not print the field names when listing windows.
  /F      Full format. By default CMDOW truncates Image names to eight
          characters and Captions/ClassNames to fit under 80 characters.
          Use this option to disable this feature.
  /P      Shows window position, coords of top left corner of the window and
          its absolute width and height in pixels.

This form of CMDOW performs a single action typically affecting all windows.

  CMDOW /TH | /TV | /CW | /MA | /UW | /AT | /FS | /WM

  /TH     Tiles all windows horizontally. Functionally equivalent to right-
          clicking the taskbar and selecting 'Tile Windows Horizontally'.
  /TV     Tiles all windows vertically. Functionally equivalent to right-
          clicking the taskbar and selecting 'Tile Windows Vertically'.
  /CW     Functionally equivalent to right-clicking the taskbar and selecting
          'Cascade Windows'.
  /MA     Minimizes all windows. Functionally equivalent to right-clicking the
          taskbar and selecting 'Minimize All Windows' or using the keyboard
          shortcut Win+M. A window may not be minimized if it has a modal
          dialog box open (typically the window displayed by Help | About).
  /UW     Undo the effect of /TH, /TV, /CW and /MA. Functionally equivalent to
          right-clicking the taskbar and selecting 'Undo...' or using the
          keyboard shortcut Win+Shift+M.
  /AT     Similar to the keyboard shortcut Alt+Tab but instead of activating
          the next highest window in the Z order, /AT activates the window at
          the bottom of the Z order. Consequently, /AT can be used to activate
          every window on the taskbar sequentially. To prevent windows on the 
          taskbar from flashing, set the following registry value to zero:-
          HKCU\Control Panel\Desktop\ForegroundLockTimeout.
  /FS     Switch the window running this process into full screen mode.
  /WM     Switch the window running this process into window mode.

This form of CMDOW performs specified action(s) on the specified window(s). Some of these commands allow you to manipulate windows in ways not normally possible. Improper use may cause unexpected results and system instability.

  CMDOW window {[/ACT] [/INA] [/ENA] [/DIS] [/VIS] [/HID] [/MIN] [/MAX] [/RES]}
  CMDOW window {[/REN newcaption] [/TOP] [/NOT] [/MOV left top]
        [/SIZ width height] [/CLS] [/END]}

  window  Window to act on. Specify a window by its handle (in hex format, eg
          0x1A0142) or caption (window title). Caption is case insensitive.
          Use asterisk before/after caption to match zero or more characters.
          Windows without captions are matched by their ClassName. Use double
          quotes for captions containing whitespace or control characters. The
          At symbol '@' may be used to refer to this window. eg 'CMDOW @ /HID'.
  /ACT    Activates the specified window. It's possible to activate a hidden
          and/or disabled window (although doing so will not make it visible or
          enabled). If a minimized window is activated, it remains minimized.
  /INA    Inactivates the specified window (activates a window shown on the
          taskbar with the lowest Z order). If the specified window is already
          inactive or it is the only window shown on the taskbar, then /INA has
          no effect. This action added for completeness rather than usefulness.
  /ENA    Enables the specified window (allowing user interaction).
  /DIS    Disables the specified window. A disabled window will continue to run
          as usual, although it will not accept user input until it is enabled.
  /VIS    Unhides the specified window (make it visible).
  /HID    Hides the specified window. Although a hidden window will not be
          shown on the taskbar, it will still run and may be unhidden later.
  /MIN    Minimizes specified window. Not all windows can be minimized, dialog
          boxes for instance.
  /MAX    Maximizes specified window (even those not having a Maximize button).
  /RES    Restores the specified window to its former size and position. If a
          minimized window was originally maximized, then /RES will maximize
          the window. Applying /RES a second time, will restore the window to
          the size and position it was before it was maximized.
  /REN    Renames the caption of the specified window to the caption specified
          after /REN. Use double quotes for captions containing whitespace.
  /TOP    Makes the specified window always on top. It will remain on top even
          when another window is activated. If two or more windows have this
          attribute set, the topmost window will be that which had the
          attribute set first.
  /NOT    Makes window not always on top. This is the normal setting for most
          windows.
  /MOV    Moves the specified window. The left and top arguments specify the
          new position of the left top corner of the window. For level one
          windows this is relative to the desktop, and for child windows this
          is relative to its parent window. Level one windows can be moved off
          the screen using negative coords or coords greater than the desktop
          size. You should not move a minimized or maximized window without
          first restoring it.
  /SIZ    Resizes the specified window. The width and height arguments specify
          the new absolute width and height. In general, windows cannot be made
          smaller using /SIZ than they could if using conventional methods. You
          should not resize a minimized or maximized window without first
          restoring it.
  /CLS    Politely asks the specified window to close. Most applications will
          respond to this request, although some may display a message box
          asking you what to do with unsaved work.
  /END    Kills the process associated with the specified window, the result is
          all windows with the same Pid are also killed. Use very carefully.

  If more than one window matches the specified caption, CMDOW only acts on the
  first one. To override this add the /DBM (Don't Blame Me) switch - DANGEROUS.
  Multiple actions are performed in order, from left to right. Eg:-

    CMDOW 0x0E0144 /hid /ren "10% complete" /mov 0 0 /siz 300 100 /act /vis
This form of CMDOW executes the specified file or opens it using the application associated with the filename extension.

  CMDOW /RUN [state] file [args]

  /RUN    Executes the specified file if possible, otherwise opens it using the
          application associated with the filename extension.
  state   Requests how the application's window is initially displayed. Use
          /MIN for minimized, /MAX for maximized and /HID for hidden. If
          omitted the application is started in its default show state. Some
          applications ignore this, use CMDOW to alter the window state after
          the application has started.
  file    File to execute/open. Use double quotes if filename contains spaces.
  args    Optional arguments passed on to the application. Specify any args
          exactly as you would if executing/opening the file directly.