# Test Case Examples - LetsWatchOut Platform

**Document Version**: 1.0  
**Author**: Chibuzor (QA Analyst)  
**Date**: April 15, 2026  
**Purpose**: Professional test case examples demonstrating senior-level QA skills

---

## Table of Contents
1. [TC-SESSION-001: Create Free PG-Rated Video Session](#tc-session-001)
2. [TC-CHAT-002: Chat Message Delivery After Network Reconnection](#tc-chat-002)
3. [TC-PAY-002: Insufficient Wallet Balance Validation](#tc-pay-002)
4. [Learning Notes: Common Mistakes to Avoid](#learning-notes)

---

## TC-SESSION-001: Create Free PG-Rated Video Session

**Test Case ID**: TC-SESSION-001  
**Feature Area**: Watch Session Creation  
**Test Design Technique**: Positive Testing (Happy Path)  
**Priority**: High  
**Automation Candidate**: Yes  

### Prerequisites
- [ ] Backend running on localhost:8080
- [ ] Frontend running on localhost:5173
- [ ] Test user exists: test_host@test.com (Password: Test1234!)
- [ ] Test video uploaded: test_pg_video.mp4
- [ ] Database accessible (PostgreSQL)

### Test Data
| Field | Value |
|-------|-------|
| Host User | test_host@test.com |
| Session Title | "Family Movie Night" |
| Description | "Free PG movie session" |
| Watch Type | Video Watch |
| Content Rating | PG |
| Ticket Price | ₦0 (Free) |
| Max Participants | 50 |
| Video File | test_pg_video.mp4 |

### Test Steps
| Step | Action | Expected Result |
|------|--------|----------------|
| 1 | Navigate to http://localhost:5173/login | Login page displays |
| 2 | Enter email: test_host@test.com, password: Test1234! | Credentials accepted |
| 3 | Click "Login" button | Redirected to dashboard |
| 4 | Click "Create Session" button | Create Session form loads |
| 5 | Enter session title: "Family Movie Night" | Text appears in title field |
| 6 | Click "Watch Type" dropdown, select "Video Watch" | "Video Watch" selected |
| 7 | Click "Content Rating" dropdown, select "PG" | "PG" selected |
| 8 | Leave ticket price at ₦0 (default) | Price shows "Free" |
| 9 | Click "Upload Video" button, select test_pg_video.mp4 | Upload progress shows 100% |
| 10 | Click "Create Session" button | Loading spinner appears |
| 11 | **[UI Check]** Verify session appears in "Watching Now" tab | Session card visible with title, "PG" badge, "Free" label |
| 12 | **[API Check]** GET http://localhost:8080/api/sessions | Response includes new session with correct data |
| 13 | **[Database Check]** `SELECT * FROM watch_sessions WHERE title = 'Family Movie Night'` | Row exists with: watch_type='video', content_rating='PG', is_active=true |

### Pass/Fail Criteria
**Pass**: 
- Session created successfully (UI shows confirmation)
- Session appears in "Watching Now" tab with correct details
- API returns session data with all required fields
- Database row created with correct values
- Host automatically joined as first participant

**Fail**: 
- Any step fails to produce expected result
- Session not visible in UI after creation
- API returns error or missing session
- Database missing row or has incorrect values
- Content rating not set to PG

### Notes
- This is a happy path test - assumes all inputs valid
- Tests grey box approach (UI + API + Database validation)
- Related test cases: TC-SESSION-002 (paid session), TC-SESSION-003 (18+ session)
- Regression risk: HIGH (core feature)
- **Interview Talking Point**: "I validate at 3 layers - UI for user experience, API for integration, database for data integrity"

---

## TC-CHAT-002: Chat Message Delivery After Network Reconnection

**Test Case ID**: TC-CHAT-002  
**Feature Area**: Real-Time Chat  
**Test Design Technique**: Error Recovery Testing  
**Priority**: High  
**Automation Candidate**: Partial (manual for network simulation)  

### Prerequisites
- [ ] Active session exists (session_id: from TC-SESSION-001)
- [ ] Two users logged in: viewer1@test.com, viewer2@test.com
- [ ] Both users joined same session
- [ ] Chrome DevTools available (for network simulation)
- [ ] WebSocket connection established (check Network tab for ws:// connection)

### Test Data
| Field | Value |
|-------|-------|
| Test User | viewer1@test.com (Password: Test1234!) |
| Observer User | viewer2@test.com (watches messages arrive) |
| Session ID | session_id from TC-SESSION-001 |
| Test Messages | "Message 1", "Message 2" (offline), "Message 3" (reconnected) |

### Test Steps
| Step | Action | Expected Result |
|------|--------|----------------|
| 1 | Open session as viewer1 in Chrome | Chat panel visible, WebSocket connected (green indicator) |
| 2 | Type "Message 1" in chat, press Enter | Message appears instantly with timestamp, viewer2 sees it |
| 3 | Open Chrome DevTools (F12), go to Network tab | DevTools opens, Network tab active |
| 4 | Check "Offline" checkbox in Network tab | Browser goes offline, WebSocket disconnected (red indicator) |
| 5 | Type "Message 2" in chat, press Enter | Message shows "Sending..." status, NOT sent to server |
| 6 | **[Browser Check]** DevTools → Application → Local Storage | "Message 2" stored in queue (key: pendingMessages) |
| 7 | Wait 5 seconds (remain offline) | Message still shows "Sending...", no error shown |
| 8 | Uncheck "Offline" checkbox in Network tab | Browser reconnects, WebSocket reconnects (green indicator) |
| 9 | **[Auto-Send Check]** Observe chat panel | "Message 2" status changes to "Sent", appears with timestamp |
| 10 | **[Viewer2 Check]** Check viewer2's screen | "Message 2" appears in correct order (after "Message 1") |
| 11 | Type "Message 3" in chat, press Enter | Message appears instantly for both users |
| 12 | **[Order Check]** Verify message sequence | Messages: "Message 1" → "Message 2" → "Message 3" |
| 13 | **[Database Check]** `SELECT * FROM chat_messages WHERE session_id = 'xxx' ORDER BY created_at` | All 3 messages exist with correct timestamps |

### Pass/Fail Criteria
**Pass**: 
- Messages sent while connected appear instantly
- Offline message queued locally (visible in LocalStorage)
- Reconnection triggers auto-send of queued messages
- Message order preserved (1 → 2 → 3)
- Both users see identical message order
- Database records all 3 messages with correct sequence

**Fail**: 
- Offline message lost (not queued)
- Message order scrambled (2 appears before 1)
- Reconnection doesn't trigger auto-send
- Error message shown to user
- Database missing messages or wrong order

### Notes
- Simulates common mobile user scenario (subway tunnel, elevator)
- WebSocket reconnection logic critical for UX
- Related: TC-CHAT-003 (multiple offline messages), TC-CHAT-004 (timeout handling)
- **Interview Talking Point**: "This tests resilience - users shouldn't lose messages due to temporary network issues. I simulate real-world failures like network drops."

---

## TC-PAY-002: Insufficient Wallet Balance Validation

**Test Case ID**: TC-PAY-002  
**Feature Area**: Ticket Purchase  
**Test Design Technique**: Boundary Value Analysis  
**Priority**: High  
**Automation Candidate**: Yes  

### Prerequisites
- [ ] Backend running on localhost:8080
- [ ] Frontend running on localhost:5173
- [ ] Test user exists: viewer1@test.com (Password: Test1234!)
- [ ] Active session exists with ticket price ₦500
- [ ] Database accessible

### Test Data (Multiple Scenarios)
| Scenario | User Wallet Balance | Ticket Price | Expected Outcome |
|----------|---------------------|--------------|------------------|
| Below Boundary | ₦499 | ₦500 | Purchase blocked, error shown |
| Exact Boundary | ₦500 | ₦500 | Purchase succeeds, balance = ₦0 |
| Above Boundary | ₦501 | ₦500 | Purchase succeeds, balance = ₦1 |

### Test Steps - Scenario 1: Below Boundary (₦499)
| Step | Action | Expected Result |
|------|--------|----------------|
| 1 | **[Database Setup]** `UPDATE wallets SET balance = 49900 WHERE user_id = (SELECT id FROM users WHERE email = 'viewer1@test.com')` | Wallet set to ₦499 |
| 2 | Login as viewer1@test.com | Dashboard displays |
| 3 | Navigate to "Watching Now" tab | Active sessions list displayed |
| 4 | Click session card with ₦500 ticket | Session details modal opens |
| 5 | Click "Purchase Ticket" button | Error message: "Insufficient balance. You have ₦499, ticket costs ₦500" |
| 6 | **[UI Check]** Verify "Purchase Ticket" button disabled | Button greyed out, not clickable |
| 7 | **[API Check]** POST /api/tickets/purchase (if attempted) | Returns 400 Bad Request with error message |
| 8 | **[Database Check]** `SELECT balance FROM wallets WHERE user_id = ...` | Balance still ₦499 (unchanged) |

### Test Steps - Scenario 2: Exact Boundary (₦500)
| Step | Action | Expected Result |
|------|--------|----------------|
| 1 | **[Database Setup]** `UPDATE wallets SET balance = 50000 WHERE user_id = ...` | Wallet set to ₦500 |
| 2 | Login as viewer1@test.com | Dashboard displays |
| 3 | Navigate to session, click "Purchase Ticket" | Confirmation dialog: "Purchase ticket for ₦500?" |
| 4 | Click "Confirm" | Success message: "Ticket purchased! Joining session..." |
| 5 | **[UI Check]** Verify redirected to session room | Video player loads, chat panel visible |
| 6 | **[Database Check]** `SELECT balance FROM wallets WHERE user_id = ...` | Balance now ₦0 (500 - 500) |
| 7 | **[Database Check]** `SELECT * FROM session_members WHERE user_id = ...` | User added to session_members table |

### Test Steps - Scenario 3: Above Boundary (₦501)
| Step | Action | Expected Result |
|------|--------|----------------|
| 1 | **[Database Setup]** `UPDATE wallets SET balance = 50100 WHERE user_id = ...` | Wallet set to ₦501 |
| 2 | Follow steps 2-4 from Scenario 2 | Ticket purchased successfully |
| 3 | **[Database Check]** `SELECT balance FROM wallets WHERE user_id = ...` | Balance now ₦1 (501 - 500) |

### Pass/Fail Criteria
**Pass**: 
- ₦499: Purchase blocked with clear error message
- ₦500: Purchase succeeds, balance = ₦0, user joins session
- ₦501: Purchase succeeds, balance = ₦1, user joins session
- All database transactions atomic (no partial updates)
- UI accurately reflects wallet balance after purchase

**Fail**: 
- ₦499: Purchase allowed (critical bug!)
- ₦500 or ₦501: Purchase blocked
- Database shows incorrect balance after transaction
- Race condition allows negative balance
- UI shows wrong balance

### Notes
- Boundary Value Analysis: Test min-1 (₦499), min (₦500), min+1 (₦501)
- Critical for financial integrity (prevent debt)
- Related: TC-PAY-003 (concurrent purchases), TC-PAY-004 (race conditions)
- **Interview Talking Point**: "I use boundary value analysis for financial features - testing edge cases like exact balance prevents critical bugs where users could go into debt"

---

## Learning Notes: Common Mistakes to Avoid

### ❌ Mistake 1: Prerequisites vs Test Steps
**Wrong**:
```
Prerequisites:
- User selects watch type
- User sets content rating
```
These are ACTIONS, not prerequisites!

**Correct**:
```
Prerequisites:
- [ ] Backend running
- [ ] Test user logged in
- [ ] Database accessible
```

### ❌ Mistake 2: Vague Expected Results
**Wrong**: "Session shows"  
**Correct**: "Session card appears in 'Watching Now' tab with title 'Family Movie Night', PG badge, and 'Free' label"

### ❌ Mistake 3: Missing Grey Box Validation
**Wrong**: Only check UI  
**Correct**: Check UI + API + Database

### ❌ Mistake 4: Steps Without HOW
**Wrong**: "User selects watch type"  
**Correct**: "Click 'Watch Type' dropdown, select 'Video Watch' from list"

### ❌ Mistake 5: Missing Test Design Technique
Always specify WHY this test exists:
- Positive Testing (happy path)
- Boundary Value Analysis (edge cases)
- Error Recovery Testing (failure handling)
- Decision Table Testing (complex logic)

---

## Practice Evidence: User's Initial Attempt (Day 2)

### What Was Good ✅
- Identified basic test flow
- Included test data section
- Attempted pass/fail criteria

### Key Improvements Needed 💡
1. **Prerequisites** were actually test steps - fixed by listing preconditions
2. **Test Steps** too vague - fixed by adding specific UI actions
3. **Missing Grey Box** - fixed by adding API + Database checks
4. **Test Data incomplete** - fixed by specifying all required fields
5. **No Test Design Technique** - fixed by identifying testing approach

### Growth Path 📈
This is EXACTLY how senior QA skills develop:
1. Write test cases independently
2. Get feedback from peers/leads
3. Revise with improvements
4. Repeat until mastery

**Next Steps**: Apply these patterns to all 105+ test cases in Week 4-5.

---

**Document Approval**: QA Lead (Chibuzor)  
**Next Review**: Week 4 (Manual Testing Phase)
