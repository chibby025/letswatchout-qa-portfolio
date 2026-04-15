# Google Sheets Test Case Template - Setup Guide

**Time to Setup:** 5 minutes  
**Result:** Professional test management system with 105+ test cases

---

## Quick Setup Steps

### 1. Import CSV (2 minutes)
- Go to [Google Sheets](https://sheets.google.com)
- File → Import → Upload `test_cases_template.csv`
- Select "Replace current sheet" → Import

### 2. Format Header (1 minute)
- Select row 1 (header)
- **Bold** (Ctrl+B)
- Background color: Light blue (#CFE2F3)
- View → Freeze → 1 row

### 3. Add Dropdowns (2 minutes)

**Status Column (I):**
- Select I2:I1000
- Data → Data validation
- List: `Not Run, Pass, Fail, Blocked, In Progress, Skipped`

**Priority Column (D):**
- Select D2:D1000
- Data → Data validation  
- List: `Critical, High, Medium, Low`

**Feature Area Column (B):**
- Select B2:B1000
- Data → Data validation
- List: `Authentication, Content Filtering, Session Management, Payment & Wallet, Real-Time Chat, Video Upload, 3D Cinema, LiveKit Audio/Video, Performance, Cross-Browser`

### 4. Add Color Coding (Optional)
**Status Column:**
- Select I2:I1000
- Format → Conditional formatting
- Pass = Green background
- Fail = Red background
- Blocked = Orange background

---

## Create Test Summary Sheet

1. Click **+** at bottom → New sheet → Rename to "Test Summary"
2. Add these formulas:

```
A1: Total Test Cases
B1: =COUNTA('Test Cases'!A2:A1000)

A2: Tests Passed
B2: =COUNTIF('Test Cases'!I2:I1000,"Pass")

A3: Tests Failed
B3: =COUNTIF('Test Cases'!I2:I1000,"Fail")

A4: Pass Rate (%)
B4: =IF(B1>0,ROUND((B2/B1)*100,2),0)
```

---

## How to Use

### During Testing:
1. Open test case row
2. Follow steps in column F
3. Record actual results in column H
4. Update status in column I (Pass/Fail/Blocked)
5. Add screenshot link in column L
6. Fill execution date (column J)

### Track Progress:
- Check "Test Summary" sheet for pass rate
- Filter by Priority to focus on Critical tests first
- Filter by Status = "Fail" to see failures

---

## Interview Talking Points

*"I created a Google Sheets test management system with:*
- *105+ test cases with grey box validation (UI + API + DB)*
- *Automated metrics tracking pass rates and coverage*
- *Visual dashboards for stakeholder reporting*
- *Data validation dropdowns for consistency*
- *Conditional formatting for quick status visibility"*

---

**Portfolio File:** Add Google Sheets link to your resume/portfolio

