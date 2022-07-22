# Creating a new release (guidelines for repo-admins)

After review of a protocol-branch and before each release the following steps will be run automatically and may require action:

1.  A GitHub Action will run when a pull request is made to the main branch.

    1.  This action will automatically run these checks:

        1.  `protocolhelper::check_frontmatter()`

        2.  `protocolhelper::check_structure()`

    2.  Check any error messages resulting from these checks and address them.
        Repeat this step until all checks succeeded.
        In principle, these errors should be addressed by the protocol contributor, but admins can help if needed.

2.  A second GitHub Action will be run when a pull request to be merged into the main branch *upon approval*.

    1.  This action will automatically update:

        1.  the repo-wide `NEWS.md` file with `protocolhelper:::update_news_release()`

        2.  the `.zenodo.json` file with `protocolhelper:::update_zenodo()`

    1..
    Check if the second Github Action ran without problems.
    If needed, admins should address any problems.
    Note that during these automatic updates, the two commits will be automatically pushed to the remote.
    This should not pose a problem for local clones as these changes can be automatically included and will not cause conflicts (i.e. `git pull origin main` with a local protocol branch checked out)

3.  A third GitHub Action will be run upon a push to the main branch to update the `protocols` website.
    I.e. when the pull request is merged into the main branch.

    1.  This will automatically trigger the following:

        1.  the general and protocol-specific tags (see [release model](README.md#release-model)) will be created and added to that merge commit.
            This will be done by `protocolhelper:::set_tags()`

            1.  general tag: `protocols-<version number>`

            2.  specific tag: `<protocol-code>-<version number>`

        2.  render the new or updated protocol and commit/push this to the `protocols` repo (which contains the rendered protocols that are needed to build the website).
            The rendering is done by `protocolhelper:::render_release()`.

            1.  Check if this action ran without problems and if needed address them.

            2.  Check success of publication steps at `protocols.inbo.be`

4.  A fourth GitHub Action will run when a tag `protocols-<version number>` is detected.
    This will trigger a GitHub release in the `protocolsource` repo and in the `protocols` repo.
    In turn, a GitHub release will trigger the `.zenodo.json` webhook to publish this new version of the repo contents on Zenodo for long-term archiving of the protocols.

    5.  Check success of GitHub releases and publication on Zenodo
