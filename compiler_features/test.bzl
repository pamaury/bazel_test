def _lto_transition_impl(settings, attr):
    # This transition just reads the current CPU value as a demonstration.
    # A real transition could incorporate this into its followup logic.
    current_features = settings["//command_line_option:features"]
    print("FEATURES: ", current_features)
    return {"//command_line_option:features": current_features + ["thin_lto"]}

lto_transition = transition(
    implementation = _lto_transition_impl,
    inputs = ["//command_line_option:features"],
    outputs = ["//command_line_option:features"],
)

def _impl(ctx):
    providers = []
    target = ctx.attr.dep[0]
    if DefaultInfo in target:
        print("forward", target)
        providers.append(DefaultInfo(
            files = target[DefaultInfo].files,
            # runfiles = target[DefaultInfo].files_to_run,
        ))
    return providers

lto_transitioning_rule = rule(
    implementation = _impl,
    attrs = {
        "_allowlist_function_transition": attr.label(
            default = "@bazel_tools//tools/allowlists/function_transition_allowlist",
        ),
        "dep": attr.label(cfg = lto_transition),
    },
)