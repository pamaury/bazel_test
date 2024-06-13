load("test.bzl", "lto_transitioning_rule")

cc_library(
    name = "lib",
    srcs = ["lib.c"],
)

cc_binary(
    name = "bin",
    srcs = ["main.c"],
    deps = [":lib"],
)

cc_binary(
    name = "bin_partial_lto",
    srcs = ["main.c"],
    deps = [":lib"],
    features = ["thin_lto"],
)

lto_transitioning_rule(
    name = "bin_full_lto",
    dep = ":bin",
)