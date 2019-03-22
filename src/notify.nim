import parseopt
import sequtils
import strutils
import notifypkg/libnotify


type
  Notification* = object
    app_name*, summary*, body*, icon*: string
    timeout*: int
    cptr: NotifyNotificationPtr


proc destroy(notification: Notification) =
  if notification.cptr != nil:
    g_free(notification.cptr)
  if notify_is_initted():
    notify_uninit()


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
  ## The Notification object returned is defaulted to 3 seconds of timeout
  ##
  if not notify_is_initted():
    notify_init("App")
  var cptr: NotifyNotificationPtr = notify_notification_new(summary, body, icon)

  return Notification(
    cptr: cptr,
    app_name: "App",
    summary: summary,
    body: body,
    icon: icon,
    timeout: 3000)


proc show*(notification: Notification): bool =
  ## Show the notification in its correspondent area.
  var e: GErrorPtr
  notification.cptr.notify_notification_set_timeout(
    cast[int32](notification.timeout))

  if notify_notification_show(notification.cptr, e):
    result = true

  notification.destroy()


proc update*(notification: Notification, sumary, body, icon: string): bool =
  ## Update the values of a notification before showing it.
  if notify_notification_update(notification.cptr, sumary, body, icon):
    return true
  return false


proc `timeout=`*(notification: var Notification, timeout: int) {.inline.} =
  ## Set the Notification timeout in milliseconds
  ##
  ## .. code-block:: Nim
  ##
  ##     var n = create("Title", "Body", "dialog-information")
  ##     n.timeout = 500
  ##     discard n.show()
  ##
  notification.timeout = timeout


if isMainModule:
  var defaults: seq[string] = @["title", "body", "dialog-information", "3000"]
  var values: seq[string] = @[]

  var p = initOptParser()
  for kind, key, val in p.getopt():
    case kind
    of cmdArgument:
      values.add(key)
    of cmdLongOption, cmdShortOption:
      discard
    of cmdEnd:
      assert(false)

  if len(values) < len(defaults):
    values = values.concat(defaults[len(values) .. ^1])

  var notif = create(values[0], values[1], values[2])
  notif.timeout = values[3].parseInt
  discard notif.show()
