# educk-identity-db

> identity bounded context: database (schema, seeds, migrations)

Part of the **LMS Library** distributed system — team `lms-library`, Grupo 2.
Governance and documentation live in [`library-docs`](https://github.com/code-corhuila/library-docs).

## Branching

Three permanent branches. **None of them accepts a direct commit** — you enter through a child
branch and leave through a Pull Request.

```
develop  <--PR--  feat/... fix/... chore/...
qa       <--PR--  qa/...
main     <--PR--  release/...  hotfix/...
```

Promotion happens **by re-application** (`git cherry-pick -x`), never by merging one permanent
branch into another: `merge develop -> qa` and `merge qa -> main` do not exist in this model.

`main` requires **1 approval from `ariel5253`**. On `develop` and `qa` the team sets its own review
rule.

Full policy: `00-governance/branching-policy.md` in `library-docs`.

## Local development role seeds (DEV ONLY)

To provision test accounts for `PARENT` (`maria.lopez@edutrack.edu.co`), `TEACHER` (`carlos.ramirez@edutrack.edu.co`), and `ADMIN` (`rectoria@edutrack.edu.co`) locally using BCrypt cost 12 via `pgcrypto`, run `seeds/02_dev_role_users.sql` with a runtime password variable:

```sh
psql "$DATABASE_URL" -v dev_password='<your-local-dev-password>' -f seeds/02_dev_role_users.sql
```

Never execute `seeds/02_dev_role_users.sql` in QA or production environments, and never commit plaintext passwords.
