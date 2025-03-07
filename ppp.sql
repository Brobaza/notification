CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    avatar_url TEXT
);

CREATE TABLE notifications (
    id SERIAL PRIMARY KEY,
    sender_id INT REFERENCES users(id) ON DELETE SET NULL,
    user_id INT REFERENCES users(id) ON DELETE CASCADE, 
    parent_id INT REFERENCES notifications(id) ON DELETE SET NULL, 
    title TEXT NOT NULL,
    message TEXT,
    category VARCHAR(50) CHECK (category IN ('communication', 'file_manager', 'project_ui', 'order')),
    status VARCHAR(20) DEFAULT 'unread' CHECK (status IN ('unread', 'read', 'archived')),
    metadata JSONB, 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE notification_status (
    id SERIAL PRIMARY KEY,
    notification_id INT REFERENCES notifications(id) ON DELETE CASCADE,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    is_read BOOLEAN DEFAULT FALSE,
    is_archived BOOLEAN DEFAULT FALSE
);

CREATE TABLE notification_actions (
    notification_id INT PRIMARY KEY REFERENCES notifications(id) ON DELETE CASCADE,
    action_name VARCHAR(50) NOT NULL, -- e.g., "Accept", "Decline", "Pay", "Reply", "Download"
    action_url TEXT NOT NULL
);

CREATE TABLE notification_tags (
    notification_id INT PRIMARY KEY REFERENCES notifications(id) ON DELETE CASCADE,
    tag_name VARCHAR(50) NOT NULL
);
