# Contributing guidelines

## Welcome!

Thank you for considering to contribute to this repository!  
If you have not done so yet, take a look at the [branching model](README.md#branching-model) for a general picture of the way git version control is used to add or update, review and approve a protocol.

## Setup your local repository

Installing the repository on your local drive:

* go to the [protocols repository](https://github.com/inbo/protocols/) and press the `Clone` button
* copy the URL to the clipboard
* start RStudio and select `File -> New project -> Version Control -> Git` -> paste the URL
* `protocols` will be automatically suggested as project directory name (keep it
that way)
* In the field `Create project as subdirectory of` select a folder on your local  disc (do *not* use a folder that google drive file stream synchronizes). For instance `C:/R/GitRepositories`.
* Click OK

You will now have a local clone of the remote repository as an RStudio project.
The `.git` directory is used by the version control system (do not make changes in this directory). 

The same directories and files which can be seen on the [remote](https://github.com/inbo/protocols) will be copied to your local drive.
Whenever you want to work in the project, you need to open `protocols.Rproj` file to start the RStudio project. 

## Workflow 

The workflow is as follows for a _new_ protocol:

1. make sure your local clone of the remote repository is up to date:
    1. with the master branch checked out, press the pull button in the Git pane
1. a subject-matter specialist uses `protocolhelper::create_sfp()` to start a new [protocol from a template](#from-a-new-template)
1. the generated protocol-code (e.g. sfp-406) is noted and a new branch named after the protocol-code is created:
    1. in the Git pane press the icon to create a new branch
1. after some work on the protocol, a first commit is made, i.e. the (developing) protocol state is stored by the version control system:
    1. stage the files generated from the template in the git pane
    1. press commit button and add a commit message
    1. press the commit button
    1. press the push button (or postpone pushing until several commits have been made)
1. the subject-matter specialist visits [github protocols](https://github.com/inbo/protocols) and starts a Pull Request (PR)

    ![](src/management/pr-on-github-1.png)

    ![](src/management/pr-on-github-1.png) 

1. Mark the PR as a draft

    ![](src/management/pr-on-github-3.png)

1. Continue work on the protocol
    1. add text, media, ... to the Rmarkdown files
    1. save your changes
    1. stage, commit, push changes
1. When finished, go to your draft pull request and press 'ready for review' and add reviewers. At least one repo admin and one other subject-matter specialist must review the protocol. The subject-matter specialist reviews the contents of the protocol and the repo-admin reviews technical aspects.

    ![](src/management/pr-on-github-4.png)

1. If the reviewers raise concerns, changes can be made to the protocol that address these concerns (stage, commit, push)
1. When all reviewers have given their approval, the repo admin:
    1. adds tags with definitive version numbers to the YAML header 
    1. updates the repo NEWS.md file
    1. and merges the PR to the master
1. The GitHub protocols repo is setup in such a way that branches that are merged in the master branch will be deleted automatically.


For an _update_ of an existing protocol all steps are the same, except for:

- you don't need `protocolhelper::create_sfp()`
- the creation of the new branch can (re-)use the protocol-code of the existing protocol
- after review is finished, the protocol-specific `NEWS.Rmd` should be updated to document the substantive changes between the updated version of the previous version.

For adding a pre-existing version of a protocol that was written in `docx` format, follow the steps to create a new protocol, except in the second step:

- a subject-matter specialist uses `protocolhelper::create_sfp()` to convert the `docx` protocol to Rmarkdown files. See section [From an existing docx protocol](#from-an-existing-docx-protocol).
- use the protocol-code from the pre-existing `docx` protocol to create a new branch and continue the steps outlined for a new protocol.

## Starting a new protocol with the aid of protocolhelper functions

The name and location of the protocol files and folder will be automatically determined by means of the input that you provide as arguments of the `create_`-family of 
functions. 
With `render = TRUE` the Rmarkdown files will be rendered to `html` output in a corresponding folder inside `docs`. 
This will allow you to check the resulting output locally.

### From an existing docx protocol

```r
library(protocolhelper)
create_sfp(title = "Klassieke vegetatieopname in een proefvlak aan de hand van visuele inschattingen van bedekking van soorten in (semi-)terrestrische vegetatie",
           subtitle = "", 
           short_title = "vegopname terrest",
           authors = "Els De Bie", 
           date = "2016-07-19", 
           reviewers = "Hans Van Calster, Lieve Vriens, Jan Wouters, Wouter Van Gompel, Els Lommelen", 
           file_manager = "Hans Van Calster", 
           revision = "1.1.0.9000",
           theme = "vegetation",
           language = "nl",
           from_docx = 
             file.path(path_to_from_docx, 
                       "SVP_401_VegetatieOpnamePV_Terrestrisch_v1.1.docx"),
           protocol_number = "401", 
           render = TRUE)
```



### From a new template


```r
library(protocolhelper)
create_sfp(title = "titel van het protocol",
           subtitle = "optionele subtitel", 
           short_title = "korte titel",
           authors = "Voornaam Naam", 
           date = "`r Sys.Date()`", 
           reviewers = "Voornaam Naam, ...", 
           file_manager = "Voornaam Naam", 
           revision = "0.0.0.9000",
           theme = "vegetation",
           language = "nl",
           from_docx = NULL,
           protocol_number = NULL, 
           render = TRUE)
```

## Rmarkdown

Some useful resources for self-learning of **Rmarkdown**:

* [rmarkdown book](https://bookdown.org/yihui/rmarkdown/)
* [bookdown book](https://bookdown.org/yihui/bookdown/)
* [tutorial rmarkdown](https://ourcodingclub.github.io/2016/11/24/rmarkdown-1.html)

In RStudio: 

* `File -> New -> R markdown` automatically gives a template 
* `Help -> Markdown Quick Reference`
* `Help -> Cheatsheets -> R markdown cheatsheet`


Tips & Tricks:

* `ctrl + alt + i`: insert R chunk 
* select lines of R code in an R chunk followed by `ctrl-alt-i` puts the selected lines in a new R chunk
* chunk options: https://yihui.name/knitr/options/
* chunk names: are optional but recommended especially if an output is generated by the chunk, do not use spaces or _ in chunk names (e.g. ```r name-of-chunk)
* use 1 chunk for 1 (ggplot) figure or 1 table or other type of output that is printed 
* To refer to files use the `rprojroot` package. 
Here is an example to refer to the project folder:

    ```r
    library(rprojroot)
    path_to_project <- find_root_file(
      "src/project",
      criterion = is_git_root
      )
    ```




## Other ways of contributing

### Suggesting changes to existing protocols

Using online editing functionalities

To do: write this section
