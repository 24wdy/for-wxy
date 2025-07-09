-- 创建归档批次表
CREATE TABLE archive_batches (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  batch_number INTEGER NOT NULL UNIQUE,
  archive_date TIMESTAMP WITH TIME ZONE NOT NULL,
  total_score NUMERIC(10, 2) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 创建错误记录表
CREATE TABLE error_records (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  error_type TEXT NOT NULL CHECK (error_type IN ('basic', 'mentality', 'time', 'schedule')),
  description TEXT NOT NULL,
  error_date DATE NOT NULL,
  point_rule TEXT NOT NULL CHECK (point_rule IN ('add', 'multiply')),
  coefficient NUMERIC(5, 2) NOT NULL CHECK (coefficient > 0),
  is_archived BOOLEAN DEFAULT false,
  archive_batch_id UUID REFERENCES archive_batches(id),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 创建索引提升查询性能
CREATE INDEX idx_error_records_is_archived ON error_records(is_archived);
CREATE INDEX idx_error_records_archive_batch_id ON error_records(archive_batch_id);
CREATE INDEX idx_archive_batches_batch_number ON archive_batches(batch_number);

-- 启用UUID扩展
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";