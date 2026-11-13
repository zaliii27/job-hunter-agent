# Demo video: shot list and script (about 2 minutes)

Goal: a client watching this should think "this person builds real, careful automations".
Record the screen at 1080p (OBS or Xbox Game Bar: Win + Alt + R). Record the phone with its own screen recorder.
Keep the voiceover calm and short. Say numbers, not adjectives.

## Before you record
- Docker Desktop and Ollama are running, and http://localhost:5680 is open and logged in.
- To get a full daily run again, open `output/state/seen.txt` and `output/state/run-log.md` and empty them (select all, delete, save). Otherwise the agent skips jobs it has already seen.
- Have one real job post copied from OnlineJobs.ph or Upwork. Blur the client's name later if needed.
- Turn off notifications from other apps. Hide your bookmarks bar.

## Shots

| # | Time | Screen | Voiceover |
|---|---|---|---|
| 1 | 0:00-0:10 | Telegram on the phone: a digest with 3-5 matches | "Every day this agent finds AI automation jobs for me, scores them, and drafts the proposal. I just review and send." |
| 2 | 0:10-0:25 | Browser: OnlineJobs.ph terms section 7.4, then docs/sources.md | "First I checked which job sites allow automation. OnlineJobs.ph and Facebook don't, and Upwork shut down its RSS. So the agent only uses official APIs, and I paste the rest." |
| 3 | 0:25-0:45 | n8n editor: Job Hunter - Daily, then Process. Hover over the main nodes | "Four job APIs, one format. Then code scores each job from 0 to 100: my skills, part-time or not, can the Philippines apply, is it senior, are there scam signs." |
| 4 | 0:45-0:55 | Score Jobs node, scroll the SETTINGS block | "The score is plain rules, not AI. Same job, same score, and I can see why." |
| 5 | 0:55-1:20 | Paste form: paste a real post, click Score and draft. Cut to the phone when the message arrives | "For OnlineJobs.ph I paste the post here. About 20 seconds later..." (show the score, matched skills and draft) |
| 6 | 1:20-1:35 | The draft, with the screening word highlighted | "Clients hide tests like 'start your reply with the word X'. A small model forgets that, so code checks it, and adds my name and portfolio link." |
| 7 | 1:35-1:50 | Google Sheet with scores, status column, and one Markdown note | "Everything lands in a sheet and as notes. Status stays 'new' until I send it myself. Nothing is ever sent automatically." |
| 8 | 1:50-2:00 | README on GitHub | "It runs on my laptop with a local model, so it costs nothing. The code is on GitHub. Link below." |

## After recording
- Cut dead time (waiting for the model) with a jump cut or a 2x speed-up.
- Add captions. Many people watch muted.
- Blur your Telegram chat ID, the Sheet URL and any client names.
- Export at 1080p. Upload to YouTube as unlisted, or to Loom, then link it at the top of the README.
- Take the 4 screenshots named in the README while you're at it and save them in `docs/screenshots/`.
