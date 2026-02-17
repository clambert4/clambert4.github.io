# SSL Troubleshooting Guide

## Common SSL Errors and Solutions

### Error 1: "Your connection is not private" or "NET::ERR_CERT_COMMON_NAME_INVALID"

**Cause:** GitHub Pages hasn't issued the SSL certificate yet, or DNS isn't properly configured.

**Solutions:**

1. **Check GitHub Pages Settings:**
   - Go to: https://github.com/clambert4/clambert4.github.io/settings/pages
   - Verify "Enforce HTTPS" is checked
   - If unchecked, check it and wait 10-15 minutes
   - If already checked, try unchecking, saving, then checking again

2. **Verify DNS Records:**
   ```bash
   # Check if DNS is pointing to GitHub Pages
   dig chris-s-lambert.com +short
   
   # Should return GitHub Pages IPs:
   # 185.199.108.153
   # 185.199.109.153
   # 185.199.110.153
   # 185.199.111.153
   ```

3. **Wait for DNS Propagation:**
   - DNS changes can take 24-48 hours
   - Check propagation: https://www.whatsmydns.net/#A/chris-s-lambert.com

4. **Remove and Re-add Custom Domain:**
   - Go to GitHub Pages settings
   - Remove "chris-s-lambert.com" from Custom domain
   - Save
   - Wait 5 minutes
   - Add "chris-s-lambert.com" back
   - Save
   - Wait 10-15 minutes for SSL certificate

### Error 2: "SSL certificate problem: unable to get local issuer certificate"

**Cause:** Certificate chain issue or browser cache.

**Solutions:**

1. **Clear Browser Cache:**
   - Chrome: Settings → Privacy → Clear browsing data → Cached images and files
   - Firefox: Settings → Privacy → Clear Data → Cached Web Content
   - Safari: Develop → Empty Caches

2. **Try Incognito/Private Mode:**
   - This bypasses cache issues

3. **Try Different Browser:**
   - Test in Chrome, Firefox, Safari, Edge

### Error 3: Certificate shows "github.io" instead of "chris-s-lambert.com"

**Cause:** Custom domain not properly configured in GitHub Pages.

**Solutions:**

1. **Verify CNAME File:**
   ```bash
   cat CNAME
   # Should contain only: chris-s-lambert.com
   ```

2. **Check GitHub Pages Settings:**
   - Custom domain should show: chris-s-lambert.com
   - Not: clambert4.github.io

3. **Re-save Custom Domain:**
   - Remove custom domain
   - Save
   - Add it back
   - Save
   - Wait 15 minutes

### Error 4: "This site can't provide a secure connection"

**Cause:** HTTPS not yet enabled or DNS issues.

**Solutions:**

1. **Wait for Certificate Issuance:**
   - Can take up to 24 hours after DNS changes
   - Check status in GitHub Pages settings

2. **Verify DNS A Records:**
   Your DNS provider should have these A records:
   ```
   Type: A
   Name: @ (or chris-s-lambert.com)
   Value: 185.199.108.153
   
   Type: A
   Name: @ (or chris-s-lambert.com)
   Value: 185.199.109.153
   
   Type: A
   Name: @ (or chris-s-lambert.com)
   Value: 185.199.110.153
   
   Type: A
   Name: @ (or chris-s-lambert.com)
   Value: 185.199.111.153
   ```

3. **Check for AAAA Records (IPv6):**
   If you want IPv6 support, add:
   ```
   Type: AAAA
   Name: @
   Value: 2606:50c0:8000::153
   
   Type: AAAA
   Name: @
   Value: 2606:50c0:8001::153
   
   Type: AAAA
   Name: @
   Value: 2606:50c0:8002::153
   
   Type: AAAA
   Name: @
   Value: 2606:50c0:8003::153
   ```

## Diagnostic Commands

### Check DNS Resolution
```bash
# Check A records
dig chris-s-lambert.com A +short

# Check if it resolves to GitHub Pages
nslookup chris-s-lambert.com

# Check DNS propagation globally
# Visit: https://www.whatsmydns.net/#A/chris-s-lambert.com
```

### Check SSL Certificate
```bash
# Check certificate details
openssl s_client -connect chris-s-lambert.com:443 -servername chris-s-lambert.com

# Or use online tool:
# https://www.ssllabs.com/ssltest/analyze.html?d=chris-s-lambert.com
```

### Check HTTP to HTTPS Redirect
```bash
# Should redirect to HTTPS
curl -I http://chris-s-lambert.com

# Should return 301 or 302 redirect
```

## Step-by-Step Fix Process

### Step 1: Verify GitHub Pages Configuration

