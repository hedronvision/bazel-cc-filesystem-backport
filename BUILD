cc_library(
    name = "hedron_std_filesystem_backport",
    hdrs = ["backport/filesystem.hpp"],
    visibility = ["//visibility:public"],

    srcs = ["impl.cpp"], # Unconditionally compile the implementation to support the pre-C++17 use case and to avoid people needing to think about platform mappings. Note that the implemention is #ifdef'd out when it's not needed; there's not a lot of cost here.
    deps = ["@gulrak_filesystem"],
)
