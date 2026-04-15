-- Test Sessions Seed Script
-- Run seed_test_users.sql first!

DELETE FROM session_members WHERE session_id IN (
  SELECT ws.session_id FROM watch_sessions ws
  JOIN users u ON ws.host_id = u.id WHERE u.email LIKE '%@test.com'
);
DELETE FROM watch_sessions WHERE host_id IN (SELECT id FROM users WHERE email LIKE '%@test.com');
DELETE FROM rooms WHERE host_id IN (SELECT id FROM users WHERE email LIKE '%@test.com');

-- Room 1: Video Watch
INSERT INTO rooms (room_id, name, description, room_type, host_id, max_capacity, is_active, created_at, updated_at)
VALUES (gen_random_uuid(), 'Test Video Watch Room', 'Video testing', 'instant_watch',
  (SELECT id FROM users WHERE email = 'host@test.com'), 50, true, NOW(), NOW());

-- Session 1: Free PG Video
INSERT INTO watch_sessions (session_id, room_id, host_id, watch_type, content_rating, ticket_price, is_active, title, description, max_participants, created_at, started_at)
VALUES (gen_random_uuid(), (SELECT room_id FROM rooms WHERE name = 'Test Video Watch Room'),
  (SELECT id FROM users WHERE email = 'host@test.com'),
  'video', 'PG', 0, true, 'Family Movie Night', 'Free PG session', 50, NOW(), NOW());

INSERT INTO session_members (session_id, user_id, user_role, joined_at)
VALUES ((SELECT session_id FROM watch_sessions WHERE title = 'Family Movie Night'),
  (SELECT id FROM users WHERE email = 'host@test.com'), 'host', NOW());

-- Room 2: 3D Cinema
INSERT INTO rooms (room_id, name, description, room_type, host_id, max_capacity, is_active, created_at, updated_at)
VALUES (gen_random_uuid(), 'Test 3D Cinema Room', '3D cinema testing', 'instant_watch',
  (SELECT id FROM users WHERE email = 'host@test.com'), 30, true, NOW(), NOW());

-- Session 2: Paid 18+ Cinema
INSERT INTO watch_sessions (session_id, room_id, host_id, watch_type, content_rating, ticket_price, is_active, title, description, max_participants, created_at, started_at)
VALUES (gen_random_uuid(), (SELECT room_id FROM rooms WHERE name = 'Test 3D Cinema Room'),
  (SELECT id FROM users WHERE email = 'host@test.com'),
  '3d_cinema', '18+', 50000, true, 'Adult Movie Night', 'Age restricted', 30, NOW(), NOW());

INSERT INTO session_members (session_id, user_id, user_role, joined_at)
VALUES ((SELECT session_id FROM watch_sessions WHERE title = 'Adult Movie Night'),
  (SELECT id FROM users WHERE email = 'host@test.com'), 'host', NOW());

-- Room 3: Lecture Hall
INSERT INTO rooms (room_id, name, description, room_type, host_id, max_capacity, is_active, created_at, updated_at)
VALUES (gen_random_uuid(), 'Test Lecture Hall', 'Classroom testing', 'event_based',
  (SELECT id FROM users WHERE email = 'host@test.com'), 145, true, NOW(), NOW());

-- Session 3: Free 13+ Lecture
INSERT INTO watch_sessions (session_id, room_id, host_id, watch_type, content_rating, ticket_price, is_active, title, description, max_participants, created_at, started_at)
VALUES (gen_random_uuid(), (SELECT room_id FROM rooms WHERE name = 'Test Lecture Hall'),
  (SELECT id FROM users WHERE email = 'host@test.com'),
  'classroom', '13+', 0, true, 'Tech Tutorial - React Testing', 'Free tutorial', 145, NOW(), NOW());

INSERT INTO session_members (session_id, user_id, user_role, joined_at)
VALUES 
  ((SELECT session_id FROM watch_sessions WHERE title = 'Tech Tutorial - React Testing'),
   (SELECT id FROM users WHERE email = 'host@test.com'), 'host', NOW()),
  ((SELECT session_id FROM watch_sessions WHERE title = 'Tech Tutorial - React Testing'),
   (SELECT id FROM users WHERE email = 'viewer1@test.com'), 'viewer', NOW());

-- Session 4: G-Rated for All Ages
INSERT INTO watch_sessions (session_id, room_id, host_id, watch_type, content_rating, ticket_price, is_active, title, description, max_participants, created_at, started_at)
VALUES (gen_random_uuid(), (SELECT room_id FROM rooms WHERE name = 'Test Video Watch Room'),
  (SELECT id FROM users WHERE email = 'host@test.com'),
  'video', 'G', 0, true, 'Kids Movie Hour', 'All ages', 100, NOW(), NOW());

INSERT INTO session_members (session_id, user_id, user_role, joined_at)
VALUES 
  ((SELECT session_id FROM watch_sessions WHERE title = 'Kids Movie Hour'),
   (SELECT id FROM users WHERE email = 'host@test.com'), 'host', NOW()),
  ((SELECT session_id FROM watch_sessions WHERE title = 'Kids Movie Hour'),
   (SELECT id FROM users WHERE email = 'minor@test.com'), 'viewer', NOW());

-- Session 5: Ended Session
INSERT INTO watch_sessions (session_id, room_id, host_id, watch_type, content_rating, ticket_price, is_active, title, description, max_participants, created_at, started_at, ended_at)
VALUES (gen_random_uuid(), (SELECT room_id FROM rooms WHERE name = 'Test Video Watch Room'),
  (SELECT id FROM users WHERE email = 'host@test.com'),
  'video', 'PG', 0, false, 'Completed Movie Session', 'Ended', 50,
  NOW() - INTERVAL '2 hours', NOW() - INTERVAL '2 hours', NOW() - INTERVAL '30 minutes');

SELECT ws.title, ws.content_rating, ws.is_active, COUNT(sm.user_id) AS participants
FROM watch_sessions ws
JOIN users u ON ws.host_id = u.id
LEFT JOIN session_members sm ON ws.session_id = sm.session_id
WHERE u.email LIKE '%@test.com'
GROUP BY ws.session_id, ws.title, ws.content_rating, ws.is_active
ORDER BY ws.created_at DESC;

\echo '✅ 5 test sessions created!'
