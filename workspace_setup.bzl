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
        url = "https://github.com/gulrak/filesystem/archive/2b4d7f239e0e749315fca1de7b2cf7438cf94a9a.zip", # Living at head because there are good, unreleased commits.
        sha256 = "f5b8820fa2b4ab46514fdf7b9dceb9cd7d7e2bdf99139d4e5cdfa941ff9d3c0c",
        strip_prefix = "filesystem-2b4d7f239e0e749315fca1de7b2cf7438cf94a9a/include",
    )
