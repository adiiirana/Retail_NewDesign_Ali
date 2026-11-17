# Call Script — Registering with Elavon (XEPOS / Software Vendor)

**Use this when calling Elavon** to register your business for payment integration with XEPOS.  
**Goal:** Become an approved software integrator (ISV) so customer tills can take Elavon card payments inside XEPOS.  
**Not the same as:** opening a shop MID for your own café — say clearly you are a **POS software company**.

---

## Before you call — have this ready

| Item | Example / notes |
|------|-----------------|
| Company legal name | Your registered company name |
| Trading name | XEPOS / brand customers see |
| Country | United Kingdom (or your market) |
| What you sell | Windows WPF POS (OfflineRetailV2) for retail |
| Integration need | Card Present / terminal payments from the till |
| Hardware interest | Customer has / wants **PAX A920 Pro** (ask if supported) |
| Existing products in POS | Teya, Paymentsense, Evo, POSLink, etc. |
| Contact | Your name, email, phone |
| Website | If any |
| Approximate merchants | How many shops you might board (even rough) |

**Decide what you want from the call**

1. **Primary:** Register **XEPOS as an Elavon technology / ISV partner** (integrate POS ↔ Elavon).  
2. **Optional:** Separately, a merchant account if *your own* company also takes cards (usually not needed just to sell POS).

---

## Who to contact

