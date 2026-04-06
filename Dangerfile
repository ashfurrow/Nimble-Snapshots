# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn("PR is classed as Work in Progress") if github.pr_title.include? "WIP"

# Warn when there is a big PR
warn("Big PR") if git.lines_of_code > 150

# Don't let testing shortcuts get into master by accident.
# Match only focused test function calls, not words like "fits" in descriptions.
fail("fdescribe left in tests") if `grep -RE '\\bfdescribe\\s*\\(' Bootstrap/BootstrapTests/ `.length > 1
fail("fit left in tests") if `grep -RE '\\bfit\\s*\\(' Bootstrap/BootstrapTests/ `.length > 1
fail("fcontext left in tests") if `grep -RE '\\bfcontext\\s*\\(' Bootstrap/BootstrapTests/ `.length > 1

swiftlint.config_file = '.swiftlint.yml'
swiftlint.lint_files
