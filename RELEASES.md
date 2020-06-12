# Creating a new release (guidelines for repo-admins)

After review of a protocol-branch and before each release the following steps are necessary:


1. with the protocol-branch checked-out:
    1. bump the version number in the `index.Rmd` yaml section from `yyyy.nn.dev` to `YYYY.NN`. Some examples:
        - a new protocol added in 2020 that was released in 2020 (fifth release in that year): `2020.00.dev` to `2020.05`
        - an update of the `2020.05` protocol in 2021 (first release in that year): `2020.05.dev` to `2021.01`
        - an update of the `2020.02` version of a protocol in the same year (fourth release in that year): `2020.02.dev` to `2020.04`
    1. update the `.zenodo.json` file:
        - add new authorships
    1. update the repo `NEWS.md` file
1. merge the branch to the master and add general and specific tags (see [release model](README.md#release-model)):
    1. general tag: `protocols-YYYY.NN`
    1. specific tag: `protocol-code-YYYY.NN`
1. Check if continuous integration proceeded without problems
1. Make a GitHub release from the general tag
1. Check success of publication steps at protocols.inbo.be and at Zenodo (records both source and rendered) 

