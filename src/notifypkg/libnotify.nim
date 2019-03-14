## These are the wrappers over the libnotify.so library.

type
  NotifyNotification = object
  NotifyNotificationPtr* = ptr NotifyNotification
  GError = object
  GErrorPtr* = ptr GError

{.push dynlib: "libnotify.so".}
proc notify_init*(s: cstring): bool {.importc, discardable.}
proc notify_uninit*() {.importc.}

proc notify_notification_new*(sumary, body, icon: cstring): NotifyNotificationPtr {.importc.}
proc notify_notification_show*(notification: NotifyNotificationPtr, error: GErrorPtr): bool {.importc.}
proc notify_notification_update*(notification: NotifyNotificationPtr, sumary, body, icon: cstring): bool {.importc.}

{.pop.}
