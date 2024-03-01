# Do not change the filename; it is part of the user interface.


load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")


def hedron_backport_std_filesystem():
    """Setup a WORKSPACE so you can easily use the std::filesytem API across platforms."""

    # Unified setup for users' WORKSPACES and this workspace when used standalone.
    # See invocations in:
    #     README.md (for users)
    #     WORKSPACE (for working on this repo standalone)

    # gulrak::filesystem
    # Handy backport of std::filesystem where it's not avalable: macOS<10.15, iOS/tvOS<13.0, and watchOS<6.0
    maybe(
        http_archive,
        name = "gulrak_filesystem",
        build_file_content = """
cc_library(
    name = "gulrak_filesystem",
    hdrs = glob(["ghc/*.hpp"]),
    visibility = ["//visibility:public"]
)
""",
        url = "https://github.com/gulrak/filesystem/archive/42ea4fc6159d6078f08f1b0531a45d88b9e2c989.zip", # Living at head because there are good, unreleased commits.
        sha256 = "a58199928d2cd293f0c8d821302e01dd80033fa15c2db6815325b8196578eeb8",
        strip_prefix = "filesystem-42ea4fc6159d6078f08f1b0531a45d88b9e2c989/include",
    )
