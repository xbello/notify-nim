import notifypkg/libnotify


type
  Notification* = object
    app_name*, summary*, body*, icon*: string
    cptr: NotifyNotificationPtr

proc create*(summary, body, icon: string): Notification =
  ## Init a new notification
  ##
  ## .. code-block:: Nim
  ##
  ##   var n: Notification = create("Title", "Body of the notification", "icon")
  ##   n.show()
  ##
  ## Icon values are PNG files found in places like ``/usr/share/icons/gnome/``.
  ## Some useful ones are:
  ##
  ## .. code-block:: Nim
  ##
  ##  dialog-error        avatar-default  user-invisible
  ##  dialog-information  computer-fail   user-available
  ##  dialog-warning      network-error
  ##  task-due            network-idle
  ##
  notify_init("App")
  var cptr: NotifyNotificationPtr = notify_notification_new(summary, body, icon)

  return Notification(
    cptr: cptr,
    app_name: "App",
    summary: summary,
    body: body,
    icon: icon)


proc destroy(notification: Notification) =
  if notification.cptr != nil:
    notify_uninit()


proc show*(notification: Notification): bool =
  ## Show the notification in its correspondent area.
  var e: GErrorPtr
  if notify_notification_show(notification.cptr, e):
    return true
  return false


proc update*(notification: Notification, sumary, body, icon: string): bool =
  ## Update the values of a notification before showing it.
  if notify_notification_update(notification.cptr, sumary, body, icon):
    return true
  return false


if isMainModule:
  var notif = create("Hello", "Sample", "dialog-information")
  discard notif.show()
