# HL TechHub — Client Onboarding Form

A single static page (`index.html`) hosted on GitHub Pages. Each submission is saved as a row in Supabase.

## 1. Supabase
1. Create a project (or use an existing one).
2. **SQL Editor** → paste and run `supabase/schema.sql`.
3. **Project Settings → API** → copy the **Project URL** and the **anon public** key.
4. In `index.html`, near the bottom, fill in `SUPABASE_URL` and `SUPABASE_ANON_KEY`.

The anon key is meant to be public. The table's security rules only allow **inserting** new rows, so nobody can read submissions with it. Never put the `service_role` key in this file.

## 2. GitHub
1. Create a repo (e.g. `hl-onboarding`) and push these files to `main`.
2. Repo **Settings → Pages** → Source: *Deploy from a branch* → `main` / root.
3. The `CNAME` file sets the custom domain to `onboarding.hl-techhub.com`. Change it if you want a different subdomain.

## 3. DNS (where hl-techhub.com is managed)
Add a CNAME record:

| Type  | Name         | Value                        |
|-------|--------------|------------------------------|
| CNAME | `onboarding` | `<your-github-username>.github.io` |

Once DNS is live, tick **Enforce HTTPS** in Settings → Pages.

## 4. Test
Open the page, submit a test entry, then check **Supabase → Table Editor → onboarding_submissions**. All answers are in the `answers` column; name, email and business are also in their own columns for quick scanning. Use the `status` column to track progress (`new`, `reviewed`, `in build`).

## Optional: email alert on new submissions
Supabase → **Database → Webhooks** → on INSERT into `onboarding_submissions`, call an Edge Function or a service like Resend/Zapier to email `info@hl-techhub.com`.
