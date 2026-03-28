# Agent Config Review Workflow

Use this workflow when changing `AGENTS.md`, `docs/agents/`, docs indexes, changelog policy, or other files that shape how future agents understand the repo.

## Goal
- Keep the agent guidance layered, consistent, and aligned with actual repo behavior.

## Review Pass
1. Confirm `AGENTS.md` still works as the short entrypoint and does not duplicate too much detail.
2. Confirm `docs/agents/README.md` and `docs/README.md` still point to the right entrypoints and workflows.
3. Check that context files describe what exists, rules describe what must remain true, and workflows describe how to execute or review changes.
4. Apply the source-of-truth and drift-resolution rules from `docs/agents/rules/repo.md`.
5. Verify that newly referenced files actually exist and that relative links resolve sensibly.
6. Decide whether the change needs a changelog entry.

## Finish
- If agent-config changes affect onboarding or user-visible guidance, update the root `README.md` too.
- Treat this as a meaningful change-set review, not a per-edit ritual.
