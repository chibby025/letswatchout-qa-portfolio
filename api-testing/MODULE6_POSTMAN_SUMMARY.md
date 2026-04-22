# Module 6: API Testing with Postman - Summary

**Tester:** Chibuzor  
**Date:** April 22, 2026  
**Tool:** Postman Desktop  
**Backend:** WeWatch API (Go/Gin)  
**Duration:** 1 hour hands-on practice

---

## 🎯 Learning Objectives Achieved

✅ **Understanding REST APIs** - HTTP methods, status codes, request/response structure  
✅ **Using Postman** - Industry-standard API testing tool  
✅ **Authentication Testing** - Login flow, cookie management  
✅ **Error Debugging** - 404 Not Found, 401 Unauthorized  
✅ **API Discovery** - Finding endpoints by reading code  
✅ **Data Validation** - Backend input validation testing

---

## 🧪 Tests Performed

### Test 1: Health Check Endpoint
**Method:** `GET`  
**URL:** `http://localhost:8080/health`  
**Expected:** 200 OK  
**Result:** ❌ 404 Not Found  
**Bug Found:** Health check endpoint doesn't exist  
**Impact:** Missing best practice for production monitoring

---

### Test 2: Get Active Sessions (Unauthenticated)
**Method:** `GET`  
**URL:** `http://localhost:8080/api/sessions/active`  
**Expected:** 401 Unauthorized  
**Result:** ✅ 401 Unauthorized  
**Finding:** Protected endpoint requires authentication (correct security!)

**Response:**
```json
{
  "error": "Authorization required"
}
```

**Backend Log:**
```
AuthMiddleware: No token found in header, cookie, or query
```

**Learning:** This is proper API security - sensitive data requires login.

---

### Test 3: User Login
**Method:** `POST`  
**URL:** `http://localhost:8080/api/auth/login`  
**Headers:** `Content-Type: application/json`  
**Body:**
```json
{
  "email": "michelle@gmail.com",
  "password": "Password"
}
```

**Result:** ✅ 200 OK

**Response:**
```json
{
  "message": "Login successful",
  "user": {
    "email": "michelle@gmail.com",
    "id": 8,
    "username": "michelle"
  }
}
```

**Cookie Received:** `wewatch_token` (authentication cookie)

**Learning:** Postman automatically stores and sends cookies with subsequent requests.

---

### Test 4: Get Active Sessions (Authenticated)
**Method:** `GET`  
**URL:** `http://localhost:8080/api/sessions/active`  
**Result:** ✅ 200 OK (cookie sent automatically)

**Response:**
```json
{
  "count": 0,
  "has_more": false,
  "limit": 10,
  "offset": 0,
  "sessions": null,
  "total": 0
}
```

**Learning:** Same endpoint that failed before now works! Authentication cookie unlocked access.

---

### Test 5: Create Watch Session
**Method:** `POST`  
**URL:** `http://localhost:8080/api/sessions`  
**Result:** ❌ 404 Not Found

**Bug Found:** Generic session endpoint doesn't exist

**Correct Endpoint Discovered:**  
- Instant Watch: `POST /api/instant-watch/sessions`  
- Room Session: `POST /api/rooms/{roomId}/sessions`

**Learning:** RESTful APIs organize resources hierarchically (sessions belong to rooms).

---

### Test 6: Create Session (Corrected)
**Method:** `POST`  
**URL:** `http://localhost:8080/api/instant-watch/sessions`  
**Body:**
```json
{
  "title": "Friday Movie Night",
  "watch_type": "cinema",
  "is_free": true,
  "content_rating": "PG"
}
```

**Result:** ❌ 400 Bad Request

**Response:**
```json
{
  "error": "watch_type must be 'video', '3d_cinema', or 'classroom'"
}
```

**Learning:** Backend validates input data! Correct values:
- ✅ `video` (regular video player)
- ✅ `3d_cinema` (3D immersive cinema)
- ✅ `classroom` (lecture hall mode)
- ❌ `cinema` (not valid - too generic)

---

## 🐛 Bugs Found

### BUG-API-001: Missing Health Check Endpoint
**Severity:** Low  
**Endpoint:** `GET /health`  
**Status:** 404 Not Found  
**Expected:** 200 OK with `{"status": "ok"}`  
**Impact:** Missing production monitoring best practice  
**Recommendation:** Add health check endpoint for load balancers and monitoring tools

---

### BUG-API-002: Generic Session Endpoint Not Implemented
**Severity:** Medium  
**Endpoint:** `POST /api/sessions`  
**Status:** 404 Not Found  
**Expected:** Either redirect to correct endpoint or return helpful error  
**Impact:** API consumers might use wrong endpoint  
**Recommendation:** 
- Option 1: Implement generic endpoint that routes to correct handler
- Option 2: Return 400 with clear error: "Use /api/instant-watch/sessions or /api/rooms/{id}/sessions"

---

## 📊 HTTP Status Codes Encountered

| Code | Meaning | Example |
|------|---------|---------|
| **200** | OK | Login successful, get sessions |
| **400** | Bad Request | Invalid watch_type value |
| **401** | Unauthorized | Missing authentication cookie |
| **404** | Not Found | Endpoint doesn't exist |

---

## 🎓 Key Concepts Learned

### 1. REST API Structure
```
HTTP Method + URL + Headers + Body = Request
Status Code + Headers + Body = Response
```

### 2. Authentication Flow
```
1. POST /api/auth/login → Get cookie
2. GET /api/sessions/active → Cookie sent automatically
3. Authenticated! ✅
```

### 3. Error Debugging Process
```
❌ Get 404 → Check URL spelling
❌ Get 401 → Need to login first
❌ Get 400 → Check request body data
✅ Get 200 → Success!
```

### 4. API Discovery Methods
- Read frontend code (React components)
- Check backend routes (Go handlers)
- Use browser DevTools Network tab
- Trial and error with Postman

---

## 🛠️ Postman Features Used

✅ **Request Builder** - Set method, URL, headers, body  
✅ **Cookie Management** - Automatic cookie storage and sending  
✅ **JSON Body Editor** - Syntax highlighting and validation  
✅ **Response Viewer** - Status code, headers, body  
✅ **History** - Track all requests made  

**Not Used Yet (for future learning):**
- ⏳ Collections (organize tests)
- ⏳ Environments (Dev vs Production)
- ⏳ Tests (JavaScript assertions)
- ⏳ Pre-request Scripts (setup data)
- ⏳ Newman CLI (run tests in terminal)

---

## 🎯 Skills Gained (Interview-Ready)

### Technical Skills
1. ✅ **REST API Testing** - GET, POST methods
2. ✅ **Postman Proficiency** - Industry-standard tool
3. ✅ **HTTP Protocol** - Status codes, headers, cookies
4. ✅ **Authentication Testing** - Login flows, session management
5. ✅ **Error Analysis** - Debug 4xx and 5xx errors
6. ✅ **API Documentation Reading** - Understand endpoints

### Interview Answer Template

**Q: "How do you test APIs?"**

**My Answer:**  
"I use Postman for API testing. For example, in my WeWatch project, I tested the authentication flow: first I send a POST request to `/api/auth/login` with email and password, verify I get a 200 status code with a user object, and check that an auth cookie is set. Then I test protected endpoints like `/api/sessions/active` - without the cookie it returns 401 Unauthorized, but with the cookie it returns 200 OK with session data. I also test error scenarios like invalid data (400 Bad Request) and missing endpoints (404 Not Found). I found 2 bugs: a missing health check endpoint and unclear error messages for session creation."

**Why This Answer Works:**
- ✅ Mentions industry tool (Postman)
- ✅ Shows systematic approach (authentication flow)
- ✅ Technical depth (status codes, cookies, endpoints)
- ✅ Error handling awareness (4xx errors)
- ✅ Bug discovery (2 real bugs found)
- ✅ Clear, confident delivery

---

## 📚 Resources & Next Steps

**Postman Documentation:**  
https://learning.postman.com/

**REST API Best Practices:**  
https://restfulapi.net/

**HTTP Status Codes Reference:**  
https://developer.mozilla.org/en-US/docs/Web/HTTP/Status

**Next Module:** Performance Testing with K6 (test how many users can use the API simultaneously)

---

## ✅ Module 6 Complete!

**Completion Date:** April 22, 2026  
**Time Invested:** 1 hour hands-on  
**Tests Performed:** 6 API tests  
**Bugs Found:** 2  
**Skills Acquired:** 6 technical skills

**Portfolio Status:** 75% Complete (Modules 1, 4, 5, 6 done)

---

**Next:** Module 7 - Performance Testing with K6 🚀
