# Test Environments Documentation

**Project:** LetsWatchOut QA Portfolio  
**Document Version:** 1.0  
**Date:** April 14, 2026  
**Last Updated:** April 14, 2026

---

## Table of Contents

1. [Environment Overview](#1-environment-overview)
2. [Development Environment](#2-development-environment)
3. [Staging Environment](#3-staging-environment)
4. [Production Environment](#4-production-environment)
5. [Test Data Management](#5-test-data-management)
6. [Environment Access](#6-environment-access)
7. [Database Configuration](#7-database-configuration)
8. [Third-Party Services](#8-third-party-services)
9. [Environment Refresh Schedule](#9-environment-refresh-schedule)

---

## 1. Environment Overview

### 1.1 Environment Purpose

| Environment | Purpose | Audience | Stability |
|------------|---------|----------|-----------|
| **Development** | Daily testing, bug reproduction | QA + Developers | Unstable (frequent changes) |
| **Staging** | Pre-production validation, client demos | QA + Stakeholders | Stable (weekly deploys) |
| **Production** | Live user traffic | Public | Very stable (controlled releases) |

### 1.2 Environment Parity

**Goal:** Staging mirrors production as closely as possible.

| Component | Development | Staging | Production |
|-----------|-------------|---------|------------|
| Frontend | Vite dev server | Vercel build | Vercel build |
| Backend | localhost:8080 | Vercel serverless | Vercel serverless |
| Database | PostgreSQL (local) | Supabase free tier | Supabase Pro |
| WebSocket | Local server | Cloud-hosted | Cloud-hosted |
| File Storage | Local disk | Vercel Blob | Vercel Blob |
| Payment | Paystack test mode | Paystack test mode | Paystack live mode |

---

## 2. Development Environment

### 2.1 Access Information

| Component | URL/Endpoint | Port |
|-----------|--------------|------|
| Frontend | http://localhost:5173 | 5173 |
| Backend API | http://localhost:8080 | 8080 |
| Database | localhost | 5432 |
| WebSocket | ws://localhost:8080 | 8080 |

### 2.2 System Requirements

**Operating System:** WSL Ubuntu 22.04  
**Node.js:** v18.x or higher  
**Go:** v1.21 or higher  
**PostgreSQL:** v14.x  
**npm:** v9.x or higher

### 2.3 Environment Setup

#### Frontend Setup
```bash
cd /home/chibuzor_dev/WeWatch/frontend
npm install
npm run dev
# Runs on http://localhost:5173
```

#### Backend Setup
```bash
cd /home/chibuzor_dev/WeWatch/backend
go run cmd/server/main.go
# Runs on http://localhost:8080
```

#### Database Setup
```bash
psql -h localhost -p 5432 -U postgres -d wewatch_db
# Password: (local development password)
```

### 2.4 Environment Variables (.env)

**Backend (.env):**
```env
# Database
DB_HOST=localhost
DB_PORT=5432
DB_USER=postgres
DB_PASSWORD=your_password
DB_NAME=wewatch_db

# JWT
JWT_SECRET=your_jwt_secret_key_min_32_chars

# Google OAuth
GOOGLE_CLIENT_ID=your_google_client_id_here
GOOGLE_CLIENT_SECRET=your_google_client_secret_here
GOOGLE_REDIRECT_URL=http://localhost:8080/api/auth/google/callback

# Paystack (Test Mode)
PAYSTACK_SECRET_KEY=sk_test_xxxxxxxxxxxxxxxxxxxxxx
PAYSTACK_PUBLIC_KEY=pk_test_xxxxxxxxxxxxxxxxxxxxxx

# Frontend URL
FRONTEND_URL=http://localhost:5173

# LiveKit
LIVEKIT_API_KEY=dev-key
LIVEKIT_API_SECRET=a77cf9f63f8e47f9fdd9d1550e129731
LIVEKIT_WS_URL=ws://localhost:7880
```

**Frontend (.env):**
```env
VITE_API_URL=http://localhost:8080
VITE_WS_URL=ws://localhost:8080
VITE_PAYSTACK_PUBLIC_KEY=pk_test_xxxxxxxxxxxxxxxxxxxxxx
```

### 2.5 Database Schema

**Key Tables:**
- `users` - User accounts (OAuth + manual)
- `rooms` - Watch rooms
- `watch_sessions` - Active/ended sessions
- `donations` - Gift transactions
- `wallets` - Token balances
- `friendships` - Social connections
- `lobby_chats` - 1-on-1 messages

**Schema Version:** See migrations in `backend/migrations/`

### 2.6 Test Data (Development)

#### Test Users

| ID | Username | Email | Password | Role | Tokens | Purpose |
|----|----------|-------|----------|------|--------|---------|
| 1 | test_host | host@test.com | Test123! | Host | 5000 | Session creator |
| 2 | test_viewer1 | viewer1@test.com | Test123! | Viewer | 1000 | Session participant |
| 3 | test_viewer2 | viewer2@test.com | Test123! | Viewer | 1000 | Multi-user tests |
| 10 | oauth_test | eliezerconstructions@gmail.com | (OAuth) | Viewer | 0 | Google OAuth testing |

**Note:** All passwords are hashed in database using bcrypt.

#### Test Sessions

| ID | Title | Type | Pricing | Rating | Host ID | Status |
|----|-------|------|---------|--------|---------|--------|
| 1 | Movie Night Free | Instant Watch | Free | PG | 1 | Active |
| 2 | Paid Session Test | Instant Watch | ₦500 | 18+ | 1 | Active |
| 3 | Lecture Hall Test | Classroom | Free | G | 1 | Active |

#### Test Media Files

Located in `backend/uploads/`:

| File | Size | Format | Purpose |
|------|------|--------|---------|
| small_test_video.mp4 | 5MB | MP4 | Quick upload test |
| medium_test_video.mp4 | 50MB | MP4 | Chunked upload test |
| large_test_video.mp4 | 200MB | MP4 | Resume test |
| poster_test.jpg | 500KB | JPEG | Thumbnail test |

### 2.7 Development Workflow

**Daily Testing Routine:**
1. Start backend server (`go run cmd/server/main.go`)
2. Start frontend dev server (`npm run dev`)
3. Access http://localhost:5173
4. Run test cases
5. Document bugs in QA repo

**Database Reset (if needed):**
```bash
# Backup current state
pg_dump -h localhost -U postgres wewatch_db > backup_$(date +%Y%m%d).sql

# Reset to clean state
psql -h localhost -U postgres -c "DROP DATABASE wewatch_db;"
psql -h localhost -U postgres -c "CREATE DATABASE wewatch_db;"
psql -h localhost -U postgres -d wewatch_db -f migrations/schema.sql
psql -h localhost -U postgres -d wewatch_db -f test-data/seed.sql
```

---

## 3. Staging Environment

### 3.1 Access Information

| Component | URL/Endpoint |
|-----------|--------------|
| Frontend | https://letswatchout-staging.vercel.app |
| Backend API | https://letswatchout-staging.vercel.app/api |
| Database | Supabase free tier (postgres://...) |
| WebSocket | wss://letswatchout-staging.vercel.app/ws |

**Status:** 🟡 Planned (not yet deployed)

### 3.2 Deployment Process

**Platform:** Vercel  
**Trigger:** Manual deploy from `staging` branch  
**Build Command:** `npm run build`  
**Output Directory:** `dist/`

**Deployment Steps:**
1. Merge tested code to `staging` branch
2. Push to GitHub: `git push origin staging`
3. Vercel auto-deploys (or manual trigger)
4. Run smoke tests on staging URL
5. Notify stakeholders for testing

### 3.3 Environment Variables (Staging)

**Vercel Environment Variables:**
```env
# Database
DATABASE_URL=postgresql://postgres:[password]@[host].supabase.co:5432/postgres

# OAuth (Same as dev for testing)
GOOGLE_CLIENT_ID=your_google_client_id_here
GOOGLE_CLIENT_SECRET=your_google_client_secret_here
GOOGLE_REDIRECT_URL=https://letswatchout-staging.vercel.app/api/auth/google/callback

# Paystack (Test Mode)
PAYSTACK_SECRET_KEY=sk_test_xxxxxxxxxxxxxxxxxxxxxx
PAYSTACK_PUBLIC_KEY=pk_test_xxxxxxxxxxxxxxxxxxxxxx

# Frontend URL
FRONTEND_URL=https://letswatchout-staging.vercel.app
```

### 3.4 Staging Test Data

**Strategy:** Clone subset of production-like data monthly.

**Test Users (Staging):**
- staging_host@test.com (Test123!)
- staging_viewer1@test.com (Test123!)
- staging_viewer2@test.com (Test123!)

**Data Refresh:** Weekly (Sundays 00:00 UTC)

### 3.5 Staging Limitations

- ⚠️ **Free Tier Constraints:**
  - Database: 500MB storage limit
  - Bandwidth: Limited to Supabase free tier
  - Concurrent connections: 100 max

- ⚠️ **Test Mode Only:**
  - Paystack test keys (no real payments)
  - Google OAuth test users only

---

## 4. Production Environment

### 4.1 Access Information

| Component | URL/Endpoint |
|-----------|--------------|
| Frontend | https://letswatchout.com |
| Backend API | https://letswatchout.com/api |
| Database | Supabase Pro (postgres://...) |
| WebSocket | wss://letswatchout.com/ws |

**Status:** 🔴 Not yet deployed (planned for post-QA)

### 4.2 Deployment Process

**Platform:** Vercel  
**Trigger:** Manual deploy from `main` branch after QA sign-off  
**Build Command:** `npm run build`  
**CDN:** Vercel Edge Network (global)

**Go-Live Checklist:**
- [ ] All Phase 1-5 QA complete
- [ ] 95%+ test pass rate
- [ ] No critical/high bugs open
- [ ] Performance benchmarks met
- [ ] Security audit passed
- [ ] Paystack live mode configured
- [ ] Domain DNS configured
- [ ] SSL certificate active
- [ ] Monitoring enabled
- [ ] Backup strategy in place

### 4.3 Environment Variables (Production)

```env
# Database (Supabase Pro)
DATABASE_URL=postgresql://postgres:[password]@[host].supabase.co:5432/postgres

# OAuth (Production)
GOOGLE_CLIENT_ID=your_google_client_id_here
GOOGLE_CLIENT_SECRET=GOCSPX-[production_secret]
GOOGLE_REDIRECT_URL=https://letswatchout.com/api/auth/google/callback

# Paystack (Live Mode)
PAYSTACK_SECRET_KEY=sk_live_xxxxxxxxxxxxxxxxxxxxxx
PAYSTACK_PUBLIC_KEY=pk_live_xxxxxxxxxxxxxxxxxxxxxx

# Frontend URL
FRONTEND_URL=https://letswatchout.com

# Monitoring
SENTRY_DSN=https://[key]@sentry.io/[project]
```

### 4.4 Production Monitoring

**Metrics Tracked:**
- Uptime (target: 99.9%)
- Response time (target: < 2s)
- Error rate (target: < 1%)
- WebSocket connection stability
- Database query performance

**Tools:**
- Vercel Analytics (built-in)
- Supabase Dashboard
- Custom logging (backend)

---

## 5. Test Data Management

### 5.1 Test Data Strategy

**Principles:**
1. **Isolation:** Test data separate from production
2. **Realism:** Data mimics real user behavior
3. **Privacy:** No real user data in testing
4. **Versioning:** Test data versioned in Git (SQL scripts)

### 5.2 Test User Accounts

#### Standard Test Users

**Host Account:**
```
Username: test_host
Email: host@test.com
Password: Test123!
Role: Host
Tokens: 5000 (₦5000)
Purpose: Create sessions, receive gifts
```

**Viewer Accounts:**
```
Username: test_viewer1
Email: viewer1@test.com
Password: Test123!
Role: Viewer
Tokens: 1000 (₦1000)
Purpose: Join sessions, send gifts
---
Username: test_viewer2
Email: viewer2@test.com
Password: Test123!
Role: Viewer
Tokens: 1000 (₦1000)
Purpose: Multi-user scenarios
```

**OAuth Test User:**
```
Email: eliezerconstructions@gmail.com
Auth: Google OAuth
Tokens: 0
Purpose: OAuth flow testing
```

**Payment Test User:**
```
Username: test_payment
Email: payment@test.com
Password: Test123!
Tokens: 0
Purpose: Paystack integration testing
```

### 5.3 Test Sessions

**Session Templates:**

| Template | Type | Pricing | Rating | Capacity | Purpose |
|----------|------|---------|--------|----------|---------|
| Free Movie | Instant Watch | Free | PG | Unlimited | Basic flow |
| Paid Event | Instant Watch | ₦500 | 18+ | 50 | Payment testing |
| Lecture Hall | Classroom | Free | G | 145 | Classroom testing |
| 3D Cinema | Instant Watch | ₦1000 | 13+ | 30 | 3D environment |

**SQL Seed Script:**
```sql
-- Located in test-data/seed_sessions.sql
INSERT INTO rooms (title, watch_type, class_type, pricing_type, price, content_rating, capacity, host_id)
VALUES 
  ('Movie Night Free', 'instant_watch', 'movie_night', 'free', 0, 'PG', 0, 1),
  ('Paid Session ₦500', 'instant_watch', 'watch_party', 'paid', 500, '18+', 50, 1),
  ('Lecture Hall Test', 'classroom', 'lecture_hall', 'free', 0, 'G', 145, 1);
```

### 5.4 Test Media Files

**File Preparation:**
```bash
# Create test media directory
mkdir -p test-data/media

# Small video (5MB) - Quick tests
ffmpeg -i source.mp4 -t 30 -vf scale=640:360 -b:v 1M small_test_video.mp4

# Medium video (50MB) - Chunked upload
ffmpeg -i source.mp4 -t 300 -vf scale=1280:720 -b:v 2M medium_test_video.mp4

# Large video (200MB) - Resume testing
ffmpeg -i source.mp4 -t 1200 -vf scale=1920:1080 -b:v 4M large_test_video.mp4
```

**Test File Inventory:**

| File | Size | Duration | Resolution | Purpose |
|------|------|----------|------------|---------|
| small_test_video.mp4 | 5MB | 30s | 640x360 | Quick upload validation |
| medium_test_video.mp4 | 50MB | 5min | 1280x720 | Chunked upload test |
| large_test_video.mp4 | 200MB | 20min | 1920x1080 | Resume functionality |
| invalid_file.txt | 1KB | N/A | N/A | Validation error test |
| corrupt_video.mp4 | 10MB | N/A | N/A | Error handling test |

### 5.5 Paystack Test Cards

**Credit Card (Success):**
```
Card Number: 4084 0840 8408 4081
Expiry: 12/25
CVV: 408
PIN: 0000
OTP: 123456
```

**Debit Card (Success):**
```
Card Number: 5060 6666 6666 6666 666
Expiry: 12/25
CVV: 123
PIN: 1234
```

**Card (Insufficient Funds):**
```
Card Number: 5060 6666 6666 6666 666
Expiry: 12/25
CVV: 123
PIN: 9999
```

**Card (Transaction Declined):**
```
Card Number: 5060 6666 6666 6666 666
Expiry: 12/25
CVV: 123
PIN: 5555
```

---

## 6. Environment Access

### 6.1 Access Control

| Environment | Access Level | Authentication |
|------------|--------------|----------------|
| Development | Full access (local machine) | None (localhost) |
| Staging | QA + Stakeholders | Test user accounts |
| Production | Public | User registration required |

### 6.2 Credentials Management

**Storage:** Environment variables (never committed to Git)

**Development Credentials:**
- Stored in: `backend/.env` and `frontend/.env`
- Git-ignored: ✅ Yes (in .gitignore)
- Shared via: Secure note (not in repository)

**Staging Credentials:**
- Stored in: Vercel dashboard (Environment Variables)
- Access: Chibuzor only (admin)

**Production Credentials:**
- Stored in: Vercel dashboard (Production environment)
- Access: Chibuzor only (admin)
- Rotation: Every 90 days

### 6.3 Database Access

**Development:**
```bash
psql -h localhost -p 5432 -U postgres -d wewatch_db
# Password: (local password)
```

**Staging:**
```bash
psql postgresql://postgres:[password]@[staging-host].supabase.co:5432/postgres
# Or use Supabase dashboard SQL editor
```

**Production:**
```bash
# Read-only access for debugging:
psql postgresql://postgres:[password]@[prod-host].supabase.co:5432/postgres -c "SELECT ..."
# Write access: Emergency only, logged
```

---

## 7. Database Configuration

### 7.1 Database Versions

| Environment | DBMS | Version | Storage | Connections |
|------------|------|---------|---------|-------------|
| Development | PostgreSQL | 14.x | Unlimited (local) | Unlimited |
| Staging | PostgreSQL (Supabase) | 14.x | 500MB | 100 |
| Production | PostgreSQL (Supabase) | 14.x | 8GB+ | 500 |

### 7.2 Schema Management

**Migrations:**
- Location: `backend/migrations/`
- Format: `YYYYMMDD_description.sql`
- Execution: Manual (psql) or automated (future: Flyway/Liquibase)

**Current Migrations:**
```
20260413000001_add_oauth_fields_to_users.sql
20260414000001_add_content_rating_to_rooms.sql
(more migrations as features added)
```

**Migration Workflow:**
1. Create migration file in `backend/migrations/`
2. Test on development DB
3. Apply to staging DB
4. Verify no errors
5. Apply to production DB (with backup first)

### 7.3 Backup Strategy

**Development:**
- Frequency: Weekly (Sundays)
- Method: `pg_dump`
- Storage: Local disk
- Retention: Last 4 weeks

**Staging:**
- Frequency: Daily (automated by Supabase)
- Retention: 7 days
- Point-in-time recovery: Not enabled (free tier)

**Production:**
- Frequency: Hourly (automated by Supabase Pro)
- Retention: 30 days
- Point-in-time recovery: Enabled
- Disaster recovery: Cross-region backups

---

## 8. Third-Party Services

### 8.1 Google OAuth

**Environment:** All (Dev, Staging, Prod)

**Configuration:**
- Project: "LetsWatchOut Production"
- Client ID: 526275259003-ftpjobfsfe3de8ltv4l0iaoet1livj4t.apps.googleusercontent.com
- Redirect URLs:
  - Dev: http://localhost:8080/api/auth/google/callback
  - Staging: https://letswatchout-staging.vercel.app/api/auth/google/callback
  - Prod: https://letswatchout.com/api/auth/google/callback

### 8.2 Paystack Payment Gateway

**Test Mode (Dev + Staging):**
- Secret Key: sk_test_xxxx
- Public Key: pk_test_xxxx
- Test Cards: See section 5.5
- Webhooks: Configured for test environment

**Live Mode (Production):**
- Secret Key: sk_live_xxxx
- Public Key: pk_live_xxxx
- Webhooks: https://letswatchout.com/api/payments/webhook
- Settlement: Bank account verified

### 8.3 LiveKit (Audio/Video)

**Development:**
- API Key: dev-key
- API Secret: a77cf9f63f8e47f9fdd9d1550e129731
- WS URL: ws://localhost:7880
- Mode: Local server

**Staging:**
- Cloud-hosted LiveKit instance
- Dedicated test room

**Production:**
- Cloud-hosted LiveKit instance
- Scalable infrastructure

### 8.4 Vercel (Hosting)

**Account:** Chibuzor's Vercel account  
**Projects:**
- letswatchout (production)
- letswatchout-staging (staging)

**Features Used:**
- Edge Network (CDN)
- Serverless Functions
- Environment Variables
- Analytics
- Vercel Blob (file storage)

---

## 9. Environment Refresh Schedule

### 9.1 Development Environment

**Database Reset:** Weekly (Sundays 00:00)
```bash
# Automated script: reset_dev_db.sh
psql -h localhost -U postgres -c "DROP DATABASE wewatch_db;"
psql -h localhost -U postgres -c "CREATE DATABASE wewatch_db;"
psql -h localhost -U postgres -d wewatch_db -f migrations/schema.sql
psql -h localhost -U postgres -d wewatch_db -f test-data/seed.sql
```

**Media Cleanup:** Monthly (1st of month)
```bash
# Clean old uploads
rm -rf backend/uploads/liveshare/*
rm -rf backend/uploads/chunks/*
# Keep test media files
```

### 9.2 Staging Environment

**Data Refresh:** Weekly (Sundays 03:00 UTC)
- Drop all test sessions
- Reset user token balances
- Clear lobby chats
- Keep user accounts

**Code Deployment:** On-demand (after dev testing)

### 9.3 Production Environment

**No automatic resets** - live user data preserved

**Maintenance Windows:**
- Preferred: Sundays 02:00-04:00 UTC (lowest traffic)
- Notifications: 48 hours advance notice
- Rollback plan: Always prepared

---

## 10. Environment Comparison Matrix

| Feature | Development | Staging | Production |
|---------|------------|---------|------------|
| **URL** | localhost:5173 | vercel-staging.app | letswatchout.com |
| **Database** | PostgreSQL (local) | Supabase (free) | Supabase (pro) |
| **OAuth** | Test credentials | Test credentials | Live credentials |
| **Payments** | Paystack test | Paystack test | Paystack live |
| **HTTPS** | No | Yes | Yes |
| **CDN** | No | Yes (Vercel) | Yes (Vercel) |
| **Monitoring** | Console logs | Basic | Full (Sentry) |
| **Backups** | Weekly manual | Daily auto | Hourly auto |
| **Uptime SLA** | N/A | N/A | 99.9% target |
| **Data Retention** | 30 days | 7 days | Indefinite |
| **Performance** | Not optimized | Optimized | Optimized |
| **Test Data** | Yes | Yes | No (real users) |

---

## 11. Troubleshooting

### 11.1 Common Issues

**Issue:** Backend won't start - "database connection failed"
```bash
# Solution: Check PostgreSQL is running
sudo service postgresql status
sudo service postgresql start

# Verify connection
psql -h localhost -U postgres -c "SELECT 1;"
```

**Issue:** Frontend can't reach backend - CORS error
```bash
# Solution: Check backend .env has correct FRONTEND_URL
FRONTEND_URL=http://localhost:5173

# Restart backend after changing .env
```

**Issue:** WebSocket connection fails
```bash
# Solution: Check firewall allows port 8080
sudo ufw allow 8080

# Test WebSocket directly
wscat -c ws://localhost:8080/ws
```

### 11.2 Environment Health Check

**Quick Health Check Script:**
```bash
#!/bin/bash
# health_check.sh

echo "🔍 Checking Development Environment..."

# Backend
curl -s http://localhost:8080/health && echo "✅ Backend OK" || echo "❌ Backend DOWN"

# Frontend
curl -s http://localhost:5173 && echo "✅ Frontend OK" || echo "❌ Frontend DOWN"

# Database
psql -h localhost -U postgres -d wewatch_db -c "SELECT 1;" > /dev/null 2>&1 && echo "✅ Database OK" || echo "❌ Database DOWN"

# WebSocket
# (requires wscat: npm install -g wscat)
timeout 3 wscat -c ws://localhost:8080/ws > /dev/null 2>&1 && echo "✅ WebSocket OK" || echo "❌ WebSocket DOWN"
```

---

## 12. Document Maintenance

**Review Schedule:** Weekly (during Phase 1-2)  
**Update Trigger:** New environment added, credentials changed, URLs updated  
**Owner:** Chibuzor  
**Last Reviewed:** April 14, 2026

---

**End of Test Environments Documentation**

**Next Steps:**
1. Set up staging environment on Vercel
2. Configure Supabase database for staging
3. Create test user accounts in all environments
4. Prepare test media files
5. Verify Google OAuth works in each environment
