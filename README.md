# Namespaxe Platform Testing Guide

## 🚀 Getting Started

This document outlines the step-by-step process for testing the Namespaxe multi-tenant Kubernetes platform. Follow these instructions to validate functionality across all key areas.

## 🔐 1. Authentication Testing

### Test Cases:

````markdown
- [ ] **Email Login**

  1. Navigate to `/signin`
  2. Enter valid credentials
  3. Verify successful redirect to dashboard

- [ ] **GitHub OAuth**

  1. Click "Login with GitHub"
  2. Complete authorization
  3. Verify session creation

- [ ] **Account Recovery**

  1. Visit `/forgot-password`
  2. Submit registered email
  3. Check inbox for reset link
  4. Verify password change

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

Would you like me to add any specific test scenarios or modify the formatting for particular sections?
```
````
