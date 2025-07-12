-- 历史时间点匹配游戏数据表
CREATE TABLE IF NOT EXISTS history_events (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  time_point TEXT NOT NULL,
  event_description TEXT NOT NULL,
  difficulty INTEGER NOT NULL CHECK (difficulty BETWEEN 1 AND 5),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 索引优化
CREATE INDEX IF NOT EXISTS idx_history_events_difficulty ON history_events(difficulty);

-- 触发器函数：自动更新updated_at字段
CREATE OR REPLACE FUNCTION update_modified_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 创建触发器
CREATE TRIGGER update_history_events_updated_at
BEFORE UPDATE ON history_events
FOR EACH ROW
EXECUTE FUNCTION update_modified_column();

-- 插入示例数据
INSERT INTO history_events (time_point, event_description, difficulty) VALUES
('公元前221年', '秦始皇统一中国', 2),
('1492年', '哥伦布发现新大陆', 3),
('1789年', '法国大革命爆发', 3),
('1945年', '第二次世界大战结束', 2);