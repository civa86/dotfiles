# Development environment

## General Coding Preferences

- Do not add comments to code unless explicitly requested.
- Do not do anything with git branches unless explicitly requested.

## Git Workflow

- Use git-flow with branches: main, develop, feature/_, release/_,hotfix/\*.
- Release branches always have the name vX.X.X where X.X.X is the version of the project file (package.json, pyproject.toml, etc...)
- Keep commits atomic and focused.

## Package manager

- Always use `yarn` installed on the system. Do **not** use `npm` for installing, running, or managing dependencies.

## Node.js / nvm

- Always use the Node version linked to the nvm `default` alias.
- Do **not** install new Node versions, and do **not** modify my nvm configuration.
- If the required Node version is not the nvm default, stop and ask — never change nvm settings or install anything.

# JavaScript / TypeScript

- Always use arrow functions over classic `function` declarations.
- Prefer `const` over `let` whenever possible.
- Never use `var` — it causes hoisting problems.

## Formatting

- If the project contains a Prettier config file (e.g. `.prettierrc`, `.prettierrc.json`, `.prettierrc.js`, `prettier.config.js`, or a `prettier` key in `package.json`), follow it with **maximum priority**.
- If no Prettier config is specified in the project, fall back to these rules (from the `.prettierrc` in my dotfiles root):
  - `printWidth`: 120
  - `tabWidth`: 2
  - `useTabs`: false
  - `semi`: false
  - `singleQuote`: true
  - `trailingComma`: none
  - `bracketSpacing`: true
  - `jsxBracketSameLine`: true
  - `arrowParens`: avoid
- For Python, if the project contains a `.pep8` file, follow it with **maximum priority**. If none is specified, fall back to these rules (from the `.pep8` in my dotfiles root):
  - `max_line_length`: 120
  - `aggressive`: 3
  - `ignore`: E402
