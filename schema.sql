CREATE TABLE game_history (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES auth.users(id),
  game_mode TEXT NOT NULL,
  difficulty INTEGER NOT NULL,
  time_taken NUMERIC(5, 2) NOT NULL,
  completed_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 可选索引以提高查询性能
CREATE INDEX idx_game_history_user_id ON game_history(user_id);
CREATE INDEX idx_game_history_completed_at ON game_history(completed_at);