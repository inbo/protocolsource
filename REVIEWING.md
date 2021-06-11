---
editor_options:
  markdown:
    mode: gfm
---

# Reviewing pull requests

Thanks to GitHub Actions, an artifact (=zip file) of the rendered protocol (= version with layout applied in html output format) is now automatically created on each pull request.

Reviewers can proceed like this:

1.  On the PR page, you can find a "details" link under "checks - On PR, build the site and ...". Go there, click on the top link in the left sidebar, and download the generated artifact at the bottom of the page.
2.  Unzip it (to any location you like)
3.  Go to the unzipped folder location and navigate to the `index.html` file (= rendered version of the protocol) and open with your browser
4.  [Review the protocol](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/commenting-on-a-pull-request) with the aid of the rendered version.
