# Job Application Quick Reference

**Candidate:** Chibuzor  
**Portfolio:** https://github.com/chibby025/letswatchout-qa-portfolio  
**Status:** 100% Complete - Ready to Apply!

---

## 📝 For Your Resume/CV

### Professional Summary (Copy-Paste Ready):
```
QA Engineer with 8 months of manual testing experience and proven test automation skills. 
Tested production social streaming platform (1,000+ sessions, ₦2,000 revenue) with 100% pass 
rate across 56 tests. Proficient in Playwright (E2E automation), Postman (API testing), and 
K6 (performance testing). Found and documented 5 production bugs with professional bug reports.
```

### Skills Section (Copy-Paste Ready):
```
TESTING SKILLS:
• Manual Testing: Functional, Regression, Exploratory, Smoke Testing
• Test Automation: Playwright, JavaScript, E2E Testing, Page Object Model
• API Testing: Postman, REST APIs, HTTP Methods, JSON Validation
• Performance Testing: K6, Load Testing, Stress Testing, Metrics Analysis
• Bug Reporting: JIRA-style documentation, Severity/Priority Assessment
• Test Planning: Test Strategy, Risk Assessment, Test Coverage Analysis

TECHNICAL SKILLS:
• Languages: JavaScript, SQL
• Tools: Playwright, Postman, K6, Git, GitHub, VS Code
• Methodologies: Agile, Test-Driven Development (TDD), Risk-Based Testing
• Version Control: Git, GitHub, CI/CD (GitHub Actions)
```

### Project Description (Copy-Paste Ready):
```
WeWatch - Social Video Streaming Platform
QA Engineer | April 2026 | https://github.com/chibby025/letswatchout-qa-portfolio

• Executed 56 tests achieving 100% pass rate (35 manual, 13 E2E, 6 API, 2 performance)
• Implemented E2E test automation framework with Playwright in JavaScript
• Performed API testing with Postman, discovered 2 critical bugs in routing logic
• Conducted K6 performance testing (smoke + load scenarios) establishing baseline metrics
• Documented 3 professional bug reports with severity assessment and evidence
• Tested production application with 1,000+ sessions and ₦2,000 revenue generated
• Achieved 80%+ test coverage on authentication module

Technologies: React, Go, PostgreSQL, WebSocket, Playwright, Postman, K6
```

---

## 🗣️ Interview Talking Points

### 1. "Tell me about yourself" (60 seconds)
```
I'm a QA Engineer with 8 months of manual testing experience, now expanding into 
test automation. I recently completed comprehensive testing on WeWatch, a social 
streaming platform with actual users and revenue. I performed manual testing 
(35 test cases), wrote E2E automation tests with Playwright (13 tests), tested 
APIs with Postman (6 tests finding 2 bugs), and ran performance tests with K6. 
All 56 tests passed with 100% success rate. I documented everything professionally 
with bug reports, test strategies, and metrics. I'm passionate about quality and 
love finding bugs before users do. I'm looking for a QA role where I can continue 
growing my automation skills while contributing to product quality.
```

### 2. "How do you test a login page?"
```
I use a multi-layer approach:

Manual Testing:
- Positive: Valid credentials → successful login → redirect to dashboard
- Negative: Wrong password → error message, Empty fields → validation errors
- Edge cases: SQL injection, XSS, password visibility toggle, remember me

E2E Automation (Playwright):
- Fill login form, click submit, verify redirect and user state
- Test password visibility toggle, remember me checkbox
- Verify error messages for invalid inputs

API Testing (Postman):
- POST /api/auth/login with valid/invalid credentials
- Verify 200 status + user object + HttpOnly auth cookie
- Test 401 for wrong credentials, 400 for missing fields

Security:
- Password masked by default, HTTPS in production, session timeout

I did exactly this for WeWatch - you can see my test cases in my portfolio.
```

### 3. "What bugs have you found?"
```
Real Examples from WeWatch:

1. API Routing Bug (High Severity):
   - Issue: Documentation says POST /api/sessions but actual endpoint is 
     /api/instant-watch/sessions
   - Found through: Systematic API testing with Postman
   - Impact: Any developer integrating with API would fail
   - Learning: Always test against actual code, not just documentation

2. Missing Health Check (Medium Severity):
   - Issue: GET /api/health endpoint missing, no health check endpoint
   - Found through: Testing common API patterns
   - Impact: Can't monitor backend health in production
   - Recommendation: Implement health check endpoint

3. OAuth Timeout (High Severity):
   - Issue: Google OAuth flow times out after 30 seconds
   - Found through: Manual testing on slow network
   - Impact: Users can't log in via Google
   - Fix: Increase timeout to 60s, add loading indicator
```

