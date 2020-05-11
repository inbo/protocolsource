# protocols

INBO protocols for monitoring

*experimental*: we are in the process of trying out git-version control for INBO protocols. In the meantime, the official versions of INBO protocols are hosted [here](https://sites.google.com/a/inbo.be/veldprotocols/) (only accessible to INBO collaborators). 
Development versions are in [this google drive folder](https://drive.google.com/drive/folders/0BzUqT1wpznBXY2ZqaXh2a0tyd2M) (only accessible to INBO collaborators). 

## Repository structure

```
  |- README.md <- up to date description of the repo content
  |- docs <- can be used to locally inspect rendered versions of protocols; is git-ignored
  |- from_docx <- contains Microsoft Word docx protocols which were converted to 
                  markdown
  |- src
  |    |- thematic <- thematic protocols
  |    |   |- 0_generic
  |    |   |- 1_water 
  |    |   |- 2_air 
  |    |   |- 3_soil 
  |    |   |- 4_vegetation 
  |    |   |- 5_species
  |    |- project <- project-specific protocols
  |    |- management <- for repo admins only
```

## Installation instructions

Installing the repository on your local drive:

* go to the [protocols repository](https://github.com/inbo/protocols/) and press the `Clone` button
* copy the URL to the clipboard
* start RStudio and select `File -> New project -> Version Control -> Git` -> paste the URL
* `protocols` will be automatically suggested as project directory name (keep it
that way)
* In the field `Create project as subdirectory of` select a folder on your local  disc (do *not* use a folder that google drive file stream synchronizes). For instance `C:/R/GitRepositories`.
* Click OK

You will now have a local clone of the remote repository as an RStudio project. The file `protocols.Rproj` will be automatically created as well as a `.git` directory (do not make changes in this directory - it is where version control takes place). 

The same directories and files which can be seen on the [remote](https://github.com/inbo/protocols) will be copied to your local drive. Whenever you want to work in the project, you need to double-click `protocols.Rproj` file to start the RStudio project. 

To refer to files use the `rprojroot` package. 
Here is an example to refer to the project folder:

```r
library(rprojroot)
path_to_project <- file.path(
  find_root(is_git_root),
  "src",
  "project"
  )
```


## Branching model

![](protocols-gitflow-model.png)


We use a simple branching model. 
The master branch is protected and can only receive commits from reviewed pull requests.
Development of a protocol (see [Workflow](#workflow)) is done in a protocol-specific branch that branches off the master branch.

Protocols can depend on other protocols (protocol dependencies) only if these dependent protocols have been approved (and are published). 
Cirular dependencies are not allowed.

Whenever a pull request is reviewed and finalized. 
A repo-admin will merge the branch to the master and add general and specific tags. 
The general tag is of the form `protocols-YYYY.number`.
The specific tag is of the form `protocol-code-YYYY.number`.
Note that the merge commit to which these tags are attached represent an entire snapshot of the complete repository - not only the part of the repository that refers to the specific protocol. 

These tags serve several purposes:

- the specific tag 
    - identifies which protocol has been added or updated 
    - identifies the version number of the protocol that has been 
added or updated
    - searching tags that have the protocol-code as string, allows reconstructing
    the full history of versions for that protocol
- the general tag 
    - is incremental, meaning that general tags can be put in a time sequence
    - will be used as tag to base a GitHub Release on. A GitHub Release is just     a zip-file containing all files in the repository at that moment. The repository is setup in such a way that with each release a Zenodo archive will be created as well. The added benefit of this is (1) guaranteed long-term archiving, (2) creation of a DOI.


Each time a merge commit is made to the master branch of the `protocols` repo, a 'mirror read-only' repository (protocols-website) will be automatically triggered to build the rendered html versions of the protocols using Travis Continuous Integration.
The resulting website is hosted at **TO BE ADDED**.
This website will host all approved and published versions of all protocols.


## Workflow 

The workflow is as follows for a _new_ protocol:

- make sure your local clone of the remote repository is up to date:
    - with the master branch checked out, press the pull button in the Git pane
- a subject-matter specialist uses `protocolhelper::create_sfp()` to start a new protocol from a template
- the generated protocol-code (e.g. sfp-401) is noted and a new branch named after the protocol-code is created:
    - in the Git pane press the icon to create a new branch
- a first commit is made:
    - stage the files generated from the template in the git pane
    - press commit button and add a commit message
    - press the commit button
    - press the push button
- the subject-matter specialist visits [github protocols](https://github.com/inbo/protocols) and starts a Pull Request (PR)

    ![](pr-on-github-1.png)

    ![](pr-on-github-1.png) 

- Mark the PR as a draft

    ![](pr-on-github-3.png)

- Continue work on the protocol
    - add text, media, ... to the Rmarkdown files
    - save your changes
    - stage, commit, push changes
- When finished go to your draft pull request and press 'ready for review' and add reviewers. At least one repo admin and one other subject-matter specialist must review the protocol. The subject-matter specialist reviews the contents of the protocol and the repo-admin reviews technical aspects.

    ![](pr-on-github-4.png)

- If the reviewers raise concerns, changes can be made to the protocol that address these concerns (stage, commit, push)
- When all reviewers have given their approval, the repo admin 
    - adds tags with definitive version numbers to the YAML header 
    - updates the repo NEWS.md file
    - and merges the PR to the master
- The GitHub protocols repo is setup in such a way that branches that are merged with the master branch will be deleted automatically.


For an _update_ of an existing protocol all steps are the same, except for:

- the creation of the new branch can (re-)use the protocol-code of the existing protocol
- after review is finished, the protocol-specific `NEWS.Rmd` should be updated to document the substantive changes between the updated version of the previous version.


## Relationships to other repositories

This repository contains the Rmarkdown versions of protocols. 

A companioning repository `protocols-website` hosts the rendered versions of these protocols.

A small R package called [protocolhelper](https://github.com/inbo/protocolhelper) has several utility functions that aid in setting up a new protocol from a template and functions to aid management of the `protocols` repository.

## Starting a new protocol with the aid of protocolhelper functions

The name and location of the file and folder will be automatically determined by means of the input that you provide to the arguments of the `create_`-family of 
functions. 
With `render = TRUE` the Rmarkdown files will be rendered to `html` output in a corresponding folder beneath `docs`. 
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

[tutorial rmarkdown](https://ourcodingclub.github.io/2016/11/24/rmarkdown-1.html)

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


## Other ways of contributing

### Suggesting changes to existing protocols

Using online editing functionalities

To do: write this section
