# protocols

INBO protocols for monitoring

*experimental*: we are in the process of trying out git-version control for INBO protocols. In the meantime, the official versions of INBO protocols are hosted [here](https://sites.google.com/a/inbo.be/veldprotocols/) (only accessible to INBO collaborators). 
Development versions are in [this google drive folder](https://drive.google.com/drive/folders/0BzUqT1wpznBXY2ZqaXh2a0tyd2M) (only accessible to INBO collaborators). 


If you want to contribute a new protocol or update an existing protocol, check the [contributing guidelines](CONTRIBUTING.md).

## Repository structure

```
  |- README.md <- up to date description of the repo content
  |- CONTRIBUTING.md <- Contributing guidelines
  |- docs <- can be used to locally inspect rendered versions of protocols; is git-ignored
  |- from_docx <- contains Microsoft Word docx protocols which were converted to 
                  markdown; is git-ignored
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

## Relationships to other repositories

This repository contains the Rmarkdown versions of protocols. 

A companion repository `protocols-website` hosts the rendered versions of these protocols.

A small R package called [protocolhelper](https://github.com/inbo/protocolhelper) has several utility functions that aid in setting up a new protocol from a template and functions to aid management of the `protocols` repository.



## Branching model

![](src/management/protocols-gitflow-model.png)


We use a simple branching model. 
The master branch is protected and can only receive commits from reviewed pull requests.
Development of a protocol (see [Workflow](#workflow)) is done in a protocol-specific branch that branches off the master branch.

Protocols can depend on other protocols (protocol dependencies) only if these dependency protocols have been approved (and are published). 
Circular dependencies are not allowed.

Whenever a pull request is reviewed and finalized, a repo-admin will merge the branch to the master and add general and specific tags. 
The general tag is of the form `protocols-YYYY.number`.
The specific tag is of the form `protocol-code-YYYY.number` (see [protocol-code](#-protocol-code)).
Note that the merge commit to which these tags are attached represents an entire snapshot of the complete repository - not only the part of the repository that refers to the specific protocol. 

These tags serve several purposes:

- the specific tag 
    - identifies which protocol has been added or updated 
    - identifies the version number of the protocol that has been 
added or updated
    - searching tags that have the protocol-code as string, allows reconstructing
    the full history of versions for that protocol
- the general tag 
    - is incremental regardless of which protocol is updated when.
    This means that general tags reflect the time sequence of protocol releases in the whole repository.
    - will be used as tag to base a GitHub Release on. A GitHub Release is just     a zip-file containing all files in the repository at that moment. The repository is setup in such a way that with each release a Zenodo archive will be created as well. The added benefit of this is (1) guaranteed long-term archiving, (2) creation of a DOI.


Each time a merge commit is made to the master branch of the `protocols` repo, a 'mirror read-only' repository (protocols-website) will be automatically triggered to build the rendered html versions of the protocols using Travis Continuous Integration.
The resulting website is hosted at **TO BE ADDED**.
This website will host all approved and published versions of all protocols.

## Fixed protocol features

### Protocol-code

A protocol-code consists of three characters and three digits separated by a dash.

|type             |theme      |theme_number |protocol-code
|:----------------|:----------|:------------|:------------|
|field            |generic    |0            |sfp-0##
|field            |water      |1            |sfp-1##
|field            |air        |2            |sfp-2##
|field            |soil       |3            |sfp-3##
|field            |vegetation |4            |sfp-4##
|field            |species    |5            |sfp-5##
|instrument       |           |             |sip-###
|operating        |           |             |sop-###
|activity         |           |             |sap-###
|project          |           |             |spp-###

The `##` indicates an incremental number. For instance, the first field protocol for "theme water" will have protocol code `sfp-101`.

### Version number

The version number is of the form `YYYY.number`. `YYYY` indicates the year in which the protocol was released. The `number` indicates the order of release within that year.

### Language identifier

Protocols can be either written in one or multiple languages. The functions in the `protocolhelper` package support Dutch (language = 'nl') and English (language = 'en').

The protocol-code, a version number and a language identifier together will identify a unique version of a protocol.

### Dependencies

#### In sfp, sip, sap or sop

In general, protocols should be as self-contained as possible, but in some cases, it could be useful to refer to other protocols.

For instance, a `sfp` in which a RTK-GPS is needed to accurately locate some sampling units can refer to a `sip` that explains the use of an RTK-GPS instrument.

#### In project-specific protocols (spp)

Project-specific protocols should address the need of fieldworkers to have an overview of tasks that need to be done sequentially, where each task or set of tasks would typically refer to a sfp, sip, sap or sop protocol.

For this specific purpose, we can make use of Rmarkdown's ability to recycle  specific parts of another protocol using a child chunk in the (parent) project-specific protocol.

Such child-reference will need to be version-specific if it is not to cause clashes with version numbering: a project-protocol at some version should not have evolving compiled counterparts.

## Dynamic protocol features

For some protocols, it may be worthwhile to parametrize parts of the protocol. 
For instance, in a protocol that explains how to visually estimate plant cover using cover classes, the following parameters could be considered dynamic:

- shape of the sampling unit
- area of the sampling unit

The subject-matter specialist will then give sensible default values for these parameters, but these values can be changed in project-specific protocols.

