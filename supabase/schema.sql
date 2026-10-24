-- HL TechHub onboarding form
-- Run once in Supabase → SQL Editor.

create table if not exists public.onboarding_submissions (
  id            uuid primary key default gen_random_uuid(),
  created_at    timestamptz not null default now(),
  full_name     text not null check (char_length(full_name) between 1 and 200),
  email         text not null check (char_length(email) between 3 and 320),
  business_name text check (char_length(business_name) <= 200),
  answers       jsonb not null default '{}'::jsonb
                check (pg_column_size(answers) < 100000),
  status        text not null default 'new'   -- new / reviewed / in build
);

-- Lock it down: the public (anon) key can ONLY insert. No reading, editing or deleting.
alter table public.onboarding_submissions enable row level security;

drop policy if exists "Public can submit onboarding" on public.onboarding_submissions;
create policy "Public can submit onboarding"
  on public.onboarding_submissions
  for insert
  to anon
  with check (status = 'new');

-- Nothing else is granted to anon, so selects/updates/deletes are blocked.
-- You view submissions in the Supabase Table Editor (as project owner).

create index if not exists onboarding_submissions_created_at_idx
  on public.onboarding_submissions (created_at desc);
