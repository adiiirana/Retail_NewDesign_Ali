# How to Integrate Elavon Payment Gateway into XEPOS — With Examples

**System:** OfflineRetailV2 (XEPOS) — .NET Framework 4.8 WPF  
**Pattern to copy:** Existing gateways especially **Teya (10)** and **Evo (8)**  
**Status:** Design / how-it-works guide — not an implemented feature yet  
**Related docs:**
- [Elavon-UK-Account-Credentials-and-Connection-Procedure.md](Elavon-UK-Account-Credentials-and-Connection-Procedure.md)
- [Elavon-XEPOS-Money-Flow-and-Customer-Examples.md](Elavon-XEPOS-Money-Flow-and-Customer-Examples.md)

---

## 1. Goal

Add **Elavon** as another selectable payment gateway so that when a cashier takes a **Credit Card / Debit Card** tender:

1. XEPOS sends the amount to Elavon (API and/or terminal).  
2. The shopper pays on the Elavon-approved device / flow.  
3. On approval, XEPOS stores auth details and completes the sale.  
4. **Money settles to that shop’s Elavon merchant account** (not to XEPOS Ltd).

---

## 2. How payments work in XEPOS today (what you plug into)

```text
POSControl (checkout)
    → opens frmPOSTenderDlg
        → cashier adds tenders (Cash, Credit Card, …)
        → on OK, if POSCardPayment == "Y"
            → InsertCardTrans()          // pending card row
            → CardVarify()               // switch on Settings.PaymentGateway
                 1 Element | 2 Mercury | … | 8 Evo | 9 Paymentsense | 10 Teya
            → UpdateCardResponse / UpdateCardTransOnEvoResponse
            → mark tender PROCESSCARD = Y
        → save sale + Tender rows + receipts
```

There is **no plugin interface**. A new gateway is another `if (Settings.PaymentGateway == N)` branch, plus setup UI and settings fields — same as Teya.

---

## 3. Target architecture for Elavon

```text
┌──────────────────────────┐
│  XEPOS till (WPF)        │
│  General Setup: Elavon   │
│  MID / terminal settings │
└────────────┬─────────────┘
             │ sale / void / refund
             ▼
┌──────────────────────────┐
│  ElavonCwsClient or      │
│  ElavonEpgClient         │  ← new helper class (like ProcessTeyaSale)
└────────────┬─────────────┘
             │
             ▼
┌──────────────────────────┐
│  Elavon (gateway +       │
│  merchant’s terminal)    │
└────────────┬─────────────┘
             │ settlement
             ▼
     Merchant’s bank account
```

**Recommended implementation style:** mirror **Teya** — HTTP client + poll/wait for result + update `CardTrans`.

Exact Elavon endpoint/product (EPG cloud API vs local terminal connector) must be confirmed with Elavon for each merchant’s hardware. The **XEPOS wiring** below stays the same either way.

---

## 4. Integration steps (what to build)

Assign the next free gateway ID, e.g. **`11 = Elavon`**.

### Step 1 — Setup UI

**File:** `OfflineRetailV2/UserControls/Administrator/frm_GeneralSetupDlg.xaml` (+ `.cs`)

Add:

- Radio button: **Elavon** (e.g. `rgPaymentGateway_10` → maps to ID `11`)  
- Tab: **Elavon** with fields such as:

| Field (example) | Purpose |
|-----------------|--------|
| Merchant / Account ID (MID) | That shop’s Elavon merchant id |
| User / alias (if required) | Login / merchant alias for connector |
| PIN / secret (if required) | Keep secure; same care as Teya API key |
| Terminal / Device ID | Which device takes the card |
| Environment | Live / Test (if Elavon issues both) |
| Connector URL (if any) | Local or cloud base URL |

Load/save like Teya/Evo when the radio is checked and setup is saved.

### Step 2 — Settings + database setup

**Files:**
- `OfflineRetailV2/Data/Settings.cs` — static properties  
- `OfflineRetailV2/PosDataObject/clsSetup.cs` — persist/load columns  

Example property names:

```text
Settings.PaymentGateway == 11
Settings.ElavonMerchantId
Settings.ElavonTerminalId
Settings.ElavonUserId          // if needed
Settings.ElavonPinOrSecret     // if needed
Settings.ElavonBaseUrl         // if needed
Settings.ElavonEnvironment     // Live / Test
```

Each **customer installation** stores **their** values (same pattern as `TeyaApiKey`, `TeyaTerminalId`).

### Step 3 — Elavon client helper

**New file (example):** `OfflineRetailV2/Elavon/ElavonPaymentClient.cs`

Responsibilities:

| Method | Behaviour |
|--------|-----------|
| `ProcessSale(amount, reference)` | Start payment; wait until approved/declined/timeout |
| `ProcessRefund(amount, originalRef)` | Refund / linked refund |
| `ProcessVoid(originalRef)` | Void same-day if supported |
| `IsConfigured()` | Check required settings present |

