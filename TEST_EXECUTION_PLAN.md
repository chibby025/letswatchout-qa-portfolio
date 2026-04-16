# QA Test Execution Plan - Critical Test Cases
**Duration**: 4-5 hours  
**Date**: April 16-17, 2026  
**Test Environment**: Local (Backend: localhost:8080, Frontend: localhost:5173)  
**Results Tracking**: [Live Google Sheet →](https://docs.google.com/spreadsheets/d/1UDOUsL0Bw4InIDWBqyp0bXTFBXhOsYKW1XW6iA_1004/edit?usp=sharing)

---

## Test Execution Checklist

### Pre-Execution Setup
- [ ] Backend running (`cd ~/WeWatch/backend && ./main`)
- [ ] Frontend running (`cd ~/WeWatch/frontend && npm run dev`)
- [ ] PostgreSQL running (`sudo service postgresql status`)
- [ ] Google Sheets open for live updates
- [ ] Screenshot tool ready (Flameshot/Snipping Tool)

---

## Critical Test Cases (35 Total)

### 🔐 Authentication (7 test cases)

#### TC-AUTH-001: Manual Registration
**Steps:**
1. Navigate to http://localhost:5173/register
2. Enter email: `testuser1@example.com`, password: `Test1234!`, username: `testuser1`
3. Submit form
4. Verify redirect to lobby

**Expected:** User created, logged in, session started  
**Google Sheet Column:** A2 (Test Case ID: TC-AUTH-001)

---

#### TC-AUTH-002: Manual Login (Existing User)
**Steps:**
1. Navigate to http://localhost:5173/login
2. Enter credentials from TC-AUTH-001
3. Submit form

**Expected:** Logged in, redirected to lobby, user data loads  
**Google Sheet Column:** A3

---

#### TC-AUTH-003: Invalid Login
**Steps:**
1. Navigate to /login
2. Enter email: `testuser1@example.com`, password: `WrongPassword123`
3. Submit

**Expected:** Error message "Invalid credentials", not logged in  
**Google Sheet Column:** A4

---

#### TC-AUTH-004: Logout
**Steps:**
1. Login as testuser1
2. Click logout button
3. Attempt to access /lobby

**Expected:** Logged out, session cleared, redirected to login  
**Google Sheet Column:** A5

---

#### TC-AUTH-005: Token Expiration (Manual)
**Steps:**
1. Login successfully
2. In DevTools → Application → Cookies, delete `token` cookie
3. Refresh page
4. Attempt protected action

**Expected:** Redirected to login, session cleared  
**Google Sheet Column:** A6

---

#### TC-AUTH-006: Google OAuth Login (Manual Test)
**Steps:**
1. Click "Continue with Google" on login page
2. Approve Google consent screen
3. Return to app

**Expected:** Logged in, profile synced (name, email, avatar)  
**Google Sheet Column:** A7  
**Note:** Requires Google OAuth setup, test manually if configured

---

#### TC-AUTH-007: Duplicate Email Registration
**Steps:**
1. Try registering with same email as TC-AUTH-001
2. Submit form

**Expected:** Error "Email already exists"  
**Google Sheet Column:** A8

---

### 💳 Payment System (6 test cases)

#### TC-PAY-001: Free Session Access
**Steps:**
1. Login as testuser1
2. Create free instant watch session
3. Join session immediately

**Expected:** No payment required, instant access  
**Google Sheet Column:** A9

---

#### TC-PAY-002: Paid Session Creation
**Steps:**
1. Login as testuser2
2. Create instant watch
3. Set price to ₦500
4. Create session

**Expected:** Session created with ticket requirement, payment modal available  
**Google Sheet Column:** A10

---

#### TC-PAY-003: Initialize Payment (If Paystack Configured)
**Steps:**
1. Select paid session from TC-PAY-002
2. Click "Buy Ticket"
3. Verify Paystack modal opens

**Expected:** Payment page loads with correct amount  
**Google Sheet Column:** A11  
**Note:** Requires Paystack setup, skip if not configured

---

#### TC-PAY-004: Payment Verification Endpoint (API Test)
**Steps:**
1. Use Postman or curl:
```bash
curl http://localhost:8080/api/payments/verify/test_reference
```
2. Check response structure

**Expected:** Returns payment status (success/failed/pending)  
**Google Sheet Column:** A12

---

#### TC-PAY-005: Host Can Join Own Paid Session
**Steps:**
1. Login as testuser2 (host from TC-PAY-002)
2. Join own paid session

**Expected:** No payment required, instant access as host  
**Google Sheet Column:** A13

---

#### TC-PAY-006: Payment Required for Non-Host
**Steps:**
1. Login as testuser3
2. Attempt to join paid session from TC-PAY-002 without payment
3. Check error response

**Expected:** Access denied, payment modal shown  
**Google Sheet Column:** A14

---

### 🎬 Session Management (8 test cases)

#### TC-SESSION-001: Create Free Instant Watch
**Steps:**
1. Login as testuser1
2. Click Create New button
3. Select "Instant Watch"
4. Enter title: "Test Movie Night", description: "Testing session creation"
5. Choose emoji: 🎬
6. Set pricing: Free
7. Click "Create Session"

**Expected:** Session created, redirected to VideoWatch.jsx, emoji icon shows  
**Google Sheet Column:** A15

---

#### TC-SESSION-002: Create 3D Cinema Session
**Steps:**
1. Login as testuser1
2. Create New → 3D Cinema
3. Enter title: "3D Movie Test"
4. Emoji: 🎥, Free
5. Create

**Expected:** Session created, redirected to CinemaScene3DDemo.jsx  
**Google Sheet Column:** A16

---

#### TC-SESSION-003: Create Lecture Hall
**Steps:**
1. Login as testuser1
2. Create New → Classroom
3. Title: "Test Lecture"
4. Emoji: 📚, Free
5. Create

**Expected:** Lecture hall created, redirected to LectureHallPage.jsx, 145 seats available  
**Google Sheet Column:** A17

---

#### TC-SESSION-004: Content Rating Selection
**Steps:**
1. Start creating session
2. Select "18+" content rating
3. Create session
4. Check database: `SELECT content_rating FROM watch_sessions WHERE id = [session_id];`

**Expected:** Rating stored correctly, badge displays with red neon glow  
**Google Sheet Column:** A18

---

#### TC-SESSION-005: End Session (Host)
**Steps:**
1. Login as host (testuser1)
2. Join session from TC-SESSION-001
3. Click "End Session" button
4. Confirm
5. Check lobby for session removal

**Expected:** Session ends, removed from lobby immediately, no spinner  
**Google Sheet Column:** A19

---

#### TC-SESSION-006: Session Visibility in Lobby
**Steps:**
1. Create session as testuser1
2. Login as testuser2
3. Go to "Watching Now" tab in lobby

**Expected:** New session appears in list without refresh  
**Google Sheet Column:** A20

---

#### TC-SESSION-007: Join Session as Participant
**Steps:**
1. Login as testuser2
2. Click on session created by testuser1
3. Verify join successful

**Expected:** Joined session, can see media/chat, no host controls  
**Google Sheet Column:** A21

---

#### TC-SESSION-008: Host Detection
**Steps:**
1. Login as testuser1 (host)
2. Join own session
3. Check for host controls (upload, end session buttons)

**Expected:** Host controls visible only to host  
**Google Sheet Column:** A22

---

### 📤 Media Upload (6 test cases)

#### TC-UPLOAD-001: Small Video Upload (10MB)
**Steps:**
1. Login as testuser1
2. Join session as host
3. Select 10MB MP4 video
4. Upload
5. Monitor progress bar

**Expected:** Upload completes, poster generated immediately, MP4 preview ready  
**Google Sheet Column:** A23  
**Test Data:** Prepare 10MB sample.mp4 in ~/WeWatch/test-data/

---

#### TC-UPLOAD-002: Image Upload
**Steps:**
1. As host, select JPG/PNG image
2. Upload
3. Verify preview

**Expected:** Image uploads successfully, displays in session  
**Google Sheet Column:** A24

---

#### TC-UPLOAD-003: Invalid File Type
**Steps:**
1. As host, select .txt or .exe file
2. Attempt upload

**Expected:** Error: "Invalid file type. Please select video/image"  
**Google Sheet Column:** A25

---

#### TC-UPLOAD-004: File Size Limit (Over 1GB)
**Steps:**
1. As host, select file > 1GB
2. Attempt upload

**Expected:** Error: "File exceeds 1GB limit"  
**Google Sheet Column:** A26  
**Note:** May skip if no large file available

---

#### TC-UPLOAD-005: Chunked Upload (100MB File)
**Steps:**
1. As host, select 100MB video
2. Upload
3. Monitor network tab for chunk requests
4. Verify sequential upload

**Expected:** File split into chunks, sequential upload, assembly on backend  
**Google Sheet Column:** A27  
**Test Data:** Prepare 100MB video.mp4

---

#### TC-UPLOAD-006: Poster Generation Broadcast
**Steps:**
1. Login as testuser1 (host), join session
2. Login as testuser2 (viewer), join same session
3. As testuser1, upload video
4. On testuser2 browser, watch for poster update (NO refresh)

**Expected:** Testuser2 sees poster appear via WebSocket broadcast  
**Google Sheet Column:** A28

---

### 🔴 Real-time Features (4 test cases)

#### TC-REALTIME-001: WebSocket Connection
**Steps:**
1. Login and navigate to lobby
2. Open DevTools → Network → WS tab
3. Monitor WebSocket connection

**Expected:** WebSocket connected, "lobby_connected" message received  
**Google Sheet Column:** A29

---

#### TC-REALTIME-002: Session Started Broadcast
**Steps:**
1. Login as testuser1, create session
2. Login as testuser2, stay on lobby
3. Verify new session appears on testuser2's lobby (no refresh)

**Expected:** Testuser2 sees new session via WebSocket broadcast  
**Google Sheet Column:** A30

---

#### TC-REALTIME-003: Session Ended Broadcast
**Steps:**
1. Testuser1 ends session
2. Testuser2 on lobby watches
3. Verify session removed from list (no refresh)

**Expected:** Session removed from testuser2's lobby immediately  
**Google Sheet Column:** A31

---

#### TC-REALTIME-004: Chat Message Broadcast
**Steps:**
1. Testuser1 and testuser2 join same session
2. Testuser1 sends chat: "Hello from user 1"
3. Verify testuser2 sees message

**Expected:** Message appears on testuser2's screen within 1 second  
**Google Sheet Column:** A32

---

### 🎥 Watch Experience (4 test cases)

#### TC-WATCH-001: 2D Video Playback
**Steps:**
1. Join VideoWatch.jsx session with uploaded video
2. Click play
3. Test controls (pause, seek, volume)

**Expected:** Video plays smoothly, controls responsive  
**Google Sheet Column:** A33

---

#### TC-WATCH-002: 3D Cinema Rendering
**Steps:**
1. Join 3D cinema session
2. Wait for scene load
3. Use WASD keys to navigate

**Expected:** 3D scene loads, seat positioning correct, camera smooth  
**Google Sheet Column:** A34

---

#### TC-WATCH-003: Lecture Hall Seat Selection
**Steps:**
1. Join lecture hall
2. Click empty seat
3. Verify occupation

**Expected:** Seat turns occupied, other users see update  
**Google Sheet Column:** A35

---

#### TC-WATCH-004: Like Functionality (Double-Click)
**Steps:**
1. Login as testuser2, join session
2. Double-click video/screen
3. Verify like animation
4. Check like count increases

**Expected:** Like registered, count updates, animation shows  
**Google Sheet Column:** A36

---

## Post-Execution Tasks

### 1. Update Google Sheets
For each test:
- Mark Status: Pass/Fail/Blocked
- Add Execution Date
- Record Actual Result
- Add Notes/Screenshots link if failed

### 2. Take Screenshots
- Failed test cases (show error messages)
- Critical features working (lobby, video playback, 3D cinema)
- Upload progress UI
- Payment modal (if Paystack configured)

Save to: `~/letswatchout-qa-portfolio/screenshots/`

### 3. Document Bugs Found
If any new bugs discovered:
- Create BUG-026.md, BUG-027.md, etc.
- Include: Description, Steps to Reproduce, Expected vs Actual, Root Cause
- Add to BUG_SUMMARY.md

### 4. Generate Test Summary Report
Create: `~/letswatchout-qa-portfolio/TEST_EXECUTION_SUMMARY.md`

Include:
```markdown
# Test Execution Summary - Critical Test Cases

**Execution Date**: April 16-17, 2026
**Test Environment**: Local Development
**Total Test Cases**: 35
**Executed**: X
**Passed**: X
**Failed**: X
**Blocked**: X
**Pass Rate**: X%

## Execution Breakdown

| Feature Area | Total | Passed | Failed | Pass Rate |
|--------------|-------|--------|--------|-----------|
| Authentication | 7 | X | X | X% |
| Payment System | 6 | X | X | X% |
| Session Management | 8 | X | X | X% |
| Media Upload | 6 | X | X | X% |
| Real-time Features | 4 | X | X | X% |
| Watch Experience | 4 | X | X | X% |

## Critical Findings
[List any bugs or issues found]

## Test Evidence
[Links to screenshots]

## Recommendations
[Next steps, areas needing improvement]
```

---

## Time Estimate

| Activity | Duration |
|----------|----------|
| Setup (start servers, prepare test data) | 15 mins |
| Authentication tests (7 cases) | 45 mins |
| Payment tests (6 cases) | 30 mins |
| Session management (8 cases) | 60 mins |
| Upload tests (6 cases) | 60 mins |
| Real-time tests (4 cases) | 30 mins |
| Watch experience (4 cases) | 30 mins |
| Update Google Sheets live | Continuous |
| Screenshots + documentation | 30 mins |
| **TOTAL** | **4-5 hours** |

---

## Success Criteria

- [ ] All 35 critical test cases executed
- [ ] Google Sheets updated with live results
- [ ] Pass rate ≥ 85% (30/35 cases pass)
- [ ] Screenshots captured for key features
- [ ] Any bugs documented in bugs/ folder
- [ ] Test summary report created
- [ ] Portfolio README updated with "Week 4 Complete"

---

**Next Step After QA Finalization:** Code cleanup (backend/frontend refactoring)
