# GitHub Pages Deployment

This guide explains how to deploy the country_search example app to GitHub Pages.

## Automatic Deployment (Recommended)

The project includes a GitHub Actions workflow that automatically builds and deploys the web app to GitHub Pages.

### Setup Steps:

1. **Enable GitHub Pages** in your repository settings:
   - Go to Settings → Pages
   - Source: "Deploy from a branch"
   - Branch: `gh-pages` (will be created automatically)
   - Folder: `/ (root)`

2. **Push to main branch** - The workflow will automatically:
   - Build the Flutter web app
   - Deploy to GitHub Pages
   - Make it available at `https://yourusername.github.io/country_search/`

## Manual Deployment

If you prefer manual deployment:

```bash
# Navigate to example directory
cd example

# Get dependencies
flutter pub get

# Build for web
flutter build web --release

# The built files will be in example/build/web/
# Upload these files to your GitHub Pages branch
```

## Troubleshooting

### Common Issues:

1. **Build fails**: Make sure Flutter web is enabled:
   ```bash
   flutter config --enable-web
   ```

2. **Page not loading**: Check that the `gh-pages` branch contains the built files from `example/build/web/`

3. **404 errors**: Ensure the base URL is correctly set in the GitHub repository settings

### Verification:

After deployment, you should see:
- ✅ Live demo link in README works
- ✅ Country picker loads and functions correctly
- ✅ All 19 languages work
- ✅ Search functionality works
- ✅ Theme switching works

## Custom Domain (Optional)

To use a custom domain:

1. Add a `CNAME` file to the `gh-pages` branch with your domain
2. Configure DNS settings for your domain
3. Update the live demo link in README.md

## Performance

The deployed app is optimized for:
- Fast loading (< 2 seconds)
- Mobile responsiveness
- Cross-browser compatibility
- SEO-friendly structure 