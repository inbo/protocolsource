<!--- indicate the protocol code in the Title above -->

## Task list

<!--see https://docs.github.com/en/github/managing-your-work-on-github/about-task-lists
for an explanation on how to use task lists-->

Steps by contributor:

- [ ] Add description to this pull request (see #-description)
- [ ] Submit the pull request by clicking 'create pull request'
- [ ] Mark the pull request as draft
- [ ] Add further commits and push commits to GitHub if needed
- [ ] Update the protocol-specific NEWS.Rmd
- [ ] Mark the pull request as 'ready for review'


Review steps:

- [ ] Add reviewers, at least one subject-matter specialist and one administrator
- [ ] Wait for review comments and address them
- [ ] Iterate until reviewer approvals (merging the pull request will be done by an administrator)

To be done by an administrator after review, but before merging the pull request:

- [ ] Update the `.zenodo.json` file (authorship will extend as protocols are added)
- [ ] Bump the version number in the `index.Rmd` yaml section from `yyyy.nn.dev` to `YYYY.NN`.
- [ ] Update the repo `NEWS.md` file

1. merge the branch to the master and add general and specific tags (see [release model](README.md#release-model)):
    1. general tag: `protocols-YYYY.NN`
    1. specific tag: `protocol-code-YYYY.NN`
1. Check if continuous integration proceeded without problems
1. Make a GitHub release from the general tag
1. Check success of publication steps at protocols.inbo.be and at Zenodo (records both source and rendered) 

To be done by an administrator after merging this pull request:

- [ ] Add general tag to the merge commit (`protocols-YYYY.NN`)
- [ ] Add specific tag to the merge commit (`protocol-code-YYYY.NN`)
- [ ] Check if continuous integration proceeded without problems
- [ ] Go to releases and create a new release based on a general tag
- [ ] Check success of publication steps at protocols.inbo.be and at Zenodo (records both source and rendered) 



## Description
<!--- Describe your protocol proposal -->
<!--- You can mention collaborators with "@githubname"-->

## Related Issue
<!--- if this closes an issue make sure include e.g., "closes #4"
or similar - or if just relates to an issue make sure to mention
it like "#4" -->


