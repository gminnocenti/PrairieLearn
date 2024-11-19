ALTER TABLE questions
ADD COLUMN IF NOT EXISTS draft boolean NOT NULL DEFAULT false;

ALTER TABLE pl_courses
ADD COLUMN IF NOT EXISTS draft_number integer NOT NULL DEFAULT 0;

CREATE TABLE IF NOT EXISTS draft_question_metadata (
  id bigserial NOT NULL PRIMARY KEY,
  question_id BIGINT REFERENCES questions (id) ON DELETE SET NULL ON UPDATE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by BIGINT REFERENCES users (user_id) ON DELETE SET NULL ON UPDATE CASCADE,
  updated_by BIGINT REFERENCES users (user_id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TYPE enum_ai_question_generation_prompt_type AS ENUM('initial', 'human_revision', 'auto_revision');

CREATE TABLE IF NOT EXISTS ai_question_generation_prompts (
  id bigserial PRIMARY KEY,
  question_id BIGINT REFERENCES questions (id) ON DELETE SET NULL ON UPDATE CASCADE,
  prompting_user_id BIGINT REFERENCES users (user_id) ON DELETE SET NULL ON UPDATE CASCADE,
  prompting_authn_user_id BIGINT REFERENCES users (user_id) ON DELETE SET NULL ON UPDATE CASCADE,
  prompt_type enum_ai_question_generation_prompt_type NOT NULL,
  user_prompt text NOT NULL,
  system_prompt text NOT NULL,
  response text NOT NULL,
  html text NOT NULL,
  python text,
  errors jsonb,
  completion jsonb NOT NULL,
  job_sequence_id BIGINT REFERENCES job_sequences (id) ON DELETE SET NULL ON UPDATE CASCADE
);