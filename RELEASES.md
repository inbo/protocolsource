# Release cycle (guidelines for repo-admins and repo-maintainers)

After and during review of a protocol-branch and before each release a couple of GitHub Actions will be run automatically and may require action.

A **first** GitHub Action ([check_protocol.yml](.github/workflows/check_protocol.yml)) will automatically run these checks:

```         
1.  `protocolhelper::check_frontmatter()`

2.  `protocolhelper::check_structure()`
```

Check any error messages resulting from these checks and address them.
Repeat this step until all checks succeed.
In principle, these errors should be addressed by the protocol contributor, but admins can help if needed.
Apart from any problems detected by these checks, the protocol contributor must also address any issues raised by at least one reviewer that is familiar with the content matter of the protocol.
If the checks succeed and all substantial issues raised by content matter reviewers are addressed, an admin or maintainer can in principle approve the pull request.

A **second** action ([update_news_zenodo.yml](.github/workflows/update_news_zenodo.yml)) will run two jobs when a protocol PR is approved.
The first job checks that at least one content-matter reviewer and one admin or maintainer approval has been given.
The second job only runs when the first job succeeds.
It will run the following steps:

```         
1.  update the repo-wide `NEWS.md` file with `protocolhelper:::update_news_release()` and commit / push the change to the branch

2.  update the repo `.zenodo.json` file with `protocolhelper:::update_zenodo()` and commit / push the change to the branch

3.  update the protocol-specific Zenodo DOI in the YAML front matter of the `index.Rmd` file with `protocolhelper:::update_doi()` and commit / push the change to the branch

4.  auto-approve the introduced changes
```

Pull these commits to get them in your local repo.

A **third** GitHub Action ([update_website.yml](.github/workflows/update_website.yml)) will be run upon a push to the main branch, i.e. when the pull request is merged into the main branch, to update the `protocols` website and deposit the website and the protocol on Zenodo.
This will automatically trigger the following:

```         
1.  The general and protocol-specific tags (see [release model](README.md#release-model)) will be created and added to that merge commit.
    This will be done by `protocolhelper:::set_tags()`

    1.  general tag: `protocols-<version number>`

    2.  specific tag: `<protocol-code>-<version number>`

2.  Render the new or updated protocol and commit/push this to the `protocols` repo (which contains the rendered protocols that are needed to build the website).
    The rendering is done by `protocolhelper:::render_release()`.
    That function will also upload the zipped html and pdf version of the protocol to a protocol-specific Zenodo deposit.
    The same general and protocol-specific tags are added to this commit in `protocols`.

    1.  Check if this action ran without problems and if needed address them.

    2.  Check success of publication steps at https://protocols.inbo.be/
```

A **fourth** GitHub Action ([release.yml](.github/workflows/release.yml)) will run when a tag `protocols-<version number>` is detected.
This will trigger a GitHub release in the `protocolsource` repo and in the `protocols` repo.
In turn, a GitHub release will trigger the `.zenodo.json` webhook to publish this new version of the repo contents on Zenodo for long-term archiving of the protocols website.
An admin or maintainer should **Check success of GitHub releases and publication on [Zenodo](https://doi.org/10.5281/zenodo.7619958)**.
