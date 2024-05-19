import sys
from monitorcontrol import get_monitors

if len(sys.argv) != 2 or not int(sys.argv[1]):
    sys.exit(1)
value = sys.argv[1]

for monitor in get_monitors():
    with monitor:
        if value.startswith("+") or value.startswith("-"):
            monitor.set_luminance(monitor.get_luminance() + int(value))
        else:
            monitor.set_luminance(int(value))
