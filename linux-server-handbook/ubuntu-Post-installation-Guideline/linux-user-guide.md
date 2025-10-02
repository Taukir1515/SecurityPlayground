# Root Password Management

```bash
# Set or change root password
sudo passwd root

# Expire root password (force reset on next login)
sudo passwd -e root

# Lock root account
sudo passwd -l root

# Unlock root account
sudo passwd -u root
```

# Add New User

```bash
# Add new user (with home directory and default shell)
sudo adduser <username>              # Debian/Ubuntu

# Add user with specific shell
sudo useradd -m -s /bin/bash <username>

# Create user and set password
sudo adduser <username>
sudo passwd <username>
```

# Group Management

```bash
# Create new group
sudo groupadd <groupname>

# Add user to group
sudo usermod -aG <groupname> <username>

# Show groups of a user
groups <username>

# Change user’s primary group
sudo usermod -g <groupname> <username>
```

# Password & Security

```bash
# Set password for a user
sudo passwd <username>

# Lock user account
sudo passwd -l <username>

# Unlock user account
sudo passwd -u <username>

# Expire user password (forces reset on next login)
sudo passwd -e <username>
```

# Remove User

```bash
# Remove user (keeps home directory)
sudo deluser <username>              # Debian/Ubuntu

# Remove user and home directory
sudo deluser --remove-home <username>
sudo userdel -r <username>
```

# User Info & Switching

```bash
# Show user info
id <username>
finger <username>
getent passwd <username>

# Switch user
su - <username>

# Run command as another user
sudo -u <username> <command>
```















