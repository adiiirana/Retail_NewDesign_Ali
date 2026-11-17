# Elavon UK — Create Account, Get Credentials, Connect to XEPOS

**Source:** Elavon *UK Operating Guide* (TOS – UK Operating Guide 03/2026)  
**Scope:** Merchant account setup, credentials, terminals, and how that connects to XEPOS conceptually.  
**Note:** This document does **not** cover Developer Portal / sandbox API keys. No application code is modified by this guide.

---

## 1. What the UK Operating Guide covers

| Included | Not the focus of this document |
|----------|--------------------------------|
| Merchant Application and Acceptance | Developer sandbox projects |
| MID, bank account, Direct Debit | Public/Secret API keys from developer.elavon.com |
| Terminals, Chip & PIN, SCA, refunds | REST hostname setup for integrators |
| Elavon Payment Gateway (EPG) merchant use | Certification engineering checklists |
| Elavon POS Services, iMerchantConnect | Pair-code cloud device APIs |

This Guide is the **merchant operating / legal** handbook after selecting Elavon as acquirer. Staff who take card payments should know the POS procedures in it.

---

## 2. End-to-end overview

```text
Contact Elavon sales
    → Complete Application (business, bank, transaction types, hardware)
    → KYC / AML / suitability checks
    → Acceptance (usually welcome email)
    → Receive MID + portal access (EPG UI / iMerchantConnect)
    → Install / hire Supported Terminal
    → Train staff on Operating Guide
    → Take live Card Present (and other consented) payments
    → (Optional later) Link XEPOS tender to Elavon once product path is agreed
```

---

## 3. Create a merchant account with Elavon

### Step 1 — Contact Elavon

