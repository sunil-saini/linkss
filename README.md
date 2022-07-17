# linkss - Links Shortcuts
CLI tool to save urls as shell commands and open that in default browser by using command directly

## Installation
```
curl -s https://raw.githubusercontent.com/sunil-saini/linkss/main/install.sh -o install.sh && . ./install.sh && rm install.sh
```
After installation open a new tab in terminal and type `linkss` to see the help

## Help
```
linkss()

NAME
    linkss -

DESCRIPTION
    Command Line Tool to add urls as shell command

SYNOPSIS
    linkss [options]

OPTIONS
    -h, --help
        show help
    -l  --list
        list existing commands
    -a  --add
        add/modify existing commands
    -d  --delete
        delete existing command
```

## Usage

- Add command for an url
    ```
    MPSUNILSA:~ ss$ linkss -a
    Enter url and short name
    Enter url : https://www.google.com/
    Enter short name for url : google
    for url https://www.google.com/ command google added successfully
    ```
    Open new terminal and type `google`, will open a tab in default browser opening https://www.google.com/

- Rename an existing command </br>
    For existing url, it will show current set command as `[current=XXXX]`
    ```
    MPSUNILSA:~ ss$ linkss -a
    Enter url and short name
    Enter url : https://www.google.com/
    Enter short name for url [current=google] : google_new
    for url https://www.google.com/ command google_new updated successfully
    ```
    Open new terminal and type `google_new` now instead of `google`, will open a tab in default browser opening https://www.google.com/
- List all existing commands
    ```
    MPSUNILSA:~ ss$ linkss -l
    google_new --> https://www.google.com/
    ```
- Delete an existing command
    ```
    MPSUNILSA:~ ss$ linkss -d
    Enter url : https://www.google.com/
    url https://www.google.com/ removed successfully
    ```

Happy Coding :beers:
