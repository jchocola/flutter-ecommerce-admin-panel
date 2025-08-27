// POST /api/init-supabase
const express = require('express');
const { createClient } = require('@supabase/supabase-js');
const router = express.Router();

router.post('/init-supabase', async (req, res) => {
  const { supabaseUrl, serviceKey } = req.body;

  const supabase = createClient(supabaseUrl, serviceKey, {
    auth: { persistSession: false }
  });

  try {
    // Create a 'products' table
    await supabase.rpc('execute_sql', {
      sql: `
        create table if not exists SampleTable (
          id uuid primary key default gen_random_uuid(),
          name text not null,
          price numeric,
          created_at timestamp default now()
        );
      `
    });

    // Create RLS policy
    await supabase.rpc('execute_sql', {
      sql: `
        alter table products enable row level security;
        create policy "Allow all" on products for select using (true);
      `
    });

    res.status(200).json({ message: 'Supabase initialized' });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Supabase setup failed', details: e.message });
  }
});
