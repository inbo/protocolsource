# Updating `renv` or the `docker` machinery

These instructions are for admins only.

Making changes to `renv.lock`:

-   create a new branch `docker-renv-update`
-   adding a new package: add the package name to the `DESCRIPTION` file, install the package and snapshot it
-   after an upgrade of R x.y to x.z: [see tutorial website](https://inbo.github.io/tutorials/tutorials/r_renv_update/#updating-r-and-packages)
-   add, commit and push `renv.lock` (potentially also `DESCRIPTION` and other files altered by `renv`), make a Pull Request
-   ask for a review
-   wait until docker succesfully built message appears before merging

Making changes to `docker` or `dockerfile` (and possibly also `renv.lock`):

-   create a new branch `docker-update`
-   make changes and add, commit, push them
-   ask for a review
-   wait until docker succesfully built message appears before merging

Whenever the above branches are merged to main, a git tag `docker-<sha-1>` will be automatically added via GHA.
Here, <sha-1> refers to the SHA-1 identifier of the merge commit.

`dockerhub` is configured in such a way that the docker image will be built when the branchname starts with `docker-<name>`.
Docker will then add a docker tag to this image called `dev-<name>`.
This means that for every commit to a `docker-<name>` branch, the docker image will be rebuilt.
This allows to test if the image can be built.
There will be at most two test images: `dev-renv-update` or `dev-update`.
When a git tag `docker-<sha-1>` appears on the main branch, the docker image will built and receive a dockerhub tag `latest`.
