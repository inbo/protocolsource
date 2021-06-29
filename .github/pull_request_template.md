<!--- indicate the protocol code in the Title above -->

## Description
<!--- Describe your protocol proposal or your proposed changes-->
<!--- You can mention collaborators with "@githubname"-->

## Related Issue
<!--- if this closes an issue make sure include e.g., "closes #4"
or similar - or if just relates to an issue make sure to mention
it like "#4" -->

## Task list

<!--see https://docs.github.com/en/github/managing-your-work-on-github/about-task-lists
for an explanation on how to use task lists-->

Steps by contributor:

- [ ] Add description to this pull request (under "## Description")
- [ ] Submit the pull request by clicking 'create pull request'
- [ ] Mark the pull request as draft
- [ ] Check whether the version number in the `index.Rmd` yaml section is of format `yyyy.nn.dev`
- [ ] In case of a protocol created from a pre-existing `docx` protocol, check if all sections comply with current template for a new protocol
- [ ] Add further commits if needed and push them to GitHub
- [ ] Update the protocol-specific `NEWS.Rmd`
- [ ] Mark the pull request as 'ready for review'


Review steps for the author(s):

- [ ] Add reviewers, at least one subject-matter specialist and one administrator
- [ ] Wait for review comments and address them
- [ ] Iterate until reviewer approvals (merging the pull request will be done by an administrator)

To be done by an administrator after review, but before merging the pull request:

- [ ] Update the `.zenodo.json` file (authorship will extend as protocols are added)
- [ ] Bump the version number in the `index.Rmd` yaml section from `yyyy.nn.dev` to `YYYY.NN`.
- [ ] Update the repo `NEWS.md` file

To be done by an administrator after merging this pull request:

- [ ] Add general tag to the merge commit (`protocols-YYYY.NN`)  (see [release model](README.md#release-model))
- [ ] Add specific tag to the merge commit (`<protocol-code>-YYYY.NN`)  (see [release model](README.md#release-model))
- [ ] Check whether continuous integration proceeded without problems
- [ ] [Create a new release](https://github.com/inbo/protocols/releases/new) based on a general tag
- [ ] Check success of publication steps at protocols.inbo.be and at Zenodo (records both source and rendered) 



