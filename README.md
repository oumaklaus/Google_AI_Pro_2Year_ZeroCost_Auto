This is the main English README for the Linux version of the project.

========================================================================
  Google AI Pro (5 TB) Zero Cost 2 Years (US$0.00 -> 24 months) Fully Automatic Console
========================================================================

[1. Runtime Requirements]
1. Linux (verified on x86_64 with Chromium); macOS should also work
2. Chromium or Google Chrome installed and on PATH (`chromium`, `google-chrome` or `chrome`),
   or point the CHROME_PATH environment variable at the browser binary
3. Python 3.10 or higher installed
4. Network: enable a US proxy on this machine, or fill in the proxy template in the console

## 2. Usage

### Start the console

Open a terminal in the project directory and run:

```bash
./run.sh
```

The launcher creates `.venv` if needed, installs dependencies on its first run,
and starts the console at **http://127.0.0.1:8765**. Open that address manually if
your browser does not open automatically. Keep the terminal open while using the
console. For later sessions, run `./run.sh` again.

No initial configuration file is required: saving settings or importing accounts
creates local `config.json`. See `config.example.json` for the configuration
structure; do not replace an existing `config.json` with the empty template.

### Optional launch settings

```bash
# Use a specific installed browser (replace the path with its actual location).
CHROME_PATH=/usr/bin/chromium ./run.sh

# Select Python when creating a new virtual environment.
PYTHON=python3.11 ./run.sh
```

`PYTHON` does not replace the interpreter in an existing `.venv`. On Linux,
Chromium automatically runs headlessly if neither `DISPLAY` nor `WAYLAND_DISPLAY`
is set. For interactive sign-in or CAPTCHA prompts, use a desktop session with a
visible browser. `HEADLESS=1` is not a supported setting in the current code.

### Manual startup (without the launcher)

Run these commands from the project directory if you prefer to manage the
environment yourself:

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt
python app.py
```

Install Chrome or Chromium separately; installing the Python dependencies does
not install the browser used by this app.

### Use the console

1. Enter your settings and click **Save config**. Section 3 below describes the
   configuration fields and supported account-import formats.
2. Import accounts you manage with **Import accounts**. Re-importing an existing
   email updates its credentials rather than adding a second row.
3. Use the account's **Run** button for an individual run. The top-level
   **Run all pending accounts** button processes unlocked accounts sequentially;
   despite its label, the backend also includes unlocked accounts with other
   statuses, such as errors. Completed or explicitly locked accounts are skipped.
4. Follow the account's status, step message, and **Live automation log**. If the
   status says **Waiting for CAPTCHA**, complete the challenge in the browser.
   Use **View** in the **Proof** column when a screenshot is available; screenshots
   are saved in `screenshots/`.
5. Click **Stop** for an active account or **Stop all tasks** for the whole queue.
   Stops are cooperative, so wait for the running task to finish stopping before
   closing the console with **Ctrl+C** in the terminal. A stop does not undo
   subscription changes already made.

The **Browser** action opens an unlocked account's saved browser profile. The
reset arrow resets its local progress to pending; it does not undo changes at
Google. Completed or explicitly locked accounts cannot be run, reset, or opened
through that action. Removing an account from the list does not delete its
browser profile or screenshots.

### Troubleshooting

| Symptom | What to check |
| --- | --- |
| `Permission denied` when starting the launcher | Run `bash run.sh`, or restore its executable bit with `chmod +x run.sh`. |
| Python reports that `venv` or `ensurepip` is unavailable | Install your distribution's Python venv package; on Debian/Ubuntu, use `sudo apt install python3-venv`. |
| Chrome/Chromium cannot be found | Install the browser or set `CHROME_PATH` to its executable. |
| The console page does not open | Check the terminal for startup errors, then open `http://127.0.0.1:8765` manually. |
| Port `8765` is already in use | Use the existing console or stop the earlier instance before starting another. |
| Dependencies are missing after an update | Run `.venv/bin/python -m pip install -r requirements.txt`; the launcher skips installation once `.venv/.deps-ok` exists. |

[Linux notes]
- Chromium is started with --no-sandbox when needed, plus --password-store=basic --use-mock-keychain
  so no keyring dialog pops up.
- Port cleanup uses ss/lsof plus signals, no longer netstat/taskkill.
- Chromium adds `--headless=new` when no X11/Wayland display is available.
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

## Language and automation compatibility

The console's buttons, status labels, and app-written messages are in English.
The retained Windows launchers also display English messages; their original
filenames remain unchanged for compatibility.

Google pages opened by the automation still use `hl=zh-CN`. Some selectors,
subscription-state checks, and date parsers depend on Chinese page text. Keep
those strings and locale parameters unchanged: translating them or forcing the
Google pages to English could break sign-in, subscription handling, or renewal
cancellation. Raw page excerpts in logs, captured dates, and screenshots may
therefore still contain Chinese. Translating documentation and launcher messages
does not change the automation; a fully English Google-page workflow would need
separate selector updates and end-to-end validation.

[Local configuration and Git privacy]
- `config.example.json` is a template with no saved accounts or payment details.
- The app creates a local `config.json` when settings are saved; it is intentionally ignored by Git.
- Browser profiles, screenshots, local artifacts, logs, and Python environments are also ignored.
- Keep private runtime data local; do not force-add ignored files.
- Saved credentials and card details are plaintext, not encrypted. The console
  displays sensitive account data and has no authentication; keep it bound to
  `127.0.0.1` and do not expose it publicly or share unredacted logs/screenshots.
