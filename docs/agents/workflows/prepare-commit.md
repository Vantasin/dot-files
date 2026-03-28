# Commit Preparation Workflow

Use this workflow when the user asks for a commit or when you are deliberately wrapping up a coherent change set.

## Goal
- Create a clean commit from the intended change set without sweeping in unrelated work.

## Steps
1. Identify the exact scope of the commit and leave unrelated changes unstaged.
2. Run the smallest relevant checks from [verify-by-change-type.md](verify-by-change-type.md).
3. Resolve any code/docs drift in the same change set.
4. Decide whether a changelog entry is needed.
5. Review the staged diff with `git diff --cached`.
6. Use a concise imperative commit subject.

## Notes
- Do not auto-commit after every edit.
- If repo-local hooks are enabled, expect `.githooks/pre-commit` to enforce the lightweight staged checks again.
