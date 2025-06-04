-- Create the custom_gpts table for storing community GPTs
CREATE TABLE IF NOT EXISTS custom_gpts (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    system_prompt TEXT NOT NULL,
    model_id TEXT NOT NULL,
    logo_url TEXT DEFAULT 'ai-logo.png',
    username TEXT DEFAULT 'Anonymous User',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable Row Level Security (RLS)
ALTER TABLE custom_gpts ENABLE ROW LEVEL SECURITY;

-- Create policies to allow public read access and insert access
CREATE POLICY "Allow public read access" ON custom_gpts
    FOR SELECT USING (true);

CREATE POLICY "Allow public insert access" ON custom_gpts
    FOR INSERT WITH CHECK (true);

-- Enable realtime for the table
ALTER PUBLICATION supabase_realtime ADD TABLE custom_gpts;

-- Create an index on created_at for performance
CREATE INDEX IF NOT EXISTS idx_custom_gpts_created_at ON custom_gpts(created_at DESC);
