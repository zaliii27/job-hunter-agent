# Job sources: what is allowed (checked 2026-11-12, more sites added 2026-11-13)

Rule for this project: use official APIs or feeds only. If a site's terms forbid bots, the agent does not touch it and I paste jobs in by hand instead.

| Source | Automated access? | How the agent uses it | Conditions we follow |
|---|---|---|---|
| Himalayas | Yes, public JSON API, no key | `https://himalayas.app/jobs/api/search?q=n8n` and `?q=ai automation`, once a day | Keep `applicationLink` unchanged, show Himalayas as the source, personal use only |
| Remote OK | Yes, public JSON API | `https://remoteok.com/api`, once a day | Link back to the Remote OK job URL and name Remote OK as the source |
| Jobicy | Yes, public API, no key | `https://jobicy.com/api/v2/remote-jobs?tag=n8n`, once a day | Max one call per hour, credit Jobicy with a link, apply links go to the Jobicy URL |
| Remotive | Yes, public API | `https://remotive.com/api/remote-jobs?search=automation`, once a day | Max about 4 calls a day, jobs arrive 24h late, link back and name Remotive |
| We Work Remotely | Yes, official RSS feeds | `https://weworkremotely.com/categories/remote-programming-jobs.rss` and `.../all-other-remote-jobs.rss`, once a day | Attribute links back to WWR. Their separate API terms forbid storing data; it is unclear if that covers RSS, so notes stay local and personal |
| 4dayweek.io | Yes, free public API, no key. Terms section 10 bans scraping but allows the documented API | `https://4dayweek.io/api/v2/jobs?q=n8n&work_arrangement=remote&limit=50`, once a day | Credit 4dayweek.io with a link, max 60 calls a minute, don't use results to build a competing job board |
| OnlineJobs.ph | No. Terms 7.4 forbid "any automated means" without express permission | Manual paste form | None needed, I read the site myself |
| Upwork | RSS feeds were shut down on 2024-08-20. The GraphQL API needs an approved developer key with the "Read marketplace Job Postings" scope | Manual paste form (API key is a possible later upgrade) | Never auto-apply |
| Facebook groups | No. Meta removed the Groups API in 2024 and treats scraping as a terms violation | Manual paste form | None needed |

| LinkedIn | No. User Agreement 8.2 bans bots, crawlers and scraping, even of public job pages. Jobs API is partner-only | Manual paste form | None needed |
| X (Twitter) | Paid only. The free API tier ended in 2026; reading posts costs about $0.005 each. Scraping is against the terms | Manual paste form | None needed |
| Kalibrr | No. Terms say they monitor for automated extraction and scraping; content is for personal, non-commercial use. No public API | Manual paste form | None needed |
| Bossjob | No public API. robots.txt blocks the job list pages (`/remote-jobs`, `/jobs-hiring`); terms page did not load | Manual paste form | None needed |
| Jora Philippines | No. Terms forbid robots and screen scraping. Mostly re-lists jobs from other sites | Manual paste form | None needed |
| PhilJobNet | No API, terms not published where I could find them, site blocks automated readers. Mostly onsite PH jobs | Manual paste form | None needed |
| stillhiring.today | Not a job feed: a community list of companies still hiring (Airtable). robots.txt blocks `/api` | By hand: open a company's careers page, paste good jobs | None needed |
| usesprout.com (Sprout) | Not a job source: an AI app that submits applications for you. That breaks this project's "never auto-send" rule | Not used | |

The agent never sends applications. It drafts, I review and send.

## Where this came from
- OnlineJobs.ph Terms of Use: https://www.onlinejobs.ph/terms (section 7.4)
- Upwork RSS deprecation: https://support.upwork.com/hc/en-us/articles/52052528243731-RSS-deprecation
- Upwork API docs: https://www.upwork.com/developer/documentation/graphql/api/docs/index.html
- Remote OK API (legal notice is the first item): https://remoteok.com/api
- Jobicy API and RSS: https://jobicy.com/jobs-rss-feed
- Remotive API: https://github.com/remotive-com/remote-jobs-api
- Himalayas API: https://himalayas.app/api
- We Work Remotely RSS feeds: https://weworkremotely.com/remote-job-rss-feed (API terms: https://weworkremotely.com/api-terms-and-guidelines)
- 4dayweek.io API and terms: https://4dayweek.io/developers and https://4dayweek.io/terms (section 10)
- LinkedIn User Agreement: https://www.linkedin.com/legal/user-agreement (section 8.2)
- Kalibrr terms: https://www.kalibrr.com/terms
- Bossjob: https://bossjob.ph/robots.txt and https://bossjob.ph/llms.txt
- Jora terms: https://au.jora.com/cms/terms-of-service
- PhilJobNet privacy page: https://philjobnet.gov.ph/privacy.aspx
- stillhiring.today: https://stillhiring.today/robots.txt
- Sprout terms: https://usesprout.com/legal/terms-of-service
- Facebook Groups API removal: https://developers.facebook.com/community/threads/584177870580474/

Terms change. Re-check these pages every few months.
