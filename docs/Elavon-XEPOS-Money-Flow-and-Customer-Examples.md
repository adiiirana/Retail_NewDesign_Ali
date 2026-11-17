# Elavon + XEPOS — How Payments Work, Who Gets the Money, and Customer Examples

**Audience:** XEPOS product / sales / support  
**Purpose:** Explain how Elavon would sit next to existing XEPOS payment gateways, who receives settlement money, and what each shop must register for themselves.  
**Related:** [Elavon-UK-Account-Credentials-and-Connection-Procedure.md](Elavon-UK-Account-Credentials-and-Connection-Procedure.md)

---

## 1. Short answers

| Question | Answer |
|----------|--------|
| If I integrate Elavon into XEPOS and give the system to customers, **do I (XEPOS) receive the card money?** | **No** (normal model). Card money settles to **each merchant’s bank account** under **their** Elavon MID. |
| Do **customers** need to register Elavon themselves? | **Yes.** Each shop needs its own Elavon merchant account (Application → Acceptance → MID → their bank account). |
| What does XEPOS get? | Software that can talk to Elavon (once built), plus any **vendor / integrator** relationship Elavon requires. You sell/licence the POS — you are **not** the acquirer for their sales. |
| Is this different from Teya / Paymentsense / Evo in XEPOS today? | **No — same commercial pattern.** Each till stores **that shop’s** keys/MID/terminal IDs in General Setup. |

---

## 2. Who is who

```text
Cardholder
    pays on terminal / card
        →
Elavon (acquirer / gateway)
    settles funds
        →
Merchant’s bank account   ←  the XEPOS CUSTOMER (shop)
        
XEPOS (software vendor)
    provides the till software
    does NOT receive the £20 coffee sale
    may charge the shop a software licence / support fee separately
```

- **Merchant / Customer** = the shop using XEPOS (e.g. “Blue Cup Café”).  
- **XEPOS / You** = software company that ships OfflineRetailV2.  
- **Elavon** = payment acquirer / gateway that moves card money to the merchant.

Unless you deliberately become a **Payment Facilitator** or master-merchant (rare, heavily regulated, different contract), **you never touch the card settlement**.

---

## 3. How XEPOS payment methods work today (same pattern Elavon would follow)

In XEPOS, card processing is chosen per installation via **Payment Gateway** in General Setup (`Settings.PaymentGateway`). Only one gateway is active at a time. Credentials are stored **per shop database / setup**, not in a global XEPOS cloud wallet.

| Gateway ID (today) | Provider | What each shop configures | Who gets the money |
|--------------------|----------|---------------------------|--------------------|
| 1 | Element | Account ID, token, terminal ID, etc. | That shop’s Element merchant account |
| 2 | Mercury | Merchant ID, user, PIN pad port, etc. | That shop’s Mercury account |
| 3 | Precidia | MAC, port, PIN pad flags | That shop’s Precidia/processor account |
| 4 | Demo | None (fake) | Nobody — test only |
| 5–6 | Datacap / Datacap EMV | Server IP, MID, COM ports | That shop’s Datacap/processor account |
| 7 | POSLink (PAX) | Serial/IP to PAX | Whatever acquirer is behind that PAX |
| 8 | Evo | Local XeConnect / Evo API settings | That shop’s Evo merchant account |
| 9 | Paymentsense | Account name, API key, terminal | That shop’s Paymentsense account |
| 10 | Teya | API key, merchant/store/terminal IDs | That shop’s Teya account |
| **(future)** | **Elavon** | **That shop’s Elavon MID + terminal / portal settings** | **That shop’s Elavon settlement account** |

### Example — Teya today (same idea as Elavon later)

1. Café A signs up with **Teya** and gets API key + terminal.  
2. In XEPOS General Setup they select **Teya** and paste **Café A’s** key.  
3. Customer pays £12.50 by card.  
4. Teya settles **£12.50 (minus fees)** to **Café A’s bank**.  
5. You (XEPOS) receive **£0** from that card sale. You only get whatever software fee Café A pays you.

Elavon would work the same way: replace “Teya” with “Elavon” and “API key” with “Elavon MID / credentials Elavon issues to that café”.

---

## 4. Money flow examples

### Example A — Correct normal model (recommended)

**People**

- You = XEPOS vendor  
- Customer = “Green Grocer Ltd”  
- Acquirer = Elavon  

**Setup**

1. Green Grocer applies to **Elavon** and is Accepted.  
2. Elavon links settlement to **Green Grocer’s** bank account.  
3. You install XEPOS with **Payment Gateway = Elavon** and enter **Green Grocer’s** MID / terminal settings.  
4. Sale: apples £8.00 on card.

**Money**

```text
Cardholder £8.00
    → Elavon
    → Green Grocer Ltd bank account   (minus Elavon MSC / fees)

XEPOS bank account: unchanged by this sale
```

Green Grocer also pays you a separate invoice for XEPOS licence/support if that is your commercial agreement.

---

### Example B — Wrong assumption (“XEPOS receives all card money”)

If every shop’s cards settled to **your** Elavon account:

- You would be acting like the merchant of record for other businesses’ sales.  
- That usually requires Payment Facilitator / special Elavon contracts, KYC on every sub-merchant, tax and chargeback liability on you.  
- **Not** how current XEPOS gateways (Teya, Paymentsense, Evo, etc.) work.  
- **Do not** promise this to customers unless Elavon and your lawyers explicitly set it up.

---

### Example C — Two shops, two Elavon accounts

| Shop | Elavon MID | Bank settled | XEPOS setup |
|------|------------|--------------|-------------|
| Blue Cup Café | MID-1001 | Blue Cup’s bank | Gateway = Elavon, MID-1001, Terminal T1 |
| Red Book Store | MID-2002 | Red Book’s bank | Gateway = Elavon, MID-2002, Terminal T2 |

You ship the **same XEPOS software** to both.  
Each has **its own** Elavon registration.  
A £50 sale at Blue Cup never appears in Red Book’s Elavon account, and **neither** sale hits your company account.

---

### Example D — Same shop, switch from Paymentsense to Elavon

1. Shop already uses XEPOS + **Paymentsense** (gateway 9). Card money goes to shop via Paymentsense.  
2. Shop decides to move to Elavon: they apply to Elavon, get new MID and terminal.  
3. In General Setup they select **Elavon** and enter Elavon settings (and stop using Paymentsense).  
4. New card sales settle via **Elavon** to the shop.  
5. Old Paymentsense history stays with Paymentsense; XEPOS still has local `CardTrans` / tender history for reporting.

You still do not receive the card money.

---

### Example E — Terminal-only (no integrated Elavon in XEPOS yet)

1. Shop has XEPOS for products and cash/cheque tenders.  
2. Shop has a standalone Elavon terminal (amount typed on the device).  
3. Cashier finishes the XEPOS sale as **Cash** or a manual **Credit Card** tender **without** electronic auth from XEPOS, and takes the real payment on the Elavon terminal.  
4. Elavon still pays **the shop**.  
5. XEPOS may not have a matching electronic `CardTrans` auth from Elavon unless staff record it carefully — reconciliation is manual.

This is possible **today** without Elavon software integration. Integrated Elavon in XEPOS is what makes the till and the terminal stay in sync automatically.

---

## 5. What you register vs what the customer registers

| Item | Who registers / owns it | Why |
|------|-------------------------|-----|
| XEPOS software licence | You ↔ customer | Your product |
| Elavon **merchant Application + MID** | **Each customer** with Elavon | They are the seller of goods; settlement goes to them |
| Merchant bank account on Elavon | **Customer** | Where card money lands |
| Elavon terminal hire/purchase for that site | **Customer** (or their ISO) | Device on their counter |
| iMerchantConnect / EPG UI login for that MID | **Customer** | Their statements and chargebacks |
| “XEPOS is an Elavon-integrated POS” (vendor / partner status) | **You** with Elavon | Lets your software be certified / supported as an integration |
| Per-till settings in General Setup | Entered at **customer** site (or by your installer using **their** credentials) | Points that copy of XEPOS at **their** MID |

### Do customers need to register Elavon Payment Gateway themselves?

**Yes — for live settlement.**

- If they want card money in **their** bank, they must be boarded by Elavon (or their ISO) under **their** business.  
- You cannot “share” one Elavon merchant account across unrelated shops in the normal XEPOS model.  
- Your job is: ship software that can use Elavon **after** each shop has its own account (same as Teya/Paymentsense today).

---

## 6. Walkthrough — giving XEPOS + Elavon to a new customer

### Day 0 — Sales conversation

You tell the customer:

> XEPOS will record the sale and can send the card payment to Elavon once integrated.  
> You must open your own Elavon merchant account.  
> Card takings go to **your** bank.  
> We charge you for the software; Elavon charges you merchant service fees on cards.

### Day 1 — Customer with Elavon

1. Customer completes Elavon Application (business, bank, volumes, Card Present, etc.).  
2. Elavon Accepts them (welcome email).  
3. Customer receives MID, portal logins, Supported terminal.  
4. Customer (or you as installer) notes: MID, terminal ID, any connector settings Elavon gives for POS use.

### Day 2 — Install XEPOS

1. Install OfflineRetailV2 on their PC.  
2. General Setup → Payment Gateway → **Elavon** (once that option exists).  
3. Enter **that customer’s** Elavon settings only.  
4. Test a small card sale.

