<!--- indicate the protocol code in the Title above -->

## Description

<!--- Describe your protocol proposal or your proposed changes-->

<!--- You can mention collaborators with "@githubname"-->

## Related Issue

<!--- if this closes an issue make sure include e.g., "closes #4" or similar - or if just relates to an issue make sure to mention it like "#4" -->

## Task list

<!--see https://docs.github.com/en/github/managing-your-work-on-github/about-task-lists for an explanation on how to use task lists-->

Steps by contributor:

-   [ ] Add description to this pull request (under "## Description")
-   [ ] Open the dropdown (triangle) near 'create pull request' and choose 'Create draft pull request'
-   [ ] Check for potential problems by running `protocolhelper::check_frontmatter()` and address them
-   [ ] Check for potential problems by running `protocolhelper::check_structure()` and address them
-   [ ] Add further commits if needed and push them to GitHub
-   [ ] Update the protocol-specific `NEWS.Rmd`
-   [ ] Mark the pull request as 'ready for review'

Review steps for the author(s):

-   [ ] Add reviewers, at least one subject-matter specialist and one administrator
-   [ ] Wait for review comments and address them
-   [ ] Iterate until reviewer approvals (merging the pull request will be done by an administrator)
-   [ ] Verify that the checks done by continuous integration succeeded. These will check if `protocolhelper::check_frontmatter()` and `protocolhelper::check_structure()` succeeded without errors.

To be done by an administrator after review: see [guidelines for admins](RELEASES.md).
