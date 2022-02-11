<!-- badges: start -->

![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)

<!-- badges: end -->

# protocols

INBO protocols

*experimental*: we are in the process of trying out git-version control for INBO protocols.
In the meantime, the official versions of INBO protocols are hosted [here](https://sites.google.com/inbo.be/veldprotocollen/).
Development versions are in [this google drive folder](https://drive.google.com/drive/folders/0BzUqT1wpznBXY2ZqaXh2a0tyd2M) (only accessible to INBO collaborators).

If you want to contribute a new protocol or update an existing protocol, check the [contributing guidelines](CONTRIBUTING.md).

## Repository structure

      |- CONTRIBUTING.md <- Contributing guidelines
      |- DESCRIPTION <- file used to document which R packages are used in the repo
      |- LICENSE <- license file
      |- NEWS.md <- repo-wide news file; contains one entry for each release
      |- README.md <- up to date description of the repo content
      |- RELEASES.md <- description of how protocols are released/published
      |- .github <- folder containing a pull request template and github action
         workflows
      |- docs <- can be used to locally inspect rendered versions of protocols; is
         git-ignored, but will be created if `protocolhelper::render_protocol()` is
         used
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

## Relationships to other repositories

This repository contains the Rmarkdown files of the protocols.

A companion repository `protocols` hosts the rendered html files for all versions of these protocols, which can be viewed at [insert website address here]().

A small R package called [protocolhelper](https://github.com/inbo/protocolhelper) has several utility functions that aid in setting up a new protocol from a template and functions to aid management of the `protocolsource` repository.
Documentation for the package can be found [here](https://inbo.github.io/protocolhelper/).

## Release model

Whenever a new protocol is added or an existing protocol is updated and approved, a new *GitHub release* of the repository will be made.
A GitHub Release is just a zip-file containing all files in the repository at that moment.
The repository is setup in such a way that with each release a Zenodo archive will be created as well.
The added benefit of this is (1) guaranteed long-term archiving, (2) creation of a DOI.
A release will also trigger the `protocols` repo to update the rendered versions of the protocols.

Tags are associated to each GitHub release.
To identify protocols and differentiate between different versions of protocols, we use two types of tags: a general tag and a specific tag.

The general tag is of the form `protocols-YYYY.NN`.
The specific tag is of the form `<protocol-code>-YYYY.NN` (see [protocol-code](#protocol-code) and [version number](#version-number)).

These tags serve several purposes:

-   the specific tag:

    -   identifies which protocol has been added or updated
    -   identifies the version number of the protocol that has been added or updated

Searching tags that have the same `<protocol-code>` as string, allows reconstructing the full history of versions for that protocol.

-   the general tag:

    -   is incremental regardless of which protocol is updated when
    -   will be used as tag to base a GitHub Release on

The incremental nature means that general tags reflect the time sequence of protocol releases in the whole repository.

## Folder and filename syntaxis

In this section, we describe the conventions we adhere to for naming of files and folders.
Each protocol is placed in a subfolder of the folder corresponding to the theme (for thematic protocols) or project (for project-specific protocols) to which it belongs (see [Repository structure](#repository-structure)).
The naming syntax for the subfolder is **`<protocol-code>_<short-title>`** and *will be automatically generated* from input you provide to [protocolhelper functions](CONTRIBUTING.md#starting-a-new-protocol-with-the-aid-of-protocolhelper-functions).

Note that the names of this subfolder and of its files are stable for different versions of the same protocol, because the files in these subfolders are subject to `Git` version control and the version number is kept inside the special file `index.Rmd`.
The subfolder contains `Rmarkdown` (i.e. `.Rmd`) files, a `_bookdown.yml` file and optionally two folders, named `data` and `media`.
Together, these files form a [bookdown book](https://bookdown.org/yihui/bookdown/), i.e. a collection of files to be read in a linear sequence that can be rendered into a 'book' (a protocol in our case) in any of a number of possible formats.

-   Apart from the `index.Rmd` file, other `Rmarkdown` files contain the contents of the individual chapters of a protocol.
-   The naming of these files follows this syntax: `##_chapter-title.Rmd`, where the `##` indicates the chapter number.
-   The folders, named `data` and `media` serve to store, respectively, tabular data and graphics files that belong to and are used in the protocol. When no tabular data or graphics files are needed for the protocol, these folders can be left empty (they will only be visible in a local clone of the repository and not appear on the remote repository).
-   The `_bookdown.yml` also holds metadata information such as the name of the output file and folder (both have the same syntax as before: `<protocol-code>_<short-title>`) to which the rendered version of the protocol will be written.

## Protocol features

### Protocol-code and protocol-number <a name="protocol-code"></a>

A **protocol-code** consists of a prefix (three characters), a protocol-number (three digits) and a language tag (two characters), all separated by a hyphen.

| type       | theme      | theme_number | protocol-code |
|:-----------|:-----------|:-------------|:--------------|
| field      | generic    | 0            | sfp-0##-nl    |
| field      | water      | 1            | sfp-1##-nl    |
| field      | air        | 2            | sfp-2##-nl    |
| field      | soil       | 3            | sfp-3##-nl    |
| field      | vegetation | 4            | sfp-4##-nl    |
| field      | species    | 5            | sfp-5##-nl    |
| instrument |            |              | sip-###-nl    |
| operating  |            |              | sop-###-nl    |
| analysis   |            |              | sap-###-nl    |
| project    |            |              | spp-###-nl    |

The `s` and `p` refer to **s**tandard **p**rotocol, while `f, i, o, a, p` indicate the first letter of the protocol type.

The three digits of the protocol-code will be referred to as the **protocol-number**.
In case of thematic protocols, the first digit of the protocol-number corresponds with the theme-number.
The `##` indicates an incremental number.
For instance, the first field protocol for "theme water" will have protocol code `sfp-101-nl`.
The `s*p-###` part of the protocol can be thought of as a code that corresponds one-to-one with the title of the protocol (when ignoring language).

The final two characters identify the language the protocol is written in.
This can be either Dutch (`nl`) or English (`en`).

### Version number

The version number is of the form `YYYY.NN`.
`YYYY` indicates the year in which the protocol was released.
The `NN` is a number that indicates the order of release within that year (starting with 01).
The same version of a protocol may or may not be available in multiple languages (see [Folder and filename syntaxis](#folder-and-filename-syntaxis) and [Translations of protocols](CONTRIBUTING.md#what-to-do-in-case-of-translations-of-protocols)).

The version number is protocol-*aspecific* by definition, i.e. it spans the whole protocols repository (e.g. `sfp-401-nl` version `2020.02` will be followed by `sfp-401-nl` version `2020.04` if `sfp-401-nl` was not updated in the `protocols-2020.03` release).

### Parameterizing a protocol

For some protocols, it may be worthwhile to [parameterize](https://bookdown.org/yihui/rmarkdown/parameterized-reports.html) parts of the protocol.
For instance, in a protocol that explains how to visually estimate plant cover using cover classes, the following parameters could be considered:

-   shape of the sampling unit
-   area of the sampling unit

The subject-matter specialist will then give sensible default values for these parameters, but these values can be changed in project-specific protocols.

### Dependencies

Dependencies are protocols on which another protocol depends.
At a minimum, a dependency is declared based on the protocol-code and a version number.
Only protocols that have been published on the protocols website can be declared as a dependency.
In each protocol-template, a `Subprotocols` part is provided that can be used to include a printed version of such a dependency.
The latter is optional except for dependencies that are parameterized with non-default parameter values.

#### In sfp, sip, sap or sop

In general, protocols should be as self-contained as possible, but in some cases, it could be useful to refer to other protocols.

For instance, a `sfp` in which an RTK-GPS is needed to accurately locate some sampling units can refer to a `sip` that explains the use of an RTK-GPS instrument.

#### In project-specific protocols (spp)

Project-specific protocols should address the need of fieldworkers to have an overview of tasks that need to be done sequentially, where each task or set of tasks would typically refer to a sfp, sip, sap or sop protocol.
As explained in the previous section, these dependencies are best added using `protocolhelper::add_dependencies()`.
To also insert them in the `Subprotocols` part `protocolhelper::add_subprotocol()` needs to be used.
