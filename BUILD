cc_library(
    name = "hedron_std_filesystem_backport",
    hdrs = ["backport/filesystem.hpp"],
    visibility = ["//visibility:public"],

    srcs = ["impl.cpp"], # Unconditionally compile the implementation to support the pre-C++17 use case and to avoid people needing to think about platform mappings. Note that the implemention is #ifdef'd out when it's not needed; there's not a lot of cost here.
    deps = ["@gulrak_filesystem"],
)

# Stardoc users only: Depend on "@hedron_std_filesystem_backport//:bzl_srcs_for_stardoc" as needed.
# Why? Stardoc requires all loaded files to be listed as deps; without this we'd prevent users from running Stardoc on their code when they load from this tool in, e.g., their own workspace.bzl.
filegroup(
    name = "bzl_srcs_for_stardoc",
    visibility = ["//visibility:public"],
    srcs = glob(["**/*.bzl"]) + [
        "@bazel_tools//tools:bzl_srcs"
    ],
)
