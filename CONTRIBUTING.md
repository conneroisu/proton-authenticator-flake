# Contributing to Proton Authenticator Nix Flake

Thank you for your interest in contributing! This document provides guidelines for contributing to this project.

## 🚀 Quick Start for Contributors

1. **Fork and Clone**
   ```bash
   git clone https://github.com/YOUR_USERNAME/proton-authenticator-flake.git
   cd proton-authenticator-flake
   ```

2. **Enter Development Environment**
   ```bash
   nix develop
   ```

3. **Make Your Changes**
   - Edit the flake.nix or other files
   - Test your changes thoroughly

4. **Verify Everything Works**
   ```bash
   nix flake check
   NIXPKGS_ALLOW_UNFREE=1 nix build --impure
   ```

## 📋 Types of Contributions

We welcome several types of contributions:

### 🐛 Bug Fixes
- Fix build issues
- Resolve dependency problems
- Correct documentation errors

### ✨ Enhancements
- Improve packaging efficiency
- Add support for new systems
- Enhance CI/CD workflows

### 📚 Documentation
- Improve README clarity
- Add usage examples
- Update troubleshooting guides

### 🧪 Testing
- Add test cases
- Improve CI coverage
- Validate on different systems

## 🔧 Development Environment

### Prerequisites
- **Nix** with flakes enabled
- **Git** for version control
- **Text editor** of your choice

### Development Shell
The project includes a development shell with all necessary tools:
```bash
nix develop
```

This provides:
- `dpkg` - For examining .deb packages
- `file` - File type identification
- `patchelf` - ELF binary modification
- Other debugging tools

### Testing Your Changes

#### 1. Flake Validation
```bash
nix flake check --show-trace
```

#### 2. Build Testing
```bash
NIXPKGS_ALLOW_UNFREE=1 nix build --impure --print-build-logs
```

#### 3. Runtime Testing
```bash
./result/bin/proton-authenticator --version
ldd result/bin/.proton-authenticator-wrapped | grep "not found"
```

#### 4. Desktop Integration Testing
```bash
ls -la result/share/applications/
ls -la result/share/icons/hicolor/*/apps/
file result/share/icons/hicolor/*/apps/*.png
```

## 📝 Coding Standards

