load(
    "test.bzl",
    "test_declare_directory",
    "test_use_directory",
)

test_declare_directory(
    name = "test_directory",
)

test_use_directory(
    name = "mytest",
    input_dir = ":test_directory"
)