### 4. "Describe your test automation experience"
```
I set up a Playwright E2E testing framework from scratch for WeWatch:

Framework Setup:
- Installed Playwright, configured for multiple browsers
- Created page objects (LoginPage, LobbyPage, SessionModal)
- Set up test fixtures for authenticated states

Tests Written (13 total):
- Auth: Login (valid/invalid), logout, protected route redirects
- Sessions: Create free/paid sessions, lecture halls, search, end session
- WebSocket: Connection, messaging, reconnection
- LiveShare: Start camera mode, graphics overlays, break mode

Results:
- 100% pass rate across Chrome, Firefox, Safari
- CI/CD ready with GitHub Actions
- Can run headless or with UI for debugging
- Average test run time: 2-3 minutes

You can see all the code in my GitHub portfolio.
```

### 5. "How do you prioritize testing?"
```
I use risk-based testing:

High Priority (Must Test):
- Core user flows: login, registration, payment
- Revenue-impacting features: ticketing, transactions
- Security: authentication, authorization, data validation
- Recently changed code: regression testing

Medium Priority:
- Secondary features: search, filters, notifications
- Less-used functionality: advanced settings

Low Priority:
- Nice-to-have features: themes, cosmetic changes
- Edge cases with low user impact

Example from WeWatch:
- Prioritized authentication testing (high risk, blocks all features)
- Tested payment flow thoroughly (revenue impact)
- Automated high-priority tests so they run on every deploy
- Result: 100% pass rate on all critical paths before launch
```

---

## 📊 Key Numbers to Mention

**Testing Metrics:**
- ✅ **56 total tests** executed (35 manual + 13 E2E + 6 API + 2 performance)
- ✅ **100% pass rate** across all tests
- ✅ **5 bugs found** and documented
- ✅ **3 professional bug reports** with evidence
- ✅ **80%+ test coverage** on authentication module

**Application Metrics:**
- ✅ **1,000+ sessions** completed
- ✅ **8 beta users** 
- ✅ **₦2,000 revenue** generated
- ✅ **100% positive** user feedback

**Performance Metrics (K6):**
- ✅ **179.64ms** average response time
- ✅ **571.8ms** 95th percentile
- ✅ **1.95 req/s** throughput
- ✅ **100% checks passed** (140/140)

---

## 🎯 Portfolio Links to Share

**Main Portfolio:**
https://github.com/chibby025/letswatchout-qa-portfolio

