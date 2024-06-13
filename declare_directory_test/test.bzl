def _declare_directory_impl(ctx):
    test_files = ctx.actions.declare_directory(ctx.label.name + ".files")
    path = test_files.path
    ctx.actions.run_shell(
        outputs = [test_files],
        command = "mkdir -p %s && echo aaa > %s && echo bbb > %s" %
                  (path, path + "/a.txt", path + "/b.txt"),
    )
    return [DefaultInfo(files = depset([test_files]))]


test_declare_directory = rule(
    implementation = _declare_directory_impl,
)

def _use_directory_impl(ctx):
    print(ctx.files.input_dir)
    list_file = ctx.actions.declare_file(ctx.label.name + ".files")
    input_dir = ctx.files.input_dir
    ctx.actions.run_shell(
        outputs = [list_file],
        inputs = input_dir,
        command = "ls %s > %s" % (input_dir[0].path, list_file.path),
    )
    return [DefaultInfo(files = depset([list_file]))]


test_use_directory = rule(
    implementation = _use_directory_impl,
    attrs = {
        "input_dir": attr.label(mandatory = True, allow_files = True),
    },
)
