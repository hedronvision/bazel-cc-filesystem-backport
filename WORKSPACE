# This file existed originally to enable quick local development via local_repository.
    # See ./ImplementationReadme.md for details on local development.
    # Why? local_repository didn't work without a WORKSPACE, and new_local_repository required overwriting the BUILD file (as of Bazel 5.0).

workspace(name = "hedron_std_filesystem_backport")

load("@hedron_std_filesystem_backport//:workspace_setup.bzl", "hedron_backport_std_filesystem")
hedron_backport_std_filesystem()