- UK / general: [https://www.elavon.co.uk](https://www.elavon.co.uk) → Contact / Sales  
- Developer / Commerce interest (US docs often cite): `websales@elavon.com`  
- If you already have a relationship manager or ISO, call them first  

Ask for: **Partner / ISV / Software Vendor / Solutions Engineer** — not only “new merchant signup.”

---

## Complete phone script

### 1) Opening

> Hello, my name is **[Your Name]** from **[Company Legal Name]**.  
> We build and sell a Windows point-of-sale system called **XEPOS**.  
> I’m calling because we want to **integrate Elavon card payments into our POS software** so our merchant customers can take chip-and-PIN / contactless payments from the till.  
> Could you please connect me to someone who handles **software vendor / ISV / partner integrations**, or a **Solutions Engineer** for POS integrators?

If they try to push only a small-shop merchant application:

> Just to clarify — we are **not** only looking for a single retail MID for our own shop.  
> We are a **software company**. Our **customers** will each need their own Elavon merchant accounts.  
> We need Elavon to **approve and support our POS as an integrated solution**.

---

### 2) Explain your product (30 seconds)

> XEPOS is a **.NET / WPF Windows POS** used in retail.  
> We already integrate other gateways such as **Teya, Paymentsense, and Evo**.  
> We want to add **Elavon** the same way: cashier selects card tender in XEPOS, payment goes to Elavon, approval is stored on the sale, and **settlement goes to each merchant’s own bank account** — not to us.

---

### 3) What you are asking them for

> Please can you help us with the following:
>
> 1. **Register our company as an Elavon integrating partner / ISV** for the UK.  
> 2. Tell us **which Elavon product** we should use for in-store POS with a card terminal — for example Elavon Payment Gateway (EPG), Converge / Commerce Web Services, Cloud Payments / device pairing, BroadPOS, or another product.  
> 3. Confirm whether a **PAX A920 Pro** is **supported** for POS software integration on that product (many of our prospects mention this device and sometimes a pair code).  
> 4. Explain what **credentials and onboarding** we need as the software vendor (vendor ID, integrator ID, production access, certification).  
> 5. Explain what **each of our merchant customers** must do separately (Application, MID, bank account, terminal).  
> 6. Share the **integration Documentation**, test process, and **certification** steps before go-live.  
> 7. Introduce us to a **Solutions Engineer** or partner manager and send next-step emails.

---

### 4) Questions to ask (tick as you go)

**Product & hardware**

- [ ] Which Elavon product is recommended for a **Windows desktop POS** driving an in-person terminal in the **UK**?  
- [ ] Is **PAX A920 Pro** on the supported device list for that product?  
- [ ] If not, which terminals are supported for our integration?  
- [ ] Is a **pair code** on the device the correct flow, or do we use another connection method?  
- [ ] Do merchants need **Commerce Web Services (CWS)** installed on the till PC, or is it cloud-only?

**Partner / credentials**

- [ ] How do we formally register as a **software partner / ISV**?  
- [ ] What identifiers will you issue to **us** (vendor ID, integrator ID, etc.)?  
- [ ] What does **each merchant** receive (MID, portal login, terminal ID)?  
- [ ] Can you confirm settlement always goes to the **merchant’s bank**, not the software vendor?  
- [ ] What is the path from **test** to **production** and how long does **certification** usually take?

**Commercial**

- [ ] Are there partner programme fees for ISVs?  
- [ ] Do you work through an **ISO / bank partner** we should speak to instead?  
- [ ] Who is our ongoing contact (name, email, phone)?

**Support**

- [ ] Where do merchants get support vs where do we (the ISV) get technical support?  
- [ ] Can you email the Operating Guide / integration checklist / partner pack?

---

### 5) What to say about money (important)

> We understand that when a customer pays by card in a shop using XEPOS, **Elavon settles to that shop’s merchant account**.  
> We only charge the shop for **software**.  
> Please confirm that is the correct model and that we should **not** put all our customers under one shared MID belonging to us.

*(Correct answer you want: Yes — each merchant has their own MID; you are the software integrator.)*

---

### 6) If they ask “Do you want a merchant account?”

> If you mean an account so **our company** can accept cards for our own invoices, we can discuss that separately later.  
> Today’s priority is **ISV / POS integration** so our **merchant customers** can accept cards through XEPOS with **their own** Elavon accounts.

---

### 7) If they ask about volumes

> We have an existing POS customer base and are adding Elavon because merchants are requesting it.  
> Exact volumes depend on rollout; we can share estimates after we know the approved product and timeline.  
> First we need technical product confirmation and partner onboarding steps.

---

### 8) Closing

> Thank you. Could you please email me:
>
> - Confirmation of the recommended product for Windows POS + in-person terminal  
> - Whether PAX A920 Pro is supported  
> - Partner / ISV registration steps and forms  
> - Name and email of our Solutions Engineer or partner contact  
> - Any Documentation or certification checklist  
>
> My email is **[your email]** and my phone is **[your phone]**.  
> Company name again: **[Company Legal Name]**, product **XEPOS**.  
> I look forward to your email. Goodbye.

---

## Short email version (if they ask you to email instead)

**Subject:** ISV / POS integration enquiry — XEPOS Windows POS (UK)

```text
Hello,

We are [Company Legal Name], developers of XEPOS, a Windows (.NET/WPF) retail POS.

We want to integrate Elavon for in-person card payments from the till. Our merchants would each hold their own Elavon merchant account and receive settlement to their own bank. We need to register as a software integrator / ISV partner.

Please advise:
1. Recommended Elavon product for Windows POS + card terminal (UK)
2. Whether PAX A920 Pro is supported for POS-driven payments
3. Partner/ISV onboarding steps and credentials issued to the software vendor
4. Certification process and Documentation
5. Solutions Engineer / partner contact

Contact: [Name], [Email], [Phone]
Website: [URL]

Thank you,
[Name]
```

---

## After the call — write down

| Field | Fill in |
|-------|---------|
| Date / time of call | |
| Elavon person name | |
| Email / phone | |
| Product they recommended | |
| A920 Pro supported? Y/N / unknown | |
| Next step they promised | |
| Forms or portal links they mentioned | |
| Reference / case number | |

---

## What “success” looks like from this call

You leave with (or get by email soon):

1. Clear statement you are being onboarded as an **ISV / partner**, not only as one shop.  
2. Named **product** for integration.  
3. Clear yes/no (or “we’ll check”) on **PAX A920 Pro**.  
4. A **Solutions Engineer / partner** contact.  
5. List of **next actions** (forms, docs, certification).

Until those exist, do not promise customers a live XEPOS↔Elavon integration date.
