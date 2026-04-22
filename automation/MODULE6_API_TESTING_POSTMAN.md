# Module 6: API Testing with Postman

**Goal:** Learn professional API testing to validate backend services  
**Time:** 6-8 hours  
**Skills:** REST APIs, Postman, API test automation, backend validation

---

## 🎯 What You'll Learn

1. **Understand APIs** - What they are, how they work (HTTP, JSON, REST)
2. **Use Postman** - Industry-standard API testing tool
3. **Write API tests** - Automate backend validation
4. **Test data flows** - Validate request/response payloads
5. **Handle authentication** - Cookies, tokens, headers
6. **Create test collections** - Organize and share API tests

---

## 📚 Prerequisites

Before you start, you should understand:
- ✅ What HTTP requests are (GET, POST, PUT, DELETE)
- ✅ What JSON is (JavaScript Object Notation)
- ✅ How APIs connect frontend to backend
- ✅ Basic WeWatch architecture (frontend → backend → database)

**Don't worry if you're fuzzy on these** - I'll explain as we go! 🚀

---

## 🧩 Part 1: Understanding APIs (30 min)

### **What is an API?**

**API = Application Programming Interface**

Think of it as a **restaurant menu**:
- 🍕 **Menu (API)**: Shows what you can order (available endpoints)
- 📝 **Order (Request)**: You tell the waiter what you want (send HTTP request)
- 🍽️ **Food (Response)**: Kitchen prepares and serves your order (server sends data)

### **How WeWatch Uses APIs:**

```
┌─────────────┐          ┌─────────────┐          ┌─────────────┐
│   Browser   │   HTTP   │   Backend   │          │  Database   │
│  (React)    │ ────────>│    (Go)     │ ────────>│ (PostgreSQL)│
│             │<────────│             │<────────│             │
└─────────────┘ JSON     └─────────────┘  SQL     └─────────────┘
```

**Example:** When you login:
1. **Frontend** → Sends: `POST /api/auth/login` with `{email, password}`
2. **Backend** → Checks database, validates credentials
3. **Backend** → Sends: `{user: {...}, token: "abc123"}` or `{error: "Invalid"}`
4. **Frontend** → Stores user data, redirects to lobby

### **API Request Structure:**

```http
POST http://localhost:8080/api/auth/login
Content-Type: application/json

{
  "email": "testhost1@example.com",
  "password": "Test1234!"
}
```

**Parts:**
- **Method:** `POST` (creating/sending data)
- **URL:** `http://localhost:8080/api/auth/login` (endpoint)
- **Headers:** `Content-Type: application/json` (metadata)
- **Body:** `{"email": "...", "password": "..."}` (payload)

### **API Response Structure:**

```http
HTTP/1.1 200 OK
Content-Type: application/json
Set-Cookie: auth_token=abc123; Path=/; HttpOnly

{
  "user": {
    "id": "123",
    "username": "TestHost1",
    "email": "testhost1@example.com",
    "role": "host"
  },
  "message": "Login successful"
}
```

**Parts:**
- **Status Code:** `200 OK` (success) or `401 Unauthorized` (failed)
- **Headers:** `Content-Type`, `Set-Cookie` (metadata)
- **Body:** `{"user": {...}}` (response data)

### **Common HTTP Methods:**

| Method | Purpose | Example |
|--------|---------|---------|
| **GET** | Fetch data (read) | `GET /api/sessions` - Get all sessions |
| **POST** | Create new resource | `POST /api/sessions` - Create session |
| **PUT** | Update entire resource | `PUT /api/sessions/123` - Update session |
| **PATCH** | Update partial resource | `PATCH /api/users/profile` - Update name only |
| **DELETE** | Remove resource | `DELETE /api/sessions/123` - Delete session |

### **Common HTTP Status Codes:**

| Code | Meaning | Example |
|------|---------|---------|
| **200** | ✅ OK | Request succeeded |
| **201** | ✅ Created | Resource created successfully |
| **400** | ❌ Bad Request | Invalid input (e.g., missing email) |
| **401** | ❌ Unauthorized | Not logged in / invalid credentials |
| **403** | ❌ Forbidden | Logged in but no permission |
| **404** | ❌ Not Found | Endpoint or resource doesn't exist |
| **500** | ❌ Server Error | Backend crashed / bug |

---

## 🛠️ Part 2: Install & Setup Postman (15 min)

### **Step 1: Install Postman**

**Option A: Download from Web (Recommended)**
1. Go to: https://www.postman.com/downloads/
2. Download for Linux (Ubuntu)
3. Extract and run:
   ```bash
   cd ~/Downloads
   tar -xzf Postman-linux-x64-*.tar.gz
   sudo mv Postman /opt/
   sudo ln -s /opt/Postman/Postman /usr/local/bin/postman
   postman
   ```

**Option B: Install via Snap (Easier)**
```bash
sudo snap install postman
postman
```

### **Step 2: Create Free Account**
1. Open Postman
2. Click "Sign Up" (optional but recommended - saves your work to cloud)
3. Use Google login or email

### **Step 3: Create Workspace**
1. Click "Workspaces" → "Create Workspace"
2. Name: **"WeWatch API Testing"**
3. Visibility: Personal
4. Click "Create"

### **Step 4: Verify Backend is Running**
```bash
# Terminal 1: Start backend
cd ~/WeWatch/backend
go run main.go

# Terminal 2: Test health endpoint
curl http://localhost:8080/health
# Should return: {"status":"ok"}
```

---

## 🧪 Part 3: Your First API Test (30 min)

### **Test 1: Health Check Endpoint**

**Goal:** Verify backend is running

**Steps:**
1. Click "New" → "HTTP Request"
2. **Method:** `GET`
3. **URL:** `http://localhost:8080/health`
4. Click "Send"

**Expected Result:**
```json
{
  "status": "ok",
  "timestamp": "2026-04-22T10:30:00Z"
}
```

**Status Code:** `200 OK`

**✅ Success!** You just made your first API call!

---

### **Test 2: Register New User**

**Goal:** Create a test user via API

**Steps:**
1. Click "New" → "HTTP Request"
2. **Method:** `POST`
3. **URL:** `http://localhost:8080/api/auth/register`
4. **Headers Tab:**
   - Key: `Content-Type`
   - Value: `application/json`
5. **Body Tab:**
   - Select "raw"
   - Select "JSON" format
   - Paste:
     ```json
     {
       "username": "APITestUser1",
       "email": "apitest1@example.com",
       "password": "Test1234!",
       "date_of_birth": "1995-05-15"
     }
     ```
6. Click "Send"

**Expected Result:**
```json
{
  "user": {
    "id": "generated-uuid",
    "username": "APITestUser1",
    "email": "apitest1@example.com",
    "role": "viewer"
  },
  "message": "Registration successful"
}
```

**Status Code:** `201 Created`

**✅ Success!** You created a user via API!

---

### **Test 3: Login with Registered User**

**Goal:** Authenticate and get auth cookie

**Steps:**
1. Click "New" → "HTTP Request"
2. **Method:** `POST`
3. **URL:** `http://localhost:8080/api/auth/login`
4. **Headers Tab:**
   - Key: `Content-Type`
   - Value: `application/json`
5. **Body Tab:**
   - Select "raw" → "JSON"
   - Paste:
     ```json
     {
       "email": "apitest1@example.com",
       "password": "Test1234!"
     }
     ```
6. Click "Send"

**Expected Result:**
```json
{
  "user": {
    "id": "...",
    "username": "APITestUser1",
    "email": "apitest1@example.com"
  },
  "message": "Login successful"
}
```

**Status Code:** `200 OK`

**Check Cookies Tab:** You should see `auth_token` cookie! 🍪

**✅ Success!** You're now authenticated!

---

### **Test 4: Get Current User (Protected Route)**

**Goal:** Test authenticated endpoint

**Steps:**
1. Click "New" → "HTTP Request"
2. **Method:** `GET`
3. **URL:** `http://localhost:8080/api/auth/me`
4. **Important:** Postman automatically sends cookies from previous requests
5. Click "Send"

**Expected Result:**
```json
{
  "id": "...",
  "username": "APITestUser1",
  "email": "apitest1@example.com",
  "role": "viewer",
  "tokens": 0
}
```

**Status Code:** `200 OK`

**What if it fails?**
- ❌ `401 Unauthorized` → You're not logged in (cookie missing)
- **Solution:** Re-run Test 3 (Login) to get fresh cookie

**✅ Success!** You accessed a protected endpoint!

---

## 📦 Part 4: Create API Test Collection (1 hour)

Now let's organize these tests into a **Collection** (like a test suite).

### **Step 1: Create Collection**
1. Click "Collections" in sidebar
2. Click "+" → "Create Collection"
3. Name: **"WeWatch API Tests"**
4. Description: "E2E API tests for WeWatch backend"

### **Step 2: Add Tests to Collection**

**Click "Add Request" for each test:**

#### **1. Health Check**
- **Name:** `TC-API-001: Health check endpoint`
- **Method:** `GET`
- **URL:** `http://localhost:8080/health`
- **Tests Tab** (add JavaScript validation):
  ```javascript
  pm.test("Status code is 200", function () {
      pm.response.to.have.status(200);
  });

  pm.test("Response has status field", function () {
      var jsonData = pm.response.json();
      pm.expect(jsonData).to.have.property('status');
      pm.expect(jsonData.status).to.eql('ok');
  });
  ```

#### **2. Register User**
- **Name:** `TC-API-002: Register new user`
- **Method:** `POST`
- **URL:** `http://localhost:8080/api/auth/register`
- **Headers:** `Content-Type: application/json`
- **Body:**
  ```json
  {
    "username": "{{$randomUserName}}",
    "email": "{{$randomEmail}}",
    "password": "Test1234!",
    "date_of_birth": "1995-05-15"
  }
  ```
- **Tests Tab:**
  ```javascript
  pm.test("Status code is 201", function () {
      pm.response.to.have.status(201);
  });

  pm.test("User created with correct data", function () {
      var jsonData = pm.response.json();
      pm.expect(jsonData).to.have.property('user');
      pm.expect(jsonData.user).to.have.property('username');
      pm.expect(jsonData.user).to.have.property('email');
  });

  // Save user ID for later tests
  pm.environment.set("userId", pm.response.json().user.id);
  pm.environment.set("userEmail", pm.response.json().user.email);
  ```

#### **3. Login**
- **Name:** `TC-API-003: Login with valid credentials`
- **Method:** `POST`
- **URL:** `http://localhost:8080/api/auth/login`
- **Body:**
  ```json
  {
    "email": "testhost1@example.com",
    "password": "Test1234!"
  }
  ```
- **Tests Tab:**
  ```javascript
  pm.test("Status code is 200", function () {
      pm.response.to.have.status(200);
  });

  pm.test("Response contains user data", function () {
      var jsonData = pm.response.json();
      pm.expect(jsonData).to.have.property('user');
      pm.expect(jsonData.user.email).to.eql("testhost1@example.com");
  });

  pm.test("Auth cookie is set", function () {
      pm.expect(pm.cookies.has('auth_token')).to.be.true;
  });
  ```

#### **4. Login Failure (Invalid Password)**
- **Name:** `TC-API-004: Login fails with wrong password`
- **Method:** `POST`
- **URL:** `http://localhost:8080/api/auth/login`
- **Body:**
  ```json
  {
    "email": "testhost1@example.com",
    "password": "WrongPassword123!"
  }
  ```
- **Tests Tab:**
  ```javascript
  pm.test("Status code is 401", function () {
      pm.response.to.have.status(401);
  });

  pm.test("Error message is returned", function () {
      var jsonData = pm.response.json();
      pm.expect(jsonData).to.have.property('error');
  });
  ```

#### **5. Get Current User (Protected)**
- **Name:** `TC-API-005: Get authenticated user profile`
- **Method:** `GET`
- **URL:** `http://localhost:8080/api/auth/me`
- **Pre-request Script** (runs before request):
  ```javascript
  // Ensure we're logged in
  // (This test should run after TC-API-003)
  ```