Internally this may:

- Call Elavon’s cloud REST API with the merchant’s credentials, **or**  
- Talk to a local Elavon service / terminal bridge  

Return a simple result object, e.g.:

```text
Success: true/false
AuthCode: "123456"
TransactionId: "ELV-998877"
MaskedPan: "****1111"
CardBrand: "VISA"
ApprovedAmount: 24.99
ErrorMessage: "Declined" / "Terminal offline"
```

### Step 4 — Sale path in tender dialog

**File:** `OfflineRetailV2/UserControls/POSSection/frmPOSTenderDlg.xaml.cs`  
**Method:** `CardVarify()` (same place as `PaymentGateway == 10` for Teya)

Pseudo-flow for Elavon:

```text
if (Settings.PaymentGateway == 11)
{
    // CardTrans row already inserted → intCardTranID

    show progress: "Waiting for Elavon / card..."

    result = ElavonPaymentClient.ProcessSale(dblCardAmt, invoiceOrTranRef)

    if (result.Success)
    {
        link tender CCTRANNO = intCardTranID
        update CardTrans:
            AuthCode, Reference, RefCardTranID,
            RefCardAuthAmount, masked account, logo, entry mode
        PROCESSCARD = "Y"
        blCardVarify = true
    }
    else
    {
        show result.ErrorMessage
        blCardVarify = false
        stop tender OK
    }
}
```

### Step 5 — Refunds / voids

**File:** `frm_POSReturnReprintDlg.xaml.cs` (and any void helpers)

Same pattern as Teya refund:

```text
if (Settings.PaymentGateway == 11)
    call ElavonPaymentClient.ProcessRefund / ProcessVoid
    update CardTrans adjust/return flags
```

If Elavon does not support void, show a clear message (Teya already does this for voids).

### Step 6 — Tender types

**File:** `PosDataObject/clsTenderTypes.cs`

Ensure Credit Card / Debit Card (and gift if needed) appear when gateway is Elavon — either reuse existing card tenders or add an `FetchPOSDataForElavon` filter if names differ.

### Step 7 — Optional extras

- Logging folder under brand path (like Precidia/POSLink logs) — never log full PAN  
- Card transaction reports already read `CardTrans` — usually work if fields are filled  
- Progress text while waiting for the terminal (copy Teya’s “Waiting for card confirmation…”)

---

## 5. End-to-end examples

### Example 1 — Happy path sale (£24.99)

**Setup (Green Grocer’s till)**

```text
Payment Gateway = Elavon (11)
ElavonMerchantId = MID-7788
ElavonTerminalId = TERM-01
```

**Cashier actions**

1. Add items; total **£24.99**.  
2. Pay → Tender dialog.  
3. Choose **Credit Card**, amount £24.99.  
4. Press OK.

**What XEPOS does**

| Step | System action |
|------|----------------|
| 1 | Inserts pending `CardTrans` (amount 24.99, type Credit Card) |
| 2 | `CardVarify` sees gateway **11** |
| 3 | Calls Elavon sale for 24.99 on TERM-01 |
| 4 | Terminal prompts customer → tap/insert → PIN/SCA if required |
| 5 | Elavon returns Approved, Auth `AB12CD`, TranId `ELV-90001` |
| 6 | Updates `CardTrans` + marks tender processed |
| 7 | Saves invoice; prints receipts |

**Money**

```text
£24.99 → Elavon → Green Grocer’s bank (minus MSC)
XEPOS vendor: £0 from this card
```

---

### Example 2 — Declined card

1. Same as above, amount £50.00.  
2. Issuer declines.  
3. Elavon client returns `Success = false`, `ErrorMessage = "Declined"`.  
4. XEPOS shows message; **does not** complete that card tender.  
5. Cashier can try another card or Cash.  
6. No settlement to merchant for the failed attempt.

---

### Example 3 — Partial approval (if Elavon returns lower amount)

Some gateways authorise less than requested (XEPOS already handles this for Evo/Mercury-style flows).

```text
Requested: £100.00
Approved:  £40.00
```

XEPOS should:

1. Update tender amount to **£40.00**.  
2. Inform cashier: card only authorised £40.  
3. Let cashier take remaining £60 on another tender.

Implement only if Elavon’s response includes approved amount ≠ request.

---

### Example 4 — Refund next day

1. Original sale stored with `RefCardTranID = ELV-90001`.  
2. Customer returns goods; cashier opens return in XEPOS.  
3. Gateway 11 → `ProcessRefund(24.99, "ELV-90001")`.  
4. On success, update `CardTrans` return flags/amounts.  
5. Elavon credits the **same card**; merchant account is debited per Elavon rules.

