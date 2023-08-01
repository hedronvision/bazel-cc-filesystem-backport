# Hedron's std::filesystem Backport for Bazel — User Interface

**What is this project trying to do for me?**

Make it easy to use the std::filesystem API across platforms, even those where std::filesystem would otherwise be (conditionally) unavailable.

[Not a bazel user? Just use [gulrak/filesystem](https://github.com/gulrak/filesystem) directly.]

**Why can't I use std::filesystem normally?**

std::filesystem is unavailable before macOS 10.15, iOS/tvOS 13.0, and watchOS 6.0, even with C++17. If you try to use std::filesystem, you'll get errors like "error: 'path' is unavailable: introduced in ..."

At least at the time of writing, most Apple developers will target OSs older than that and therefore need to backport std::filesystem. This library is useful if you'd like to use std::filesystem and let your code work on Apple platforms :)

[This'll also let you use std::filesystem in older C++ versions (C++11 on), but that's not the main motivation. Just update to the latest C++ version!]

**How does this solve my problem?**

Just use the setup snippet below, `#include "backport/filesystem.hpp"` and then use fs:: as a drop-in replacement for std::filesystem in code that might target Apple platforms. [If you want to open a fstream(fs::path), instead do fs::fstream(fs::path).]

Under the hood, we're falling back to [gulrak/filesystem](https://github.com/gulrak/filesystem) (only) in binaries that need it. [gulrak/filesystem](https://github.com/gulrak/filesystem) is API-compatible with std::filesystem, so you can write the same modern code you would otherwise, and, once std::filesystem support is ubiquitous, it'll be easy to transition off this shim. (Once upon a time, we fell back on boost::filesystem, but there were enough differences in the API to be very annoying, especially around time, despite boost::filesystem having inspired std::filesystem.)

## Usage

> Basic Setup Time: 2m

Howdy, Bazel user 🤠. Let's get you using the std::filesystem API in no time.

There's a bunch of text here but only because we're trying to spell things out and make them easy. If you have issues, let us know; we'd love your help making things even better and more complete—and we'd love to help you!

### First, do the usual WORKSPACE setup.

Copy this into your Bazel `WORKSPACE` file to add this repo as an external dependency, making sure to update to the [latest commit](https://github.com/hedronvision/bazel-cc-filesystem-backport/commits/main) per the instructions below.

```Starlark
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")


# Hedron's std::filesystem Backport
# Lets you use the std::filesystem API on Apple platforms, where it wouldn't otherwise be available.
# (Deployment targets before macOS 10.15, iOS/tvOS 13.0, and watchOS 6.0)
# Just use fs:: as a drop-in replacement for std::filesystem.
# https://github.com/hedronvision/bazel-cc-filesystem-backport
http_archive(
    name = "hedron_std_filesystem_backport",

    # Replace the commit hash in both places (below) with the latest, rather than using the stale one here.
    # Even better, set up Renovate and let it do the work for you (see "Suggestion: Updates" in the README).
    url = "https://github.com/hedronvision/bazel-cc-filesystem-backport/archive/315416306204ce6bb2983b4a923815a7e89eb727.tar.gz",
    strip_prefix = "bazel-cc-filesystem-backport-315416306204ce6bb2983b4a923815a7e89eb727",
    # When you first run this tool, it'll recommend a sha256 hash to put here with a message like: "DEBUG: Rule 'hedron_std_filesystem_backport' indicated that a canonical reproducible form can be obtained by modifying arguments sha256 = ..."
)
load("@hedron_std_filesystem_backport//:workspace_setup.bzl", "hedron_backport_std_filesystem")
hedron_backport_std_filesystem()
```

### Second, use fs:: as a drop-in replacement for std::filesystem

Add `"@hedron_std_filesystem_backport"` to your `deps`, and...

```C++
#include "backport/filesystem.hpp"

fs::path p = ...
fs::ofstream(p) << ...
```

The API is the same as std::filesystem (and fstream), just under fs::

See https://en.cppreference.com/w/cpp/filesystem for API docs.

### There is no (required) step 3!

But we do have a suggestion...

### Suggestion: Updates

Improvements come frequently to the underlying libraries, including security patches, so we'd recommend keeping up-to-date.

We'd strongly recommend you set up [Renovate](https://github.com/renovatebot/renovate) (or similar) at some point to keep this dependency (and others) up-to-date by default. [We aren't affiliated with Renovate or anything, but we think it's awesome. It watches for new versions and sends you PRs for review or automated testing. It's free and easy to set up. It's been astoundingly useful in our codebase, and we've worked with the wonderful maintainer to make things great for Bazel use. And it's used in official Bazel repositories--and this one!]

If not now, maybe come back to this step later, or watch this repo for updates. [Or hey, maybe give us a quick star, while you're thinking about watching.] Like Abseil, we live at head; the latest commit to the main branch is the commit you want. So don't rely on release notifications; use [Renovate](https://github.com/renovatebot/renovate) or poll manually for new commits.

## Congratulations!

Way to make it through setup. Cheers to being able to easily use the std::filesystem API in portable code.

---

## Other Projects Likely Of Interest

If you're using Bazel for C++, you'll likely also want some of our other tooling, like...

1. Helping your editor understand your code and provide autocomplete: [hedronvision/bazel-compile-commands-extractor](https://github.com/hedronvision/bazel-compile-commands-extractor)
2. A good way of making secure network requests: [hedronvision/bazel-make-cc-https-easy](https://github.com/hedronvision/bazel-make-cc-https-easy)
