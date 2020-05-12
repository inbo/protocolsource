This folder contains `.docx` protocols developed in Microsoft Word. 
`.docx` files placed in this folder can be converted to Rmarkdown / bookdown
by one of the `create_s?p()` functions.
Use the `from_docx` parameter for this purpose.

When a specific `.docx` file is no longer needed, it should be deleted from this folder to avoid that multiple versions of essentialy the same protocol co-exist. 
Note that after deletion (and commiting the change), this `.docx` file can always be retrieved from older commits in the git repo.
