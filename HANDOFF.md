# HANDOFF: continuing Job Hunter with free models

Read this first if you are a new AI session (or future me) picking up this project.

## What this is
An n8n agent that pulls remote AI automation jobs from official APIs, accepts pasted jobs from sites that forbid bots, scores them with code, drafts proposals with a local LLM, and sends a Telegram digest, a Google Sheet row and a Markdown note. It **never** applies by itself.

## Current state (2026-11-13)
- Built and tested on live data on 2026-11-12 (162 jobs, 77 PH-eligible, 5 drafts in 36 s; paste draft in 16 s).
- Runs in its own container `jobhunter-n8n` at http://localhost:5680, started with `docker compose up -d` from this folder.
- 4 workflows imported: Job Hunter - Daily / Paste / Process / Error Alert (IDs `jobHunterDaily`, `jobHunterPaste`, `jobHunterProc`, `jobHunterError`).
- See the checklist at the bottom for what is still open.

## Where things are
| What | Where |
|---|---|
| Workflows (source of truth is n8n; these are clean exports) | `workflows/*.json` |
| Skills profile the AI may use | `profile/skills-profile.md` (mounted read-only at `/app/profile`) |
| Proposal prompt | `prompts/proposal-writer.md` (mounted read-only at `/app/prompts`) |
| Job notes, seen list, run log | `output/job-leads/`, `output/state/seen.txt`, `output/state/run-log.md` (gitignored) |
| Settings (chat ID, Sheet ID, Ollama) | `.env` (gitignored), read in workflows as `{{ $env.NAME }}` |
| Bot token, Google key | n8n credentials only. Never in files |
| Job source research | `docs/sources.md` |

## How the pieces fit
- **Daily:** Schedule (9:20, 12:20, 15:20, 18:20) → Read run log → "Ran Today?" (skip if a `| daily |` line exists for today) → 8 HTTP nodes (Remote OK, Himalayas x2, Jobicy, Remotive, WWR RSS x2, 4dayweek.io, each `executeOnce` + continue on error) → `Collect Jobs` (Code: one format) → calls Process with `jobsJson`, `mode=daily`.
- **Paste:** Form trigger (path `job-paste`) → `Build Job` (Code) → calls Process with `mode=paste`.
- **Process:** Input → read seen list, profile, prompt → `Score Jobs` (Code, all tuning in the SETTINGS block at the top) → `Has Jobs?` → `Ask Qwen` (Ollama `/api/chat`, `format: json`, `think: false`) → `Build Note` (Code: parses JSON, enforces screening word / portfolio line / name, builds note + sheet row) → save note → `Sheet Set?` → `Add to Sheet` → `Digest` (Code, runs once) → Telegram + run log + seen list.
- Daily mode: drops jobs the Philippines can't apply for, already-seen jobs, and scores under 45; max 5 drafts. Paste mode: always drafts and only flags problems.

## How to change things
1. Edit in the n8n editor at http://localhost:5680 (easiest), test, then publish.
2. Run `bash scripts/export-workflows.sh` (Git Bash) to save clean copies into `workflows/`. It replaces credential IDs with placeholders and refuses to finish if a real one slips through.
3. Commit.
- Editing JSON by hand instead: change `workflows/*.json`, then `bash scripts/import-workflows.sh` (imports, publishes, restarts). Credentials then need re-selecting in the editor, because the public files hold placeholders.
- Testing tip: `n8n execute` inside the container clashes with the running task broker. Add `-e N8N_RUNNERS_BROKER_PORT=5699 -e QUEUE_HEALTH_CHECK_PORT=5698` to `docker exec`. It also starts from the first trigger, not the manual one, so test Process through the paste form instead.

## Rules (keep these)
- Only official APIs or feeds. No scraping of sites whose terms forbid it (OnlineJobs.ph, Facebook, Upwork). Re-check `docs/sources.md` every few months.
- Respect API limits: Remotive at most 4 calls a day, Jobicy at most 1 an hour. The daily guard keeps both under that.
- Keep the source link on every job (their terms require attribution).
- Never auto-send applications. Drafts only.
- Never put tokens, chat IDs or Sheet IDs in committed files.
- Owner style: beginner-friendly explanations, no em dashes, one step at a time.

## Good next tasks for a free model (small and safe)
- [ ] Take the 4 README screenshots and record the demo video (`docs/demo-script.md`).
- [ ] Add a "Telegram paste": the bot accepts `job: <post>` and runs Process. Needs a Telegram Trigger, which needs a public URL (tunnel), so it's bigger than it looks.
- [ ] Weekly stats message: how many jobs, average score, how many applied (read the sheet's Status column).
- [ ] Archive the one-time workflow "Job Hunter - TEST new sources (one-time)" in the n8n UI (used on 2026-11-13 to test WWR and 4dayweek.io).
- [ ] Add more Himalayas searches (for example `q=zapier`, `q=chatbot`) in Daily, one HTTP node each, plus a line in `Collect Jobs`.
- [ ] Tune SETTINGS in `Score Jobs` after a week of real results (which jobs were good but scored low?).

## Bigger tasks (worth a stronger model)
- [ ] Improve `prompts/proposal-writer.md` so drafts sound less generic. Test on 5 saved job notes before and after.
- [ ] Upwork official API (needs an approved developer key with the "Read marketplace Job Postings" scope).
- [ ] Port `Score Jobs` to Python as a learning exercise, with tests on saved jobs.

## Open setup checklist
- [x] Owner account created at http://localhost:5680
- [x] Telegram credential "Job Hunter bot" created, bot started on the phone
- [ ] Google credential "Job Hunter Google service account" created, sheet shared, `GOOGLE_SHEET_ID` in `.env` (optional; until then the sheet step is skipped)
- [x] Telegram credential selected in Process (Send Digest) and Error Alert (Send Alert). Add to Sheet still needs the Google one.
- [x] Workflows published, end-to-end tests passed in this container on 2026-11-13 (paste: 84/100 in 15 s; daily: 164 fetched, 76 open to PH, 5 drafts in 38 s; Telegram digest received)
- [ ] First commit pushed to GitHub (committed locally on 2026-11-13, not pushed yet)
- [ ] Put the real portfolio URL and rate in `profile/skills-profile.md`

## Known issues
- qwen3:8b sometimes writes a proposal line in the client's voice ("We're a small shop..."). Fix it when reviewing; a prompt fix is in "Bigger tasks".
- With `minScore` 45, weak matches (for example an ML inference role at 62) can fill the last draft slots. Consider 60 to 65 after a week of results.
