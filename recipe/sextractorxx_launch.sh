#!/bin/sh

if [[ -f /usr/bin/osascript ]]; then
    /usr/bin/osascript -e 'tell application "Terminal" to activate' \
        -e 'tell application "System Events" to tell process "Terminal" to keystroke "t" using command down' \
        -e 'tell application "Terminal" to do script "conda activate '${CONDA_DEFAULT_ENV}'" in selected tab of the front window' \
        -e 'tell application "Terminal" to do script "sextractor++ --version" in selected tab of the front window'
fi