- **Tests Tab:**
  ```javascript
  pm.test("Status code is 200", function () {
      pm.response.to.have.status(200);
  });

  pm.test("User profile is returned", function () {
      var jsonData = pm.response.json();
      pm.expect(jsonData).to.have.property('id');
      pm.expect(jsonData).to.have.property('username');
      pm.expect(jsonData).to.have.property('email');
  });
  ```

---

## 🏃 Part 5: Run Collection (15 min)

### **Run All Tests in Collection**

1. Click on collection name: "WeWatch API Tests"
2. Click "Run" button (▶️ icon)
3. **Collection Runner** opens
4. Click "Run WeWatch API Tests"
5. Watch tests execute automatically! 🎉

**Expected Result:**
```
✅ TC-API-001: Health check endpoint (25ms)
✅ TC-API-002: Register new user (180ms)
✅ TC-API-003: Login with valid credentials (120ms)
✅ TC-API-004: Login fails with wrong password (80ms)
✅ TC-API-005: Get authenticated user profile (45ms)

5/5 tests passed (450ms total)
```

---

## 🎓 Part 6: Advanced API Testing (2 hours)

### **Test 6: Create Watch Session**

**Goal:** Test session creation endpoint

```json
POST http://localhost:8080/api/sessions
Content-Type: application/json
Cookie: auth_token=... (from login)

{
  "title": "Friday Movie Night",
  "class_type": "Movie",
  "is_free": true,
  "max_viewers": 50,
  "scheduled_time": "2026-04-25T20:00:00Z"
}
```

**Tests:**
```javascript
pm.test("Session created successfully", function () {
    pm.response.to.have.status(201);
    var jsonData = pm.response.json();
    pm.expect(jsonData).to.have.property('session_id');
    
    // Save session ID for later tests
    pm.environment.set("sessionId", jsonData.session_id);
});
```

---

### **Test 7: Get Session Details**

```json
GET http://localhost:8080/api/sessions/{{sessionId}}
```

**Tests:**
```javascript
pm.test("Session details returned", function () {
    pm.response.to.have.status(200);
    var jsonData = pm.response.json();
    pm.expect(jsonData.title).to.eql("Friday Movie Night");
    pm.expect(jsonData.is_free).to.be.true;
});
```

---

### **Test 8: Join Session as Viewer**

```json
POST http://localhost:8080/api/sessions/{{sessionId}}/join
```

**Tests:**
```javascript
pm.test("Viewer joined session", function () {
    pm.response.to.have.status(200);
    var jsonData = pm.response.json();
    pm.expect(jsonData.message).to.include("joined");
});
```

---

### **Test 9: Payment API (Buy Tokens)**

```json
POST http://localhost:8080/api/payments/initialize
Content-Type: application/json

{
  "amount": 1000,
  "email": "testhost1@example.com"
}
```

**Tests:**
```javascript
pm.test("Payment initialized", function () {
    pm.response.to.have.status(200);
    var jsonData = pm.response.json();
    pm.expect(jsonData).to.have.property('authorization_url');
    pm.expect(jsonData).to.have.property('reference');
});
```

---

## 📊 Part 7: Document Your API Tests (1 hour)

Create a document showing your API test coverage.

### **Create: `api-testing/MODULE6_API_TEST_SUMMARY.md`**

