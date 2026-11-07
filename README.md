Chinese original of the Windows project: keep `README.md` in the Windows copy for that; this is the Linux copy's English README.

========================================================================
  Google AI Pro (5 TB) Zero Cost 2 Years (US$0.00 -> 24 months) Fully Automatic Console
========================================================================

[1. Runtime Requirements]
1. Linux (verified on x86_64 with Chromium); macOS should also work
2. Chromium or Google Chrome installed and on PATH (`chromium`, `google-chrome` or `chrome`),
   or point the CHROME_PATH environment variable at the browser binary
3. Python 3.10 or higher installed
4. Network: enable a US proxy on this machine, or fill in the proxy template in the console

[2. Quick Start Steps]
1. First run: ./run.sh  (creates .venv, installs the dependencies and starts the console)
2. Daily use: ./run.sh again
3. The console is served at: http://127.0.0.1:8765
   (If your desktop has no default browser opener, open that address manually)

[Linux notes]
- Chromium is started with --no-sandbox when needed, plus --password-store=basic --use-mock-keychain
  so no keyring dialog pops up.
- Port cleanup uses ss/lsof plus signals, no longer netstat/taskkill.
- Set HEADLESS=1 to append --headless=new to the browser arguments.
- The original Windows .bat launchers are kept and still work on Windows.

[3. Filling In a Payment Card & Running Accounts]
1. Fill in the payment card (required):
   - In the [Global config, tax-free region, zero-cost 2-year Pro plan & card settings] area on the left,
     enter your own Visa or Mastercard foreign-currency card:
     * Card number (16 digits)
     * Expiry (month / year, e.g. 08 / 29)
     * Security code (3-digit CVC)
     * Cardholder name in Latin letters
     * The tax-free ZIP is pre-filled with 97201 (Oregon, a US tax-free state), no need to change
   - Then click [Save config].
   - Note: the script has a strict built-in zero-cost guard; it only clicks subscribe when the checkout
     popup confirms US$0.00, so nothing is charged at any point.

2. Bulk import Google accounts:
   - Paste accounts (one per line) into the [Bulk account import] area on the right; any separator works:
     * email----password----recovery email
     * email----password----recovery email----2FA secret
     * email----password----2FA secret
   - Click [Import accounts].

3. Start the fully automatic run:
   - Click [Run] next to a single account, or [Run all pending accounts] at the top.
   - The script automatically performs:
     Step 1: sign in to Google and pass recovery email / 2FA verification
     Step 2: inline tax-free card binding + layer 1 12-month free bundle (US$0.00)
     Step 3: stack layer 2 6-month free bundle (US$0.00 -> 18 months)
     Step 4: stack layer 3 6-month free bundle (US$0.00 -> 24 months cap)
     Step 5: go to Google Play, cancel auto-renewal, lock in the 2-year expiry and screenshot it as proof


# Card shop: https://faka.cdkey.si
# Blog: https://blog.caowo.de
# TG group: @Hello_Florence

[Local configuration and Git privacy]
- `config.example.json` is a template with no saved accounts or payment details.
- The app creates a local `config.json` when settings are saved; it is intentionally ignored by Git.
- Browser profiles, screenshots, local artifacts, logs, and Python environments are also ignored.
- Keep private runtime data local; do not force-add ignored files.
