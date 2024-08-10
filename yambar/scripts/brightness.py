import sys
import subprocess
from monitorcontrol import get_monitors

MIN = 1
MAX = 100
DEFAULT = 50
BUILTIN_INCREMENT = 10
EXTERNAL_INCREMENT = 20

cmd = sys.argv[1]
monitors = get_monitors()


def confine(value: int) -> int:
    value = 5 * round(value / 5)
    return max(MIN, min(value, MAX))


def set_builtin_brightness(cmd: str) -> None:
    if cmd == "-":
        subprocess.run(["brightnessctl", "set", str(BUILTIN_INCREMENT) + "%-", "&"])
    elif cmd == "+":
        subprocess.run(
            ["brightnessctl", "set", "+" + str(BUILTIN_INCREMENT) + "%", "&"]
        )
    else:
        subprocess.run(["brightnessctl", "set", str(DEFAULT) + "%", "&"])


def set_external_brightness(monitors, cmd: str) -> None:
    set_value = -1

    for monitor in monitors:
        with monitor:
            if set_value < MIN:
                if cmd == "+" or cmd == "-":
                    set_value = monitor.get_luminance() + int(
                        cmd + str(EXTERNAL_INCREMENT)
                    )
                else:
                    set_value = DEFAULT
                set_value = confine(set_value)

            monitor.set_luminance(set_value)
    notify_set_value(set_value)


def notify_set_value(set_value: int) -> None:
    subprocess.run(
        [
            "notify-send",
            "Display Brightness",
            "Set to " + str(set_value) + "%",
            "-h",
            "string:x-canonical-private-synchronous:yambar-ddcutil-notification",
        ]
    )


def main():
    cmd = sys.argv[1]
    monitors = get_monitors()

    if len(monitors) > 0:
        set_external_brightness(monitors, cmd)
    else:
        set_builtin_brightness(cmd)


if __name__ == "__main__":
    main()
