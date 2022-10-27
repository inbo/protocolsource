---
editor_options:
  markdown:
    mode: gfm
    canonical: false
---

# Contributing guidelines

## Welcome!

Thank you for considering to contribute to this repository!

## Setup your local repository

Are you a first-time GitHub user?
Make sure you can authenticate to GitHub by following [these guidelines](https://inbo.github.io/tutorials/tutorials/git_authentication/).

Installing the repository on your local drive:

-   go to the [protocolsource repository](https://github.com/inbo/protocolsource/) and press the green `Code` button
-   select HTTPS and copy the URL to the clipboard
-   start RStudio and select `File -> New project -> Version Control -> Git` -\> paste the URL
-   `protocolsource` will be automatically suggested as project directory name (keep it that way)
-   In the field `Create project as subdirectory of` select a folder on your local disc. For instance `C:/R/repositories`.
-   Click "Create project"

You will now have a local clone of the remote repository as an RStudio project.
The `.git` directory is used by the version control system (do not make changes in this directory).

The same directories and files which can be seen on the [remote](https://github.com/inbo/protocolsource) will be copied to your local drive.
Whenever you want to work in the project, you need to open `protocolsource.Rproj` file to start the RStudio project.

This RStudio project uses [renv](https://rstudio.github.io/renv/articles/renv.html) to manage R package dependencies.
This ensures that different users have the same versions of packages installed.
See also [collaborating with renv](https://rstudio.github.io/renv/articles/collaborating.html).
The first time you open the RStudio project `renv` should automatically download and install the appropriate version of `renv` into the project library.
After this has completed, you can use `renv::restore()` to restore the project library locally on your machine.
In case you need another package than the ones installed (see the [DESCRIPTION file](DESCRIPTION)) for this project, proceed as follows:

- `renv::install("nameofthepackage")`
- add the name of the package to the [DESCRIPTION file](DESCRIPTION)
- `renv::snapshot()`: type 'y' in the console when asked to update [the lock file](renv.lock)
- commit the changed [lock file](renv.lock)

but please consider this carefully and ask one of the admins if in doubt.
Note also that any dependency packages needed by the packages listed in the [DESCRIPTION file](DESCRIPTION) are also available in the project and they are listed in [the lock file](renv.lock).

## Branching model

![](src/management/protocols-gitflow-model.png)

We use a simple branching model.
The main branch is protected and can only receive commits from reviewed pull requests.
Development of a protocol (see [Workflow](#workflow)) is done in a protocol-specific branch that branches off the main branch.
The name of the protocol-specific branch should be equal to the protocol-code.

Protocols can depend on other protocols (protocol dependencies) only if these dependency protocols have been approved (and are published).
Circular dependencies are not allowed.

Whenever a pull request is reviewed, approved and finalized, a repo-admin will merge the branch to the main and add general and specific tags (see [release model](README.md#release-model)).
Note that the merge commit to which these tags are attached represents an entire snapshot of the complete repository - not only the part of the repository that refers to the specific protocol.

Each time a merge commit is made to the main branch of the `protocolsource` repo, a 'mirror read-only' repository (`protocols` repo) will be automatically triggered to build the rendered html versions of the protocols using GitHub Actions.
The resulting website is hosted at https://inbo.github.io/protocols/.
This website will host all approved and published versions of all protocols.

## Workflow

The workflow is as follows for a **new** protocol:

1.  make sure your local clone of the remote repository is up to date:

    1.  with the main branch checked out, press the pull button in the RStudio Git pane

2.  a subject-matter specialist uses `protocolhelper::create_protocol()` (or one of its shortcut functions `create_sfp()` or `create_spp()`) to start a new [protocol from a template](#from-a-new-template)

3.  the generated protocol-code (e.g. `sfp-406-nl`) is noted and a new branch named after the protocol-code is created:

    1.  in the Console type `checklist::new_branch(branch = "<protocol-code>")` (replace <protocol-code> by the generated protocol-code, e.g. `sfp-406-nl`)

4.  after some work on the protocol, a first commit is made, i.e. the (developing) protocol state is stored by the version control system:

    1.  stage the files generated from the template in the git pane
    2.  press commit button and add a commit message
    3.  press the commit button
    4.  press the push button (or postpone pushing until several commits have been made)

5.  the subject-matter specialist visits [github protocolsource](https://github.com/inbo/protocolsource) and starts a Pull Request (PR)

    ![](src/management/pr-on-github-1.png)

    ![](src/management/pr-on-github-2.png)

6.  Mark the PR as a draft

    ![](src/management/pr-on-github-3.png)

7.  Continue work on the protocol

    1.  See [What to do in case of parameterized protocols?](#parameterized)
        for specific guidelines about parameterizing parts of a protocol

    2.  See [What to do in case of dependencies?](#dependencies)
        for how to declare protocol dependencies and adding them as subprotocols

    3.  See [What to do in case of translations?](#translations)
        for guidance about translations of protocols

    4.  regularly preview the html version of the protocol:

        1.  with `protocolhelper::render_protocol(protocol_folder_name =     "name-of-your-protocol-folder")` (when this function is finished, read the message in the R console after "Output created: ..." to see where you can find and preview the rendered version of your protocol)
        2.  alternatively, download the rendered version: see [these instructions](REVIEWING.md)

    5.  add text, media, ... to the Rmarkdown files
    6.  save your changes

    7.  stage, commit, push changes

8.  When finished, go to your draft pull request and press 'ready for review' 

   1. Wait for the continuous integration checks to finish and see if the checks succeeded.
   These checks will run `protocolhelper::check_frontmatter()` and `protocolhelper::check_structure()`, and update the version number if needed.
   In case there are problems with the YAML front matter of your `index.Rmd` file or problems with the structure of the protocol not conforming to the protocol templates, these problems will be listed and can be consulted.
   
       1.  Address the problems detected by `protocolhelper::check_frontmatter` or `protocolhelper::check_structure`. You can see the list of problems by clicking on the check online (at the bottom of the pull request webpage). Alternatively, you can run these functions locally and see the list of problems printed in your console.
        Note that during this automatic run, a commit to update the version number may be automatically pushed to the remote.
        If this commit is added, press pull in the RStudio Git Pane to add it to your local clone
       
       1.  iterate (stage, commit, push changes) until the functions detect no problems
   
   1. Add reviewers.
    At least one repo admin and one other subject-matter specialist must review the protocol.
    The subject-matter specialist reviews the contents of the protocol and the repo-admin reviews technical aspects.

    ![](src/management/pr-on-github-4.png)

9.  Reviewers can follow [these guidelines](REVIEWING.md)

10. If the reviewers raise concerns, changes can be made to the protocol that address these concerns (stage, commit, push)

11. When all reviewers have given their approval, the **repo admin** needs to do some necessary admin tasks before merging [see RELEASES.md](RELEASES.md)

12. The GitHub protocolsource repo is setup in such a way that branches that are merged in the main branch will be deleted automatically.

For an **update** of an existing protocol all steps are the same, except for:

-   you don't need `protocolhelper::create_protocol()`
-   the creation of the new branch can (re-)use the protocol-code of the existing protocol
-   after review is finished, the protocol-specific `NEWS.md` should be updated to document the substantive changes between the updated version of the previous version.

For adding a **pre-existing version of a protocol that was written in `docx` format**, follow the steps to create a new protocol, except in the second step:

-   a subject-matter specialist uses `protocolhelper::create_protocol()` (or one of its shortcut functions `create_sfp()` or `create_spp()`) to convert the `docx` protocol to Rmarkdown files. See section [From an existing docx protocol](#from-an-existing-docx-protocol).
-   the old protocol-code from the pre-existing `docx` protocol will likely not correspond with the new protocol-code. Mention this in the protocol-specific `NEWS.md` file. Use the new protocol-code to create a new branch with `checklist::new_branch()`
-   If the section titles in the `docx` version of the protocol comply with section titles in the templates used by the `protocolhelper` package, then you will normally not see Rmarkdown file names starting with the same number. Otherwise, the function will have written both empty template Rmarkdown files as well as Rmarkdown files resulting from conversion of the `docx` file. (Note that `NEWS.md` and `index.Rmd` are always created from the `protocolhelper` templates.) In that case, you need to make changes (renaming files, deleting redundant files) so that Rmarkdown file names comply with the [template Rmarkdown files](https://github.com/inbo/protocolhelper/tree/main/inst/rmarkdown/templates).
    - if this is the case, it will also be detected by `protocolhelper::check_structure()`. So it is advised to use this function to detect these and other problems.
-   continue the steps outlined for a new protocol.

## Starting a new protocol with the aid of protocolhelper functions

The name and location of the protocol files and folder will be automatically determined by means of the input that you provide as arguments of the `create_`-family of functions (`create_protocol()`, `create_spp()`, `create_sfp()`).
With `render = TRUE` the Rmarkdown files will be rendered to `html` output in a corresponding folder inside `docs`.
This will allow you to check the resulting output locally.

### From an existing docx protocol

```r
library(protocolhelper)
create_sfp(title = "Klassieke vegetatieopname in een proefvlak aan de hand van visuele inschattingen van bedekking van soorten in (semi-)terrestrische vegetatie",
           short_title = "vegopname terrest",
           authors = "De Bie, Els",
           orcids = "0000-0000-1234-5678",
           date = "2016-07-19", 
           reviewers = "Hans Van Calster, Lieve Vriens, Jan Wouters, Wouter Van Gompel, Els Lommelen", 
           file_manager = "Hans Van Calster", 
           theme = "vegetation",
           language = "nl",
           from_docx = 
             file.path(path_to_from_docx, 
                       "SVP_401_VegetatieOpnamePV_Terrestrisch_v1.1.docx"),
           protocol_number = "401", 
           render = FALSE)
```

### From a new template

```r
library(protocolhelper)
create_sfp(title = "titel van het protocol",
           subtitle = "optionele subtitel", 
           short_title = "korte titel",
           authors = c("Achternaam1, Voornaam1", "Achternaam2, voornaam2"),
           orcids = c("0000-0000-1234-5678", "0000-0000-1234-8765"),
           date = "`r Sys.Date()`", 
           reviewers = "Voornaam Naam, ...", 
           file_manager = "Voornaam Naam", 
           theme = "vegetation",
           language = "nl",
           from_docx = NULL,
           protocol_number = NULL, 
           render = FALSE)
```

Alternatively, for a project-specific protocol:

```r
library(protocolhelper)
create_spp(title = "Bodemstalen nemen", 
           short_title = "bodemstalen", 
           authors = c("Beton, Jon", "Plastiek, Jef"),
           orcids = c("0000-0000-1234-5678", "0000-0000-8765-4321"),
           date = Sys.Date(), 
           reviewers = "reviewer1, reviewer2", 
           file_manager = "manager",
           project_name = "mne",
           language = "nl",
           render = FALSE)
```

## <a name="parameterized"></a>What to do in case of parameterized protocols?

See [the bookdown manual](https://bookdown.org/yihui/rmarkdown/parameterized-reports.html) for a general explanation about parameterized reports.

Suppose we have a protocol where we would like to specify parameters: the depth beneath the soil surface that needs to be sampled with a soil auger as well as the number of subsamples to take and the diameter of the auger.
To do this, we need to go to the YAML header of our `index.Rmd` file and add a `params` section to the header with the needed key-value pair:

    ---
    ... #(...) indicates all metadata in the YAML header, such as title and authors
    params:
      soil_depth_cm: 10
      number_subsamples: 9
      auger_diameter_cm: 2.5
    ---

Now we are ready to use this parameter in the remainder of the protocol text.
We can either call the parameter using an inline R expression:

    We use the soil auger to sample the soil up to a depth of `r params$soil_depth_cm` centimeter.

Or in an R chunk:

```r
volume_sampled_cm3 <- params$soil_depth_cm * 
    params$number_subsamples *
    pi * params$auger_diameter_cm ^ 2 / 4 
```

## <a name="dependencies"></a>What to do in case of dependencies?

When a protocol [depends on other protocols](README.md#dependencies), they need to be declared in the `params` section of the YAML header of the `ìndex.Rmd` file.
The easiest way to do this is with the aid of `protocolhelper::add_dependencies()`.
Moreover, if a subprotocol uses [parameters](#parameterized), the subprotocol parameter values can be customized at the level of the main protocol.
Instead of creating the YAML section manually as in [What to do in case of parameterized protocols?](#parameterized),
we use the function `protocolhelper::add_dependencies()`.
The reason to use a function here is twofold:

-   the function does some basic checks to see if the dependencies are correctly specified
-   the YAML syntaxis for specifying the dependencies is complicated

Here is an example of using the function:

```r
protocolhelper::add_dependencies(
    code_mainprotocol = "spp-999-en",
    protocol_code = c("sfp-123-en", "sfp-124-en"),
    version_number = c("2020.01", "2020.02"),
    params = list(NA, 
                  list(
                      soil_depth_cm = 20,
                      number_subsamples = 18,
                      auger_diameter_cm = 1
                      )
                  )
)
```

This will add the following YAML syntax to the `index.Rmd` YAML header of `spp-999-en`:

    ---
    ... #(...) indicates all metadata in the YAML header, such as title and authors
    params:
      dependencies:
        value:
        - protocol_code: sfp-123-en
          version_number: '2020.01'
          params: .na
          appendix: false
        - protocol_code: sfp-124-en
          version_number: '2020.02'
          params:
            soil_depth_cm: 20
            number_subsamples: 18
            auger_diameter_cm: 1
          appendix: true
    ---

Note that in this example we have not specified the `appendix` argument of `protocolhelper::add_dependencies()`.
By default, `appendix = !is.na(params)` which means that any protocol that is specified as a dependency with [non-default parameters](#parameterized) will be included as an 'appendix' in the `Subprotocols` part of the main protocol.

Before we can render the main protocol with all its subprotocols, one extra step is needed.
The function `protocolhelper::add_subprotocol()` must be used to add md-files of the dependencies to be included as subprotocols.

To continue with the example:

```r
protocolhelper::add_subprotocols(
    code_mainprotocol = "spp-999-en"
)
```

Executing this code will write a single markdown file and associated media and data files for each subprotocol.
Each subprotocol will be written to a subfolder of the main protocol.
The subfolder name is the same as the version number of the subprotocol.

## <a name="translations"></a>What to do in case of translations of protocols?

Protocols can be written in either one or multiple languages.
The functions in the `protocolhelper` package support Dutch (language = 'nl') and English (language = 'en').
A translation of the same protocol will be evident from the protocol-code, e.g.: `sfp-001-nl` and `sfp-001-en`.
Note that these must be considered as two different protocols (with a different protocol code), although the protocol prefix+number shows their relationship.
To indicate that a specific version of `sfp-001-en` is a literal translation of a version of `sfp-001-nl`, the `NEWS.md` file of `sfp-001-en` should mention this, in a version-specific way.
Different language variants of the 'same' protocol should be added to the repo in a separate pull request.
Note that in subsequent versions of - say - `sfp-001-en` it is allowed that its contents diverge from `sfp-001-nl` of which it was a literal translation.

## Learning Rmarkdown

Some useful resources for self-learning of **Rmarkdown**:

-   [rmarkdown book](https://bookdown.org/yihui/rmarkdown/)
-   [bookdown book](https://bookdown.org/yihui/bookdown/)
-   [tutorial rmarkdown](https://ourcodingclub.github.io/2016/11/24/rmarkdown-1.html)

In RStudio:

-   `File -> New -> R markdown` automatically gives a template
-   `Help -> Markdown Quick Reference`
-   `Help -> Cheatsheets -> R markdown cheatsheet`

Tips & Tricks:

-   `ctrl + alt + i`: insert R chunk

-   select lines of R code in an R chunk followed by `ctrl-alt-i` puts the selected lines in a new R chunk

-   chunk options: <https://yihui.name/knitr/options/>

-   chunk names: are optional but recommended especially if an output is generated by the chunk, do not use spaces or \_ in chunk names (e.g. \`\`\`r name-of-chunk)

-   use 1 chunk for 1 (ggplot) figure or 1 table or other type of output that is printed

-   To refer to files use the `rprojroot` package.
    Here is an example to refer to the project folder:

    ```r
    library(rprojroot)
    path_to_project <- find_root_file(
      "src/project",
      criterion = is_git_root
      )
    ```

-   Use `knitr::include_graphics()` to insert `png`, `jpg`, ... files that you put into the `media` folder of the protocol

-   In case your protocol contains video material, do not store the video in the `media` folder, but publish it on the INBO vimeo channel and embed them following the instructions given [here](https://bookdown.org/yihui/rmarkdown/learnr-videos.html).

## Other ways of contributing

### Suggesting changes to draft protocols

If you are not familiar with git and RStudio, there are still ways to contribute.
The GitHub website has [online editing functionalities](https://help.github.com/en/github/managing-files-in-a-repository/editing-files-in-your-repository) which can be used to suggest changes to draft protocols.

<!--To do: instead of the link, use own screenshots to explain this-->
