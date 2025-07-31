# LPM

# GitHub-Based Lua Package Manager

### Description

- A custom-built Lua package manager designed to fetch and manage Lua projects directly from GitHub
- Inspired by package managers like npm, cargo, and luarocks, it introduces a GitHub-powered ecosystem tailored to Lua developers
- With support for versioning, caching, dependency resolution, and lockfile tracking, lua-pkg enables reproducible builds and smooth development workflows in pure Lua environments

---

## NOTICE

- Please read through this `README.md` to better understand the project's source code and setup instructions
- Also, make sure to review the contents of the `License/` directory
- Your attention to these details is appreciated — enjoy exploring the project!

---

## Problem Statement

- Lua lacks a universal, modern package manager that integrates tightly with GitHub and offers developer-friendly features like reproducible builds, semantic versioning, and cache-based installation
- Existing solutions like LuaRocks are powerful but rigid for users seeking GitHub-native tooling and lockfile support

---

## Project Goals

### Create a Lightweight CLI Tool to Manage Lua Packages from GitHub

- Users can install, remove, update, and list packages directly from GitHub repositories via a simple command-line interface

### Enable Dependency Management and Caching

- Automatically resolve dependencies, cache installed packages locally, and track versions through a lockfile to ensure consistent builds

---

## Tools, Materials & Resources

### HTTP & JSON Libraries

- `lua-http`, `luasocket`, `curl`, `dkjson`, `lunajson`, `cjson`

### CLI & File Management Tools

- `argparse`, `lfs` (LuaFileSystem)

### GitHub API Reference

- `GET /repos/:owner/:repo/contents/:path`, `GET /repos/:owner/:repo/releases/latest`, `GET /search/repositories`

---

## Design Decision

### GitHub-Centric Package Retrieval

- Uses the GitHub REST API to download manifests, releases, and tags, allowing users to leverage the entire GitHub Lua ecosystem without a centralized registry

### Manifest-Driven Installation

- Packages declare a `pkg.lua` manifest with versioning and dependencies, similar to package.json, enabling structured package resolution

### Local Cache and Lockfile

- Caches all downloaded content to `~/.lua-pkg/`, and records builds in `lockfile.json` for reproducibility

---

## Features

### lua-pkg install <package>

- Downloads the specified GitHub package, parses its manifest, installs dependencies recursively, and updates the lockfile

### lua-pkg update

- Checks for newer releases/tags for all installed packages and updates them with respect to semantic versioning

### lua-pkg remove <package>

- Removes a package and any unused dependencies from the local cache and runtime path

---

## Block Diagram

```plaintext
                              ┌────────────────────────────┐
                              │      GitHub Repository     │
                              │────────────────────────────│
                              │ - pkg.lua manifest         │
                              │ - Releases & Tags          │
                              └────────────┬───────────────┘
                                           │
             ┌─────────────────────────────▼────────────────────────────┐
             │                  lua-pkg CLI Tool                        │
             │──────────────────────────────────────────────────────────│
             │ - Parses args and subcommands                            │
             │ - Downloads packages via GitHub API                      │
             │ - Parses manifests, resolves dependencies                │
             │ - Caches packages locally                                │
             │ - Updates lockfile                                       │
             └────────────┬──────────────────────────────┬──────────────┘
                          │                              │
       ┌──────────────────▼─────────────────┐     ┌──────▼───────────────────┐
       │        ~/.lua-pkg/packages/        │     │ ~/.lua-pkg/lockfile.json │
       │ - Installed source code (init.lua) │     │ - Tracks version, SHA,   │
       │ - Indexed by name + version        │     │   and source URL         │
       └────────────────────────────────────┘     └──────────────────────────┘

```

---

## Functional Overview

- The tool performs package installation, version updates, and removal by:
	- Searching GitHub for Lua projects
	- Downloading manifests and package files
	- Parsing dependencies and resolving them recursively
	- Caching downloaded packages locally
	- Updating the lockfile with resolved versions and sources

---

## Challenges & Solutions

### Dependency Resolution from GitHub

- Solved by parsing the `dependencies` field in `pkg.lua` and recursively downloading nested dependencies with version pinning

### Managing Semantic Versions and Cache Consistency

- Introduced lockfile mechanism and local cache indexing, combined with GitHub Release/Tag APIs for version lookup

---

## Lessons Learned

### Deep GitHub API Integration with Lua

- Acquired practical experience interacting with REST APIs using Lua networking libraries and parsing complex JSON data

### Building a CLI Tool with Robust UX

- Designed a command structure, help system, and error handling for real-world usability across platforms

---

## Project Structure

```plaintext
root/
├── License/
│   ├── LICENSE.md
│   │
│   └── NOTICE.md
│
├── .gitattributes
│
├── .gitignore
│
└── README.md

```

---

## Future Enhancements

- GitHub OAuth support to bypass API rate limits
- Support for private GitHub repositories via SSH or token-based auth
- Offline mode with cached fallback builds
- Support for custom registries or self-hosted package mirrors
- Telemetry for tracking install/update statistics (opt-in)
- Package checksums and integrity verification
