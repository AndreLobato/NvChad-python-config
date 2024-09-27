# Old, to be updated!
See [issues](https://github.com/dobval/NvChad-python-config/issues)

# NvChad-python-config
Custom config of Nvim (NvChad) as a Python IDE.
Inspired from [Dreams of Code](https://github.com/dreamsofcode-io/neovim-python)
Note: This guide takes into account the new configuration structure in NvChad v2.5 and beyond as outlined in the [release notes](https://nvchad.com/news/v2.5_release/).

# Plugins
- **Pyright** - Static Type Checker (LSP)
- **Black** - Formatter (configured on-save)
- **Ruff** - LSP
- **MyPy** - Static Type Checker
- **DebugPy** - Debugging

# Pre-requisites
- [NvChad](https://nvchad.com/docs/quickstart/install/#install) (Check if Neovim is up to date!)
  <details>
    <summary>Backup previous Nvim config (optional)</summary>
    
    ```bash
      mv ~/.config/nvim ~/.config/nvim_backup
    ```
    
  </details>
  - Git
  - npm (for installing Pyright)
  - Python (of course)
  
# Installation
```bash
git clone https://github.com/dobval/NvChad-python-config.git ~/.config/nvim/lua/custom
```
Then run `nvim` and let everything install.

Restart Neovim and install the treesitter syntax
```bash
:TSInstall python
```
