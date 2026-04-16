# LetsWatchOut - QA Portfolio

![QA Testing](https://img.shields.io/badge/Testing-Manual%20%7C%20Automated-brightgreen)
![Playwright](https://img.shields.io/badge/E2E-Playwright-45ba4b)
![Postman](https://img.shields.io/badge/API-Postman-FF6C37)
![K6](https://img.shields.io/badge/Performance-K6-7D64FF)
![Status](https://img.shields.io/badge/Status-In%20Progress-yellow)

**Comprehensive QA testing portfolio for LetsWatchOut social streaming platform**

---

## 📋 Project Overview

**Application:** LetsWatchOut  
**Type:** Social streaming platform with 3D cinema, lecture halls, and video watch  
**Tech Stack:** React + Go + PostgreSQL + WebSocket + LiveKit  
**QA Timeline:** 10 weeks (April 14 - June 23, 2026)  
**Testing Scope:** 105+ manual test cases, 25+ automated tests, performance benchmarks

### Key Features Tested
- 🔐 Google OAuth 2.0 authentication
- 🎬 Real-time video watch sessions (3 types: 2D, 3D Cinema, Lecture Hall)
- 📤 Chunked media uploads with network-aware compression
- 💳 Payment processing (Paystack integration)
- 🎁 Live gifting system with WebSocket notifications
- 🎨 LiveShare graphics overlays
- 💬 Real-time chat and social features

---

## 🎯 Portfolio Highlights

### What This Portfolio Demonstrates

✅ **Systematic Test Planning**
- Comprehensive test strategy (50+ pages)
- Risk assessment and mitigation
- Traceability matrix (requirements → test cases)

✅ **Manual Testing Excellence**
- 105+ detailed test cases across 9 feature areas
- Professional bug reports with evidence
- Weekly test execution reports

✅ **Test Automation Framework**
- Playwright E2E tests (25+ scenarios)
- Postman API collections (20+ endpoints)
- K6 performance tests (load, stress, spike)

✅ **Real Production Experience**
- Live app with 8 beta users, 1000+ sessions
- Revenue-generating features tested (₦2,000 earned)
- Critical bugs found and documented

✅ **Professional Documentation**
- ISTQB-aligned terminology
- Clear metrics and KPIs
- Portfolio-ready case study

---

## 📁 Repository Structure

```
letswatchout-qa-portfolio/
├── docs/                        # Test planning & strategy documents
│   ├── TEST_STRATEGY.md        # Comprehensive test plan (50+ pages)
│   ├── TEST_ENVIRONMENTS.md    # Dev/staging/prod configs
│   ├── RISK_MATRIX.md          # Risk assessment & mitigation
│   └── TRACEABILITY.xlsx       # Requirements coverage
│
├── test-cases/                  # Manual test case repository
│   └── TEST_CASES.xlsx         # 105+ test cases with execution results
│
├── test-execution/              # Test run artifacts
│   ├── reports/                # Weekly and final test reports
│   └── screenshots/            # Visual evidence for bugs
│
├── bug-reports/                 # Defect documentation
│   ├── BUG-001-oauth-timeout.md
│   ├── BUG-002-upload-failure.md
│   └── bug-template.md         # Standardized bug report format
│
├── automation/                  # Test automation frameworks
│   ├── e2e/                    # Playwright E2E tests
│   ├── api/                    # Postman + Newman
│   └── performance/            # K6 load tests
│
└── case-study/                  # Portfolio documentation
    └── PORTFOLIO_CASE_STUDY.md # Detailed writeup for Medium/LinkedIn
```

---

## 🧪 Testing Approach

### Phase 1: Test Planning (Week 3) ✅
- [x] Test strategy document
- [x] Environment setup
- [ ] Risk assessment
- [ ] Test case template

### Phase 2: Test Case Development (Week 4-5)
- [ ] Authentication test cases (15)
- [ ] Session management test cases (20)
- [ ] Media upload test cases (12)
- [ ] Payment test cases (10)
- [ ] Real-time features test cases (15)
- [ ] Gift system test cases (10)
- [ ] Watch experience test cases (18)
- [ ] Social features test cases (5)

### Phase 3: Test Automation (Week 6-7)
- [ ] Playwright setup
- [ ] E2E test scripts (25+)
- [ ] CI/CD integration (GitHub Actions)

### Phase 4: API & Performance (Week 8-9)
- [ ] Postman collections
- [ ] Newman CLI automation
- [ ] K6 load tests (50-200 concurrent users)
- [ ] Performance baseline

### Phase 5: Portfolio Documentation (Week 10)
- [ ] Final test report
- [ ] Case study blog post
- [ ] GitHub repo polish
- [ ] LinkedIn/Medium publication

---

## 📊 Test Coverage Matrix

| Feature Area | Test Cases | Automated | Pass Rate | Status |
|--------------|-----------|-----------|-----------|--------|
| Authentication | 15 | 8 | TBD | 🟡 In Progress |
| Session Management | 20 | 10 | TBD | ⬜ Not Started |
| Media Upload | 12 | 5 | TBD | ⬜ Not Started |
| Payment System | 10 | 3 | TBD | ⬜ Not Started |
| Real-time Features | 15 | 7 | TBD | ⬜ Not Started |
| Gift System | 10 | 4 | TBD | ⬜ Not Started |
| Watch Experience | 18 | 6 | TBD | ⬜ Not Started |
| Social Features | 5 | 2 | TBD | ⬜ Not Started |
| **Total** | **105** | **45** | **TBD** | 🟡 **30% Complete** |

---

## 🐛 Defect Summary

**Status:** In Progress (Testing not yet started)

| Severity | Found | Fixed | Open | Reopen Rate |
|----------|-------|-------|------|-------------|
| Critical | 0 | 0 | 0 | 0% |
| High | 0 | 0 | 0 | 0% |
| Medium | 0 | 0 | 0 | 0% |
| Low | 0 | 0 | 0 | 0% |
| **Total** | **0** | **0** | **0** | **0%** |

*Updated weekly as testing progresses*

---

## 🛠️ Tools & Technologies

### Test Management
- **Test Case Repository:** Google Sheets
- **Bug Tracking:** GitHub Issues
- **Documentation:** Markdown + Git

### Test Automation
- **E2E Testing:** [Playwright](https://playwright.dev/) v1.40+
- **API Testing:** [Postman](https://www.postman.com/) + Newman v6+
- **Performance Testing:** [K6](https://k6.io/) v0.48+
- **CI/CD:** GitHub Actions

### Supporting Tools
- **Browser DevTools:** Network analysis, console debugging
- **Git:** Version control for test artifacts
- **VS Code:** Test script development

---

## 📈 Key Metrics

### Quality Metrics (Target)
- **Test Case Pass Rate:** ≥ 95% (critical paths)
- **Test Coverage:** ≥ 85% (features)
- **Defect Detection Rate:** ≥ 10 bugs/week
- **Automation Coverage:** ≥ 25 tests

### Performance Metrics (Target)
- **API Response Time:** ≤ 500ms (95th percentile)
- **Page Load Time:** ≤ 3 seconds
- **Concurrent Users:** 50-200 (load test)
- **WebSocket Uptime:** ≥ 99%

---

## 📝 Sample Test Case

**TC-AUTH-002: Google OAuth Login Success**

| Field | Value |
|-------|-------|
| **Feature** | Authentication |
| **Priority** | Critical (P0) |
| **Type** | Functional |
| **Prerequisites** | Valid Google account exists |

**Steps:**
1. Navigate to https://letswatchout.com/login
2. Click "Sign in with Google" button
3. Select Google account from popup
4. Grant requested permissions

**Expected Result:**
- User logged in successfully
- Redirected to /lobby page
- Avatar synced from Google profile
- JWT token stored in HttpOnly cookie
- Session persistent across page refresh

**Test Data:**
- Email: oauth_test@gmail.com
- Browser: Chrome 120.0

**Status:** ⬜ Not Executed

---

## 🎓 Learning Outcomes

This portfolio demonstrates proficiency in:

### Manual Testing
- ✅ Test case design (equivalence partitioning, boundary value analysis)
- ✅ Exploratory testing techniques
- ✅ Bug report writing with evidence
- ✅ Test execution tracking and reporting

### Test Automation
- ✅ Playwright framework setup and configuration
- ✅ Page Object Model (POM) design pattern
- ✅ API testing with Postman collections
- ✅ Performance testing with K6 scripts

### QA Process
- ✅ Test strategy and planning
- ✅ Risk assessment and mitigation
- ✅ Defect lifecycle management
- ✅ Metrics tracking and reporting

### Tools & Technologies
- ✅ Playwright (JavaScript/TypeScript)
- ✅ Postman + Newman CLI
- ✅ K6 (Go-based load testing)
- ✅ Git version control
- ✅ GitHub Actions (CI/CD)

---

## 📧 Contact

**QA Analyst:** Chibuzor  
**Portfolio:** [GitHub - letswatchout-qa-portfolio](https://github.com/chibuzor_dev/letswatchout-qa-portfolio)  
**Project Link:** [LetsWatchOut](https://github.com/chibuzor_dev/WeWatch)  
**LinkedIn:** [linkedin.com/in/chibuzor](https://linkedin.com/in/chibuzor)

---

## 📄 License

This QA portfolio is open source for educational and demonstration purposes.

---

## 🔖 Tags

`qa-testing` `test-automation` `playwright` `postman` `k6` `manual-testing` `bug-tracking` `test-strategy` `portfolio` `quality-assurance` `react` `golang` `websocket` `real-time-testing`

---

**Last Updated:** April 14, 2026  
**Status:** 🟡 In Progress (Week 3 - Test Planning Phase)
