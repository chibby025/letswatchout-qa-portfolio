-- Test Users Seed Script
-- Password: Test1234!
DELETE FROM wallets WHERE user_id IN (SELECT id FROM users WHERE email LIKE '%@test.com');
DELETE FROM users WHERE email LIKE '%@test.com';

INSERT INTO users (username, email, password_hash, date_of_birth, role, created_at, updated_at)
VALUES ('test_host', 'host@test.com', '$2a$10$N9qo8uLOickgx2ZMRZoMye6IXWQ7J5U5JIx1Xz9EjY0bQhU7xq5.G', 
  CURRENT_DATE - INTERVAL '36 years', 'user', NOW(), NOW());
INSERT INTO wallets (user_id, balance, created_at, updated_at)
VALUES ((SELECT id FROM users WHERE email = 'host@test.com'), 500000, NOW(), NOW());

INSERT INTO users (username, email, password_hash, date_of_birth, role, created_at, updated_at)
VALUES ('test_viewer1', 'viewer1@test.com', '$2a$10$N9qo8uLOickgx2ZMRZoMye6IXWQ7J5U5JIx1Xz9EjY0bQhU7xq5.G', 
  CURRENT_DATE - INTERVAL '31 years', 'user', NOW(), NOW());
INSERT INTO wallets (user_id, balance, created_at, updated_at)
VALUES ((SELECT id FROM users WHERE email = 'viewer1@test.com'), 100000, NOW(), NOW());

INSERT INTO users (username, email, password_hash, date_of_birth, role, created_at, updated_at)
VALUES ('teen_viewer', 'minor@test.com', '$2a$10$N9qo8uLOickgx2ZMRZoMye6IXWQ7J5U5JIx1Xz9EjY0bQhU7xq5.G',
  CURRENT_DATE - INTERVAL '15 years', 'user', NOW(), NOW());
INSERT INTO wallets (user_id, balance, created_at, updated_at)
VALUES ((SELECT id FROM users WHERE email = 'minor@test.com'), 50000, NOW(), NOW());

INSERT INTO users (username, email, password_hash, date_of_birth, role, created_at, updated_at)
VALUES ('boundary_user', 'boundary@test.com', '$2a$10$N9qo8uLOickgx2ZMRZoMye6IXWQ7J5U5JIx1Xz9EjY0bQhU7xq5.G',
  CURRENT_DATE - INTERVAL '18 years' + INTERVAL '1 day', 'user', NOW(), NOW());
INSERT INTO wallets (user_id, balance, created_at, updated_at)
VALUES ((SELECT id FROM users WHERE email = 'boundary@test.com'), 100000, NOW(), NOW());

INSERT INTO users (username, email, password_hash, date_of_birth, role, created_at, updated_at)
VALUES ('just18_user', 'just18@test.com', '$2a$10$N9qo8uLOickgx2ZMRZoMye6IXWQ7J5U5JIx1Xz9EjY0bQhU7xq5.G',
  CURRENT_DATE - INTERVAL '18 years', 'user', NOW(), NOW());
INSERT INTO wallets (user_id, balance, created_at, updated_at)
VALUES ((SELECT id FROM users WHERE email = 'just18@test.com'), 100000, NOW(), NOW());

INSERT INTO users (username, email, password_hash, date_of_birth, role, created_at, updated_at)
VALUES ('oauth_test', 'oauth@test.com', NULL, CURRENT_DATE - INTERVAL '33 years', 'user', NOW(), NOW());
INSERT INTO wallets (user_id, balance, created_at, updated_at)
VALUES ((SELECT id FROM users WHERE email = 'oauth@test.com'), 75000, NOW(), NOW());

INSERT INTO users (username, email, password_hash, date_of_birth, role, created_at, updated_at)
VALUES ('nodob_user', 'nodob@test.com', '$2a$10$N9qo8uLOickgx2ZMRZoMye6IXWQ7J5U5JIx1Xz9EjY0bQhU7xq5.G',
  NULL, 'user', NOW(), NOW());
INSERT INTO wallets (user_id, balance, created_at, updated_at)
VALUES ((SELECT id FROM users WHERE email = 'nodob@test.com'), 0, NOW(), NOW());

SELECT u.id, u.username, u.email, EXTRACT(YEAR FROM AGE(u.date_of_birth)) AS age,
       w.balance / 100 AS balance_naira
FROM users u LEFT JOIN wallets w ON u.id = w.user_id
WHERE u.email LIKE '%@test.com' ORDER BY u.id;

\echo '✅ 8 test users created! Password: Test1234!'