### Day 3 — Live sale example

| Step | What happens | Money |
|------|----------------|-------|
| 1 | Cashier rings £24.99 basket in XEPOS | — |
| 2 | Selects Credit Card tender | — |
| 3 | XEPOS calls Elavon / terminal for £24.99 | — |
| 4 | Customer taps/inserts card; approved | Auth held/settled by Elavon |
| 5 | XEPOS saves sale + `CardTrans` with auth code | — |
| 6 | Later batch/settlement | **£24.99 − fees → customer’s bank** |
| 7 | Your company | No deposit from this card |

### If customer never registers with Elavon

- Integrated card pay in XEPOS **cannot** settle to them.  
- They can still use XEPOS for cash/other tenders.  
- Or use another gateway they *have* registered (Teya, Paymentsense, etc.).

---

## 7. Fees — who pays what (example numbers)

Illustrative only — real fees are on each party’s contracts.

| Fee | Paid by | Paid to |
|-----|---------|---------|
| XEPOS monthly licence £99 | Shop | You |
| Elavon Merchant Service Charge e.g. 1.5% +  £0.10 | Shop | Elavon |
| Terminal hire £15/month | Shop | Elavon (if hired) |
| Chargeback / exception fees | Shop | Elavon |

**Example:** £100 card sale  

- Shop receives ~£98.40 from Elavon (after MSC).  
- You still receive only your £99 software fee that month (unrelated to the £100 sale).  

---

## 8. Chargebacks and risk — who is liable?

Under the normal model (shop is Elavon merchant):

- Cardholder disputes a sale → Elavon deals with **the shop’s MID**.  
- Shop must respond to retrieval requests and may lose the funds (Operating Guide Section 8).  
- **You** are not automatically liable for their chargebacks just because they use XEPOS — unless your contract with them or Elavon says otherwise.

That is another reason each shop must have **their own** Elavon account: risk and settlement follow the merchant of record.

---

## 9. Side-by-side story: three customers on your software

```text
You (XEPOS Ltd)
 ├── Customer A — Paymentsense MID-A → money to Bank A
 ├── Customer B — Teya MID-B         → money to Bank B
 └── Customer C — Elavon MID-C       → money to Bank C
```

All three run the **same** XEPOS build.  
Each General Setup points at **that shop’s** gateway credentials.  
Your company bank account is **not** in any of those settlement paths.

---

## 10. FAQ for sales / customers

**Q: If we buy XEPOS with Elavon, do you take a cut of every card payment?**  
A: Not via Elavon settlement. Elavon pays you (the shop). We charge separately for software.

**Q: Can we use your Elavon account?**  
A: No. You need your own Elavon merchant account so money and chargebacks sit with your business.

**Q: We already have Elavon on a standalone terminal. Do we still need to “register”?**  
A: You already did for the terminal. For XEPOS **integration**, Elavon must confirm that same MID can be used from POS software, and XEPOS must be configured with your settings.

**Q: We have no Elavon account yet.**  
A: Apply to Elavon (or your ISO) first. XEPOS can still run; card integration waits until you are Accepted.

**Q: Will all our shops share one Elavon MID?**  
A: Usually each legal entity / outlet follows Elavon’s boarding rules (sometimes one MID with multiple terminals, sometimes separate MIDs). Ask Elavon. XEPOS still stores whatever IDs Elavon assigns **per installation**.

**Q: Is Elavon different from Teya/Paymentsense in XEPOS?**  
A: Same idea: per-shop credentials, per-shop settlement. Different technical connector and setup fields.

---

## 11. What XEPOS must build later (reminder — not done in this doc)

To make Elavon behave like Teya/Evo inside the till:

1. New Payment Gateway option in General Setup.  
2. Fields for **that merchant’s** Elavon identifiers / terminal settings.  
3. Sale / void / refund calls in the tender flow.  
4. Save auth into `CardTrans` like other gateways.  

Commercial rule stays the same after coding: **credentials = customer’s; money = customer’s.**

---

## 12. One-page summary

1. **Integrate Elavon into XEPOS** = teach the software to talk to Elavon.  
2. **Give XEPOS to customers** = each shop installs the software.  
3. **Each shop registers with Elavon** = their MID, their bank, their terminal.  
4. **When they make sales** = Elavon pays **them**, not you.  
5. **You get paid** via software licence / support — not by taking their card takings.  
6. This matches how **Element, Mercury, Evo, Paymentsense, Teya** already work in XEPOS.

---

*Informational document for XEPOS. Not a contract with Elavon. Settlement and liability always follow the merchant Agreement Elavon has with each shop.*
