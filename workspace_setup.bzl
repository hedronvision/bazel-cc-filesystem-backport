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
        url = "https://github.com/gulrak/filesystem/archive/f19cbbbd312c3552961ce6ed8e69ea581c6b29d5.zip", # Living at head because there are good, unreleased commits.
        sha256 = "ed7dd20fe314a255fb7dea5a9960d7e63896dcd38e6e5f90b7c603cbabc0ff1d",
        strip_prefix = "filesystem-f19cbbbd312c3552961ce6ed8e69ea581c6b29d5/include",
    )
