#!/bin/sh -l

Rscript --no-save --no-restore -e 'stopifnot("protocolhelper" %in% rownames(installed.packages()))'
