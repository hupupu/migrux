# Migrux

A project to migrate Ubuntu-based Linux installations between computers.

## Structure

- `apps/`: Contains individual folders for each application, each with its own `backup`, `install`, and `restore` scripts.
- `scripts/`: Contains global or orchestration scripts for the migration process.

## How to add an application

Create a new directory in `apps/` with the application name.
Inside that directory, provide three scripts:
1. `backup`: Defines how to back up configuration and data for this app.
2. `install`: Defines how to install the application.
3. `restore`: Defines how to restore the backed up configuration and data.
