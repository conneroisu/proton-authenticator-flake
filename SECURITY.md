# Security Policy

## 🔒 Security Commitment

The security of the Proton Authenticator Nix Flake is a top priority. This document outlines our security practices and how to report security vulnerabilities.

## 🛡️ What We Secure

### Packaging Security
- **Source Integrity**: We only package official Proton Authenticator releases
- **Hash Verification**: All source downloads use cryptographic hash verification
- **Dependency Auditing**: Regular security audits of all dependencies
- **Build Reproducibility**: Builds are reproducible and verifiable

### Supply Chain Security
- **Official Sources**: Only download from official Proton distribution channels
- **Signature Verification**: When available, we verify package signatures
- **Dependency Pinning**: All dependencies are pinned to specific versions
- **CI/CD Security**: Secure automated build and test processes

## 🚨 Supported Versions

We provide security updates for the following versions:

| Version | Supported          |
| ------- | ------------------ |
| Latest  | ✅ Yes             |
| < Latest| ❌ No              |

**Note**: We track the latest official Proton Authenticator releases. Older versions are not supported.

## 🔍 Security Measures

### Automated Security Checks
Our CI/CD pipeline includes:
- **Dependency Scanning**: Automated vulnerability scanning
- **Source Verification**: Hash integrity checks
- **Build Security**: Sandboxed builds with minimal privileges
- **Runtime Verification**: Post-build security validation

### Manual Security Reviews
- **Code Review**: All changes undergo security-focused code review
- **Threat Modeling**: Regular assessment of potential attack vectors
- **Dependency Auditing**: Manual review of all dependencies

## 📋 Security Best Practices for Users

### Recommended Usage
```nix
# Always specify exact versions in production
inputs.proton-authenticator.url = "github:conneroisu/proton-authenticator-flake/v1.0.0";

# Enable security features
nixpkgs.config = {
  allowUnfree = true;
  # Consider additional security hardening
  allowInsecurePredicate = pkg: builtins.elem (lib.getName pkg) [ "proton-authenticator" ];
};
```

### Environment Security
- **Desktop Environment**: Use on secure, updated systems only
- **Network Security**: Ensure secure network connections
- **System Updates**: Keep NixOS/Nix updated to latest versions
- **Privilege Management**: Run with minimal required privileges

## 📧 Reporting Security Vulnerabilities

### 🚨 CRITICAL: Do Not Use Public Issues

**For security vulnerabilities, please DO NOT create public GitHub issues.**

### Responsible Disclosure Process

1. **Email**: Send vulnerability details to `connerohnesorge@gmail.com`
2. **Subject**: Use subject line: `[SECURITY] Proton Authenticator Flake Vulnerability`
3. **Encryption**: Use GPG encryption if possible (key available on request)

### Information to Include

Please provide as much information as possible:

```
**Vulnerability Type**: [e.g., Supply Chain, Build Process, etc.]
**Severity**: [Critical/High/Medium/Low]
**Description**: [Detailed description of the vulnerability]
**Steps to Reproduce**: [Step-by-step reproduction instructions]
**Impact**: [Potential security impact]
**Affected Versions**: [Which versions are affected]
**Proposed Fix**: [If you have suggestions]
**Your Contact**: [How we can reach you for questions]
```

### What to Expect

| Timeline | Action |
|----------|--------|
| **24 hours** | Acknowledgment of receipt |
| **72 hours** | Initial assessment and triage |
| **7 days** | Detailed investigation and response plan |
| **30 days** | Fix development and testing |
| **Coordinated** | Public disclosure after fix |

## 🔐 Security Considerations

### Package Integrity

#### What We Verify
- ✅ SHA256 hashes of all downloaded sources
- ✅ Official Proton download URLs only
- ✅ No modifications to upstream binaries
- ✅ Reproducible build process

#### What We Don't Control
- ❌ Upstream Proton Authenticator security
- ❌ NixOS/nixpkgs security (but we track advisories)
- ❌ User system security
- ❌ Network transport security (HTTPS assumed)

### Dependencies

#### Minimal Dependency Policy
We maintain a minimal dependency set:
- **Build Dependencies**: Only essential build tools
- **Runtime Dependencies**: Only required libraries
- **No Optional Dependencies**: Avoid unnecessary attack surface

#### Dependency Monitoring
- **Automated Scanning**: Daily vulnerability scans
- **Manual Review**: Regular dependency audits
- **Update Policy**: Prompt updates for security issues

## 🚨 Known Security Considerations

### Unfree Software Notice
Proton Authenticator is proprietary software. While we package it securely, users should be aware:
- Source code is not available for audit
- Security depends on Proton's development practices
- Updates depend on Proton's release schedule

### System Requirements
This package requires:
- `nixpkgs.config.allowUnfree = true`
- Network access for initial download
- Desktop environment for GUI functionality

## 📊 Security Metrics

### Build Security
- **Sandboxed Builds**: ✅ All builds run in Nix sandbox
- **Reproducible**: ✅ Builds are reproducible
- **Hash Verified**: ✅ All sources cryptographically verified
- **Minimal Privileges**: ✅ Build process runs with minimal privileges

### CI/CD Security
- **Secure Actions**: ✅ Using official, pinned GitHub Actions
- **Secret Management**: ✅ No secrets used in build process
- **Automated Scanning**: ✅ Vulnerability scanning enabled
- **Branch Protection**: ✅ Main branch protected

## 🔄 Security Updates

### Update Policy
- **Critical**: Immediate updates within 24 hours
- **High**: Updates within 72 hours
- **Medium**: Updates within 1 week
- **Low**: Updates in next planned release

### Notification Channels
Security updates are announced via:
- 📧 GitHub Security Advisories
- 🏷️ GitHub Releases (tagged as security update)
- 💬 GitHub Discussions (pinned announcements)

## 🤝 Security Community

### Bug Bounty
Currently, we do not offer a bug bounty program, but we:
- Acknowledge all valid reports
- Credit reporters in security advisories (with permission)
- Maintain a hall of fame for security contributors

### Collaboration
We collaborate with:
- NixOS security team
- Upstream Proton security team (when applicable)
- Security research community

## 📚 Additional Resources

### Security Documentation
- [NixOS Security](https://nixos.org/manual/nixos/stable/index.html#ch-security)
- [Nix Security Model](https://nixos.org/guides/nix-pills/nix-store.html)
- [Proton Security](https://proton.me/security)

### Security Tools
For security analysis of this flake:
```bash
# Audit dependencies
nix-shell -p nix-audit-tools --run "nix-audit /nix/store/path"

# Check for vulnerabilities
nix-shell -p vulnix --run "vulnix -S /nix/store/path"

# Verify build reproducibility
nix build --rebuild --diff-hook
```

## 📞 Contact Information

### Security Team
- **Primary Contact**: connerohnesorge@gmail.com
- **Response Time**: 24-72 hours
- **GPG Key**: Available on request

### Non-Security Issues
For non-security issues, please use:
- 🐛 [GitHub Issues](https://github.com/conneroisu/proton-authenticator-flake/issues)
- 💬 [GitHub Discussions](https://github.com/conneroisu/proton-authenticator-flake/discussions)

---

**Thank you for helping keep the Proton Authenticator Nix Flake secure!** 🔒

*Last Updated: January 2025*