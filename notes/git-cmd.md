# GitHub Repository Creation Commands

git reset --hard


## 🚀 **Quick Start: Easiest Method (GitHub Web Interface)**

### **Step-by-Step Visual Method (RECOMMENDED):**
1. **Go to [GitHub.com](https://github.com)** and login to your account
2. **Click the green "New" button** (or "+" icon → "New repository")
3. **Fill in repository details:**
   - **Repository name**: `visionpro-floor-app` (or your preferred name)
   - **Description**: `VisionPro floor planning app`
   - **Public or Private**: Choose visibility
4. **Check initialization options (recommended):**
   - ✅ **Add a README file** - Creates initial documentation
   - ✅ **Add .gitignore**: Select **"Swift"** (perfect for VisionPro projects)
   - ✅ **Choose a license**: MIT is popular for open source
5. **Click "Create repository"** - Done! Repository is created on GitHub
6. **Connect your local project:**
   ```bash
   cd /Users/karanyang/Desktop/VisionPro_APP26
   git init
   git remote add origin https://github.com/karanY2019/VisionPro2026-Feature.git
   git add .
   git commit -m "Initial VisionPro app commit"
   git push -u origin main
   ```

**That's it! This visual method is the clearest and most beginner-friendly.**

---

## Alternative: GitHub CLI (For Command Line Users)

### **If you prefer command line:**
```bash
# Create repository via CLI (requires GitHub CLI installation)
gh repo create visionpro-floor-app --description "VisionPro floor planning app" --private --gitignore "Swift" --source . --push

# OR create and clone (easier for new projects)
gh repo create visionpro-floor-app --description "VisionPro floor planning app" --private --gitignore "Swift" --clone
```

---

## Method 1: Using GitHub Web Interface (Recommended)

### **Visual Step-by-Step Guide:**
1. **Navigate to GitHub.com** and log in to your account
2. **Click the green "New" button** (or the "+" icon in the top right corner → "New repository")
3. **Repository Configuration:**
   - **Repository name**: Enter a descriptive name (e.g., "visionpro-floor-app")
   - **Description**: Add a brief description of your project
   - **Visibility**: Choose "Public" (visible to everyone) or "Private" (only visible to you)
4. **Initialize Repository** (recommended options):
   - ✅ **Add a README file**: Creates a default README.md with project information
   - ✅ **Add .gitignore**: Select "Swift" for iOS/VisionPro projects
   - ✅ **Choose a license**: MIT License is popular for open source projects
5. **Click "Create repository"** - Your repository is now live on GitHub!
6. **Connect your local code:**
   ```bash
   cd /path/to/your/local/project
   git init
   git remote add origin https://github.com/yourusername/repository-name.git
   git add .
   git commit -m "Initial commit"
   git push -u origin main
   ```

### **Why This Method is Best:**
- **Visual and intuitive** - No command line complexity
- **Beginner-friendly** - Clear form fields and options
- **Immediate feedback** - See your repository created in real-time
- **No installation required** - Works in any web browser
- **Template selection** - Easy to add .gitignore and licenses

## Method 2: Using GitHub CLI

### ⚡ **Important: Global Installation**
GitHub CLI (`gh`) is installed **globally on your system**, not per-project. Once installed, it's available from any directory on your Mac.

### Prerequisites
```bash
# Install GitHub CLI (if not already installed)
# macOS
brew install gh

# Verify installation (run from anywhere)
gh --version

# Check if already installed
which gh
```

### Create Repository via CLI
```bash
# Login to GitHub (first time only)
gh auth login

# Create a new repository
gh repo create repository-name

# Create repository with description
gh repo create repository-name --description "Your repository description"

# Create private repository
gh repo create repository-name --private

# Create public repository (default)
gh repo create repository-name --public

# Create repository with .gitignore template
gh repo create repository-name --gitignore "Swift"  # or "Node", "Python", etc.

# Create repository with license
gh repo create repository-name --license "MIT"  # or "Apache-2.0", "GPL-3.0", etc.

# Create repository with README
gh repo create repository-name --enable-issues --enable-wiki

# Create from current directory and push
cd /path/to/local/project
git init
git add .
git commit -m "Initial commit"
gh repo create repository-name --source . --push

# Create repository and clone immediately
gh repo create repository-name --clone
```

## Method 3: Using Git Commands (Local Repository Only)

### ⚠️ **Important Note:**
**Git itself cannot create GitHub repositories!** Git only manages local repositories. To create a GitHub repository, you must use:
- GitHub Web Interface (Method 1)
- GitHub CLI (Method 2)
- GitHub API (Method 4)

### Initialize Local Repository
```bash
# Initialize local git repository
git init

# Add remote origin (repository must already exist on GitHub)
git remote add origin https://github.com/username/repository-name.git

# Create and switch to main branch
git branch -M main

# Add all files
git add .

# Initial commit
git commit -m "Initial commit"

# Push to GitHub (repository must exist first)
git push -u origin main
```

### Workflow for Git-Only Approach:
1. **First**: Create repository via GitHub Web Interface or GitHub CLI
2. **Then**: Use git commands locally to connect and push

## Method 4: Using GitHub API

### Create Repository via API
```bash
# Using curl
curl -X POST \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: token YOUR_GITHUB_TOKEN" \
  https://api.github.com/user/repos \
  -d '{
    "name": "repository-name",
    "description": "Your repository description",
    "private": false,
    "auto_init": true,
    "gitignore_template": "Swift"
  }'

# Using GitHub CLI with API
gh api repos/create \
  --name repository-name \
  --description "Your repository description" \
  --private false
```

## Common GitHub Repository Creation Examples

### Swift iOS Project
```bash
# Option 1: Web Interface (Recommended)
# 1. Create repo on GitHub.com with Swift .gitignore
# 2. Then locally:
cd /path/to/ios-project
git init
git remote add origin https://github.com/username/ios-app-name.git
git branch -M main
git add .
git commit -m "Initial iOS project commit"
git push -u origin main

# Option 2: GitHub CLI
gh repo create ios-app-name --description "iOS application built with Swift" --public --gitignore "Swift"
```

### Node.js Project
```bash
# Option 1: Web Interface (Recommended)
# 1. Create repo on GitHub.com with Node .gitignore
# 2. Then locally:
mkdir project-name
cd project-name
npm init -y
git init
git remote add origin https://github.com/username/node-project.git
git branch -M main
git add .
git commit -m "Initial Node.js project"
git push -u origin main

# Option 2: GitHub CLI
gh repo create node-project --description "Node.js application" --gitignore "Node" --public
```

### Python Project
```bash
# Option 1: Web Interface (Recommended)
# 1. Create repo on GitHub.com with Python .gitignore
# 2. Then locally:
mkdir project-name
cd project-name
python -m venv venv
git init
git remote add origin https://github.com/username/python-project.git
git branch -M main
git add .
git commit -m "Initial Python project"
git push -u origin main

# Option 2: GitHub CLI
gh repo create python-project --description "Python application" --gitignore "Python" --public
```

## Post-Creation Setup Commands

### Set Default Branch
```bash
git branch -M main
git push -u origin main
```

### Configure Repository Settings
```bash
# Set repository description
gh repo edit --description "Updated description"

# Enable/disable features
gh repo edit --enable-issues
gh repo edit --enable-wiki
gh repo edit --disable-issues
gh repo edit --disable-wiki

# Set repository visibility
gh repo edit --visibility private
gh repo edit --visibility public
```

### Add Collaborators
```bash
# Add collaborator via CLI
gh api repos/username/repository-name/collaborators/collaborator-username -X PUT -F permission=push

# Or use web interface
# Go to Settings → Manage Access → Invite collaborator
```

## Best Practices

### Repository Naming
- Use lowercase with hyphens: `my-awesome-project`
- Be descriptive: `visionpro-floor-app` instead of `app`
- Avoid special characters except hyphens and underscores

### Repository Structure
```
repository-name/
├── README.md          # Project description and setup instructions
├── .gitignore         # Files to ignore (auto-generated with template)
├── LICENSE            # License file
├── src/               # Source code
├── docs/              # Documentation
├── tests/             # Test files
├── .github/           # GitHub-specific files
│   ├── workflows/     # GitHub Actions
│   └── ISSUE_TEMPLATE/
└── CONTRIBUTING.md    # Contribution guidelines
```

### Initial Commit Best Practices
```bash
# Stage meaningful files only
git add README.md .gitignore LICENSE
git commit -m "chore: initial repository setup"

# Or add all files if ready
git add .
git commit -m "feat: initial project setup"
```

### Quick Start Template
```bash
# Complete setup for new project
gh auth login
gh repo create my-new-repo --description "My new project" --public --gitignore "Swift" --license "MIT"
git clone https://github.com/username/my-new-repo.git
cd my-new-repo
# Add your project files here
git add .
git commit -m "feat: initial implementation"
git push
```

## Troubleshooting

### Common Issues
```bash
# Authentication issues
gh auth login

# Permission denied
git remote set-url origin https://username:token@github.com/username/repo.git

# Large file issues
git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch large-file-path' --prune-empty --tag-name-filter cat -- --all

# Repository already exists error
# Check if repository exists: https://github.com/username/repository-name
# Use different name or delete existing repository
```

### Useful GitHub CLI Commands
```bash
# List your repositories
gh repo list

# View repository info
gh repo view username/repository-name

# Fork a repository
gh repo fork username/repository-name

# Star a repository
gh repo star username/repository-name
```

---

*Last updated: December 21, 2025*
