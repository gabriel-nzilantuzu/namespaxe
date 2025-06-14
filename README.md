# Namespaxe Platform Testing Guide

**Platform URL:** [https://namespaxe.com](https://namespaxe.com)

## 🚀 Getting Started

Validate all critical functionality of the Namespaxe multi-tenant Kubernetes platform using this test suite.

## 🔐 1. Authentication Testing

### Test Case 1: Email Login

**Objective:** Verify email/password authentication

**Steps:**

1. Navigate to [https://namespaxe.com/signin](https://namespaxe.com/signin)
2. Enter valid credentials:
   - Email: `your_test_user@company.com`
   - Password: `[valid_password]`
3. Click "Sign In"

**Verification:**

- [ ] Redirected to `https://namespaxe.com/dashboard`
- [ ] Username appears in navigation bar
- [ ] Session cookie contains `HttpOnly` and `Secure` flags

---

### Test Case 2: GitHub OAuth

**Objective:** Validate third-party authentication

**Steps:**

1. On sign-in page, click "Login with GitHub"
2. Complete GitHub authentication:
   - Enter GitHub credentials
   - Complete 2FA if enabled
3. Click "Authorize"

**Verification:**

- [ ] Redirected to Namespaxe dashboard
- [ ] GitHub account appears in Profile → Linked Accounts
- [ ] New session visible in Security → Active Sessions

---

### Test Case 3: Account Recovery

**Objective:** Test password reset workflow

**Steps:**

1. Visit [https://namespaxe.com/forgot-password](https://namespaxe.com/forgot-password)
2. Submit registered email address
3. Check inbox for "Password Reset Instructions" email
4. Click reset link (valid 24h)
5. Set new password:
   - New Password: `[secure_password]`
   - Confirm Password: `[secure_password]`

**Verification:**

- [ ] Confirmation toast message appears
- [ ] Can login with new credentials
- [ ] Old password rejects authentication

---

## 🔧 2. Edge Case Testing

**Negative Tests:**

- [ ] Attempt login with invalid email format
- [ ] Submit wrong password (verify lockout after 5 attempts)
- [ ] Click expired password reset link
- [ ] Revoke GitHub OAuth access via GitHub settings

## 🔒 Security Checks

- [ ] All authentication endpoints use HTTPS
- [ ] Session cookies have `SameSite=Lax` attribute
- [ ] Password field masks input

  | Action           | Steps                                                                   | Expected Result                |
  | ---------------- | ----------------------------------------------------------------------- | ------------------------------ |
  | Create Namespace | 1. Go to `/tenants` → "New Namespace"<br>2. Select package<br>3. Submit | Green status in dashboard      |
  | Delete Namespace | 1. Select namespace<br>2. Choose "Delete"<br>3. Confirm                 | Disappears from list           |
  | Restore RBAC     | 1. Select compromised namespace<br>2. Click "Repair Permissions"        | All RBAC resources regenerated |

1. Navigate to `/tenants/{subId}/{ns}/workloads`
2. Click "New Pod"
3. Select either:
   - Template (pre-configured)
   - Custom YAML
4. Verify:

   - Status transitions to "Running"
   - Logs are accessible
   - Metrics appear

5. Create deployment via:
   - [ ] UI Form
   - [ ] YAML Upload
6. Test:
   - [ ] Scaling (adjust replicas)
   - [ ] Rolling updates
   - [ ] Rollback function

- [ ] **Service Creation**

  - ClusterIP: `curl <service>.<namespace>.svc.cluster.local`
  - NodePort: Verify external access on assigned port

- [ ] **Ingress Validation**
  1. Create ingress rule
  2. Add DNS record
  3. Test:
     ```bash
     curl -H "Host: your-app.namespaxe.com" http://<ingress-ip>
     ```

1. **RBAC Tests**

   - [ ] Regular user cannot access admin actions
   - [ ] Cross-namespace access denied

2. **Secret Handling**

   - [ ] Create secret via UI
   - [ ] Verify:
     - Base64 encoding in API
     - No plaintext in etcd

3. **Audit Logs**
   ```bash
   kubectl logs -n namespaxe-system -l app=audit-trail
   ```

## 🐞 7. Reporting Issues

### Bug Report Template:

```markdown
**Environment:**

- Browser: [Chrome/Firefox/Safari]
- Cluster: [AWS/GCP/Azure]

**Steps to Reproduce:**

1.
2.
3.

**Expected Behavior:**

**Actual Behavior:**

**Screenshots:**
[Upload via Ctrl+V]

This README provides:

1. Clear test instructions
2. Code snippets for technical validations
3. Structured reporting format
4. Visual scheduling
5. Multiple verification methods
```

```

```
