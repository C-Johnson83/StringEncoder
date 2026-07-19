Excel Workbook Launcher Toolkit

A small toolkit for opening password-protected Excel workbooks without exposing the password to end users. A lightweight .bat launcher hands off to PowerShell, which reads an obfuscated password file and opens the target workbook automatically — no password prompt, no plaintext password anywhere a user would casually stumble onto it.


⚠️ Security model, read this first. This toolkit provides obfuscation, not strong security. It's designed for environments where the goal is preventing casual/accidental access (e.g. a coworker opening a file in Notepad) rather than defending against a determined, technically skilled attacker. See Security Notes below before relying on this for anything sensitive.




Table of Contents


How it works
Repo structure
Requirements
Setup
Usage
Adding a new workbook
Troubleshooting
Security notes / limitations
Contributing



How it works

User double-clicks Launcher.bat
        │
        ▼
Launcher.bat calls PowerShell with -ExecutionPolicy Bypass
        │
        ▼
OpenWorkbook.ps1 runs:
   1. Reads the obfuscated password file (.dat)
   2. Decodes it (Base64)
   3. Opens Excel via COM
   4. Opens the target workbook using the decoded password
        │
        ▼
Workbook opens, fully functional — user never sees the password

One shared OpenWorkbook.ps1 script handles opening any workbook — each workbook just gets its own thin .bat launcher that tells the shared script which workbook and which password file to use.
