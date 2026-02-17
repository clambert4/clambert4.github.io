#!/bin/bash

# Deployment Script for Modernized Site
# Run this script to deploy all changes to GitHub Pages

echo "🚀 Deploying modernized site to GitHub Pages..."
echo ""

# Check if we're in the right directory
if [ ! -f "CNAME" ]; then
    echo "❌ Error: Not in clambert4.github.io directory"
    echo "Please cd to the correct directory first"
    exit 1
fi

# Show what will be deployed
echo "📦 Files to be deployed:"
echo ""
git status --short
echo ""

# Confirm deployment
read -p "Deploy these changes? (y/n) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Deployment cancelled"
    exit 1
fi

# Add all changes
echo "📝 Adding changes..."
git add .

# Commit with timestamp
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
echo "💾 Committing changes..."
git commit -m "Modernize UI with contemporary design and add SSL documentation - $TIMESTAMP"

# Push to GitHub
echo "⬆️  Pushing to GitHub..."
git push origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Deployment successful!"
    echo ""
    echo "🌐 Your site will be live in 1-2 minutes at:"
    echo "   https://chris-s-lambert.com"
    echo ""
    echo "📋 Next steps:"
    echo "   1. Wait 1-2 minutes for GitHub Pages to build"
    echo "   2. Visit https://chris-s-lambert.com"
    echo "   3. Hard refresh (Ctrl+Shift+R or Cmd+Shift+R)"
    echo "   4. Verify modern design is visible"
    echo "   5. Check HTTPS padlock icon"
    echo ""
    echo "📊 Monitor deployment:"
    echo "   https://github.com/clambert4/clambert4.github.io/actions"
    echo ""
else
    echo ""
    echo "❌ Deployment failed!"
    echo "Check the error message above and try again"
    exit 1
fi
