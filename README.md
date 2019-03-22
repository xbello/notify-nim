# notify-nim

A quick wrapper over [libnotify](https://developer.gnome.org/libnotify/),
a library to show unobstrusive notifications in a Gnome environment.

## Usage


    import notify

    var n: Notification = create("Title", "Body of the notification", "dialog-information")
    # Optionally set a timeout in milliseconds
    n.timeout = 1000
    discard n.show()

`icon` values are PNG files found in places like `/usr/share/icons/gnome/`.
Some useful ones are:

    dialog-error        avatar-default  user-invisible
    dialog-information  computer-fail   user-available
    dialog-warning      network-error
    task-due            network-idle
    
## Install

You can require it in `your_program.nimble` [file](https://github.com/nim-lang/nimble#depsdependencies):

    requires "nim > 0.19.0", "notify"
    
Or you can install it with [nimble](https://github.com/nim-lang/nimble#nimble-install):

    nimble install notify
    
 ### Requisites
 
 You should have `libnotify.so` in your system, usually doing something like:
 
     [ubuntu]$ sudo apt install libnotify
     [fedora]$ sudo dnf install libnotify
