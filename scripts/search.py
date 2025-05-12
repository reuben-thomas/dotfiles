#!/home/reuben/.pyenv/shims/python3

import subprocess
import validators
import argparse

WOFI_CONFIG_PATH = "/home/reuben/.config/wofi/search/config"
WOFI_STYLE_PATH = "/home/reuben/.config/wofi/search/style.css"
BROWSER_CMD = "brave-browser"

MAX_BANG_LENGTH = 4
DEFAULT_SEARCH_ENGINE = "https://www.google.com/search?q=%s"
DEFAULT_BANG_SEARCH_ENGINE = "https://search.brave.com/search?q=%s"

BANG_URL_MAP = {
    "!yt": "https://www.youtube.com/results?search_query=%s",
    "!gpt": "https://chatgpt.com/?oai-dm=1&temporary-chat=true&model=gpt-4o&q=%s",
    "!cl": "https://claude.ai/new?q=%s",
    "!gh": "https://github.com/search?q=%s",
    "!gm": "https://mail.google.com/mail/u/0/#search/%s",
    "!gd": "https://drive.google.com/drive/search?q=%s",
    "!gi": "https://www.google.com/search?tbm=isch&q=%s",
    "!gp": "https://photos.google.com/search/%s",
    "!gsc": "https://scholar.google.com/scholar?hl=en&as_sdt=0%2C5&q=%s&btnG=&oq=hello",
    "!th": "https://www.merriam-webster.com/thesaurus/%s",
    "!w": "https://en.wikipedia.org/w/index.php?title=Special:Search&search=%s",
}


def open_in_browser(url: str):
    browser_cmd = [BROWSER_CMD, url]
    subprocess.run(browser_cmd)


def run(query: str):
    query_split = query.split(" ")

    # Do nothing if empty string
    if len(query) == 0 or query.isspace():
        return

    # Bang
    if (
        query.startswith("!")
        and len(query_split) > 1
        and len(query_split[0]) <= MAX_BANG_LENGTH
    ):
        if (bang_url := BANG_URL_MAP.get(query_split[0])) is not None:
            open_in_browser(bang_url % "+".join(query_split[1:]))
        else:
            open_in_browser(DEFAULT_BANG_SEARCH_ENGINE % "+".join(query_split))

    # Valid URL
    elif validators.url(query) or validators.domain(query):
        open_in_browser(query)

    # Google Search
    else:
        open_in_browser(DEFAULT_SEARCH_ENGINE % "+".join(query_split))


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Run a query from the command line.")
    parser.add_argument("query", type=str, help="The query string to process")
    args = parser.parse_args()

    run(args.query)
