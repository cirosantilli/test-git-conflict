Generate various kinds of Git conflicts, including conflicts suitable
to interactively test a merge resolution tool.

The `./generate-conflicts.sh` script generates branches `conflict0`, `conflict1` and `conflict2`
with the desired conflicts. The generated branch tree will look like:

    conflict (current branch)
    |
    conflict0
    |
    +--------------+
    |              |
    conflict1      conflict2

**Running that script completely removes branches `conflict0`,
`conflict1` and `conflict2` and any unstaged changes**!
Don't make persistent changes to those branches: modify the script on branch `conflict` instead.
Rationale: it is too hard to generate conflicts manually without a script.

The script can be run from any branch. It always leaves you on branch `conflict2`,
from which you can then do `git merge conflict1` to generate the conflict.

Once you have generated the branches, you can force push all of them with `./deploy.sh origin`.
