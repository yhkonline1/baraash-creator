create table if not exists public.admin_users (
  user_id uuid primary key references auth.users(id) on delete cascade,
  created_at timestamptz not null default now()
);

alter table public.admin_users enable row level security;

drop policy if exists "Admins can see own admin record" on public.admin_users;

create policy "Admins can see own admin record"
on public.admin_users
for select
to authenticated
using (user_id = auth.uid());

insert into public.admin_users (user_id)
values ('15223da2-4331-41f0-be38-cf10555c00fd')
on conflict (user_id) do nothing;


drop policy if exists "Admins can read creators" on public.creators;

create policy "Admins can read creators"
on public.creators
for select
to authenticated
using (
  exists (
    select 1
    from public.admin_users a
    where a.user_id = auth.uid()
  )
);


drop policy if exists "Admins can insert creators" on public.creators;

create policy "Admins can insert creators"
on public.creators
for insert
to authenticated
with check (
  exists (
    select 1
    from public.admin_users a
    where a.user_id = auth.uid()
  )
);


drop policy if exists "Admins can update creators" on public.creators;

create policy "Admins can update creators"
on public.creators
for update
to authenticated
using (
  exists (
    select 1
    from public.admin_users a
    where a.user_id = auth.uid()
  )
)
with check (
  exists (
    select 1
    from public.admin_users a
    where a.user_id = auth.uid()
  )
);


drop policy if exists "Admins can read products" on public.products;

create policy "Admins can read products"
on public.products
for select
to authenticated
using (
  exists (
    select 1
    from public.admin_users a
    where a.user_id = auth.uid()
  )
);


drop policy if exists "Admins can insert products" on public.products;

create policy "Admins can insert products"
on public.products
for insert
to authenticated
with check (
  exists (
    select 1
    from public.admin_users a
    where a.user_id = auth.uid()
  )
);


drop policy if exists "Admins can update products" on public.products;

create policy "Admins can update products"
on public.products
for update
to authenticated
using (
  exists (
    select 1
    from public.admin_users a
    where a.user_id = auth.uid()
  )
)
with check (
  exists (
    select 1
    from public.admin_users a
    where a.user_id = auth.uid()
  )
);


drop policy if exists "Admins can read submissions" on public.content_submissions;

create policy "Admins can read submissions"
on public.content_submissions
for select
to authenticated
using (
  exists (
    select 1
    from public.admin_users a
    where a.user_id = auth.uid()
  )
);


drop policy if exists "Admins can update submissions" on public.content_submissions;

create policy "Admins can update submissions"
on public.content_submissions
for update
to authenticated
using (
  exists (
    select 1
    from public.admin_users a
    where a.user_id = auth.uid()
  )
)
with check (
  exists (
    select 1
    from public.admin_users a
    where a.user_id = auth.uid()
  )
);