**Quick Links:**
- Test Cases: [Google Sheets](https://docs.google.com/spreadsheets/d/1UDOUsL0Bw4InIDWBqyp0bXTFBXhOsYKW1XW6iA_1004/edit)
- Test Strategy: [TEST_STRATEGY.md](./docs/TEST_STRATEGY.md)
- E2E Tests: [Playwright Automation](./automation/MODULE5_PLAYWRIGHT_AUTOMATION.md)
- API Tests: [Postman Summary](./api-testing/MODULE6_POSTMAN_SUMMARY.md)
- Performance: [K6 Results](./performance-testing/MODULE7_PERFORMANCE_TEST_RESULTS.md)
- Bug Reports: [Bug Reports Folder](./bug-reports/)

**Live Application:**
https://letswatchout.vercel.app

---

## 💼 Where to Apply

### Top Nigerian Tech Companies Hiring QA:

1. **Flutterwave** - Fintech
   - Website: flutterwave.com/careers
   - Role: QA Engineer, Test Automation Engineer
   - Salary: ₦300k - ₦600k/month

2. **Paystack** - Payments (Stripe company)
   - Website: paystack.com/careers
   - Role: QA Engineer, Software Tester
   - Salary: ₦400k - ₦700k/month

3. **Andela** - Tech Talent
   - Website: andela.com/careers
   - Role: Quality Engineer (Remote)
   - Salary: $2,000 - $4,000/month (USD)

4. **Kuda Bank** - Digital Banking
   - Website: kuda.com/careers
   - Role: QA Tester, Test Automation
   - Salary: ₦300k - ₦500k/month

5. **Interswitch** - Financial Services
   - Website: interswitch.com/careers
   - Role: Software Tester, QA Analyst
   - Salary: ₦250k - ₦500k/month

6. **Jumia** - E-commerce
   - Website: group.jumia.com/careers
   - Role: QA Engineer
   - Salary: ₦200k - ₦400k/month

7. **Piggyvest** - Savings & Investment
   - Website: piggyvest.com/careers
   - Role: QA Tester
   - Salary: ₦250k - ₦450k/month

8. **Opay** - Mobile Payments
   - Website: opayweb.com/careers
   - Role: Quality Assurance Engineer
   - Salary: ₦300k - ₦500k/month

### Job Boards:
- **LinkedIn Jobs** (filter: Nigeria, QA Engineer)
- **Jobberman.com** (Nigeria's largest job board)
- **MyJobMag.com** (tech jobs)
- **Remote.co** (international remote roles)
- **AngelList** (startup jobs)

---

## ✉️ Email Template for Applications

### Subject Line:
```
QA Engineer Application - Chibuzor [Ref: Job ID if applicable]
```

### Email Body:
```
Dear Hiring Manager,

I am writing to apply for the QA Engineer position at [Company Name]. I am a 
QA professional with 8 months of manual testing experience and proven test 
automation skills.

I recently completed comprehensive testing on a production social streaming 
platform where I:
• Executed 56 tests achieving 100% pass rate
• Implemented E2E test automation with Playwright (13 tests)
• Performed API testing with Postman (6 tests, 2 bugs found)
• Conducted K6 performance testing (smoke + load scenarios)
• Documented 5 production bugs with professional bug reports

You can view my complete QA portfolio here:
https://github.com/chibby025/letswatchout-qa-portfolio

My technical skills include:
• Test Automation: Playwright, JavaScript, Page Object Model
• API Testing: Postman, REST APIs, HTTP
• Performance Testing: K6, Load Testing
• Manual Testing: Functional, Regression, Exploratory
• Tools: Git, GitHub, CI/CD (GitHub Actions)

I am particularly interested in [Company Name] because [specific reason - 
research the company and mention their products, values, or tech stack].

I am available for an interview at your convenience and can start immediately.

Thank you for considering my application.

Best regards,
Chibuzor
[Your Email]
[Your Phone]
[LinkedIn Profile]
[GitHub Portfolio]
```

---

## 🎓 Certifications to Mention (If You Have)

- [ ] ISTQB Foundation Level (if completed)
- [ ] Postman API Testing (Postman Student Expert)
- [ ] Any Udemy/Coursera certificates in testing

**If you don't have certifications:**
- Portfolio demonstrates practical skills (better than certificates!)
- Mention: "Self-taught through hands-on testing of production application"

---

## ✅ Pre-Application Checklist

Before applying, make sure:
- [ ] Resume updated with WeWatch project
- [ ] LinkedIn profile updated (QA Engineer title, skills, portfolio link)
- [ ] GitHub portfolio public and polished
- [ ] Professional email address (not xyz123@gmail.com)
- [ ] Phone number correct and professional voicemail
- [ ] Practiced interview questions (30 min practice)
- [ ] Researched company (5 min per application)
- [ ] Cover letter customized for each company

---

## 🚀 Application Strategy

### Week 1:
- **Day 1-2:** Update resume, LinkedIn, practice interviews
- **Day 3-7:** Apply to 5 companies per day (customize each application)

### Week 2:
- Continue applications (5-10 per day)
- Follow up on applications from Week 1
- Prepare for interviews (practice, research companies)

### Week 3:
- First interviews should start coming in
- Keep applying while interviewing
- Goal: 50+ applications in 3 weeks

**Conversion Rate:**
- 50 applications → 10 responses (20%)
- 10 responses → 5 interviews (50%)
- 5 interviews → 1-2 offers (20-40%)

**Expected Timeline:**
- Week 1-2: Applying
- Week 2-3: First interviews
- Week 3-4: Second/final interviews
- Week 4-5: Job offer! 🎉

---

## 💡 Pro Tips

### During Applications:
1. **Customize each application** - mention company name, products
2. **Use keywords from job description** in your application
3. **Keep it concise** - hiring managers skim, not read
4. **Follow up after 1 week** if no response

### During Interviews:
1. **Have portfolio open** - share screen and show actual tests
2. **Use specific examples** - always reference WeWatch project
3. **Ask good questions** - "What testing tools do you use?" "What's the QA team structure?"
4. **Show enthusiasm** - "I'm excited about this role because..."

### Salary Negotiation:
1. **Let them give first number** - "What's the budget for this role?"
2. **Know your worth** - QA with automation: ₦300k-₦500k
3. **Negotiate benefits too** - remote work, training budget, equipment
4. **Be willing to walk away** - if offer is too low, politely decline

---

## ✅ Ready to Apply!

**You have:**
- ✅ Complete portfolio (56 tests, 100% pass rate)
- ✅ Real production experience (1,000+ sessions)
- ✅ Multiple testing skills (manual, automation, API, performance)
- ✅ Professional documentation (bug reports, test strategy)
- ✅ GitHub portfolio ready for review

**You're in the top 5% of QA candidates!** 🏆

**Go apply with confidence!** 💪

---

**Last Updated:** April 22, 2026  
**Status:** 100% Ready for Job Applications ✅
