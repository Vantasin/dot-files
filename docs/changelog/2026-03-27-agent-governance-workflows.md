# 2026-03-27 Agent Governance Workflows

## Summary
- Added source-of-truth and drift-resolution rules to the stable repo rules.
- Added a verification matrix by change type.
- Added workflows for package lifecycle changes and agent-config review.
- Updated the existing review and docs-maintenance workflows to use those new pieces.

## Why
- The repo had good coverage for normal maintenance but still needed clearer guidance for resolving documentation drift, validating changes by category, and reviewing the agent guidance itself.
- These additions make the agent setup more self-maintaining without turning it into a recursive process.

## Verification
- Confirmed the new workflows are linked from `AGENTS.md` and `docs/agents/README.md`.
- Confirmed the new rules and workflows align with the current repo structure and existing review/docs flows.