```markdown
# Module 6: API Testing Summary

**Tester:** Your Name  
**Date:** April 22, 2026  
**Tool:** Postman  
**Backend:** WeWatch API (Go)

---

## 🎯 Test Coverage

### **Authentication APIs**
- ✅ TC-API-001: Health check
- ✅ TC-API-002: Register new user
- ✅ TC-API-003: Login with valid credentials
- ✅ TC-API-004: Login with invalid credentials (401)
- ✅ TC-API-005: Get current user profile

### **Session Management APIs**
- ✅ TC-API-006: Create free session
- ✅ TC-API-007: Get session details
- ✅ TC-API-008: Join session as viewer

### **Payment APIs**
- ✅ TC-API-009: Initialize payment

---

## 📈 Test Results

**Total Tests:** 9  
**Passed:** 9 ✅  
**Failed:** 0 ❌  
**Pass Rate:** 100%

**Total Execution Time:** 850ms

---

## 🐛 Bugs Found

### Bug 1: Session Title Length Not Validated
- **Endpoint:** `POST /api/sessions`
- **Issue:** Accepts titles >255 characters (should reject)
- **Status Code:** `201 Created` (should be `400 Bad Request`)
- **Impact:** Medium - Database truncates title causing data loss

### Bug 2: Error Messages Inconsistent
- **Endpoint:** `POST /api/auth/login`
- **Issue:** Returns `"message": "Invalid credentials"` but other endpoints use `"error": "..."`
- **Impact:** Low - Frontend must handle multiple error formats

---

## 🎓 Skills Learned

1. ✅ Understanding REST APIs (GET, POST, PUT, DELETE)
2. ✅ Using Postman for API testing
3. ✅ Writing automated API tests (JavaScript assertions)
4. ✅ Handling authentication (cookies, tokens)
5. ✅ Validating response structure and data
6. ✅ Testing error scenarios (4xx, 5xx status codes)
7. ✅ Organizing tests into collections
8. ✅ Running automated test suites

---

## 📸 Screenshots

![Postman Collection](../screenshots/api/postman-collection.png)  
![Test Results](../screenshots/api/test-results.png)

---

## 🔗 Postman Collection

**Export & Share:**
1. Click collection → ⚙️ Settings → Export
2. Save as: `wewatch-api-tests.postman_collection.json`
3. Upload to GitHub portfolio

**Import Link:**  
`https://github.com/yourusername/qa-portfolio/api-testing/wewatch-api-tests.json`

---

## ✅ Interview Readiness

**Question:** "How do you test APIs?"

**Your Answer:**  
"I use Postman to test REST APIs. For example, in my WeWatch project, I created a collection of 9 API tests covering authentication, session management, and payment endpoints. I validate response status codes, data structure, error handling, and authentication flows. I also write JavaScript assertions to automate validation, so the tests can run in CI/CD pipelines. I found 2 bugs: inconsistent error message formats and missing input validation on session titles."

**Why this answer is strong:**
- ✅ Mentions industry-standard tool (Postman)
- ✅ Shows systematic approach (collections, coverage)
- ✅ Demonstrates technical depth (status codes, assertions, CI/CD)
- ✅ Proves bug-finding ability (2 real bugs)
- ✅ Clear and confident delivery
```

---

## 🚀 Your Assignment

### **Deliverables:**

1. **Postman Collection** - 9+ API tests
2. **Test Summary Document** - MODULE6_API_TEST_SUMMARY.md
3. **Screenshots** - Test results, collection structure
4. **Exported Collection** - JSON file for GitHub

### **Grading Rubric:**

| Criteria | Points | Your Score |
|----------|--------|------------|
| Created Postman collection | 20 | ___ |
| All 9 core tests passing | 30 | ___ |
| JavaScript assertions written | 20 | ___ |
| Tested error scenarios (4xx) | 15 | ___ |
| Documented findings | 10 | ___ |
| Exported collection to GitHub | 5 | ___ |
| **Total** | **100** | **___** |

---

## 📚 Resources

**Postman Learning:**
- 📖 [Postman Documentation](https://learning.postman.com/)
- 🎥 [Postman Beginner Tutorial](https://www.youtube.com/watch?v=VywxIQ2ZXw4)
- 🧪 [API Testing Best Practices](https://www.postman.com/api-platform/api-testing/)

**REST API Concepts:**
- 📖 [What is REST?](https://restfulapi.net/)
- 📖 [HTTP Status Codes](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status)

---

## ✅ Module 6 Complete!

**Next:** Module 7 - Performance Testing with K6

---

**Questions?** Ask me anything! I'm here to help you succeed. 🚀
