# 🔐 Proton Authenticator Nix Flake

[![CI Status](https://github.com/conneroisu/proton-authenticator-flake/workflows/CI/badge.svg)](https://github.com/conneroisu/proton-authenticator-flake/actions)
[![Flake Check](https://github.com/conneroisu/proton-authenticator-flake/workflows/Flake%20Check/badge.svg)](https://github.com/conneroisu/proton-authenticator-flake/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Release](https://img.shields.io/github/v/release/conneroisu/proton-authenticator-flake)](https://github.com/conneroisu/proton-authenticator-flake/releases/latest)
[![Nix Flake](https://img.shields.io/badge/Nix-Flake-blue?logo=nixos)](https://nixos.org)

A reliable, well-tested Nix flake for [Proton Authenticator](https://proton.me/support/authenticator) - the secure 2FA app from Proton. This flake packages the official `.deb` release for seamless integration with NixOS and Nix-based systems.

## ✨ Features

- 🔄 **Automatic Updates**: CI checks for new releases weekly
- 🛡️ **Security First**: Comprehensive security auditing and dependency verification
- 🖥️ **Desktop Integration**: Full `.desktop` file and icon support
- 📦 **Zero Configuration**: Works out-of-the-box with proper environment setup
- ✅ **Well Tested**: Extensive CI/CD pipeline with automated verification
- 🔧 **Development Ready**: Includes development shell for contributors

## 🚀 Quick Start

### One-liner Installation
```bash
NIXPKGS_ALLOW_UNFREE=1 nix run --impure github:conneroisu/proton-authenticator-flake
```

### Build and Test Locally
```bash
git clone https://github.com/conneroisu/proton-authenticator-flake.git
cd proton-authenticator-flake
NIXPKGS_ALLOW_UNFREE=1 nix build --impure
./result/bin/proton-authenticator
```

## 📖 Installation Methods

### Method 1: Direct Run (Recommended for Testing)
```bash
# Run once without installing
NIXPKGS_ALLOW_UNFREE=1 nix run --impure github:conneroisu/proton-authenticator-flake
```

### Method 2: NixOS System Configuration
Add to your `flake.nix`:
```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    proton-authenticator.url = "github:conneroisu/proton-authenticator-flake";
  };

  outputs = { self, nixpkgs, proton-authenticator }: {
    nixosConfigurations.your-hostname = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        {
          environment.systemPackages = [
            proton-authenticator.packages.x86_64-linux.default
          ];
          nixpkgs.config.allowUnfree = true;
        }
      ];
    };
  };
}
```

### Method 3: Home Manager
```nix
{
  inputs = {
    home-manager.url = "github:nix-community/home-manager";
    proton-authenticator.url = "github:conneroisu/proton-authenticator-flake";
  };

  outputs = { home-manager, proton-authenticator, ... }: {
    homeConfigurations.your-username = home-manager.lib.homeManagerConfiguration {
      modules = [
        {
          home.packages = [
            proton-authenticator.packages.x86_64-linux.default
          ];
          nixpkgs.config.allowUnfree = true;
        }
      ];
    };
  };
}
```

### Method 4: Nix Profile
```bash
# Install to your profile
NIXPKGS_ALLOW_UNFREE=1 nix profile install --impure github:conneroisu/proton-authenticator-flake

# Remove if needed
nix profile remove proton-authenticator
```

## 🔧 Requirements

- **System**: x86_64-linux (Intel/AMD 64-bit Linux)
- **Nix**: Flakes support enabled
- **License**: Must allow unfree packages (`nixpkgs.config.allowUnfree = true`)
- **Desktop**: Any modern Linux desktop environment (GNOME, KDE, XFCE, etc.)

### Enable Flakes (if not already enabled)
```bash
# Add to ~/.config/nix/nix.conf or /etc/nix/nix.conf
experimental-features = nix-command flakes
```

## 🛠️ Development

### Development Shell
```bash
git clone https://github.com/conneroisu/proton-authenticator-flake.git
cd proton-authenticator-flake
nix develop
```

### Available Commands in Dev Shell
- `dpkg` - For examining .deb packages
- `file` - File type identification
- `patchelf` - ELF binary modification

### Testing Changes
```bash
# Check flake
nix flake check

# Build and test
NIXPKGS_ALLOW_UNFREE=1 nix build --impure

# Verify package contents
ls -la result/
ldd result/bin/.proton-authenticator-wrapped
```

## 📋 Package Details

| Property | Value |
|----------|-------|
| **Package Name** | `proton-authenticator` |
| **Version** | `1.0.0` |
| **Source** | Official Proton .deb package |
| **License** | Unfree (Proton proprietary) |
| **Closure Size** | ~300MB |
| **Supported Systems** | x86_64-linux |

### What's Included
- 📱 Proton Authenticator binary
- 🖥️ Desktop integration (`.desktop` file)
- 🎨 Application icons (32x32, 128x128, 256x256@2)
- 🔗 Properly linked dependencies
- 🌍 GTK/GLib environment configuration

## 🔍 Verification

This package undergoes comprehensive testing:

- ✅ **Build Testing**: Clean builds from scratch
- ✅ **Dependency Verification**: All shared libraries properly linked
- ✅ **Security Auditing**: Source integrity and vulnerability checks
- ✅ **Desktop Integration**: Icon and .desktop file validation
- ✅ **Cross-platform**: Tested on multiple NixOS configurations

## 🤝 Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Quick Contribution Guide
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly with `nix flake check`
5. Submit a pull request

## 🐛 Troubleshooting

### Common Issues

**"unfree license" error**
```bash
# Solution: Enable unfree packages
export NIXPKGS_ALLOW_UNFREE=1
# Or add to your NixOS config: nixpkgs.config.allowUnfree = true;
```

**Application won't start**
```bash
# Check if you have a desktop environment running
echo $XDG_CURRENT_DESKTOP

# Verify all dependencies are linked
ldd result/bin/.proton-authenticator-wrapped | grep "not found"
```

**Build fails with network error**
```bash
# Check internet connection and try again
nix build --impure --rebuild
```

### Getting Help
- 🐛 [Report Issues](https://github.com/conneroisu/proton-authenticator-flake/issues)
- 💬 [Discussions](https://github.com/conneroisu/proton-authenticator-flake/discussions)
- 📧 [Contact Maintainer](mailto:connerohnesorge@gmail.com)

## 📊 Project Status

- **Maintenance**: ✅ Actively maintained
- **CI/CD**: ✅ Comprehensive testing pipeline
- **Security**: ✅ Regular security audits
- **Updates**: ✅ Automated update checking
- **Documentation**: ✅ Comprehensive docs

## 📄 License

This Nix flake is licensed under the MIT License. See [LICENSE](LICENSE) for details.

**Note**: The Proton Authenticator application itself is proprietary software owned by Proton AG. This flake only provides packaging for NixOS/Nix users.

## 🙏 Acknowledgments

- [Proton](https://proton.me) for creating Proton Authenticator
- [NixOS](https://nixos.org) community for the excellent ecosystem
- Contributors and testers who help improve this flake

---

<div align="center">

**⭐ If this helped you, please star the repository! ⭐**

</div>
