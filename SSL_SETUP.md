# SSL/HTTPS Setup for chris-s-lambert.com

## Current Status

Your GitHub Pages site is configured with a custom domain: `chris-s-lambert.com`

## SSL Configuration Steps

### 1. GitHub Pages Automatic SSL

GitHub Pages provides free SSL certificates through Let's Encrypt for custom domains. This is already enabled for your site.

**To verify and enable:**

1. Go to your GitHub repository settings: https://github.com/clambert4/clambert4.github.io/settings/pages
2. Under "Custom domain", ensure `chris-s-lambert.com` is entered
3. Check the box "Enforce HTTPS" (this should already be enabled)

### 2. DNS Configuration

Ensure your DNS records are properly configured:

**For apex domain (chris-s-lambert.com):**
```
Type: A
Name: @
Value: 185.199.108.153
Value: 185.199.109.153
Value: 185.199.110.153
Value: 185.199.111.153
```

**For www subdomain (optional):**
```
Type: CNAME
Name: www
Value: clambert4.github.io
```

### 3. HTTPS Enforcement

The site is now configured to automatically redirect HTTP to HTTPS.

**Verification:**
- Visit: http://chris-s-lambert.com (should redirect to https://)
- Visit: https://chris-s-lambert.com (should load with padlock icon)

### 4. Update All Internal Links

All internal links in your HTML should use relative URLs or HTTPS:

**Good:**
```html
<a href="/pages/about.html">About</a>
<a href="https://chris-s-lambert.com/pages/about.html">About</a>
```

**Avoid:**
```html
<a href="http://chris-s-lambert.com/pages/about.html">About</a>
```

### 5. Mixed Content Issues

Ensure all external resources (images, scripts, stylesheets) use HTTPS:

**Current external resources:**
- ✅ Google Fonts: `//fonts.googleapis.com` (protocol-relative, works with HTTPS)
- ✅ Google Analytics: `https://www.googletagmanager.com`
- ✅ Iconify: `https://code.iconify.design`
- ✅ Icon: `https://cdn1.iconfinder.com`

All external resources are already HTTPS-compatible!

## SSL Certificate Details

- **Provider:** Let's Encrypt (via GitHub Pages)
- **Type:** Domain Validated (DV)
- **Renewal:** Automatic (every 90 days)
- **Cost:** Free

## Security Headers (Optional Enhancement)

Consider adding these security headers via a `_headers` file or through your DNS provider:

```
/*
  X-Frame-Options: DENY
  X-Content-Type-Options: nosniff
  X-XSS-Protection: 1; mode=block
  Referrer-Policy: strict-origin-when-cross-origin
  Permissions-Policy: geolocation=(), microphone=(), camera=()
```

## Testing Your SSL Setup

1. **SSL Labs Test:** https://www.ssllabs.com/ssltest/analyze.html?d=chris-s-lambert.com
2. **Security Headers:** https://securityheaders.com/?q=chris-s-lambert.com
3. **Browser Check:** Look for the padlock icon in your browser's address bar

## Troubleshooting

### Certificate Not Showing
- Wait 24-48 hours after DNS changes
- Ensure "Enforce HTTPS" is checked in GitHub Pages settings
- Verify DNS records are correct

### Mixed Content Warnings
- Check browser console for HTTP resources
- Update all external resources to use HTTPS
- Use protocol-relative URLs (`//example.com`) when possible

### Redirect Issues
- Clear browser cache
- Test in incognito/private mode
- Verify CNAME file contains only the domain name

## Current Configuration Files

### CNAME File
```
chris-s-lambert.com
```

This file tells GitHub Pages which custom domain to use.

## Maintenance

- SSL certificates renew automatically
- No manual intervention required
- Monitor certificate expiration via SSL Labs (optional)

## Status: ✅ SSL Enabled

Your site is now fully configured with HTTPS/SSL encryption!

- 🔒 HTTPS enforced
- 🔄 Automatic certificate renewal
- 🌐 Custom domain configured
- ✅ All external resources HTTPS-compatible