---

### Example 5 — Two different customers (same XEPOS build)

| Till | Settings | Sale £10 goes to |
|------|----------|------------------|
| Café A | MID-A, TERM-A | Café A bank via Elavon |
| Shop B | MID-B, TERM-B | Shop B bank via Elavon |

Software is identical; **credentials differ per install**. Wrong MID in setup = money/auth against the wrong merchant (or failures) — always enter **that shop’s** Elavon details.

---

### Example 6 — Compared to Teya in code terms

**Teya today (simplified):**

```text
PaymentGateway == 10
ProcessTeyaSale(amount) → HTTP create payment → poll status
UpdateCardTransOnEvoResponse(AuthCode, Reference, …)
```

**Elavon later (same shape):**

```text
PaymentGateway == 11
ProcessElavonSale(amount) → Elavon connector → wait for result
UpdateCardTrans… (same fields filled from Elavon response)
```

If you can follow a Teya sale in the debugger, you already know the Elavon insertion points.

---

## 6. Sequence diagram — integrated sale

```text
Cashier          XEPOS Tender         Elavon Client         Terminal/Elavon
   |                   |                     |                      |
   |-- Credit Card --->|                     |                      |
   |                   |-- InsertCardTrans ->|                      |
   |                   |-- ProcessSale ----->|                      |
   |                   |                     |-- start payment ---->|
   |                   |                     |                      |-- customer pays
   |                   |                     |<-- approved ---------|
   |                   |<-- result ----------|                      |
   |                   |-- Update CardTrans  |                      |
   |                   |-- Save sale         |                      |
   |<-- receipt -------|                     |                      |
```

---

## 7. Configuration example (what the installer types)

**General Setup → Payment Gateway → Elavon**

```text
Environment:        Live
Merchant ID:        1234567
Terminal ID:        A920-SERIAL-OR-EPG-TERM-ID
User / Alias:       (as provided by Elavon for this MID)
Secret / PIN:       (as provided by Elavon — do not share)
Base URL:           (only if your approved connector needs it)
```

**Prerequisites before testing on site**

1. Shop Accepted by Elavon (own MID).  
2. Supported terminal online.  
3. Elavon confirmed this MID may be used from POS software.  
4. XEPOS build with gateway 11 installed.

---

## 8. Failure / edge-case examples

| Situation | Expected XEPOS behaviour |
|-----------|---------------------------|
| Elavon settings blank | Message: “Elavon is not configured” (like Teya) |
| Terminal offline / timeout | Fail tender; leave sale unpaid on card; allow retry |
| Customer cancels on pinpad | Fail tender; no auth stored as approved |
| Network drop after approve but before XEPOS updates | Need idempotent check / Elavon transaction lookup if API supports it — design carefully |
| Void not supported | Message to use refund (same idea as Teya) |
| Gateway still set to Paymentsense | Elavon code path not used — switch radio to Elavon |

---

## 9. Files checklist (implementation map)

| Area | Files |
|------|--------|
| Gateway radio + Elavon tab | `frm_GeneralSetupDlg.xaml`, `.xaml.cs` |
| Settings properties | `Data/Settings.cs` |
| Save/load setup | `PosDataObject/clsSetup.cs` (+ DB columns if needed) |
| Sale switchboard | `frmPOSTenderDlg.xaml.cs` → `CardVarify` |
| Elavon HTTP/terminal logic | New `ElavonPaymentClient.cs` (or similar) |
| Returns / refunds | `frm_POSReturnReprintDlg.xaml.cs` |
| Tender list filters | `PosDataObject/clsTenderTypes.cs` |
| Optional progress UI | Reuse Teya progress helpers or small wait dialog |

---

## 10. How it “works” for the shop after integration

1. Installer sets **Payment Gateway = Elavon** and pastes **that shop’s** credentials.  
2. Every card tender on that till goes through Elavon.  
3. Approvals appear in XEPOS history (`CardTrans`) and in the merchant’s Elavon portals (e.g. iMerchantConnect / EPG UI).  
4. Elavon settles to the **shop’s bank**.  
5. XEPOS continues to handle inventory, receipts, and reports as today.

---

## 11. What this document does *not* decide

- Exact Elavon REST JSON or CWS command names (depends on product Elavon assigns).  
- Whether PAX A920 Pro is supported for your MID.  
- Production certification steps with Elavon.

Those come from Elavon’s product Documentation / Solutions Engineer. The **XEPOS-side** integration pattern above stays valid once that product is chosen.

---

## 12. One-sentence summary

**Integrate Elavon like Teya:** add gateway ID 11, store each shop’s Elavon settings, call Elavon inside `CardVarify`, save the auth on `CardTrans` — then card sales work in XEPOS while **each customer still receives their own money via their own Elavon account.**