1. Use [https://www.elavon.co.uk](https://www.elavon.co.uk) or speak to an Elavon **sales manager** / **customer account manager**.  
2. Tell them you need UK card acquiring and specify:
   - **Card Present** (terminal in store)  
   - Whether you also need Internet and/or Mail Order / Telephone Order (MO/TO)  
   - Whether you need **Elavon Payment Gateway** and/or **Elavon POS Services**  
   - Hardware: Elavon-supplied terminal **or** a third-party device (must be confirmed as **Supported Hardware**)

> Registration follows the process set by the Elavon sales or account manager during the sales process (Operating Guide, Section 23 §5.1).

### Step 2 — Complete the Application

Expect to provide:

- Legal / trading name, address, ownership, directors, beneficial owners  
- Nominated **bank account** for settlement and fees (Direct Debit)  
- Expected volumes and **transaction types**  
- Terminal hire or purchase preferences  
- Products/services sold (affects risk and which services Elavon enables)

**Consent required for certain channels (Section 16):**

| Channel | Rule |
|---------|------|
| Internet Transactions | Need Elavon’s prior written consent (often via accepted Application) |
| MO/TO | Same |
| DCC, Electronic Gift Cards, Recurring sales | Same pattern — enabled only if agreed / on Schedule of Fees |

Do not process those types until Elavon has agreed.

### Step 3 — Onboarding checks and Acceptance

Elavon will run onboarding checks (including KYC, AML, credit / suitability). They may decline even if checks look fine.

**Acceptance** is when Elavon confirms **in writing**, usually by a **welcome email**. Only then are you boarded for those Services.

You should then have (or be assigned):

- **Merchant ID (MID)** / account identifiers for statements and portals  
- Settlement to your bank account  
- **Schedule of Fees** (MSC and related charges)

### Step 4 — Bank account

- Maintain a valid merchant bank account.  
- Protect login details and account data.  
- Notify Elavon promptly of address / contact / account changes.  
- If the bank account changes, complete a new **Direct Debit Mandate** (forms via Elavon UK collateral / Customer Service as referenced in the Guide).

---

## 4. Credentials and portals the merchant receives

These are the credentials that matter for day-to-day merchant use (not developer sandbox keys).

| Access | How you get it | Purpose |
|--------|----------------|---------|
| **MID / account numbers** | Issued on Acceptance / welcome pack | Identify the merchant on statements, terminals, support |
| **Elavon Payment Gateway User Interface — username + password** | Issued after Acceptance (Section 24 §4) | Look up transactions; configure hosted payments; enter MO/TO; fraud tools |
| **iMerchantConnect** | Free — [www.iMerchantConnect.com](https://www.iMerchantConnect.com) (Section 9) | Deposits, batches, statements, chargebacks, MSC |
| **Terminal Supervisor / admin passwords** | With terminal setup / Quick Reference Guide | Offline / deferred auth features where enabled |
| **EPG Users** | Merchant creates additional users in EPG UI | Separate staff logins with permissions |

**Rules (Section 24 §4):**

- Keep usernames and passwords confidential.  
- Each EPG User should have their own login.  
- Notify Elavon immediately of unauthorised use or security breaches.

**EPG support (Section 24 §5):**

- Email: `epgsupporteurope@elavon.com` (response typically within two Business Days)  
- Or telephone via “Contact us” on the portal linked from the Guide  

---

## 5. Terminals and Card Present setup

### Supported hardware

- You must use **Supported Hardware** for Elavon POS Services (Section 23 §1.2).  
- Ask Elavon for the current Supported Hardware list.  
- Using unsupported devices can mean features fail; Elavon is not liable for that.

**If the customer has a PAX A920 Pro:** ask Elavon in writing whether it is Supported Hardware for their MID and which Elavon product runs on it (e.g. terminal app / BroadPOS / other). Do not assume it is covered because another shop uses PAX.

### Getting a terminal from Elavon

Typical path (Appendix 3 — hire, and Goods / Card Reader appendices):

1. Agree hire or purchase on the Application / Schedule of Fees.  
2. Accept delivery (hire: usually within 28 days of Elavon notifying you the unit is ready).  
3. Elavon installs or arranges installation as agreed.  
4. You provide power and telecoms / connectivity and pay related line charges.  
5. Operate the terminal per the Operating Guide and the terminal **Quick Reference Guide**.  
6. Keep the terminal clean, secure, and attended unless Elavon authorises otherwise.  
7. Do not repair or disassemble the unit yourself.  
8. Return hired terminals when the agreement ends (fees apply if not returned or damaged).

### Chip and PIN / contactless (Section 12)

- Terminals must be Chip and PIN compliant where C&P cards are accepted.  
- Provide a PIN Pad and a reasonably private area for PIN entry.  
- Do not ask the cardholder to disclose their PIN to staff.  
- Do not print PIN data on receipts.  
- Prefer chip / contactless over key entry to reduce fraud and exception charges (Section 11).

### Wireless / portable terminals (Section 12 §5)

- Coverage can fail. If you cannot get Authorisation / SCA, use the backup procedures in the Guide.  
- Completing sales without Authorisation because of poor signal is at **your own risk**.

### Daily Card Present practice (Sections 2–3, 13–14)

1. Check card dates, name, signature panel as applicable.  
2. Insert / tap / swipe as the terminal prompts.  
3. Obtain **Authorisation** (floor limit is normally zero unless Elavon agrees otherwise).  
4. Apply **SCA** when the Issuer / Elavon require it.  
5. Give the cardholder a receipt; keep your copy (retain **at least two years**).  
6. Batch / present transactions within the time limits in the Guide (typically within a few Business Days; scheme-specific outer limits apply).  
7. On decline: do not complete the card sale; offer another payment method.  
8. On suspicion: use **Code 10** via Authorisations.

---

## 6. Refunds and disputes (merchant obligations)

**Refunds (Section 15):**

- Issue a Refund Receipt; offer a copy to the cardholder.  
- Refund must not exceed the original sale.  
- Refund to the **same card / same cardholder account**.  
- Do not refund cash for a card sale unless the law requires it.  
- Elavon may debit your merchant bank account for refunds.

**Chargebacks (Section 8):**

- Can arise long after the sale (Guide notes periods up to hundreds of days).  
- Respond to retrieval / copy requests within the stated time (often 14 Business Days; sometimes 48 hours for fraud).  
- UK chargebacks contact in Guide: `chargebacks@elavon.com` / 0845 850 0195 option 4.

---

## 7. PCI DSS

You (and any third-party vendors you use) must comply with **PCI DSS** and related scheme programmes (Section 10).  
See [https://www.elavon.com/pci](https://www.elavon.com/pci).  

Optional **PCI Waiver Plan / Secured Pro** tools may be available if you meet eligibility (Section 22 / Appendix 2) — subscribe only if Elavon offers them on your Agreement.

---

## 8. Connecting this to XEPOS (conceptual)

XEPOS already supports multiple payment gateways via setup (`Settings.PaymentGateway`) and processes card tenders in the POS tender flow, storing results in `CardTrans`.

### What must be true before “connecting” XEPOS

1. Merchant is **Accepted** by Elavon (MID live).  
2. Elavon has confirmed the **in-person product** for that merchant (terminal driven by POS vs amount entered only on the terminal).  
3. Hardware is on Elavon’s **Supported** list for that product.  
4. Merchant portal logins work; staff can take a test live (or Elavon-guided) sale on the terminal.  
5. XEPOS product owner and Elavon agree how the till will talk to Elavon (implementation is separate work).

### Two connection models

| Model | What the merchant needs | Role of XEPOS |
|-------|-------------------------|---------------|
| **A. Terminal-only** | Boarded MID + Supported terminal + staff training | Sale total may be entered on the terminal manually; XEPOS records cash/other tenders or a manual “card” tender without driving the device |
| **B. Integrated POS** | Same as A, plus Elavon-approved POS integration method for your software | XEPOS tender screen starts the card payment, waits for approval, stores auth in `CardTrans` |

This document covers getting ready for **Model A** fully, and the **merchant-side prerequisites** for **Model B**. Building Model B inside XEPOS is a later engineering task once Elavon confirms the product.

### What to store in XEPOS setup later (merchant credentials, not sandbox)

When integration is approved, typical merchant-facing settings would include things like:

- Merchant / MID identifiers Elavon provides for that site  
- Terminal ID / lane / device name if applicable  
- Environment flag only if Elavon issues separate test vs live merchant accounts (still merchant accounts — not Developer Portal sandbox keys)  
- Any portal or connector settings Elavon documents for that product  

Exact fields depend on the product Elavon assigns.

---

## 9. Merchant go-live checklist

- [ ] Application submitted to Elavon sales / account manager  
- [ ] Onboarding checks completed  
- [ ] Welcome email / written Acceptance received  
- [ ] MID known and bank account + Direct Debit active  
- [ ] Schedule of Fees understood  
- [ ] Allowed channels confirmed (Card Present / Internet / MO/TO as needed)  
- [ ] Supported terminal delivered, installed, and working  
- [ ] EPG UI username/password received (if EPG is on the Agreement)  
- [ ] iMerchantConnect access working  
- [ ] Staff trained on Chip & PIN, declines, Code 10, refunds, receipts  
- [ ] Card scheme decals displayed where required  
- [ ] Receipt retention process (2 years) in place  
- [ ] PCI approach agreed  
- [ ] If using XEPOS integrated card pay: Elavon has confirmed Supported Hardware + integration method in writing  

---

## 10. Useful contacts (from the Operating Guide)

| Need | Contact |
|------|---------|
| General | [https://www.elavon.co.uk](https://www.elavon.co.uk) |
| iMerchantConnect | [https://www.iMerchantConnect.com](https://www.iMerchantConnect.com) |
| EPG support | `epgsupporteurope@elavon.com` |
| Chargebacks (UK) | `chargebacks@elavon.com` / 0845 850 0195 option 4 |
| PCI | [https://www.elavon.com/pci](https://www.elavon.com/pci) |
| Consumables / imprinters | Guide references Paper Rolls / elavonconsumables.com |

Legal entity on the Guide back cover: **U.S. Bank Europe DAC**, trading as **Elavon Merchant Services** (UK branch).

---

## 11. Short sequence to give a customer

1. Contact Elavon (or your ISO) and complete the **Application**.  
2. Wait for **Acceptance** / welcome email and your **MID**.  
3. Set up **bank account / Direct Debit**.  
4. Receive **portal logins** (EPG UI and/or iMerchantConnect).  
5. Get an Elavon-**Supported** terminal installed and trained.  
6. Take payments following the Operating Guide.  
7. Only after that, ask Elavon (and XEPOS) whether the till can **drive** the terminal; until then, XEPOS and the terminal can run as separate tools if needed.

---

*Based on Elavon UK Operating Guide 03/2026. Developer Portal / sandbox API material intentionally omitted.*
