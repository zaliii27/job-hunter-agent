# Job sources: what is allowed (checked 2026-11-12)

Rule for this project: use official APIs or feeds only. If a site's terms forbid bots, the agent does not touch it and I paste jobs in by hand instead.

| Source | Automated access? | How the agent uses it | Conditions we follow |
|---|---|---|---|
| Himalayas | Yes, public JSON API, no key | `https://himalayas.app/jobs/api/search?q=n8n` and `?q=ai automation`, once a day | Keep `applicationLink` unchanged, show Himalayas as the source, personal use only |
| Remote OK | Yes, public JSON API | `https://remoteok.com/api`, once a day | Link back to the Remote OK job URL and name Remote OK as the source |
| Jobicy | Yes, public API, no key | `https://jobicy.com/api/v2/remote-jobs?tag=n8n`, once a day | Max one call per hour, credit Jobicy with a link, apply links go to the Jobicy URL |
| Remotive | Yes, public API | `https://remotive.com/api/remote-jobs?search=automation`, once a day | Max about 4 calls a day, jobs arrive 24h late, link back and name Remotive |
| OnlineJobs.ph | No. Terms 7.4 forbid "any automated means" without express permission | Manual paste form | None needed, I read the site myself |
| Upwork | RSS feeds were shut down on 2024-08-20. The GraphQL API needs an approved developer key with the "Read marketplace Job Postings" scope | Manual paste form (API key is a possible later upgrade) | Never auto-apply |
| Facebook groups | No. Meta removed the Groups API in 2024 and treats scraping as a terms violation | Manual paste form | None needed |

The agent never sends applications. It drafts, I review and send.

## Where this came from
- OnlineJobs.ph Terms of Use: https://www.onlinejobs.ph/terms (section 7.4)
- Upwork RSS deprecation: https://support.upwork.com/hc/en-us/articles/52052528243731-RSS-deprecation
- Upwork API docs: https://www.upwork.com/developer/documentation/graphql/api/docs/index.html
- Remote OK API (legal notice is the first item): https://remoteok.com/api
- Jobicy API and RSS: https://jobicy.com/jobs-rss-feed
- Remotive API: https://github.com/remotive-com/remote-jobs-api
- Himalayas API: https://himalayas.app/api
- Facebook Groups API removal: https://developers.facebook.com/community/threads/584177870580474/

Terms change. Re-check these pages every few months.
