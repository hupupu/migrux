# Agent guidance

## Read first

Before making changes, read `README.md` for the project overview and this file for working conventions. Inspect the relevant scripts before changing behavior; do not assume an undocumented workflow or test command.

## Project overview

Migrux migrates Ubuntu-based Linux installations between computers. It is primarily a Bash project. The root-level `backup`, `install`, and `restore` scripts orchestrate app-specific scripts under `apps/`.

## Repository layout

- `backup`, `install`, `restore`: top-level orchestration entry points.
- `apps/<app>/backup`, `apps/<app>/install`, `apps/<app>/restore`: app-specific operations. An app script may be omitted when that operation is not needed.
- `apps/_template/`: starter scripts for a new app. Directories prefixed with `_` or `.` are skipped by orchestration.
- `scripts/utils`: shared logging, argument validation, directory backup/restore, permission, and app-script execution helpers.

## Conventions and behavior

- Keep app-specific behavior in that app's directory and follow the existing Bash style.
- Reuse helpers from `scripts/utils` when they fit; inspect their implementation and call sites before changing their behavior.
- The orchestrator passes the backup destination to an app's `backup` script and the backup source to its `restore` script. The `install` script is called without these arguments. Preserve this contract unless intentionally changing all affected call sites and documenting the change.
- The top-level `backup` script requires an empty destination directory (or creates it). Restore operations copy data into the destination machine and may change file permissions; treat them as potentially destructive and make changes conservatively.
- Do not add real backups, credentials, private keys, personal data, or machine-specific paths to the repository. Keep generated backup data out of version control.
- Do not introduce new dependencies or broad refactors for a focused change.

## Zed and agent workflow

- Use this file as the persistent project guidance for Zed Agent threads; use `README.md` for the user-facing overview and usage instructions.
- Before editing, inspect the relevant files and any existing local changes. Keep edits focused and do not overwrite unrelated user work.
- Do not commit, create branches, or perform other Git history operations unless explicitly requested.
- If a task depends on a product decision, machine-specific detail, or behavior that cannot be established from the repository, ask rather than inventing it.

## Validation

- No automated test or lint command is documented in the repository. Do not claim tests passed unless you actually ran them.
- For a Bash change, use the checks appropriate to the change (for example, `bash -n` on modified scripts), and run a script only when doing so is safe and its effects are understood.
- Report what you checked and call out validation that could not safely or reasonably be performed.
- Update `README.md` when a user-facing workflow or setup instruction changes. Keep this file focused on agent workflow and stable project conventions, not task-by-task progress notes.
