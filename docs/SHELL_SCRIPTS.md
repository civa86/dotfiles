# Bash Scripts

Set of useful bash utilities.

## bash-completion-install

Install all the bash-completion scripts

**Usage**

```bash
bash-completion-install
```

**Requirements**

- bash-completion installed

---

## prettier-rules-install

Copy prettier code style rules in current project

**Usage**

```bash
prettier-rules-install
```

**Requirements**

- valid npm project (package.json)

---

## extract-package-version

Print the current version of package.json.

**Usage**

```bash
extract-package-version
```

**Requirements**

- valid npm project (package.json)

---

## release

Utlity to start a new release with git flow.

**Usage**

```bash
release x.x.x
```

**Requirements**

- npm, git, git-flow
- project initialized with git-flow branches
- develop branch checkout without pending changes
- valid npm project (package.json)

**Tasks**

- Start the new release
- Bump the package.json version