1. Go to: https://github.com/clambert4/clambert4.github.io/settings/pages
2. Check:
   - ✅ Source: Deploy from a branch → main
   - ✅ Custom domain: chris-s-lambert.com
   - ✅ Enforce HTTPS: Checked

### Step 2: Verify CNAME File

1. Check file exists:
   ```bash
   cat clambert4.github.io/CNAME
   ```

2. Should contain only:
   ```
   chris-s-lambert.com
   ```

3. No extra spaces, no "www", no "https://"

### Step 3: Check DNS Records

1. Log into your DNS provider (GoDaddy, Namecheap, Cloudflare, etc.)

2. Verify A records point to GitHub Pages:
   ```
   185.199.108.153
   185.199.109.153
   185.199.110.153
   185.199.111.153
   ```

3. Remove any conflicting records:
   - Remove old A records
   - Remove CNAME records for @ (apex domain)
   - Keep only the 4 GitHub Pages A records

### Step 4: Force Certificate Refresh

1. Go to GitHub Pages settings
2. Remove custom domain (delete "chris-s-lambert.com")
3. Click Save
4. Wait 5 minutes
5. Add custom domain back ("chris-s-lambert.com")
6. Click Save
7. Check "Enforce HTTPS"
8. Wait 10-15 minutes

### Step 5: Verify Certificate Issuance

1. Visit: https://chris-s-lambert.com
2. Click padlock icon in browser
3. Check certificate details:
   - Issued to: chris-s-lambert.com
   - Issued by: Let's Encrypt
   - Valid dates: Should be current

## Common Mistakes

### ❌ Wrong CNAME Content
```
# WRONG - includes www
www.chris-s-lambert.com

# WRONG - includes protocol
https://chris-s-lambert.com

# WRONG - includes path
chris-s-lambert.com/

# CORRECT
chris-s-lambert.com
```

### ❌ Wrong DNS Records
```
# WRONG - CNAME for apex domain
Type: CNAME
Name: @
Value: clambert4.github.io

# CORRECT - A records for apex domain
Type: A
Name: @
Value: 185.199.108.153 (and 3 others)
```

### ❌ Mixed Records
```
# WRONG - Both A and CNAME for same domain
Type: A
Name: @
Value: 185.199.108.153

Type: CNAME
Name: @
Value: clambert4.github.io

# CORRECT - Only A records for apex
Type: A
Name: @
Value: 185.199.108.153 (and 3 others)
```

## Timeline Expectations

- **DNS Changes:** 1-48 hours for global propagation
- **SSL Certificate:** 10 minutes - 24 hours after DNS is correct
- **GitHub Pages Build:** 1-2 minutes after push
- **Total Time:** Can take up to 48 hours for everything to work

## Still Having Issues?

### Check These:

1. **DNS Propagation:**
   - https://www.whatsmydns.net/#A/chris-s-lambert.com
   - Should show GitHub Pages IPs globally

2. **GitHub Pages Status:**
   - https://www.githubstatus.com/
   - Check for any ongoing issues

3. **Certificate Status:**
   - https://www.ssllabs.com/ssltest/analyze.html?d=chris-s-lambert.com
   - Should show A or A+ rating

4. **Browser Issues:**
   - Clear cache completely
   - Try incognito mode
   - Try different browser
   - Try different device

### Contact Support:

If nothing works after 48 hours:

1. **GitHub Support:**
   - https://support.github.com/
   - Select "GitHub Pages" category

2. **DNS Provider Support:**
   - Contact your domain registrar
   - Verify DNS records are correct

## Quick Fix Checklist

- [ ] CNAME file contains only "chris-s-lambert.com"
- [ ] GitHub Pages custom domain is "chris-s-lambert.com"
- [ ] "Enforce HTTPS" is checked
- [ ] DNS A records point to GitHub Pages IPs
- [ ] No conflicting DNS records
- [ ] Waited at least 15 minutes after changes
- [ ] Cleared browser cache
- [ ] Tested in incognito mode
- [ ] Tested in different browser
- [ ] DNS propagation complete (check whatsmydns.net)

## Current Status Check

Run these commands to check current status:

```bash
# 1. Check DNS
dig chris-s-lambert.com +short

# 2. Check HTTPS
curl -I https://chris-s-lambert.com

# 3. Check redirect
curl -I http://chris-s-lambert.com

# 4. Check certificate
echo | openssl s_client -connect chris-s-lambert.com:443 -servername chris-s-lambert.com 2>/dev/null | openssl x509 -noout -subject -dates
```

Expected results:
1. Should return GitHub Pages IPs
2. Should return 200 OK
3. Should return 301/302 redirect to HTTPS
4. Should show chris-s-lambert.com and valid dates

---

**Need immediate help?** Share the specific error message you're seeing and I can provide targeted solutions.
