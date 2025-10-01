# 📝 Git Commands Cheatsheet

## 🔹 Setup & Configuration
```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
git config --list               # Show config
```

---

## 🔹 Starting a Repo
```bash
git init                        # Initialize new repo
git clone <url>                 # Clone remote repo
```
## Git Clone all repositories in Github using Powershell

```bash
# Replace taukir1515 with your GitHub username
$User = "taukir1515"
$Repos = Invoke-RestMethod "https://api.github.com/users/$User/repos?per_page=100"

foreach ($Repo in $Repos) {
    git clone $Repo.clone_url
}
```

---

## 🔹 Most Useful Commands
```bash
git status                      # Show changes
git add <file_name>             # Stage file
git add .                       # Stage all files in the current directory and all its subdirectories.
git commit -m "message"         # Commit staged changes
git commit -am "message"        # Automatically stage tracked files that have been modified or deleted (with `git add`).
```

## Unstage - Uncommit - Other

```bash
git checkout -- <file>      # Discard local changes

git reset <file_name>       # Unstage file <Sends to previous condition of git add>

git reset --soft HEAD~1     # Undo the last commit but keep changes staged
git reset HEAD~1            # Undo the last commit and keep changes unstaged
git reset --hard HEAD~1     # Undo the last commit and discard changes completely
git revert <commit_hash>    # Undo a specific commit in history
```

💡 Tip
> HEAD~1 always refers to the last commit.
> Replace 1 with 2, 3, etc., to go back multiple commits.

## Unstaged-Staged-Committed Condition

```bash
Unstaged/Untracked  --(git add)-->  Staged/Tracked  --(git commit)-->  Committed
```

---

## 🔹 Branching & Merging
```bash
git branch                      # List branches
git branch <name>               # Create branch
git checkout <name>             # Switch branch
git switch <name>               # (Newer) Switch branch
git checkout -b <name>          # Create + switch
git merge <branch>              # Merge into current branch
git branch -d <name>            # Delete branch
```

---

## 🔹 Remote Repositories
```bash
git remote -v                   # List remotes
git remote add origin <url>     # Add remote repository. url=https://github.com/Taukir1515/securityPlayground
git remote remove origin        # Remove remote

git push -u origin main         # Push the local 'main' branch to 'origin' for the first time and set it as the default upstream
git push                        # Push changes to the default upstream branch (remembered via -u)
git push origin taukir          # Push changes to a specific branch named 'taukir' on the remote
git pull                        # Fetch + merge
git fetch                       # Download changes only
```


---

## 🔹 Stash
```bash
git stash                       # Save dirty state
git stash list                  # Show stashes
git stash apply                 # Re-apply latest stash
git stash drop                  # Delete stash
```

---

## 🔹 Log & History
```bash
git log                         # Full history
git log --oneline               # One line per commit
git log --graph --oneline --all # Branch tree view
git show <commit>               # Details of commit
```

---

## 🔹 Tags
```bash
git tag                         # List tags
git tag v1.0                    # Create tag
git push origin v1.0            # Push tag
```

---

## 🔹 Submodules
```bash
git submodule add <url> path    # Add submodule
git submodule update --init     # Init submodules
```

---

⚡ Get Help  
```bash
git help <command>      # to get details on any command.
```