### Nix Code Style
- Use **4 spaces** for indentation (no tabs)
- Follow [Nix style guide](https://nix.dev/contributing/style-guide)
- Use meaningful variable names
- Add comments for complex logic

### Example Style
```nix
{
  # Good: descriptive names and proper indentation
  buildInputs = with pkgs; [
    gtk3
    glib
    pango
    cairo
  ];

  # Good: clear phases
  installPhase = ''
    runHook preInstall
    
    mkdir -p $out/bin
    install -m755 usr/bin/proton-authenticator $out/bin/
    
    runHook postInstall
  '';
}
```

### Documentation Style
- Use **clear, concise language**
- Include **code examples** where helpful
- **Test all examples** before submitting
- Use **proper markdown formatting**

## 🔄 Contribution Workflow

### 1. Issue First (Recommended)
For significant changes, please open an issue first to discuss:
- Proposed changes
- Implementation approach
- Potential impact

### 2. Branch Naming
Use descriptive branch names:
- `fix/build-error-nixos-24-05`
- `feat/add-aarch64-support`
- `docs/improve-installation-guide`

### 3. Commit Messages
Follow [Conventional Commits](https://www.conventionalcommits.org/):
```
feat: add support for aarch64-linux systems
fix: resolve dependency linking issue on NixOS 24.05
docs: improve troubleshooting section in README
ci: add automated security scanning
```

### 4. Pull Request Process

#### Before Submitting
- [ ] Run `nix flake check`
- [ ] Test build with `NIXPKGS_ALLOW_UNFREE=1 nix build --impure`
- [ ] Verify application launches correctly
- [ ] Update documentation if needed
- [ ] Add tests if applicable

#### PR Description Template
```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] CI/CD improvement

## Testing
- [ ] Tested on NixOS
- [ ] Tested build process
- [ ] Verified application launches
- [ ] Checked desktop integration

## Checklist
- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] No breaking changes (or clearly documented)
```

## 🧪 Testing Guidelines

### Required Tests
All contributions must pass:
1. **Flake Check**: `nix flake check`
2. **Build Test**: Clean build from scratch
3. **Runtime Test**: Application launches without errors

### Additional Testing (Encouraged)
- Test on different NixOS versions
- Verify desktop integration works
- Check with different desktop environments
- Validate icon rendering

### CI/CD Pipeline
Our GitHub Actions will automatically:
- Run flake checks
- Build the package
- Verify dependencies
- Check security
- Test desktop integration

## 🏷️ Release Process

### Version Bumping
When Proton releases a new version:
1. Update `version` in `flake.nix`
2. Update `url` with new version number
3. Update `sha256` hash (run build to get new hash)
4. Test thoroughly
5. Update `README.md` if needed

### Example Version Update
```nix
# Before
version = "1.0.0";
url = "https://proton.me/download/authenticator/linux/ProtonAuthenticator_1.0.0_amd64.deb";
sha256 = "sha256-Ri6U7tuQa5nde4vjagQKffWgGXbZtANNmeph1X6PFuM=";

# After
version = "1.1.0";
url = "https://proton.me/download/authenticator/linux/ProtonAuthenticator_1.1.0_amd64.deb";
sha256 = "sha256-NEWHASHERE...";
```

## 🔒 Security Considerations

### Source Integrity
- Always verify official Proton download URLs
- Check SHA256 hashes match official releases
- Never modify binaries or add patches

### Dependency Management
- Keep dependency list minimal
- Use official nixpkgs packages only
- Avoid custom or patched dependencies

### Security Reporting
For security issues, please:
1. **DO NOT** open a public issue
2. Email: connerohnesorge@gmail.com
3. Include detailed description
4. Allow time for responsible disclosure

## 🤝 Community Guidelines

### Code of Conduct
This project follows the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you agree to uphold this code.

### Communication
- **Be respectful** and professional
- **Be patient** with new contributors
- **Provide constructive feedback**
- **Ask questions** if something is unclear

### Getting Help
- 💬 [GitHub Discussions](https://github.com/conneroisu/proton-authenticator-flake/discussions)
- 🐛 [Issues](https://github.com/conneroisu/proton-authenticator-flake/issues)
- 📧 [Email](mailto:connerohnesorge@gmail.com)

## 📋 Maintainer Notes

### Review Criteria
Pull requests are evaluated on:
- **Functionality**: Does it work as intended?
- **Security**: No security regressions
- **Testing**: Adequate test coverage
- **Documentation**: Updated as needed
- **Style**: Follows project conventions

### Merge Process
1. Automated checks must pass
2. Manual review by maintainer
3. Testing on maintainer's system
4. Merge and tag if this is a release

## 🎯 Future Roadmap

### Planned Improvements
- Support for more architectures (aarch64-linux)
- Automated update checking
- Better error handling
- Enhanced desktop integration

### Ideas Welcome
We're open to suggestions for:
- New features
- Better packaging approaches
- Improved user experience
- Enhanced security

## 🙏 Recognition

Contributors will be:
- Listed in release notes
- Mentioned in README acknowledgments
- Added to GitHub contributors list

Thank you for helping make Proton Authenticator accessible to the Nix community!

---

## Quick Reference

```bash
# Setup
git clone <your-fork>
cd proton-authenticator-flake
nix develop

# Test
nix flake check
NIXPKGS_ALLOW_UNFREE=1 nix build --impure

# Verify
./result/bin/proton-authenticator --version
ldd result/bin/.proton-authenticator-wrapped
```

**Questions?** Open a [discussion](https://github.com/conneroisu/proton-authenticator-flake/discussions) or [issue](https://github.com/conneroisu/proton-authenticator-flake/issues)!